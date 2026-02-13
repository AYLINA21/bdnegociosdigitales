/*
funciones de agregado:

1.sum()
2.max()
3.min()
4.avg()
5.count(*)
6.count(campo)
*/

--selleccionar los paises de donde son los clientes

SELECT DISTINCT Country
FROM Customers;

--agregación count(*) cuenta el numero d registros
--que tiene la tabla

SELECT COUNT (*) AS [Total de Ordenes]
FROM Orders;

--Seleccionar el total de ordenes que fueron enviadas a alemania

SELECT COUNT (*) AS [Total de Ordenes]
FROM Orders
WHERE ShipCountry like 'Germany';

SELECT ShipCountry, COUNT (*) AS [Total de Ordenes]
FROM Orders
GROUP BY ShipCountry;

-- 03/02/26

SELECT*
FROM CUSTOMERS;

-- el count no cuenta los null

SELECT COUNT (CustomerID)
FROM CUSTOMERS;

SELECT COUNT (Region)
FROM CUSTOMERS;

--selecciona de cuantas ciudades son las ciudaades de los clientes 

SELECT DISTINCT city
FROM CUSTOMERS
ORDER BY city ASc;

SELECT COUNT (DISTINCT City) AS [CIUDAADES CLIENTES]
FROM CUSTOMERS;

--MAX 
--SELECCIONA  EL PECIO MAXIMO DE LOS PRODUCTOS

--PRIMERO HAY QUE VER LOS DATOS 

SELECT*
FROM Products
ORDER BY UnitPrice DESC;

SELECT MAX (UnitPrice) AS [PRECIO MAS ALTO]
FROM Products;

--seleccionar la fecha de compra mas actual

SELECT OrderDate
FROM orders
ORDER BY OrderDate DESC;

SELECT MAX (OrderDate) AS [Ultima fecha de compra]
FROM Orders;

--seleccionar el año de la fecha de compra mas reciente

SELECT OrderDate
FROM orders
ORDER BY OrderDate DESC;

SELECT MAX (YEAR (OrderDate)) AS [Ultima fecha de compra]
FROM Orders;

SELECT MAX (DATEPART(YEAR, ORDERDATE))
FROM ORDERS;

SELECT DATEPART(YEAR, MAX (ORDERDATE)) AS [AÑO]
FROM ORDERS;

--MIN
--CUAL ES LA MINIMA CANTIDAD DE LOS PEDIDOS

SELECT MIN (QUANTITY) AS [CANTIDAD MINIMA]
FROM [Order Details];

--CUAL ES LA MINIMA CANTIDAD DE LOS PEDIDOS
SELECT MIN(UnitPrice) as [precio minimo de venta]
from [Order Details]

---cual es el importe mas bajo de las compras
SELECT (UnitPrice *Quantity *(1-Discount)) as [Importe]
from [Order Details]
order by [Importe] ASC

SELECT min (UnitPrice *Quantity *(1-Discount)) as [Importe]
from [Order Details]

--total de los precios de los productos

SELECT sum (UnitPrice) as [suma]
from [Order Details]

--OBTENER EL TOTAL DE DINERO PERCIBIDO POR LAS VENTAS

SELECT Sum (UnitPrice *Quantity *(1-Discount)) as [Importe]
from [Order Details]

--seleccionar las ventas totales de los productos 4-10-20 total 

SELECT Sum (Quantity *(UnitPrice)) as [ventas totales]
from [Order Details]
WHERE ProductID = '4'OR
    ProductID = '10' OR
    ProductID = '20';

SELECT ProductID
from [Order Details];

--seleccionar el numero de ordenes hechas por los sig clientes
--Around the Horn, Bolido Comidad preparadas, Chop-suey Chinese

SELECT Sum (OrderID) as [Ordenes]
FROM Orders
WHERE CustomerID = 'AROUT'OR
    CustomerID = 'BOLID' OR
    CustomerID = 'CHOPS';

--seleccionar el total de ordenes del segundo trimestro de 1996

select count (*)
FROM Orders
WHERE DATEPART (QUARTER, orderdate) =3
and DATEPART(YEAR,Orderdate) = 1996;


--seleccinar el numero de ordenes entre 1996 a 1997
SELECT COUNT (*) AS [NUMERO DE ORDENES]
FROM Orders
WHERE DATEPART (YEAR,orderdate) BETWEEN 1991 AND 1994;

--seleccionar el numero de clientes que comienzan con B o que TERMINAN con S

SELECT  COUNT(*) AS [CLIENTES A/B]
FROM Customers
WHERE CompanyName Like 'B%S';

--seleccionar el numero de clientes que comienzan con a o que TERMINAN con S

SELECT  COUNT(*) AS [CLIENTES A/B]
FROM Customers
WHERE CompanyName Like 'a%' or CompanyName LIKE 'b%';

--seleccionar el numero de ordenes realizadas por el cliente chop-suey chinisse en 1996

SELECT *
FROM Customers
WHERE CompanyName = 'Chop-suey Chinise';

SELECT COUNT (*) AS [NUMERO DE ORDENES], 
sum (orderID) AS [SUMA DE LAS ORDENES]
FROM Orders
WHERE CustomerID = 'CHOPS'
AND YEAR(OrderDate) = 1996;

/*
 GROUP BY HAVIND


*/

SELECT CustomerID
FROM orders;

SELECT
	CustomerID, 
	count (*) AS [NUMERO DE ORDENES]
FROM orders
GROUP BY CustomerID;

SELECT
	CustomerID, 
	count (*) AS [NUMERO DE ORDENES]
FROM orders
GROUP BY CustomerID
ORDER BY 2 DESC;

--LOS JOINS VAN DESPUES DEL ORDER
SELECT
	customers.CompanyName,
	count (*) AS [NUMERO DE ORDENES]
FROM orders
INNER JOIN
Customers
ON orders.CustomerID = Customers.CustomerID
GROUP BY customers.CompanyName
ORDER BY 2 DESC;

SELECT
	c.CompanyName,
	count (*) AS [NUMERO DE ORDENES]
FROM orders as o
INNER JOIN
Customers as c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY 2 DESC;


SELECT CustomerID, count (*)
FROM orders
WHERE Customerid in (1,3)
GROUP BY CustomerID;

-- seleccionar el numero de productos (conteo) por categoria, mostrar categoriaID, 
--total de los productos, ordenarlos de mayor a menor por el total de productos

SELECT CategoryID ,count (*) as [numero de productos]
FROM Products
GROUP BY CategoryID
ORDER BY 2 deSC;

SELECT CategoryID ,count (*) as [numero de productos]
FROM Products
GROUP BY CategoryID
ORDER BY count (*) DESC;

SELECT CategoryID ,count (*) as [numero de productos]
FROM Products
GROUP BY CategoryID
ORDER BY[numero de productos] DESC;

-- Seleccionar el numero de productos (Conteo) por categoria, mostrar CategoriaID, TotaldeProductos
-- Ordenarlos de mayor a menor por el totaldeproductos
SELECT *
FROM Products;
SELECT
CategoryID,
COUNT (UnitsInStock) AS [Total de Productos]
FROM Products
GROUP BY CategoryID
ORDER BY 2 DESC;

-- Seleccionar el precio promedio por provedor de los productos
-- Redondear a dos decimales el resultado
-- Ordenar de forma descendente por el precio promedio
SELECT *
FROM Products;

SELECT
SupplierID,
ROUND (SUM(UnitPrice/ SupplierID),2) AS [Promedio por provedor]
FROM Products
GROUP BY SupplierID
ORDER BY 2 DESC;

-- Seleccionar el numero de clientes por pais
-- Ordenarlos por Pais alfabeticamente
SELECT *
FROM Customers;
SELECT
COUNT (*) AS [Numero de Clientes],
Country
FROM Customers
GROUP BY Country;

--obtener la cantidad total vendida agrupada por producto y por pedido

SELECT *, (UnitPrice * Quantity) AS [total]-- campo calculado solo suma el precio del producto y la cantidad TOTAL
FROM [Order Details]

SELECT SUM (UnitPrice * Quantity) AS [total]-- suma las filas y todas las columnas
FROM [Order Details]

SELECT ProductID, SUM (UnitPrice * Quantity *(1-Discount)) AS [total]---ORDENA POR PRODUCTO Y DA EL TOTAL
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID

SELECT ProductID,OrderID, SUM (UnitPrice * Quantity *(1-Discount)) AS [total]---ORDENA POR PRODUCTO Y ORDEN DA EL TOTAL
FROM [Order Details]
GROUP BY ProductID , OrderID
ORDER BY ProductID , [total]

SELECT * , (UnitPrice*Quantity) AS [TOTAL]
FROM [Order Details]
WHERE OrderID = 10847
and ProductID = 1

--SELECCIONAR LA CANTIDAD MAXIMA VENDIDA POR PRODUCTO EN CADA PEDIDO

SELECT ProductID,OrderID,  MAX (Quantity)  AS [Cantidad Maxima]
FROM [Order Details]
GROUP BY ProductID , OrderID
ORDER BY ProductID , OrderID;

/*flujo logico de ejecucion en sql 
1. from
2. join 
3. where
4. group by
5. having
6. select
7. disting
8. order by
*/

--having (filtro pero de grupos)
--seleccionar los clientes que hayan realizado mas de 10 pedidos

SELECT  customerid, count(*) AS [NUMERO DE ORDENES]
FROM orders
GROUP BY CustomerID
Having COUNT (*) > 10
ORDER BY 2 DESC;

SELECT  C.CompanyName ,COUNT(*) AS [NUMERO DE ORDENES]
FROM Orders AS o
INNER JOIN
Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
Having COUNT (*) > 10
ORDER BY 2 DESC;
-- EL 2 SIGNIFICA LA COLUMNA DOS

--SELECCIONAR LOS EMPLEADOS QUE HAYAN GESTIONADO PEDIDOS POR UN TOTAL SUPERIOR A 50 MIL EN VENTAS 
--( MOSTRAR EL NOMBRE DEL EMPLEADO Y EL ID DEL EMPLEADO, Y EL TOTAL DE COMPRAS)

SELECT 
	CONCAT (E.FirstName,' ', E.LastName) AS [NOMBRE COMPLETO],
	(OD.QUANTITY * OD.UNitPrice* (1- od.Discount))
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [ORDER DETAILS] AS OD
ON O.OrderID = OD.OrderID
ORDER BY E.FirstName ASC;

SELECT 
	CONCAT (E.FirstName,' ', E.LastName) AS [NOMBRE COMPLETO],
	ROUND(SUM(OD.QUANTITY * OD.UNitPrice* (1- od.Discount)),2 ) AS [IMPORTE]
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID = O.EmployeeID
INNER JOIN [ORDER DETAILS] AS OD
ON O.OrderID = OD.OrderID
GROUP BY E.FirstName, E.LastName
HAVING SUM (OD.QUANTITY * OD.UNitPrice* (1- od.Discount))>100000
ORDER BY E.FirstName, [IMPORTE] DESC;

--seleccionar el numero productos vendidos en mas de 20 pedidos distintos 
--mostrar id producto, el nombre del producto y el numero de ordenes 

SELECT
	P.ProductID, 
	P.ProductName, 
	COUNT( O. OrderID) AS [NUMERO DE PEDIDOS]
FROM Products AS P
INNER JOIN [ORDER DETAILS] as OD
ON P.ProductID =OD.ProductID
INNER JOIN Orders AS O 
ON O.OrderID = OD.OrderID
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(DISTINCT  O. OrderID)>20;

--SELECCIONAR LOS PRODUCTOS NO DESCONTINUADOS
--CALCULAR EL PRECIO PROMEDIO VENDIDO, Y 
--MOSTRAR SOLO AQUELLOS QUE SE HAYAN VENDIDO
--EN MENOS DE 15 PEDIDOS 

SELECT p.ProductName, avg (od.UnitPrice) AS [Precio Promedio] 
FROM Products AS P 
INNER JOIN [Order Details] AS OD
ON P.ProductID = OD.ProductID
WHERE P.Discontinued =0
GROUP BY p.ProductName
HAVING COUNT (OrderID)<15;

--seleccionar el precio maximo de productos por
--categoria, pero solo si la suma de unidades es menor a 200
--y a demas que no esten descontinuados

SELECT 
	C.CategoryID, 
	C.CategoryName,
	p.Productname
	MAX (P.UnitPrice) AS [Precio Maximo]
FROM Products AS P 
INNER JOIN Categories AS C
ON P.CategoryID = C.CategoryID
WHERE P.Discontinued =0
GROUP BY C.CategoryID, 
	     C.CategoryName,
		 P.ProductName
HAVING COUNT (P.UnitsInStock)<200
order by CategoryName, p.ProductName desc;
	



