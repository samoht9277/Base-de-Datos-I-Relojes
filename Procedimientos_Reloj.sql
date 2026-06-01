USE Reloj;
GO

-- ============================================================
-- STORED PROCEDURES - Relojería
-- Requiere haber corrido antes Reloj.sql (la estructura).
-- Los 3 usan parámetros y manejo de errores (TRY/CATCH).
-- sp_RegistrarVenta y sp_ActualizarPrecio además usan transacción.
-- ============================================================


-- ============================================================
-- A) sp_RegistrarVenta
-- Registra una venta completa en UNA transacción: crea la
-- Factura, el Pedido, el detalle (congelando el precio actual)
-- y descuenta el stock. Si no hay stock suficiente, hace ROLLBACK.
-- ============================================================
CREATE OR ALTER PROCEDURE sp_RegistrarVenta
    @id_cliente    INT,
    @id_empleado   INT,
    @id_producto   INT,
    @cantidad      INT,
    @id_medio_pago INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validaciones
        IF @cantidad <= 0
            THROW 50001, 'La cantidad debe ser mayor a 0.', 1;

        DECLARE @stock_actual INT, @precio_actual FLOAT;
        SELECT @stock_actual = stock, @precio_actual = precio
        FROM Producto
        WHERE id_producto = @id_producto;

        IF @stock_actual IS NULL
            THROW 50002, 'El producto no existe.', 1;

        IF @stock_actual < @cantidad
            THROW 50003, 'Stock insuficiente para completar la venta.', 1;

        -- Generar los IDs nuevos
        DECLARE @id_factura INT = (SELECT ISNULL(MAX(id_factura), 0) + 1 FROM Factura);
        DECLARE @id_pedido  INT = (SELECT ISNULL(MAX(id_pedido), 0) + 1 FROM Pedido);

        -- 1) Factura
        INSERT INTO Factura (id_factura, fecha_factura, impuesto, estado_factura, id_medio_pago)
        VALUES (@id_factura, GETDATE(), 21, 'Pagado', @id_medio_pago);

        -- 2) Pedido
        INSERT INTO Pedido (id_pedido, fecha_pedido, fecha_entrega, num_factura, id_cliente, id_empleado)
        VALUES (@id_pedido, GETDATE(), NULL, @id_factura, @id_cliente, @id_empleado);

        -- 3) Detalle (congelamos el precio actual del producto)
        INSERT INTO Pedido_Producto (id_pedido, id_producto, cantidad_comprada, precio_venta_historico)
        VALUES (@id_pedido, @id_producto, @cantidad, @precio_actual);

        -- 4) Descontar el stock
        UPDATE Producto
        SET stock = stock - @cantidad
        WHERE id_producto = @id_producto;

        COMMIT TRANSACTION;
        PRINT 'Venta OK -> Factura #' + CAST(@id_factura AS VARCHAR(10)) + ' / Pedido #' + CAST(@id_pedido AS VARCHAR(10));
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW; -- re-lanza el error original al que llamó al SP
    END CATCH
END;
GO


-- ============================================================
-- B) sp_ActualizarPrecio
-- Cambia el precio de un producto y deja registro del cambio
-- en Historial_Precios, todo en una transacción.
-- ============================================================
CREATE OR ALTER PROCEDURE sp_ActualizarPrecio
    @id_producto  INT,
    @nuevo_precio FLOAT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @nuevo_precio <= 0
            THROW 50010, 'El nuevo precio debe ser mayor a 0.', 1;

        DECLARE @precio_anterior FLOAT;
        SELECT @precio_anterior = precio
        FROM Producto
        WHERE id_producto = @id_producto;

        IF @precio_anterior IS NULL
            THROW 50011, 'El producto no existe.', 1;

        -- ID nuevo para el historial
        DECLARE @id_historial INT = (SELECT ISNULL(MAX(id_historial), 0) + 1 FROM Historial_Precios);

        -- 1) Registrar el cambio en el historial
        INSERT INTO Historial_Precios (id_historial, id_producto, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (@id_historial, @id_producto, @precio_anterior, @nuevo_precio, GETDATE());

        -- 2) Actualizar el precio del producto
        UPDATE Producto
        SET precio = @nuevo_precio
        WHERE id_producto = @id_producto;

        COMMIT TRANSACTION;
        PRINT 'Precio actualizado -> antes: ' + CAST(@precio_anterior AS VARCHAR(20)) + ' / ahora: ' + CAST(@nuevo_precio AS VARCHAR(20));
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO


-- ============================================================
-- C) sp_ReporteVentasCliente
-- Devuelve un resumen de compras de un cliente: cantidad de
-- pedidos y total gastado. Acepta un rango de fechas opcional
-- (si van en NULL, trae todo). Es de solo lectura (sin transacción).
-- ============================================================
CREATE OR ALTER PROCEDURE sp_ReporteVentasCliente
    @id_cliente  INT,
    @fecha_desde DATETIME = NULL,
    @fecha_hasta DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE id_cliente = @id_cliente)
        THROW 50020, 'El cliente no existe.', 1;

    SELECT
        C.id_cliente,
        C.nombre_cliente + ' ' + C.apellido_cliente                      AS Cliente,
        COUNT(DISTINCT P.id_pedido)                                      AS Cantidad_Pedidos,
        ISNULL(SUM(PP.cantidad_comprada * PP.precio_venta_historico), 0) AS Total_Gastado
    FROM Cliente C
    LEFT JOIN Pedido P
        ON C.id_cliente = P.id_cliente
       AND (@fecha_desde IS NULL OR P.fecha_pedido >= @fecha_desde)
       AND (@fecha_hasta IS NULL OR P.fecha_pedido <= @fecha_hasta)
    LEFT JOIN Pedido_Producto PP
        ON P.id_pedido = PP.id_pedido
    WHERE C.id_cliente = @id_cliente
    GROUP BY C.id_cliente, C.nombre_cliente, C.apellido_cliente;
END;
GO


-- ============================================================
-- EJEMPLOS DE USO (descomentar para probar)
-- ============================================================
-- EXEC sp_RegistrarVenta @id_cliente = 1, @id_empleado = 1, @id_producto = 1, @cantidad = 2, @id_medio_pago = 3;
-- EXEC sp_ActualizarPrecio @id_producto = 1, @nuevo_precio = 260000;
-- EXEC sp_ReporteVentasCliente @id_cliente = 1;
-- EXEC sp_ReporteVentasCliente @id_cliente = 1, @fecha_desde = '2026-05-01', @fecha_hasta = '2026-05-31';
