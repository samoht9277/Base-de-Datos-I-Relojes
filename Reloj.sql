CREATE DATABASE Reloj;

USE Reloj;
-- NIVEL 0: TABLAS PADRE (Sin dependencias)

CREATE TABLE [Provincia] (
  [id_provincia] int PRIMARY KEY,
  [nombre_provincia] varchar(100)
)
GO

CREATE TABLE [Marca] (
  [id_marca] int PRIMARY KEY,
  [nombre_marca] varchar(100)
)
GO

CREATE TABLE [Empleado] (
  [id_empleado] int PRIMARY KEY,
  [apellido_empleado] varchar(150),
  [nombre_empleado] varchar(150)
)
GO

CREATE TABLE [Medio_Pago] (
  [id_medio_pago] int PRIMARY KEY,
  [nombre_pago] varchar(100)
)
GO

CREATE TABLE [Proveedor] (
  [id_proveedor] int PRIMARY KEY,
  [nombre_proveedor] varchar(100),
  [email_proveedor] varchar(100)
)
GO

-- NIVEL 1: DEPENDENCIAS DE PRIMER GRADO

CREATE TABLE [Localidad] (
  [id_localidad] int PRIMARY KEY,
  [nombre_localidad] varchar(150),
  [codigo_postal] varchar(20),
  [id_provincia] int FOREIGN KEY REFERENCES [Provincia]([id_provincia])
)
GO

CREATE TABLE [Producto] (
  [id_producto] int PRIMARY KEY,
  [nombre_reloj] varchar(150),
  [precio] float,
  [movimiento] varchar(100),
  [diametro] float,
  [estilo] varchar(100),
  [num_serie] int,
  [ref_modelo] varchar(100),
  [stock] int,
  [meses_garantia] int,
  [id_marca] int FOREIGN KEY REFERENCES [Marca]([id_marca])
)
GO

CREATE TABLE [Factura] (
  [id_factura] int PRIMARY KEY,
  [fecha_factura] datetime,
  [impuesto] int,
  [estado_factura] varchar(50),
  [id_medio_pago] int FOREIGN KEY REFERENCES [Medio_Pago]([id_medio_pago])
)
GO

-- NIVEL 2: DEPENDENCIAS DE SEGUNDO GRADO


CREATE TABLE [Cliente] (
  [id_cliente] int PRIMARY KEY,
  [nombre_cliente] varchar(150),
  [apellido_cliente] varchar(150),
  [email_cliente] varchar(150),
  [telefono_cliente] int,
  [cuit_cliente] int,
  [calle_direccion] varchar(150),
  [altura_direccion] int,
  [id_localidad] int FOREIGN KEY REFERENCES [Localidad]([id_localidad])
)
GO

CREATE TABLE [Historial_Precios] (
  [id_historial] int PRIMARY KEY,
  [id_producto] int FOREIGN KEY REFERENCES [Producto]([id_producto]),
  [precio_anterior] float,
  [precio_nuevo] float,
  [fecha_cambio] datetime
)
GO

CREATE TABLE [Producto_Proveedor] (
  [id_producto] int FOREIGN KEY REFERENCES [Producto]([id_producto]),
  [id_proveedor] int FOREIGN KEY REFERENCES [Proveedor]([id_proveedor]),
  PRIMARY KEY ([id_producto], [id_proveedor])
)
GO

-- NIVEL 3 Y 4: CIRCUITO DE PEDIDOS Y RESEÑAS


CREATE TABLE [Pedido] (
  [id_pedido] int PRIMARY KEY,
  [fecha_pedido] datetime,
  [fecha_entrega] datetime,
  [num_factura] int FOREIGN KEY REFERENCES [Factura]([id_factura]),
  [id_cliente] int FOREIGN KEY REFERENCES [Cliente]([id_cliente]),
  [id_empleado] int FOREIGN KEY REFERENCES [Empleado]([id_empleado])
)
GO

CREATE TABLE [Pedido_Producto] (
  [id_pedido] int FOREIGN KEY REFERENCES [Pedido]([id_pedido]),
  [id_producto] int FOREIGN KEY REFERENCES [Producto]([id_producto]),
  [cantidad_comprada] int,
  [precio_venta_historico] float,
  PRIMARY KEY ([id_pedido], [id_producto]) 
)
GO

CREATE TABLE [Reseña] (
  [id_reseña] int PRIMARY KEY,
  [id_pedido] int,
  [id_producto] int,
  [contenido] text,
  [fecha_reseña] datetime,
  -- FK Compuesta: Apunta exactamente a la combinación Pedido+Producto
  FOREIGN KEY ([id_pedido], [id_producto]) REFERENCES [Pedido_Producto]([id_pedido], [id_producto])
)
GO

-- CARGA DE DATOS DE PRUEBA (MOCK DATA)

INSERT INTO [Marca] ([id_marca], [nombre_marca])
VALUES  (1, 'Casio');
GO

INSERT INTO [Producto] ([id_producto], [nombre_reloj], [precio], [stock], [meses_garantia], [id_marca])
VALUES  (100, 'G-Shock', 150000, 3, 12, 1);
GO

INSERT INTO [Historial_Precios] ([id_historial], [id_producto], [precio_anterior], [precio_nuevo], [fecha_cambio])
VALUES  (1, 100, 130000, 150000, '2026-05-01T10:00:00');
GO