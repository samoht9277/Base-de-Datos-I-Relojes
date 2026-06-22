USE Reloj;
GO

---------VISTA--------------

CREATE VIEW Venta_empleado AS
SELECT 
    CAST(e.nombre_empleado AS varchar) + ' ' + CAST(e.apellido_empleado AS varchar) AS Empleado_Productivo,
    COUNT(p.id_pedido) AS Cantidad_Ventas_Gestionadas
FROM 
    Empleado e
INNER JOIN 
    Pedido p ON e.id_empleado = p.id_empleado
GROUP BY 
    e.id_empleado,
    e.nombre_empleado,
    e.apellido_empleado;

GO


CREATE VIEW Cliente_total_gastado AS
SELECT nombre_cliente + ' , ' + apellido_cliente AS VIP_cliente,
	   SUM(PP.cantidad_comprada * PP.precio_venta_historico) AS Total_Gastado
FROM Cliente C
INNER JOIN Pedido P ON C.id_cliente = P.id_cliente
INNER JOIN Pedido_Producto PP ON P.id_pedido = PP.id_pedido
GROUP BY 
    C.id_cliente, 
    C.nombre_cliente, 
    C.apellido_cliente;

GO

SELECT * FROM Cliente_total_gastado
ORDER BY Total_Gastado DESC;


GO

---------CONSULTAS-------------
-- C1: Contacto de clientes por localidad
SELECT email_cliente AS Email,
       CAST(telefono_cliente AS varchar) AS Telefono,
       id_localidad AS Localidad
FROM Cliente
WHERE id_Localidad = 2
ORDER BY apellido_cliente ASC;
GO

-- C2: Clientes por total gastado
SELECT VIP_cliente AS Cliente,
       Total_Gastado
FROM Cliente_total_gastado
ORDER BY Total_Gastado DESC;
GO

-- C3: Relojes con stock bajo
SELECT nombre_reloj AS Reloj,
       stock AS Stock_Actual
FROM Producto
WHERE stock < 5;
GO

-- C4: Movimientos con precio promedio y stock total
SELECT movimiento,
       COUNT(*) AS Cantidad_Modelos,
       ROUND(AVG(precio), 2) AS Precio_Promedio,
       SUM(stock) AS Stock_Total
FROM Producto
GROUP BY movimiento
ORDER BY Precio_Promedio DESC;
GO

-- C5: Relojes con su marca
SELECT Producto.nombre_reloj, Marca.nombre_marca
FROM Producto
INNER JOIN Marca ON Producto.id_marca = Marca.id_marca;
GO

-- C6: Precio promedio por marca
SELECT nombre_marca AS Marca,
       ROUND(AVG(P.precio), 2) AS Precio_Promedio
FROM Marca M
INNER JOIN Producto p ON M.id_marca = p.id_marca
GROUP BY M.nombre_marca
ORDER BY M.nombre_marca DESC;
GO

-- C7: Empleados cuyo nombre o apellido empieza con F
SELECT nombre_empleado AS Nombre,
       apellido_empleado AS Apellido
FROM Empleado
WHERE (nombre_empleado LIKE 'F%') OR (apellido_empleado LIKE 'F%')
ORDER BY nombre_empleado ASC;
GO

-- C8: Ventas por empleado
SELECT Empleado_Productivo AS Empleado,
       Cantidad_Ventas_Gestionadas AS Ventas
FROM Venta_empleados
ORDER BY Cantidad_Ventas_Gestionadas DESC;
GO

-- C9: Proveedores con cantidad de productos y stock total
SELECT pr.nombre_proveedor AS Proveedor,
       pr.email_proveedor AS Contacto,
       COUNT(DISTINCT ppr.id_producto) AS Cantidad_Productos,
       SUM(p.stock) AS Stock_Total_Suministrado
FROM Proveedor pr
INNER JOIN Producto_Proveedor ppr ON pr.id_proveedor = ppr.id_proveedor
INNER JOIN Producto p ON ppr.id_producto = p.id_producto
GROUP BY pr.id_proveedor, pr.nombre_proveedor, pr.email_proveedor
ORDER BY Stock_Total_Suministrado DESC;
GO

-- C10: Proveedores a contactar por stock bajo
SELECT pr.nombre_proveedor AS Proveedor_a_Contactar,
       pr.email_proveedor AS Email,
       p.nombre_reloj AS Reloj_Casi_Agotado,
       p.stock AS Stock_Actual
FROM Proveedor pr
INNER JOIN Producto_Proveedor ppr ON pr.id_proveedor = ppr.id_proveedor
INNER JOIN Producto p ON ppr.id_producto = p.id_producto
WHERE p.stock <= 5
AND EXISTS (
    SELECT 1 FROM Pedido_Producto pp
    WHERE pp.id_producto = p.id_producto
)
ORDER BY p.stock ASC;
GO





----------------------TRIGGERS---------------------------

       
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

-- Caso de prueba para el trigger de validación de email
INSERT INTO Cliente (id_cliente, nombre_cliente, apellido_cliente, email_cliente, telefono_cliente, cuit_cliente, calle_direccion, altura_direccion, id_localidad)
VALUES (999, 'Test', 'Trigger', 'emailsinarroba', 1134567890, 20999999, 'Calle Falsa', 123, 1);

--- Caso de prueba para el trigger de validación de precio
UPDATE Producto SET precio = -500 WHERE id_producto = 1;
