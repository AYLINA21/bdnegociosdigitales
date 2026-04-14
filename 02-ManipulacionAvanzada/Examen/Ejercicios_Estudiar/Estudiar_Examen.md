# 📊 Bases de Datos - Resumen SQL

## 🧠 Consultas Básicas

### 🔹 SELECT
Sirve para mostrar datos de una tabla.

```sql
SELECT * FROM tabla;
SELECT columna1, columna2 FROM tabla;
```
🔹 WHERE

Filtra filas antes de agrupar.

```sql
SELECT *
FROM tabla
WHERE condicion;
```
📌 Ejemplo:
```sql
SELECT *
FROM Customers
WHERE Country = 'USA';
```
## ORDER BY

Ordena los resultados.
```sql
SELECT *
FROM tabla
ORDER BY columna ASC;
```
## 🧩 Proyección

Selecciona solo columnas específicas.
```sql
SELECT nombre, edad
FROM personas;
```

## 🏷️ Alias

Cambia el nombre de columnas.
``` sql
SELECT nombre AS NombreCliente
FROM clientes;
```

## 🧮 Campos Calculados

Permiten hacer operaciones.
```sql
SELECT precio * cantidad AS total
FROM ventas;
```
📌 Con descuento:

``` sql
SELECT (UnitPrice * Quantity) * (1 - Discount) AS total
FROM [Order Details];
```

## ⚙️ Operadores
🔸 Relacionales
```shell
> mayor que
< menor que
= igual
!= diferente
```

## 🔸 Lógicos

```shell
AND → ambas condiciones
OR → una u otra
NOT → negación
WHERE edad > 18 AND ciudad = 'Tula';
```

## 🔍 Filtros Especiales
```shell
🔸 IN
WHERE pais IN ('Mexico','USA');
🔸 BETWEEN
WHERE precio BETWEEN 10 AND 50;
🔸 LIKE
WHERE nombre LIKE 'a%';
```


## 📌 Comodines:

```shell
% → varios caracteres
_ → un carácter

```

## 📊 Funciones de Agregado


### 🔹 COUNT()

Cuenta registros.

SELECT COUNT(*) FROM tabla;

### 🔹 SUM()

Suma valores.

SELECT SUM(precio) FROM tabla;

### 🔹 AVG()

Promedio.

SELECT AVG(precio) FROM tabla;

### 🔹 MAX() / MIN()

Valor máximo y mínimo.

## 📊 GROUP BY

Agrupa datos.
```sql
SELECT pais, COUNT(*)
FROM clientes
GROUP BY pais;
```

📌 Regla:
Todas las columnas del SELECT que no son función deben ir en GROUP BY.

## ⚠️ HAVING

Filtra grupos (después del GROUP BY).
```sql
SELECT pais, COUNT(*)
FROM clientes
GROUP BY pais
HAVING COUNT(*) > 5;

```

### 🔥 Diferencias Clave
Cláusula	| Función
WHERE	| Filtra filas
GROUP BY	| Agrupa datos
HAVING	| Filtra grupos

## 🔄 Orden de Ejecución
```sql
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
```

## 🔗 JOINS
### 🔹 INNER JOIN

Muestra coincidencias.
```sql
SELECT *
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID;
```
### 🔹 LEFT JOIN

Todo de la izquierda + coincidencias.

### 🔹 RIGHT JOIN

Todo de la derecha.

### 🔹 FULL JOIN

Todo de ambas tablas.

## 🏗️ Creación de Tablas
```sql
CREATE TABLE clientes(
 id INT,
 nombre VARCHAR(50)
);
```

## ➕ INSERT
```sql
INSERT INTO clientes VALUES (1,'Aylin');
```

## 🔐 FOREIGN KEY

Relaciona tablas.
```sql
FOREIGN KEY (id_cliente)
REFERENCES clientes(id)
```

## ⚙️ STORED PROCEDURES
```sql
CREATE PROC saludo
AS
BEGIN
 PRINT 'Hola mundo';
END;
```

## 🔹 Con parámetros
```sql
CREATE PROC saludar
@nombre VARCHAR(50)
AS
BEGIN
 PRINT 'Hola ' + @nombre;
END;
```

## 🔹 OUTPUT
```sql
@resultado INT OUTPUT
```

## 🧪 Validaciones
```sql
IF NOT EXISTS(...)
IF @valor < 0
```

## 🚨 Manejo de Errores
```sql
BEGIN TRY
END TRY
BEGIN CATCH
END CATCH;
```

## 💳 Transacciones
```sql
BEGIN TRANSACTION
COMMIT
ROLLBACK
```

## 🔥 THROW
```sql
THROW 50001, 'Error', 1;
```

## 🔀 CASE
```sql
CASE
 WHEN precio > 100 THEN 'Caro'
 ELSE 'Barato'
END
```

## 🚀 Resumen Final
```shell
SELECT → mostrar
WHERE → filtrar
GROUP BY → agrupar
HAVING → filtrar grupos
JOIN → unir tablas
COUNT / SUM → resumir
```

## 🚀 Guardar cambios en Git (flujo básico)

### 🟢 Paso 1: Agregar cambios

```bash
git add .
```

Agrega todos los archivos modificados al área de preparación.

---

### 🟡 Paso 2: Crear commit

```bash
git commit -m "nombre del commit"
```

Guarda los cambios con un mensaje descriptivo.

---

### 🔵 Paso 3: Cambiar a la rama principal

```bash
git checkout main
```

Cambia a la rama principal del proyecto.

---

### 🟣 Paso 4: Hacer merge de la rama

```bash
git merge nombre_rama
```

Une los cambios de tu rama a la rama principal.

---

### 🔴 Paso 5: Subir cambios al repositorio

```bash
git push
```

Envía los cambios al repositorio remoto (GitHub).

---

## 💡 Ejemplo completo

```bash
git add .
git commit -m "agregando stored procedure de ventas"
git checkout main
git merge mi-rama
git push
```
