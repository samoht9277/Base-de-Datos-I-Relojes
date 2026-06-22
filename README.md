# Base de Datos - Relojería 🕒

Proyecto de Base de Datos I (UADE). Una tienda de relojes en SQL Server, normalizada a 3FN.

## Cómo correrlo

Abrí los archivos en SQL Server Management Studio (SSMS) y ejecutalos **en este orden**:

1. `Reloj.sql` — crea la base de datos y las 14 tablas.
2. `BaseDato.sql` — carga los datos de prueba.
3. `Funciones_Reloj.sql` — crea la función.
4. `Procedimientos_Reloj.sql` — crea los stored procedures.
5. `Consultas_Reloj.sql` — crea las vistas y triggers, y corre las consultas.

> ⚠️ El orden importa: cada archivo necesita que hayas corrido el anterior.

`Casos_Prueba.sql` se corre aparte: son casos negativos que **deben fallar** (prueban que las restricciones del modelo funcionan).

## Archivos

| Archivo | Qué hace |
|---|---|
| `Reloj.sql` | Crea la base `Reloj` + las 14 tablas, normalizadas a 3FN (la estructura) |
| `BaseDato.sql` | Inserta los datos de prueba: 40 relojes + marcas, clientes, pedidos, etc. |
| `Funciones_Reloj.sql` | Función `fn_PrecioConIVA`: precio de lista con IVA (21%) |
| `Procedimientos_Reloj.sql` | 3 stored procedures: registrar venta, actualizar precio, reporte por cliente |
| `Consultas_Reloj.sql` | 2 vistas, 10 consultas de ejemplo y 2 triggers de validación |
| `Casos_Prueba.sql` | Casos negativos que deben fallar (FK inexistente, PK duplicada, tipo inválido) |
