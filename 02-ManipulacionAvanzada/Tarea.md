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

### Dónde se aplica (varios ejemplos):
```shell
WHERE CompanyName LIKE 'a%'
WHERE City LIKE '_ondon'
WHERE CompanyName LIKE '[bsp]%'
```
Se utiliza LIKE para buscar patrones de texto usando comodines (%, _, [ ], [^ ]).