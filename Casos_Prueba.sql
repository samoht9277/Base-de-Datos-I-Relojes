USE Reloj;
GO

-- ============================================================
-- CASOS DE PRUEBA (negativos) - Relojería
-- Cada INSERT debe FALLAR: valida una restricción del modelo.
-- Conviene correrlos de a uno para ver el error de cada caso.
-- ============================================================

-- CP-01: FK inexistente -> el id_cliente 8888 no existe
INSERT INTO Pedido (id_pedido, fecha_pedido, fecha_entrega, num_factura, id_cliente, id_empleado)
VALUES (9999, '2026-06-20', '2026-06-25', NULL, 8888, 1);
GO

-- CP-02: tipo inválido -> 'caro' no es un número para precio
INSERT INTO Producto (id_producto, nombre_reloj, precio, stock, id_marca)
VALUES (9999, 'Reloj Prueba', 'caro', 5, 1);
GO

-- CP-03: PK duplicada -> el id_marca 1 ya existe
INSERT INTO Marca (id_marca, nombre_marca)
VALUES (1, 'Casio Duplicado');
GO

-- CP-04: FK compuesta inexistente -> (1042, 105) no es un Pedido_Producto válido
INSERT INTO Reseña (id_reseña, id_pedido, id_producto, contenido, fecha_reseña)
VALUES (9999, 1042, 105, 'Excelente reloj', '2026-06-20');
GO

-- CP-05: FK inexistente -> el id_marca 999 no existe
INSERT INTO Producto (id_producto, nombre_reloj, precio, stock, id_marca)
VALUES (9999, 'Reloj Sin Marca', 100000, 5, 999);
GO
