CREATE DATABASE Reloj;
GO

USE Reloj;
GO

-- ============================================================
-- ESQUEMA DE BASE DE DATOS - Relojería
-- Las 14 tablas, normalizado a 3FN.
-- Orden por nivel de dependencia (padres antes que hijos).
-- ============================================================


-- ============================================================
-- NIVEL 0: TABLAS PADRE (sin dependencias)
-- ============================================================
CREATE TABLE Provincia (
    id_provincia      INT PRIMARY KEY,
    nombre_provincia  VARCHAR(100)
);
GO

CREATE TABLE Marca (
    id_marca      INT PRIMARY KEY,
    nombre_marca  VARCHAR(100)
);
GO

CREATE TABLE Empleado (
    id_empleado        INT PRIMARY KEY,
    apellido_empleado  VARCHAR(150),
    nombre_empleado    VARCHAR(150)
);
GO

CREATE TABLE Medio_Pago (
    id_medio_pago  INT PRIMARY KEY,
    nombre_pago    VARCHAR(100)
);
GO

CREATE TABLE Proveedor (
    id_proveedor      INT PRIMARY KEY,
    nombre_proveedor  VARCHAR(100),
    email_proveedor   VARCHAR(100)
);
GO


-- ============================================================
-- NIVEL 1: DEPENDENCIAS DE PRIMER GRADO
-- ============================================================
CREATE TABLE Localidad (
    id_localidad      INT PRIMARY KEY,
    nombre_localidad  VARCHAR(150),
    codigo_postal     VARCHAR(20),
    id_provincia      INT FOREIGN KEY REFERENCES Provincia(id_provincia)
);
GO

CREATE TABLE Producto (
    id_producto     INT PRIMARY KEY,
    nombre_reloj    VARCHAR(150),
    precio          FLOAT,
    movimiento      VARCHAR(100),
    diametro        FLOAT,
    estilo          VARCHAR(100),
    num_serie       INT,
    ref_modelo      VARCHAR(100),
    stock           INT,
    meses_garantia  INT,
    id_marca        INT FOREIGN KEY REFERENCES Marca(id_marca)
);
GO

CREATE TABLE Factura (
    id_factura      INT PRIMARY KEY,
    fecha_factura   DATETIME,
    impuesto        INT,
    estado_factura  VARCHAR(50),
    id_medio_pago   INT FOREIGN KEY REFERENCES Medio_Pago(id_medio_pago)
);
GO


-- ============================================================
-- NIVEL 2: DEPENDENCIAS DE SEGUNDO GRADO
-- ============================================================
CREATE TABLE Cliente (
    id_cliente        INT PRIMARY KEY,
    nombre_cliente    VARCHAR(150),
    apellido_cliente  VARCHAR(150),
    email_cliente     VARCHAR(150),
    telefono_cliente  INT,
    cuit_cliente      INT,
    calle_direccion   VARCHAR(150),
    altura_direccion  INT,
    id_localidad      INT FOREIGN KEY REFERENCES Localidad(id_localidad)
);
GO

CREATE TABLE Historial_Precios (
    id_historial     INT PRIMARY KEY,
    id_producto      INT FOREIGN KEY REFERENCES Producto(id_producto),
    precio_anterior  FLOAT,
    precio_nuevo     FLOAT,
    fecha_cambio     DATETIME
);
GO

CREATE TABLE Producto_Proveedor (
    id_producto   INT FOREIGN KEY REFERENCES Producto(id_producto),
    id_proveedor  INT FOREIGN KEY REFERENCES Proveedor(id_proveedor),
    PRIMARY KEY (id_producto, id_proveedor)
);
GO


-- ============================================================
-- NIVEL 3 Y 4: CIRCUITO DE PEDIDOS Y RESEÑAS
-- ============================================================
CREATE TABLE Pedido (
    id_pedido      INT PRIMARY KEY,
    fecha_pedido   DATETIME,
    fecha_entrega  DATETIME,
    num_factura    INT FOREIGN KEY REFERENCES Factura(id_factura),
    id_cliente     INT FOREIGN KEY REFERENCES Cliente(id_cliente),
    id_empleado    INT FOREIGN KEY REFERENCES Empleado(id_empleado)
);
GO

CREATE TABLE Pedido_Producto (
    id_pedido               INT FOREIGN KEY REFERENCES Pedido(id_pedido),
    id_producto             INT FOREIGN KEY REFERENCES Producto(id_producto),
    cantidad_comprada       INT,
    precio_venta_historico  FLOAT,
    PRIMARY KEY (id_pedido, id_producto)
);
GO

CREATE TABLE Reseña (
    id_reseña     INT PRIMARY KEY,
    id_pedido     INT NOT NULL,
    id_producto   INT NOT NULL,
    contenido     TEXT,
    fecha_reseña  DATETIME,
    -- FK compuesta: apunta exactamente a la combinación Pedido + Producto
    FOREIGN KEY (id_pedido, id_producto) REFERENCES Pedido_Producto(id_pedido, id_producto)
);
GO
