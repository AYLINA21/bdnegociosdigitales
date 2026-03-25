# Actividad de Evaluación 2
TEMA 1 
## Consultas simples 

Introducción

En este reporte se presentan consultas simples en SQL, con el propósito de comprender cómo se puede obtener y organizar información desde una base de datos de manera clara y eficiente. A lo largo del desarrollo se aplican instrucciones básicas como SELECT, el uso de alias, campos calculados, operadores lógicos y relacionales, así como consultas con fechas y patrones de búsqueda.

Para la realización de estas consultas se utiliza la base de datos Northwind, proporcionada por el profesor Gallardo, la cual simula un entorno real de ventas, productos, clientes y pedidos. Esto permite practicar consultas SQL en situaciones similares a las que se presentan en sistemas reales.

El objetivo principal de este trabajo es reforzar los conocimientos básicos de SQL y comprender la importancia de las consultas simples como base para el manejo y análisis de información dentro de una base de datos relacional.

### Antes de comenzar es importante tener esto presente

# SELECT *

### ¿Para qué sirve?
Sirve para mostrar todos los campos (columnas) de una tabla sin necesidad de escribirlos uno por uno.
#### Sintaxis
```shell
SELECT *
FROM NombreTabla;
```
# Proyección

### ¿Qué es?
La proyección es el proceso de seleccionar únicamente ciertos campos específicos de una tabla.

### ¿Para qué sirve?

 * Mostrar solo la información necesaria

 * Reducir datos innecesarios

 * Hacer consultas más claras y eficientes

 #### Sintaxis
```shell
SELECT columna1, columna2
FROM NombreTabla;
```

# Alias de columnas

### ¿Qué es?
Un alias es un nombre temporal que se le asigna a una columna o tabla en el resultado de una consulta.

### ¿Para qué sirve?

 * Mejorar la presentación de los resultados

 * Hacer más entendibles los nombres de las columnas
 #### Sintaxis
```shell
SELECT columna AS NuevoNombre
FROM NombreTabla;
```
# Campos calculados

### ¿Qué son?
Son valores que no existen físicamente en la tabla, sino que se generan mediante una operación dentro de la consulta.

### ¿Para qué sirven?

 * Realizar cálculos matemáticos

 * Obtener totales, importes o resultados derivados
 #### Sintaxis
```shell
SELECT columna1 * columna2 AS NombreCalculado
FROM NombreTabla;
```
# Operadores lógicos 
## (AND - OR - NOT)

### ¿Para qué sirven?
Permiten combinar varias condiciones dentro de una cláusula WHERE.

AND  → ambas condiciones deben cumplirse

OR → al menos una condición debe cumplirse

NOT → niega una condición
#### Sintaxis
```shell
WHERE condicion1 AND condicion2;
```
# Operadores relacionales

### ¿Para qué sirven?
Permiten comparar valores dentro de una consulta.

###  Principales operadores:
```shell
> mayor que

< menor que

>= mayor o igual que

<= menor o igual que

= igual

<> o != diferente
```
#### Sintaxis
```shell
WHERE columna > valor;
```
# Discount

### ¿Qué es?
Es un campo que representa un porcentaje de descuento aplicado a un producto o venta.

### ¿Para qué sirve?

 * Calcular el importe final de una venta

 * Reducir el precio total según el porcentaje aplicado

 *  Generalmente se usa dentro de operaciones matemáticas.

# Operador IN

###  ¿Para qué sirve?
Permite comparar un valor con una lista de posibles valores en una sola condición.
#### Sintaxis
```shell
WHERE columna IN (valor1, valor2, valor3);
```
# Operador BETWEEN

### ¿Para qué sirve?
Sirve para seleccionar valores que estén dentro de un rango específico, incluyendo los límites.
#### Sintaxis
```shell
WHERE columna BETWEEN valorInferior AND valorSuperior;
```
# Operador LIKE

### ¿Para qué sirve?
Permite buscar datos que coincidan con un patrón de texto.

### Trabaja con comodines como:
```shell
% → varios caracteres

_ → un solo carácter
```
#### Sintaxis
```shell
WHERE columna LIKE 'patron';
```
# Ejemplos de uso en el query realizado en clase 

## SELECT *

 ### Dónde se aplica:
```shell
 SELECT *
FROM Categories;

SELECT *
FROM Products;

SELECT *
FROM Orders;

SELECT *
FROM Order Details;
```
Se está utilizando SELECT * para mostrar todas las columnas de cada tabla sin filtrar información.

## Proyección

### Dónde se aplica:
 ```shell
SELECT
    ProductID,
    ProductName,
    UnitPrice,
    UnitsInSTock
FROM Products;
```
Aquí se seleccionan solo ciertos campos de la tabla Products, lo que corresponde a una proyección, ya que no se muestran todas las columnas.

## Alias de columnas

### Dónde se aplica:
```shell
SELECT
    ProductID AS [NUMERO DE PRODUCTO],
    ProductName 'NOMBRE DE PRODUCTO',
    UnitPrice AS [PRECIO UNITARIO],
    UnitsInSTock AS STOCK
FROM Products;
```
y también:
```shell
SELECT
    CompanyName AS CLIENTE,
    City AS CIUDAD,
    Country AS PAIS
FROM Customers;
```
Se están usando alias para cambiar temporalmente el nombre de las columnas y hacer el resultado más entendible, tambien se usan porque a veces los datos en ambas tablas pueden llamarse igual.

##  Campos calculados

### Dónde se aplica:

```shell
SELECT *, (UnitPrice * UnitsInStock) AS [COSTO INVENTARIO]
FROM Products;
```
y también:

```shell
(UnitPrice * Quantity) AS IMPORTE
```
Se crean columnas nuevas a partir de operaciones matemáticas, las cuales no existen físicamente en la tabla.

## Discount

### Dónde se aplica:

```shell
(UnitPrice * Quantity) * (1 - Discount)
AS [Importe con Descunto 2]
```
Se utiliza el campo Discount para calcular el importe final de una venta aplicando un porcentaje de descuento.

## Operadores relacionales

### Dónde se aplica:
```shell
WHERE UnitPrice > 30
WHERE UnitSInStock < 20
WHERE OrderDate > '1997-12-31'
```
Se usan operadores como >, < para comparar valores y filtrar registros según una condición.

## Operadores lógicos (AND, OR, NOT)

### Dónde se aplica:

```shell
WHERE UnitPrice > 20 AND UnitsInStock < 100;
WHERE Country = 'USA' OR Country = 'Canada';
WHERE NOT (CompanyName LIKE 'a%' OR CompanyName LIKE 'b%');
 ```
 Se combinan varias condiciones dentro del WHERE usando operadores lógicos.

## Operador IN

### Dónde se aplica:
```shell
WHERE Country IN ('Germany','France','UK')
```
El operador IN permite comparar un valor contra una lista de opciones en una sola condición.

## Operador BETWEEN

### Dónde se aplica:
```shell
WHERE UnitPrice BETWEEN 20 AND 40
```
Se seleccionan registros cuyos valores se encuentran dentro de un rango, incluyendo los límites

## Operador LIKE

### Dónde se aplica:
```shell
WHERE CompanyName LIKE 'a%'
WHERE City LIKE '_ondon'
WHERE CompanyName LIKE '[bsp]%'
```
Se utiliza LIKE para buscar patrones de texto usando comodines (%, _, [ ], [^ ]).


## TEMA 2 FUNCIONES DE AGREGADO 

Introducción

En este tema se trabajan las funciones de agregado en SQL, que sirven para obtener información resumida a partir de varios registros de una base de datos. Con estas funciones es posible calcular totales, promedios, cantidades, valores máximos y mínimos, lo cual es muy útil cuando se necesita analizar datos de forma rápida y clara.

El objetivo de este apartado es entender cómo las funciones de agregado ayudan a simplificar la información y facilitan la creación de reportes, especialmente en bases de datos que manejan muchos registros, como las de ventas, productos o clientes.

### Antes de comenzar es importante tener esto presente

## COUNT()

Sirve para contar registros.

+ COUNT(*) → cuenta todas las filas

+ COUNT(campo) → cuenta solo las filas que no sean NULL

#### Sintaxis
Contar todos los registros
```shell
SELECT COUNT(*) 
FROM nombre_tabla;
```
Contar valores no nulos de una columna
```shell
SELECT COUNT(nombre_columna) 
FROM nombre_tabla;
```
Contar valores distintos
```shell
SELECT COUNT(DISTINCT nombre_columna) 
FROM nombre_tabla;
```

## SUM()

Sirve para sumar valores numéricos de una columna.

#### Sintaxis
```shell
SELECT SUM(nombre_columna)
FROM nombre_tabla;
```

## AVG()

Sirve para calcular el promedio de una columna numérica.

#### Sintaxis
```shell
SELECT AVG(nombre_columna)
FROM nombre_tabla;
```

## MAX()

Devuelve el valor más alto de una columna.

#### Sintaxis
```shell
SELECT AVG(nombre_columna)
FROM nombre_tabla;
```

## MIN()

Devuelve el valor más bajo de una columna.

#### Sintaxis
```shell
SELECT MIN(nombre_columna)
FROM nombre_tabla;
```
## COUNT(DISTINCT campo)

Cuenta valores diferentes, sin repetir.

#### Sintaxis
```shell
SELECT COUNT(NOMBRE_COLUMNA) 
FROM NOMBRE_TABLA ;
```

# Ejemplos de uso en el query realizado en clase 

## COUNT()
### Dónde se aplica:
```shell
SELECT COUNT(*) AS [Total de Ordenes]
FROM Orders;

SELECT COUNT(CustomerID)
FROM Customers;

SELECT COUNT(DISTINCT City) AS [CIUDAADES CLIENTES]
FROM Customers;
```

Se utiliza COUNT() para contar registros.
Puede contar todas las filas (*), valores no nulos de una columna o valores distintos con DISTINCT.

## SUM()
### Dónde se aplica:
```shell
SELECT SUM(UnitPrice) AS [suma]
FROM [Order Details];

SELECT SUM(UnitPrice * Quantity * (1-Discount)) AS [Importe]
FROM [Order Details];
```

Se utiliza SUM() para sumar valores numéricos, ya sea de una columna o de una operación (campo calculado).

## AVG()
### Dónde se aplica:
```shell
SELECT AVG(od.UnitPrice) AS [Precio Promedio]
FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID;
```
Se utiliza AVG() para calcular el promedio de valores numéricos.

## MAX()
### Dónde se aplica:
```shell
SELECT MAX(UnitPrice) AS [PRECIO MAS ALTO]
FROM Products;

SELECT MAX(OrderDate) AS [Ultima fecha de compra]
FROM Orders;

SELECT MAX(Quantity) AS [Cantidad Maxima]
FROM [Order Details];
```
Se utiliza MAX() para obtener el valor más alto de una columna (precio, fecha, cantidad, etc.).

## MIN()
### Dónde se aplica:
```shell
SELECT MIN(Quantity) AS [CANTIDAD MINIMA]
FROM [Order Details];

SELECT MIN(UnitPrice * Quantity * (1-Discount)) AS [Importe]
FROM [Order Details];
```
Se utiliza MIN() para obtener el valor más bajo de una columna o de un cálculo.

## TEMA 3 GROUP BY 

INTRODUCCIÓN 

GROUP BY se utiliza para agrupar registros que tienen un mismo valor en una columna y poder aplicar funciones de agregado sobre cada grupo.

En pocas palabras:
  + sirve para resumir información.

 En lugar de ver dato por dato, GROUP BY permite ver resultados por grupos, como:

 + pedidos por cliente

 + productos por categoría

+ clientes por país

 + ventas por producto

 ###  ¿Para qué sirve?

 -  Contar cuántos registros hay por grupo

-  Sacar totales, promedios, máximos o mínimos por grupo

 - Analizar datos de forma más clara y ordenada

- Regla importante 

### Cuando se usa GROUP BY:

Todas las columnas que aparecen en el SELECT y no están dentro de una función de agregado deben ir en el GROUP BY.

# SEGUN SU USO 
### GROUP BY simple (una sola columna)

Se usa cuando se quiere agrupar por un solo campo.
#### SINTAXIS 
```shell
GROUP BY columna;
```
### GROUP BY con funciones de agregado

Es la forma más común: agrupar y aplicar funciones como COUNT, SUM, AVG, etc.
#### SINTAXIS 
```shell
SELECT columna, FUNCION_AGREGADO(columna)
FROM tabla
GROUP BY columna;
```
### GROUP BY con varias columnas

Se usa cuando se necesita agrupar por más de un campo al mismo tiempo.
#### SINTAXIS 
```shell
GROUP BY columna1, columna2;
```

## GROUP BY con ORDER BY

Permite ordenar los resultados agrupados.

#### SINTAXIS

```shell
GROUP BY columna
ORDER BY columna;
```
También se puede ordenar por posición:
#### SINTAXIS
```shell
GROUP BY columna
ORDER BY 2;
```

### GROUP BY con HAVING

Se utiliza para filtrar grupos, no registros individuales.
#### SINTAXIS
```shell
GROUP BY columna
ORDER BY 2;
```
### GROUP BY con funciones y campos calculados

Se agrupan datos y se usan operaciones o cálculos.
#### SINTAXIS
```shell
SELECT columna, FUNCION_AGREGADO(expresion)
FROM tabla
GROUP BY columna;
```

### EJEMPLO EN EL SCRIPT REALIZADO EN CLASE 

#### Agrupa las órdenes por país de envío y cuenta cuántas hay por cada país.

```shell
SELECT ShipCountry, COUNT (*) AS [Total de Ordenes]
FROM Orders
GROUP BY ShipCountry;
```

#### Agrupa las órdenes por cliente.
```shell
SELECT
    CustomerID, 
    COUNT (*) AS [NUMERO DE ORDENES]
FROM Orders
GROUP BY CustomerID;
```

#### Agrupa las órdenes por cliente igual que el anterior, pero ordenado de mayor a menor.
```shell
SELECT
    CustomerID, 
    COUNT (*) AS [NUMERO DE ORDENES]
FROM Orders
GROUP BY CustomerID
ORDER BY 2 DESC;
```

#### GROUP BY con WHERE , Filtra primero y luego agrupa.
```shell
SELECT CustomerID, COUNT (*)
FROM Orders
WHERE CustomerID IN (1,3)
GROUP BY CustomerID;
```
#### Contar productos por categoría
```shell
SELECT CategoryID, COUNT (*) AS [numero de productos]
FROM Products
GROUP BY CategoryID
ORDER BY 2 DESC;
```
#### GROUP BY usando alias en ORDER BY para ordenar 
```shell
SELECT CategoryID, COUNT (*) AS [numero de productos]
FROM Products
GROUP BY CategoryID
ORDER BY [numero de productos] DESC;
```
#### GROUP BY con varias tablas y condiciones
```shell
SELECT 
    C.CategoryID, 
    C.CategoryName,
    P.ProductName,
    MAX (P.UnitPrice) AS [Precio Maximo]
FROM Products AS P
INNER JOIN Categories AS C
ON P.CategoryID = C.CategoryID
WHERE P.Discontinued = 0
GROUP BY C.CategoryID, C.CategoryName, P.ProductName
HAVING COUNT (P.UnitsInStock) < 200
ORDER BY CategoryName, P.ProductName DESC;
```
## TEMA 3 HAVING

HAVING se utiliza para filtrar resultados agrupados, es decir, filtra grupos, no registros individuales.

Es como un WHERE, pero para cuando ya use GROUP BY.

### ¿Para qué sirve?

#### Sirve para:

+ Mostrar solo los grupos que cumplen una condición

 + Filtrar resultados que usan funciones de agregado como:
```shell
COUNT

SUM

AVG

MAX

MIN
```

## Diferencia clave (muy importante)

WHERE → filtra filas antes de agrupar

HAVING → filtra grupos después de agrupar

#### Por eso:

WHERE NO puede usar funciones de agregado

HAVING SÍ puede usar funciones de agregado

#### Sintaxis básica de HAVING
```shell
SELECT columna, FUNCION_AGREGADO(columna)
FROM tabla
GROUP BY columna
HAVING condicion;
```

## NOTA:

Si la condición lleva COUNT, SUM, AVG, MAX o MIN → va en HAVING

# NOTA: 
### ORDEN DE EJECUCION  
```shell
FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
```
### SINTAXIS 
```shell
SELECT
FROM
JOIN
WHERE
GROUP BY
HAVING
ORDER BY
```
### HAVING con una sola función de agregado

Se usa cuando se quiere filtrar grupos con una condición simple.

#### Uso:

Filtrar grupos según un COUNT, SUM, AVG, MAX o MIN.

#### Sintaxis general:

```shell
HAVING FUNCION_AGREGADO(columna) operador valor
```
### HAVING con varias funciones de agregado

Se usa cuando se necesitan varias condiciones al mismo tiempo.

#### Uso:
Aplicar más de una regla sobre los grupos.

#### Sintaxis general:

```shell
HAVING 
    FUNCION_AGREGADO(columna) operador valor
    AND | OR
    FUNCION_AGREGADO(columna) operador valor
```
### HAVING combinado con WHERE

### Uso:

WHERE filtra registros individuales

HAVING filtra grupos

```shell
WHERE condicion_sin_agregado
GROUP BY columna
HAVING condicion_con_agregado
 ```
 ### EJEMPLOS DEL ECRIPT REALIZADO EN CLASE 

 HAVING filtra los clientes agrupados que tienen más de 10 órdenes.  
 
```shell
SELECT customerid, COUNT(*) AS [NUMERO DE ORDENES]
FROM orders
GROUP BY CustomerID
HAVING COUNT(*) > 10
ORDER BY 2 DESC;
 ```
 HAVING para mostrar solo los clientes con alta cantidad de pedidos.
```shell
 SELECT C.CompanyName, COUNT(*) AS [NUMERO DE ORDENES]
FROM Orders AS o
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
HAVING COUNT(*) > 10
ORDER BY 2 DESC;
```
Productos vendidos en más de 20 pedidos distintos, 
HAVING filtra productos según el número de pedidos donde aparecen.

```shell
 SELECT
    P.ProductID,
    P.ProductName,
    COUNT(O.OrderID) AS [NUMERO DE PEDIDOS]
FROM Products AS P
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O
ON O.OrderID = OD.OrderID
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(DISTINCT O.OrderID) > 20;
```
# Conclusión

En este reporte se trabajó con consultas simples en SQL usando la base de datos Northwind, proporcionada por el profesor Gallardo, con el fin de aprender a obtener y analizar información de una base de datos. A lo largo del tema se utilizaron consultas básicas con SELECT, proyección de columnas y alias para mostrar los datos de forma más clara.

También se aplicaron operadores relacionales, lógicos, IN, BETWEEN y LIKE, los cuales ayudan a filtrar la información de manera más específica. Además, se usaron campos calculados y funciones de agregado como COUNT, SUM, AVG, MAX y MIN para obtener totales, promedios y otros resultados importantes.

Finalmente, con el uso de GROUP BY y HAVING se pudo agrupar y filtrar la información de forma más organizada. En general, estos temas son la base para entender cómo funciona SQL y cómo convertir datos en información útil.

```shell
NO HAGA EXAMEN PROFE NO ME VOY A ACORDAR DE TODO AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
```