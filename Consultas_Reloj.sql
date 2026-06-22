USE Reloj;
GO

-- ============================================================
-- CONSULTAS, VISTAS Y TRIGGERS - Relojería
-- Requiere haber corrido antes Reloj.sql y BaseDato.sql.
-- ============================================================


-- ============================================================
-- VISTAS
-- ============================================================

-- Vista: ventas gestionadas por empleado
CREATE VIEW Venta_empleados AS
SELECT
    CAST(E.nombre_empleado AS VARCHAR) + ' ' + CAST(E.apellido_empleado AS VARCHAR) AS Empleado_Productivo,
    COUNT(P.id_pedido)                                                              AS Cantidad_Ventas_Gestionadas
FROM Empleado E
INNER JOIN Pedido P ON E.id_empleado = P.id_empleado
GROUP BY E.id_empleado, E.nombre_empleado, E.apellido_empleado;
GO

-- Vista: total gastado por cliente
CREATE VIEW Cliente_total_gastado AS
SELECT
    C.nombre_cliente + ' , ' + C.apellido_cliente         AS VIP_cliente,
    SUM(PP.cantidad_comprada * PP.precio_venta_historico) AS Total_Gastado
FROM Cliente C
INNER JOIN Pedido P           ON C.id_cliente = P.id_cliente
INNER JOIN Pedido_Producto PP ON P.id_pedido = PP.id_pedido
GROUP BY C.id_cliente, C.nombre_cliente, C.apellido_cliente;
GO


-- ============================================================
-- CONSULTAS
-- ============================================================

-- C1: Contacto de clientes por localidad
SELECT
    email_cliente                     AS Email,
    CAST(telefono_cliente AS VARCHAR) AS Telefono,
    id_localidad                      AS Localidad
FROM Cliente
WHERE id_localidad = 2
ORDER BY apellido_cliente ASC;
GO

-- C2: Clientes por total gastado
SELECT
    VIP_cliente AS Cliente,
    Total_Gastado
FROM Cliente_total_gastado
ORDER BY Total_Gastado DESC;
GO

-- C3: Relojes con stock bajo
SELECT
    nombre_reloj AS Reloj,
    stock        AS Stock_Actual
FROM Producto
WHERE stock < 5;
GO

-- C4: Movimientos con precio promedio y stock total
SELECT
    movimiento,
    COUNT(*)              AS Cantidad_Modelos,
    ROUND(AVG(precio), 2) AS Precio_Promedio,
    SUM(stock)            AS Stock_Total
FROM Producto
GROUP BY movimiento
ORDER BY Precio_Promedio DESC;
GO

-- C5: Relojes con su marca
SELECT P.nombre_reloj, M.nombre_marca
FROM Producto P
INNER JOIN Marca M ON P.id_marca = M.id_marca;
GO

-- C6: Precio promedio por marca
SELECT
    M.nombre_marca          AS Marca,
    ROUND(AVG(P.precio), 2) AS Precio_Promedio
FROM Marca M
INNER JOIN Producto P ON M.id_marca = P.id_marca
GROUP BY M.nombre_marca
ORDER BY M.nombre_marca DESC;
GO

-- C7: Empleados cuyo nombre o apellido empieza con F
SELECT
    nombre_empleado   AS Nombre,
    apellido_empleado AS Apellido
FROM Empleado
WHERE nombre_empleado LIKE 'F%' OR apellido_empleado LIKE 'F%'
ORDER BY nombre_empleado ASC;
GO

-- C8: Ventas por empleado
SELECT
    Empleado_Productivo         AS Empleado,
    Cantidad_Ventas_Gestionadas AS Ventas
FROM Venta_empleados
ORDER BY Cantidad_Ventas_Gestionadas DESC;
GO

-- C9: Proveedores con cantidad de productos y stock total
SELECT
    PR.nombre_proveedor             AS Proveedor,
    PR.email_proveedor              AS Contacto,
    COUNT(DISTINCT PPR.id_producto) AS Cantidad_Productos,
    SUM(P.stock)                    AS Stock_Total_Suministrado
FROM Proveedor PR
INNER JOIN Producto_Proveedor PPR ON PR.id_proveedor = PPR.id_proveedor
INNER JOIN Producto P             ON PPR.id_producto = P.id_producto
GROUP BY PR.id_proveedor, PR.nombre_proveedor, PR.email_proveedor
ORDER BY Stock_Total_Suministrado DESC;
GO

-- C10: Proveedores a contactar por stock bajo
SELECT
    PR.nombre_proveedor AS Proveedor_a_Contactar,
    PR.email_proveedor  AS Email,
    P.nombre_reloj      AS Reloj_Casi_Agotado,
    P.stock             AS Stock_Actual
FROM Proveedor PR
INNER JOIN Producto_Proveedor PPR ON PR.id_proveedor = PPR.id_proveedor
INNER JOIN Producto P             ON PPR.id_producto = P.id_producto
WHERE P.stock <= 5
  AND EXISTS (
      SELECT 1 FROM Pedido_Producto PP
      WHERE PP.id_producto = P.id_producto
  )
ORDER BY P.stock ASC;
GO


-- ============================================================
-- TRIGGERS
-- ============================================================

-- Valida el formato del email al insertar un cliente
CREATE TRIGGER trg_Validar_Email_Cliente
ON Cliente
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED WHERE email_cliente NOT LIKE '%@%.%')
    BEGIN
        RAISERROR('El email ingresado no tiene un formato válido.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Evita que un producto quede con precio negativo tras un UPDATE
CREATE TRIGGER trg_Evitar_Precio_Negativo
ON Producto
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED WHERE precio < 0)
    BEGIN
        RAISERROR('El precio no puede ser menor a cero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Casos de prueba de los triggers (ambos deben fallar)
-- Trigger de email: email sin arroba
INSERT INTO Cliente (id_cliente, nombre_cliente, apellido_cliente, email_cliente, telefono_cliente, cuit_cliente, calle_direccion, altura_direccion, id_localidad)
VALUES (999, 'Test', 'Trigger', 'emailsinarroba', 1134567890, 20999999, 'Calle Falsa', 123, 1);
GO

-- Trigger de precio: precio negativo
UPDATE Producto SET precio = -500 WHERE id_producto = 1;
GO
