USE Reloj;
GO
-------------------------------------------
----        CLIENTE     -------------------
-------------------------------------------
SELECT email_cliente + ' | | ' + CAST(telefono_cliente AS varchar) AS info_contacto FROM Cliente
WHERE id_Localidad = 2
ORDER BY apellido_cliente ASC;


SELECT nombre_cliente + ' , ' + apellido_cliente AS VIP_cliente,
	   SUM(PP.cantidad_comprada * PP.precio_venta_historico) AS Total_Gastado
FROM Cliente C
INNER JOIN Pedido P ON C.id_cliente = P.id_cliente
INNER JOIN Pedido_Producto PP ON P.id_pedido = PP.id_pedido
GROUP BY 
    C.id_cliente, 
    C.nombre_cliente, 
    C.apellido_cliente
ORDER BY 
    Total_Gastado DESC;


-------------------------------------------
----        RELOJ       -------------------
-------------------------------------------

SELECT nombre_reloj  FROM Producto AS Relojes
WHERE stock < 5;

SELECT nombre_marca , AVG(P.precio)AS Promedio
FROM Marca M
INNER JOIN Producto p ON M.id_marca = p.id_marca
GROUP BY M.nombre_marca  
ORDER BY M.nombre_marca DESC;


-------------------------------------------
----        EMPLEADO       ----------------
-------------------------------------------

SELECT nombre_empleado AS Empleado FROM Empleado
WHERE (nombre_empleado LIKE 'F%') OR (apellido_empleado LIKE 'F%')
ORDER BY nombre_empleado ASC;

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
    e.apellido_empleado
ORDER BY 
    Cantidad_Ventas_Gestionadas DESC;

    
-------------------------------------------
----        PROVEEDORES       -------------
-------------------------------------------

SELECT nombre_proovedor AS Nombre FROM Proovedor
ORDER BY nombre_proovedor ASC;

SELECT 
    nombre_proovedor AS Proveedor_Local, 
    email_proovedor AS Contacto
FROM 
    Proovedor
WHERE 
    email_proovedor LIKE '%.ar%';