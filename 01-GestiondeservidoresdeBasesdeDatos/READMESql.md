# Guía de Instalación de SQL Server Management Studio (SSMS)

## Introducción

El presente documento describe los pasos necesarios para descargar e instalar SQL Server Management Studio (SSMS), una herramienta utilizada para la administración, configuración y consulta de bases de datos en Microsoft SQL Server. Esta guía está dirigida a estudiantes que comienzan a trabajar con sistemas gestores de bases de datos.

---

## ¿Qué es SQL Server Management Studio?

SQL Server Management Studio (SSMS) es una aplicación desarrollada por Microsoft que permite administrar bases de datos de SQL Server. A través de esta herramienta se pueden crear bases de datos, ejecutar consultas SQL, gestionar usuarios y realizar tareas de mantenimiento.

---
## Descarga de SQL Server Management Studio

1. Abrir un navegador web.
2. Acceder al sitio oficial de Microsoft:
   https://learn.microsoft.com/sql/ssms
3. Hacer clic en el botón **Download SQL Server Management Studio (SSMS)**.
4. Esperar a que se complete la descarga del instalador.

## Descarga de SQL 
![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20101137.png)

## Instalación de SQL Server Management Studio

1. Abrir el archivo descargado del instalador.
2. Aceptar los términos y condiciones.
3. Hacer clic en el botón **Install**.
4. Esperar a que el proceso de instalación finalice.
5. Reiniciar el equipo si el sistema lo solicita.

## Verificación de la instalación

1. Abrir el menú Inicio de Windows.
2. Buscar **SQL Server Management Studio**.
3. Ejecutar la aplicación.
4. Verificar que se muestre la ventana principal de SSMS.

## Conexión al servidor

1. Al abrir SSMS, se mostrará la ventana **Connect to Server**.
2. Seleccionar el tipo de servidor: **Database Engine**.
3. Ingresar el nombre del servidor.
4. Seleccionar el tipo de autenticación:
   - Autenticación de Windows
   - Autenticación de SQL Server
5. Hacer clic en **Connect**.

## Conclusión

SQL Server Management Studio es una herramienta fundamental para la administración de bases de datos en SQL Server. Mediante esta guía se describieron los pasos básicos para su descarga, instalación y verificación, permitiendo al usuario comenzar a trabajar con bases de datos de forma adecuada.

---

## Descarga de SQL 
![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20101137.png)

## Conclusión

SQL Server Management Studio es una herramienta fundamental para la administración de bases de datos en SQL Server. Mediante esta guía se describieron los pasos básicos para su descarga, instalación y verificación, permitiendo al usuario comenzar a trabajar con bases de datos de forma adecuada.

## Video de clase [INSTALACION SQL](https://www.canva.com/design/DAG_KE55rzA/Jgilg2LCDyr0Ij6CkRdFxg/edit?utm_content=DAG_KE55rzA&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton).

## Inicio SQL
![This is an alt text.](/IMG/Captura%20de%20pantalla%202026-01-22%20103836.png)

## Comandos básicos de SQL

### Creación y selección de bases de datos

| Comando | Descripción |
|--------|-------------|
| `CREATE DATABASE nombre_bd;` | Crea una nueva base de datos. |
| `USE nombre_bd;` | Selecciona la base de datos a utilizar. |
| `DROP DATABASE nombre_bd;` | Elimina una base de datos existente. |

---

### Creación y eliminación de tablas

| Comando | Descripción |
|--------|-------------|
| `CREATE TABLE nombre_tabla (...);` | Crea una nueva tabla dentro de la base de datos. |
| `DROP TABLE nombre_tabla;` | Elimina una tabla existente. |
| `TRUNCATE TABLE nombre_tabla;` | Elimina todos los registros de una tabla sin borrar su estructura. |

---

### Inserción, consulta y eliminación de datos

| Comando | Descripción |
|--------|-------------|
| `INSERT INTO nombre_tabla VALUES (...);` | Inserta registros en una tabla. |
| `SELECT * FROM nombre_tabla;` | Muestra todos los registros de una tabla. |
| `SELECT columna1, columna2 FROM nombre_tabla;` | Muestra columnas específicas de una tabla. |
| `DELETE FROM nombre_tabla WHERE condición;` | Elimina registros que cumplen una condición. |

---

### Actualización de datos

| Comando | Descripción |
|--------|-------------|
| `UPDATE nombre_tabla SET columna = valor WHERE condición;` | Actualiza registros existentes en una tabla. |

---

### Filtros y condiciones

| Comando | Descripción |
|--------|-------------|
| `WHERE` | Filtra registros según una condición. |
| `ORDER BY columna ASC/DESC;` | Ordena los resultados de una consulta. |
| `LIMIT número;` | Limita la cantidad de registros mostrados. |
| `LIKE` | Permite buscar patrones dentro de un campo. |

---

### Funciones básicas

| Comando | Descripción |
|--------|-------------|
| `COUNT(columna)` | Cuenta el número de registros. |
| `SUM(columna)` | Suma los valores de una columna. |
| `AVG(columna)` | Calcula el promedio de una columna. |
| `MAX(columna)` | Obtiene el valor máximo. |
| `MIN(columna)` | Obtiene el valor mínimo. |

---

### Relaciones entre tablas

| Comando | Descripción |
|--------|-------------|
| `PRIMARY KEY` | Define una clave primaria. |
| `FOREIGN KEY` | Define una clave foránea. |
| `JOIN` | Permite combinar registros de dos o más tablas. |

---

### Control de transacciones

| Comando | Descripción |
|--------|-------------|
| `BEGIN TRANSACTION;` | Inicia una transacción. |
| `COMMIT;` | Guarda los cambios realizados. |
| `ROLLBACK;` | Revierte los cambios no confirmados. |
