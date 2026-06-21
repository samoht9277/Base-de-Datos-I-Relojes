USE Reloj;
GO
-------------------------------------------
----        CLIENTE     -------------------
-------------------------------------------
SELECT email_cliente + ' | | ' + CAST(telefono_cliente AS varchar) AS info_contacto FROM Cliente
WHERE id_Localidad = 2
ORDER BY apellido_cliente ASC;

GO

------------------------------------VISTA----------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------------------------


SELECT * FROM Cliente_total_gastado
ORDER BY Total_Gastado DESC;



-------------------------------------------
----        RELOJ       -------------------
-------------------------------------------
SELECT * FROM Producto;


SELECT nombre_reloj  FROM Producto AS Relojes
WHERE stock < 5;
GO 

SELECT * FROM Producto
WHERE precio > 800000;
GO


SELECT * FROM Producto
WHERE diametro > 45;
GO


SELECT nombre_reloj AS Reloj_Cuarzo FROM Producto
WHERE movimiento = 'Cuarzo';

SELECT nombre_reloj AS Reloj_Casual FROM Producto
WHERE estilo = 'Casual';

SELECT Producto.nombre_reloj, Marca.nombre_marca
FROM Producto
INNER JOIN Marca ON Producto.id_marca = Marca.id_marca;

SELECT p.nombre_reloj, m.nombre_marca, AVG(p.precio) AS Promedio
FROM Producto p
INNER JOIN Marca m ON p.id_marca = m.id_marca ON m.id_marca = p.id_marca
GROUP BY m.nombre_marca
ORDER BY M.nombre_marca DESC;

SELECT nombre_marca , AVG(P.precio)AS Promedio
FROM Marca M
INNER JOIN Producto p ON M.id_marca = p.id_marca
GROUP BY M.nombre_marca  
ORDER BY M.nombre_marca DESC;

GO

-------------------------------------------
----        EMPLEADO       ----------------
-------------------------------------------

SELECT nombre_empleado AS Empleado FROM Empleado
WHERE (nombre_empleado LIKE 'F%') OR (apellido_empleado LIKE 'F%')
ORDER BY nombre_empleado ASC;

GO

-----------------------------------VISTA---------------------------------------------------------------------
CREATE VIEW Venta_empleados AS
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
SELECT * FROM Venta_empleados
ORDER BY 
    Cantidad_Ventas_Gestionadas DESC;
---------------------------------------------------------------------------------------------------------
    
-------------------------------------------
----        PROVEEDORES       -------------
-------------------------------------------

SELECT nombre_proveedor AS Nombre FROM Proveedor
ORDER BY nombre_proveedor ASC;

SELECT 
    nombre_proveedor AS Proveedor_Local, 
    email_proveedor AS Contacto
FROM 
    Proveedor
WHERE 
    email_proveedor LIKE '%.ar%';


SELECT 
    pr.nombre_proveedor AS Proveedor,
    SUM(pp.cantidad_comprada * pp.precio_venta_historico) AS Total_Dinero_Generado
FROM Proveedor pr
INNER JOIN Producto_Proveedor ppr ON pr.id_proveedor = ppr.id_proveedor
INNER JOIN Pedido_Producto pp ON ppr.id_producto = pp.id_producto
GROUP BY 
    pr.id_proveedor, 
    pr.nombre_proveedor
ORDER BY 
    Total_Dinero_Generado DESC;




SELECT 
    pr.nombre_proveedor AS Proveedor_a_Contactar,
    pr.email_proveedor AS Email,
    p.nombre_reloj AS Reloj_Casi_Agotado,
    p.stock AS Stock_Actual
FROM Proveedor pr
INNER JOIN Producto_Proveedor ppr ON pr.id_proveedor = ppr.id_proveedor
INNER JOIN Producto p ON ppr.id_producto = p.id_producto
WHERE p.stock <= 5
AND EXISTS (
    -- Solo mostrame este faltante si el reloj tiene al menos 1 venta registrada.
    -- No queremos reponer relojes que no se venden nunca
    SELECT 1 
    FROM Pedido_Producto pp 
    WHERE pp.id_producto = p.id_producto
)
ORDER BY p.stock ASC;
