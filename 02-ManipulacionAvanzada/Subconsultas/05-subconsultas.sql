--subconsulta escalar  (regresan un valor)

---Escalar en select

SELECT 
	o.OrderID,
	(od.Quantity * od.UnitPrice) AS [Total],
	(SELECT AVG (od.Quantity	 * od.UnitPrice)FROM [Order Details] AS od) AS [AVGTOTAL]
FROM ORDERS AS o
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID;

--mostrar el nombre del producto y el precio promedio de todos los productos 

SELECT 
	p.ProductName,
	(SELECT AVG (UnitPrice)FROM Products) AS [Precio Promedio]
FROM Products AS p
INNER JOIN [Order Details] AS od
ON p.ProductID = od.ProductID;

-- Mostrar cada empleado y la cantidad total de pedidos que tiene
SELECT 
	e.EmployeeID, FirstName, Lastname,
	(SELECT COUNT (*)
	FROM Orders AS o
	) AS [NUMERO PEDIDOS]
FROM Employees AS e; 

--subconsulta derivada 

SELECT 
	e.EmployeeID, FirstName, Lastname,
	(SELECT COUNT (*)
	FROM Orders AS o
	WHERE e.EmployeeID = o.EmployeeID
	) AS [NUMERO PEDIDOS]
FROM Employees AS e; 

---- subconsulta co relacionada 

SELECT 
	e.EmployeeID, FirstName, Lastname, COUNT (o.OrderID) AS [NUMERO DE ORDENES]
FROM Employees AS e
INNER JOIN Orders AS o
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, FirstName, Lastname;

--
select *
FROM Employees;

-- mostrar cada cliente y la fecha de su ultimo pedido

--mostrar pedidos con nombre del cliente y total del pedido sum
SELECT o.OrderID, c.CompanyName, (
SELECT  SUM (od.Quantity * od.UnitPrice)
FROM [Order Details] as od
where od.OrderID = o.OrderID
) AS [TOTAl]
FROM ORDERS AS o 
inner join Customers as c
on o.CustomerID = c.CustomerID;

--- DATOS DE EJEMPLO 

CREATE DATABASE bdsubconsultas;
GO

CREATE TABLE clientes (
	id_cliente int not null identity(1,1) primary key,
	nombre nvarchar(50) not null,
	ciudad nchar (20) not null
	);

CREATE TABLE pedidos (
	id_pedido int not null identity(1,1) primary key,
	id_cliente int not null,
	total money not null,
	fecha date not null,
	CONSTRAINT fk_pedidos_Clientes
	FOREIGN KEY (id_cliente)
	REFERENCES clientes (id_cliente)
	);

---- consulta ESCALAR:
-- total maximo de ordenes 

SELECT * 
FROM [Order Details]

INSERT INTO clientes (nombre, ciudad) VALUES
('Ana', 'CDMX'),
('Luis', 'Guadalajara'),
('Marta', 'CDMX'),
('Pedro', 'Monterrey'),
('Sofia', 'Puebla'),
('Carlos', 'CDMX'), 
('Artemio', 'Pachuca'), 
('Roberto', 'Veracruz');

INSERT INTO pedidos (id_cliente, total, fecha) VALUES
(1, 1000.00, '2024-01-10'),
(1, 500.00,  '2024-02-10'),
(2, 300.00,  '2024-01-05'),
(3, 1500.00, '2024-03-01'),
(3, 700.00,  '2024-03-15'),
(1, 1200.00, '2024-04-01'),
(2, 800.00,  '2024-02-20'),
(3, 400.00,  '2024-04-10');

---- CONSULTA ESCALAR

---Seleccionar los pedidos en donde el total se aiguual
--al total maximo

SELECT * FROM pedidos;
SELECT * FROM CLIENTES;

SELECT * 
FROM pedidos 
WHERE total = (
SELECT MAX (total)
FROM pedidos
);

SELECT p.id_pedido, c.nombre, p.fecha, p.total
FROM pedidos as p
INNER JOIN
clientes as c
on p.id_cliente = c.id_cliente
Order by p.total desc;

---

SELECT p.id_pedido, c.nombre, p.fecha, p.total
FROM pedidos as p
INNER JOIN
clientes as c
on p.id_cliente = c.id_cliente
WHERE p.total = (
SELECT MAX (total)
FROM pedidos
);

--Seleccionar los pedidos mayores al promedio 
SELECT AVG (total)
FROM pedidos;

SELECT * 
FROM pedidos
WHERE total>(
SELECT AVG (TOTAL)
FROM pedidos);

---Seleccionar todos los pedidos  del cliente que tenga el menor id
select min (id_cliente)
from pedidos;

select *
from pedidos
where id_cliente = (select min (id_cliente)
from pedidos);


select id_cliente, COUNT (*) AS [Numero de pedidos]
from pedidos
where id_cliente = (
select min (id_cliente)
from pedidos
)
GROUP BY id_cliente;

-- MOSTRAR LOS DATOS DEL PEDIDO DEL ULTIMA ORDEN 

select max (fecha)
from pedidos;

select p.id_pedido, c.nombre, p.fecha, p.total
from pedidos as p
INNER JOIN clientes as c
ON p.id_cliente = c.id_cliente
where fecha = (select max (fecha)
from pedidos);

--- Mostrar todos los pedidoas con un total que sea el mas bajo 
select min (total)
from pedidos;

select p.id_pedido, c.nombre, p.fecha, p.total
from pedidos as p
INNER JOIN clientes as c
ON p.id_cliente = c.id_cliente
where p.total = (select min (total)
from pedidos);

--- seleccionar los pedidos con el nombre del cliente cuyo total de 
--(Freight) sea mayor al promedio general del (Freight)

Use NORTHWND;

select *
from orders;

select AVG (Freight)
from orders;

select o.OrderID, c.CompanyName, CONCAT (e.FirstName,'', e.LastName)as [Fullname], o.Freight
from orders as o 
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join Employees as e 
on e.EmployeeID = o.EmployeeID
where o.Freight >(
	select AVG (Freight)
	from orders
)
order by o.Freight DESC;

---Subqueries de una columna con IN, ANY, ALL( LLEVAN UNA SOLA COLUMNA)
--La clausulta in 

---Clientes que han hecho pedidos
USE bdsubconsultas;

SELECT  * 
FROM CLIENTES
WHERE id_cliente IN (
	SELECT id_cliente
	FROM pedidos
);

SELECT DISTINCT c.id_cliente, c.nombre, c.ciudad
FROM CLIENTES as c 
inner join pedidos as p
on c.id_cliente = p.id_cliente;

-- clientes que han hecho pedidos mayores a 800
--subconsulta que se agregara a la consulta principal
SELECT id_cliente
FROM pedidos
where total > 800 ;

--consulta principal
SELECT *
FROM pedidos
WHERE id_cliente In ( 
	SELECT id_cliente
	FROM pedidos
	where total > 800);

	SELECT *
FROM pedidos
WHERE id_cliente In ( 
	SELECT id_cliente
	FROM pedidos
	where total > 800);

	SELECT *
	FROM pedidos 
	WHERE id_cliente IN (1,3,1) ;

--- SELECCIONAR TODOS LOS CLIENTES DE LA CDMX  QUE HAN HECHO PEDIDOS 

SELECT id_cliente
FROM Pedidos;

---

SELECT *
FROM clientes;
---

SELECT c.id_cliente, c.nombre, c.ciudad
FROM pedidos as p
RIGHT JOIN
clientes as c 
ON p.id_cliente = c.id_cliente
WHERE p.id_cliente IS NULL;

----

SELECT id_cliente
FROM clientes 
WHERE id_cliente NOT IN (
	SELECT id_cliente
	FROM Pedidos);

-- seleccionar los pedidos de clientes de Monterrey
select id_cliente
FROM Clientes 
WHERE ciudad = 'Monterrey'
;

--- Sub consulta
Select  *
from pedidos
where id_cliente IN (
	select id_cliente
	FROM Clientes 
	WHERE ciudad = 'Monterrey');

---  join para ver quien 
SELECT *
FROM clientes as c 
INNER JOIN pedidos as p
ON c.id_cliente = p.id_cliente
WHERE c.ciudad = 'Monterrey';


--- OPERADOR ANY 
---Seleccionar pedidos mayores que algun pedido de luis ( id_cliente = 2)

---PRIMERO LA SUB CONSULTA

SELECT total
FROM pedidos
WHERE id_cliente = 2;

--- consulta principal
SELECT * 
FROM pedidos
where total > ANY (SELECT total
FROM pedidos
WHERE id_cliente = 2);

---seleccionar los pedidos mayores (total) de algun pedido de Ana 
select * 
FROM Clientes; 

SELECT total
FROM pedidos
WHERE id_cliente = 1;

SELECT *
FROM pedidos
where total > ANY (
	SELECT total
	FROM pedidos
	WHERE id_cliente = 1);

--- seleccionar los pedidos mayores que algun pedido superior (total) a 500
SELECT total
FROM pedidos

WHERE total>500

SELECT *
FROM pedidos
WHERE total > ANY(
SELECT total
FROM pedidos
WHERE total>500
);
 