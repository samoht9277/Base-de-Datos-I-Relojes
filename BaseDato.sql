USE Reloj;

-- CARGA DE DATOS DE PRUEBA (MOCK DATA)
-- TABLA: Provincia
INSERT INTO [Provincia] ([id_provincia], [nombre_provincia]) VALUES
(1, 'Buenos Aires'), (2, 'Córdoba'), (3, 'Santa Fe'), (4, 'Mendoza'), 
(5, 'Tucumán'), (6, 'Salta'), (7, 'Neuquén'), (8, 'Río Negro'), 
(9, 'Chubut'), (10, 'Tierra del Fuego');
GO

-- TABLA: Marca
INSERT INTO [Marca] ([id_marca], [nombre_marca]) VALUES
(1, 'Casio'), (2, 'Rolex'), (3, 'Omega'), (4, 'Seiko'), 
(5, 'Tag Heuer'), (6, 'Garmin'), (7, 'Tissot'), (8, 'Citizen'), 
(9, 'Fossil'), (10, 'Orient');
GO

-- TABLA: Medio_Pago
INSERT INTO [Medio_Pago] ([id_Medio_Pago], [Nombre_Pago]) VALUES
(1, 'Efectivo'), (2, 'Transferencia Bancaria'), (3, 'Tarjeta de Crédito - Visa'), 
(4, 'Tarjeta de Crédito - Mastercard'), (5, 'Tarjeta de Crédito - Amex'), 
(6, 'Tarjeta de Débito - Visa'), (7, 'Tarjeta de Débito - Maestro'), 
(8, 'Mercado Pago'), (9, 'PayPal'), (10, 'Criptomonedas (USDT)');
GO

-- TABLA: Empleado
INSERT INTO [Empleado] ([id_empleado], [apellido_empleado], [nombre_empleado]) VALUES
(1, 'Fresca', 'Nicolas'), (2, 'Otero', 'Tomas'), (3, 'Gomez', 'Martin'), 
(4, 'Perez', 'Lucia'), (5, 'Fernandez', 'Julieta'), (6, 'Lopez', 'Carlos'), 
(7, 'Martinez', 'Sofia'), (8, 'Rodriguez', 'Diego'), (9, 'Sanchez', 'Micaela'), 
(10, 'Romero', 'Facundo');
GO

INSERT INTO [Proveedor] ([id_proveedor], [nombre_proveedor], [email_proveedor]) VALUES
(1, 'Distribuidora Casio Arg', 'ventas@casio.com.ar'),
(2, 'Rolex Swiss Imports', 'import@rolex.ch'),
(3, 'Grupo Omega SA', 'contacto@omega.com.ar'),
(4, 'Seiko Latam', 'latam@seiko.jp'),
(5, 'Tag Heuer Oficial', 'b2b@tagheuer.com'),
(6, 'Garmin Deportes', 'retail@garmin.com'),
(7, 'Tissot BA', 'ventas@tissot.ar'),
(8, 'Citizen Global', 'distribucion@citizen.com'),
(9, 'Fossil Accesorios', 'mayorista@fossil.com'),
(10, 'Orient Vintage', 'info@orient.com.ar');
GO

-- ==========================================
-- NIVEL 1: DEPENDENCIAS DE PRIMER GRADO
-- ==========================================
INSERT INTO [Localidad] ([id_localidad], [nombre_localidad], [codigo_postal], [id_provincia]) VALUES
(1, 'La Plata', '1900', 1),
(2, 'Mar del Plata', '7600', 1),
(3, 'Villa Carlos Paz', '5152', 2),
(4, 'Rosario', '2000', 3),
(5, 'San Rafael', '5600', 4),
(6, 'San Miguel de Tucumán', '4000', 5),
(7, 'Cafayate', '4427', 6),
(8, 'San Martín de los Andes', '8370', 7),
(9, 'Bariloche', '8400', 8),
(10, 'Ushuaia', '9410', 10);
GO

-- id_marca: 1=Casio, 2=Rolex, 3=Omega, 4=Seiko, 5=Tag, 6=Garmin, 7=Tissot, 8=Citizen, 9=Fossil, 10=Orient
-- ==========================================
-- CARGA DE CATÁLOGO COMPLETO (40 Relojes)
-- ==========================================
INSERT INTO [Producto] ([id_producto], [nombre_reloj], [precio], [movimiento], [diametro], [estilo], [num_serie], [ref_modelo], [stock], [meses_garantia], [id_marca]) VALUES
-- Marca 1: Casio
(1, 'G-Shock Mudmaster', 250000, 'Cuarzo', 55.3, 'Deportivo', 1001, 'GWG-1000', 10, 12, 1),
(11, 'Edifice Bluetooth', 320000, 'Cuarzo', 45.6, 'Racing', 1011, 'ECB-2000', 12, 12, 1),
(12, 'Vintage A168', 65000, 'Cuarzo', 36.3, 'Casual', 1012, 'A168WA', 30, 12, 1),
(28, 'G-Shock Classic Square', 120000, 'Cuarzo', 43.2, 'Deportivo', 1028, 'DW-5600E', 50, 12, 1),

-- Marca 2: Rolex
(2, 'Submariner Date', 15000000, 'Automático', 41.0, 'Buceo/Lujo', 1002, '126610LN', 2, 60, 2),
(13, 'Cosmograph Daytona', 32000000, 'Automático', 40.0, 'Cronógrafo', 1013, '116500LN', 1, 60, 2),
(14, 'Datejust 36', 12000000, 'Automático', 36.0, 'Vestir', 1014, '126234', 3, 60, 2),
(29, 'GMT-Master II', 18000000, 'Automático', 40.0, 'Viajero', 1029, '126710BLRO', 1, 60, 2),

-- Marca 3: Omega
(3, 'Speedmaster Moonwatch', 8500000, 'Mecánico', 42.0, 'Cronógrafo', 1003, '310.30.42.50', 4, 60, 3),
(15, 'Seamaster 300M', 6500000, 'Automático', 42.0, 'Buceo', 1015, '210.30.42.20', 5, 60, 3),
(16, 'Aqua Terra 150M', 7200000, 'Automático', 41.0, 'Casual', 1016, '220.10.41.21', 4, 60, 3),
(30, 'De Ville Prestige', 4500000, 'Automático', 39.5, 'Vestir', 1030, '424.10.40.20', 3, 60, 3),

-- Marca 4: Seiko
(4, 'Seiko 5 Sports', 350000, 'Automático', 42.5, 'Casual', 1004, 'SRPD55K1', 15, 24, 4),
(17, 'Prospex Alpinist', 850000, 'Automático', 39.5, 'Deportivo', 1017, 'SPB121J1', 10, 24, 4),
(18, 'Presage Cocktail Time', 620000, 'Automático', 40.5, 'Vestir', 1018, 'SRPB41J1', 8, 24, 4),
(31, 'Prospex Turtle', 580000, 'Automático', 45.0, 'Buceo', 1031, 'SRP777', 12, 24, 4),

-- Marca 5: Tag Heuer
(5, 'Carrera Calibre 16', 4200000, 'Automático', 44.0, 'Racing', 1005, 'CBM2110', 3, 24, 5),
(19, 'Monaco Gulf Edition', 8500000, 'Automático', 39.0, 'Racing', 1019, 'CBL2115', 2, 24, 5),
(20, 'Aquaracer Professional', 3800000, 'Automático', 43.0, 'Buceo', 1020, 'WBP201A', 6, 24, 5),
(32, 'Formula 1', 1800000, 'Cuarzo', 43.0, 'Racing', 1032, 'WAZ1010', 8, 24, 5),

-- Marca 6: Garmin
(6, 'Fenix 7X Sapphire', 950000, 'Smartwatch', 51.0, 'Deportivo', 1006, '010-02541', 8, 12, 6),
(21, 'Forerunner 965', 850000, 'Smartwatch', 47.1, 'Deportivo', 1021, '010-02809', 15, 12, 6),
(33, 'Instinct 2 Solar', 550000, 'Smartwatch', 45.0, 'Deportivo', 1033, '010-02627', 15, 12, 6),
(34, 'Venu 3', 600000, 'Smartwatch', 45.0, 'Casual', 1034, '010-02784', 10, 12, 6),

-- Marca 7: Tissot
(7, 'PRX Powermatic 80', 780000, 'Automático', 40.0, 'Clásico', 1007, 'T137.407.11', 12, 24, 7),
(22, 'Le Locle Powermatic', 750000, 'Automático', 39.3, 'Vestir', 1022, 'T006.407.11', 9, 24, 7),
(23, 'Seastar 1000', 550000, 'Cuarzo', 45.5, 'Buceo', 1023, 'T120.417.11', 14, 24, 7),
(35, 'Gentleman', 850000, 'Automático', 40.0, 'Casual', 1035, 'T127.407.11', 5, 24, 7),

-- Marca 8: Citizen
(8, 'Promaster Eco-Drive', 410000, 'Eco-Drive', 44.0, 'Buceo', 1008, 'BN0150-28E', 20, 36, 8),
(24, 'Tsuyosa Automatic', 350000, 'Automático', 40.0, 'Casual', 1024, 'NJ0150-81E', 22, 36, 8),
(36, 'Garrison Eco-Drive', 250000, 'Eco-Drive', 42.0, 'Militar', 1036, 'BM8180-03E', 25, 36, 8),
(37, 'Nighthawk', 450000, 'Eco-Drive', 42.0, 'Aviador', 1037, 'BJ7000-52E', 10, 36, 8),

-- Marca 9: Fossil
(9, 'Grant Chronograph', 120000, 'Cuarzo', 44.0, 'Casual', 1009, 'FS4736', 25, 12, 9),
(25, 'Nate Chronograph', 140000, 'Cuarzo', 50.0, 'Deportivo', 1025, 'JR1401', 18, 12, 9),
(38, 'Townsman Automatic', 280000, 'Automático', 44.0, 'Vestir', 1038, 'ME3099', 12, 12, 9),
(39, 'Machine Chronograph', 150000, 'Cuarzo', 42.0, 'Casual', 1039, 'FS4656', 20, 12, 9),

-- Marca 10: Orient
(10, 'Bambino Version 2', 280000, 'Automático', 40.5, 'Vestir', 1010, 'FAC00009W', 6, 12, 10),
(26, 'Kamasu Ray II', 320000, 'Automático', 41.8, 'Buceo', 1026, 'RA-AA0001B', 11, 12, 10),
(27, 'Sun and Moon V3', 450000, 'Automático', 42.5, 'Clásico', 1027, 'RA-AK0008S', 7, 12, 10),
(40, 'Mako III', 350000, 'Automático', 41.8, 'Buceo', 1040, 'RA-AA0002L', 8, 12, 10);
GO
GO

-- id_medio_pago: 1=Efectivo, 2=Transferencia, 3=Visa Credito, etc.
INSERT INTO [Factura] ([id_factura], [fecha_factura], [impuesto], [estado_factura], [id_medio_pago]) VALUES
(1, '2026-05-10T10:30:00', 21, 'Pagado', 3),
(2, '2026-05-11T14:15:00', 21, 'Pendiente', 2),
(3, '2026-05-12T16:45:00', 21, 'Pagado', 1),
(4, '2026-05-13T09:20:00', 21, 'Pagado', 8),
(5, '2026-05-14T11:10:00', 21, 'Anulado', 4),
(6, '2026-05-15T15:30:00', 21, 'Pagado', 2),
(7, '2026-05-16T12:00:00', 21, 'Pagado', 6),
(8, '2026-05-17T18:25:00', 21, 'Pagado', 10),
(9, '2026-05-18T10:05:00', 21, 'Pendiente', 2),
(10, '2026-05-19T17:40:00', 21, 'Pagado', 3);
GO

-- ==========================================
-- NIVEL 2: DEPENDENCIAS DE SEGUNDO GRADO
-- ==========================================
INSERT INTO [Cliente] ([id_cliente], [nombre_cliente], [apellido_cliente], [email_cliente], [telefono_cliente], [cuit_cliente], [calle_direccion], [altura_direccion], [id_localidad]) VALUES
(1, 'Tomas', 'Otero', 'tomas@email.com', 11445566, 20334455, 'Av. Cabildo', 2500, 1),
(2, 'Franco', 'Salazar', 'profe@uade.edu.ar', 11223344, 20112233, 'Lima', 757, 1),
(3, 'Lionel', 'Messi', 'leo@miami.com', 11998877, 20998877, 'Costanera Norte', 10, 4),
(4, 'Emiliano', 'Martinez', 'dibu@aston.com', 11554433, 20554433, 'Playa Grande', 1500, 2),
(5, 'Angel', 'Di Maria', 'fideo@sl.com', 11667788, 20667788, 'Centro', 300, 4),
(6, 'Rodrigo', 'De Paul', 'rodri@atl.com', 11776655, 20776655, 'Av. San Martin', 400, 1),
(7, 'Julian', 'Alvarez', 'arana@mcity.com', 11889900, 20889900, 'Ruta 9', 150, 3),
(8, 'Enzo', 'Fernandez', 'enzo@cfc.com', 11221122, 20221122, 'Av. Libertador', 5000, 1),
(9, 'Alexis', 'Mac Allister', 'colo@liv.com', 11332211, 20332211, 'Ruta 40', 800, 5),
(10, 'Cristian', 'Romero', 'cuti@spur.com', 11443322, 20443322, 'Av. General Paz', 120, 2);
GO

-- Registramos un cambio de precio para los 10 relojes (ej. inflación)
INSERT INTO [Historial_Precios] ([id_historial], [id_producto], [precio_anterior], [precio_nuevo], [fecha_cambio]) VALUES
(1, 1, 200000, 250000, '2026-04-01T00:00:00'),
(2, 2, 14000000, 15000000, '2026-04-15T00:00:00'),
(3, 3, 8000000, 8500000, '2026-04-20T00:00:00'),
(4, 4, 300000, 350000, '2026-04-22T00:00:00'),
(5, 5, 4000000, 4200000, '2026-05-01T00:00:00'),
(6, 6, 850000, 950000, '2026-05-02T00:00:00'),
(7, 7, 700000, 780000, '2026-05-05T00:00:00'),
(8, 8, 380000, 410000, '2026-05-08T00:00:00'),
(9, 9, 100000, 120000, '2026-05-10T00:00:00'),
(10, 10, 250000, 280000, '2026-05-12T00:00:00');
GO

-- Relacionamos qué proveedor trae qué producto
INSERT INTO [Producto_Proveedor] ([id_producto], [id_proveedor]) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), 
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
GO

-- ==========================================
-- NIVEL 3 Y 4: CIRCUITO DE PEDIDOS Y RESEÑAS
-- ==========================================
INSERT INTO [Pedido] ([id_pedido], [fecha_pedido], [fecha_entrega], [num_factura], [id_cliente], [id_empleado]) VALUES
(1, '2026-05-10T10:30:00', '2026-05-12T10:30:00', 1, 1, 1),
(2, '2026-05-11T14:15:00', NULL, 2, 2, 2),
(3, '2026-05-12T16:45:00', '2026-05-14T10:00:00', 3, 3, 3),
(4, '2026-05-13T09:20:00', '2026-05-15T12:00:00', 4, 4, 4),
(5, '2026-05-14T11:10:00', NULL, 5, 5, 5),
(6, '2026-05-15T15:30:00', '2026-05-17T09:00:00', 6, 6, 6),
(7, '2026-05-16T12:00:00', '2026-05-18T14:30:00', 7, 7, 7),
(8, '2026-05-17T18:25:00', '2026-05-19T11:15:00', 8, 8, 8),
(9, '2026-05-18T10:05:00', NULL, 9, 9, 9),
(10, '2026-05-19T17:40:00', '2026-05-21T16:00:00', 10, 10, 10);
GO

-- Acá "congelamos" el precio al momento de la venta
INSERT INTO [Pedido_Producto] ([id_pedido], [id_producto], [cantidad_comprada], [precio_venta_historico]) VALUES
(1, 1, 1, 250000),
(2, 2, 1, 15000000),
(3, 3, 1, 8500000),
(4, 4, 2, 350000),
(5, 5, 1, 4200000),
(6, 6, 1, 950000),
(7, 7, 3, 780000),
(8, 8, 1, 410000),
(9, 9, 5, 120000),
(10, 10, 2, 280000);
GO

-- Las reseñas deben apuntar a la combinación exacta del pedido y el producto vendido
INSERT INTO [Reseña] ([id_reseña], [id_pedido], [id_producto], [contenido], [fecha_reseña]) VALUES
(1, 1, 1, 'Excelente reloj, resiste todo. Lo metí en el barro y sigue perfecto.', '2026-05-15T10:00:00'),
(2, 2, 2, 'Una joya absoluta. El profe Salazar me puso un 10 por llevarlo puesto.', '2026-05-20T12:00:00'),
(3, 3, 3, 'Increíble cronógrafo, vale cada peso.', '2026-05-18T09:30:00'),
(4, 4, 4, 'Compré dos. Muy buena relación calidad-precio.', '2026-05-17T15:45:00'),
(5, 5, 5, 'Hermoso, pero la entrega se demoró un poco.', '2026-05-22T11:10:00'),
(6, 6, 6, 'La batería de este smartwatch es infinita. Lo recomiendo.', '2026-05-20T16:20:00'),
(7, 7, 7, 'Diseño clásico retro muy elegante.', '2026-05-21T14:00:00'),
(8, 8, 8, 'El sistema Eco-Drive es un golazo, me olvido de las pilas.', '2026-05-23T10:15:00'),
(9, 9, 9, 'Los compré para regalo de la empresa. Cumplen bien.', '2026-05-25T13:30:00'),
(10, 10, 10, 'Reloj de vestir clásico. Un poco chico el dial, pero lindo.', '2026-05-26T18:00:00');
GO