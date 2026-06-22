USE Reloj;
GO

-- ============================================================
-- FUNCIONES - Relojería
-- Requiere haber corrido antes Reloj.sql (la estructura).
-- ============================================================


-- ============================================================
-- fn_PrecioConIVA
-- Devuelve el precio final al público de un reloj, aplicando
-- el IVA (21%) sobre el precio de lista.
-- Recibe el id del producto y retorna el precio con impuesto.
-- Si el producto no existe, devuelve NULL.
-- ============================================================
CREATE OR ALTER FUNCTION fn_PrecioConIVA (@id_producto INT)
RETURNS DECIMAL(12, 2)
AS
BEGIN
    DECLARE @precio FLOAT;
    DECLARE @iva DECIMAL(4, 2) = 0.21;   -- 21%

    SELECT @precio = precio
    FROM Producto
    WHERE id_producto = @id_producto;

    IF @precio IS NULL
        RETURN NULL;

    RETURN CAST(@precio * (1 + @iva) AS DECIMAL(12, 2));
END
GO

-- Ejemplo de uso:
-- SELECT nombre_reloj, precio, dbo.fn_PrecioConIVA(id_producto) AS precio_con_iva
-- FROM Producto;
