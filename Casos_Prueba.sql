-- CP-01
INSERT INTO Pedido (id_pedido, fecha_pedido, fecha_entrega, num_factura, id_cliente, id_empleado)
VALUES (9999, '2026-06-20', '2026-06-25', NULL, 8888, 1);

-- CP-02
INSERT INTO Producto (id_producto, nombre_reloj, precio, stock, id_marca)
VALUES (9999, 'Reloj Prueba', 'caro', 5, 1);

-- CP-03
INSERT INTO Marca (id_marca, nombre_marca)
VALUES (1, 'Casio Duplicado');

-- CP-04
INSERT INTO Reseña (id_reseña, id_pedido, id_producto, contenido, fecha_reseña)
VALUES (9999, 1042, 105, 'Excelente reloj', '2026-06-20');

-- CP-05
INSERT INTO Producto (id_producto, nombre_reloj, precio, stock, id_marca)
VALUES (9999, 'Reloj Sin Marca', 100000, 5, 999);