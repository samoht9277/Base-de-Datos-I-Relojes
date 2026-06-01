# Base de Datos - Relojería 🕒

Proyecto de Base de Datos I (UADE). Una tienda de relojes en SQL Server.

## Cómo correrlo

Abrí los archivos en SQL Server Management Studio (SSMS) y ejecutalos **en este orden**:

1. `Reloj.sql` — crea la base de datos y las tablas.
2. `BaseDato.sql` — carga los datos.
3. `Procedimientos_Reloj.sql` — crea los stored procedures.
4. `Consultas_Reloj.sql` — consultas de ejemplo para chequear que ande.

> ⚠️ El orden importa: cada archivo necesita que hayas corrido el anterior.

## Archivos

| Archivo | Qué hace |
|---|---|
| `Reloj.sql` | Crea la base `Reloj` + las 14 tablas (la estructura) |
| `BaseDato.sql` | Inserta los datos de prueba (marcas, relojes, clientes, pedidos, etc.) |
| `Procedimientos_Reloj.sql` | 3 stored procedures: registrar venta, actualizar precio, reporte por cliente |
| `Consultas_Reloj.sql` | Consultas `SELECT` de ejemplo |
| `presentacion.html` | Presentación del proyecto |
