/**
1. INNER JOIN
2. LEFT JOIN
3. RIGTH JOIN
4. LEFT JOIN
**/

--SELECCIONAR LAS CATEGORIAS Y SUS PRODUCTOS

SELECT 
C.CategoryID, 
P.CategoryID,
C.CategoryName,
P.ProductName,
P.UnitPrice,
P.UnitsInStock,
(P.UnitPrice * P.UnitsInStock)
AS [Precio Inventario]
FROM Categories  as C
INNER JOIN Products as P
ON C.CategoryID = P.CategoryID
where C.CategoryID=9;

-------------------------------------------------------------------------
 DROP TABLE categoria;

-- Crear una tabla a partir de una consuta 

SELECT TOP 0
	CategoryID,
	CategoryName
	INTO  categoria
	FROM categories;

ALTER TABLE categoria
ADD CONSTRAINT pk_categoria
PRIMARY KEY (CategoryID);

INSERT INTO categoria
VALUES ('C1'),('C2'),('C3'),('C4'),('C5');

SELECT TOP 0
	ProductID AS [numero producto],
	ProductName AS [nombre_producto],
	CategoryID AS [catego_id]
FROM Products;

DROP TABLE producto;

SELECT TOP 0
	ProductID AS [numero_producto],
	ProductName AS [nombre_producto],
	CategoryID AS [catego_id]
INTO producto
FROM Products;

ALTER TABLE producto
ADD CONSTRAINT pk_producto
PRIMARY KEY (numero_producto);

ALTER TABLE producto
ADD CONSTRAINT fk_producto_categoria
FOREIGN KEY (catego_id)
REFERENCES categoria (CategoryID)
ON DELETE CASCADE;

INSERT INTO producto
VALUES ('P1',1),
		('P2',1),
		('P3',2),
		('P4',2),
		('P5',3),
		('P6',NULL);

--INNER JOIN


SELECT *
FROM categoria AS c
INNER JOIN 
producto AS P
ON c.CategoryID = p.catego_id;

--LEFT JOIN
SELECT *
FROM categoria AS c
LEFT JOIN 
producto AS P
ON c.CategoryID = p.catego_id;

-- RIGHT JOIN
SELECT *
FROM categoria AS c
RIGHT JOIN 
producto AS P
ON c.CategoryID = p.catego_id;

-- FULL JOIN
SELECT *
FROM categoria AS c
FULL JOIN 
producto AS P
ON c.CategoryID = p.catego_id;

-- SIMULAR EL RIGHT JOIN DEL QUERY ANTERIOR 
-- CON UN LEFT JOIN

SELECT c.CategoryID, c.CategoryName,
	p.numero_producto, p.nombre_producto,
	p.catego_id
FROM categoria AS c
RIGHT JOIN 
producto AS P
ON c.CategoryID = p.catego_id;


SELECT c.CategoryID, c.CategoryName,
	p.numero_producto, p.nombre_producto,
	p.catego_id
FROM producto AS p
LEFT JOIN  
categoria AS c
ON c.CategoryID = p.catego_id;

-- VISUALIZAR TODAS LAS CATEGORIAS QUE NO TIENEN PRODUCTOS 

SELECT *
FROM categoria AS c
LEFT JOIN
producto AS p
ON c.CategoryID = p.catego_id
WHERE numero_producto is null;

-- SELECCIONAR TODOS LOS PRODUCTOS QUE 
-- NO TIENE CATEGORIA

SELECT *
FROM producto AS p
LEFT JOIN
categoria AS c
ON c.CategoryID = p.catego_id
WHERE catego_id is null;

SELECT *
FROM producto;

SELECT *
FROM categoria; 

--GUARDADR EN UNA TABLA DE PRODUCTOS NUEVOS TODOS AQUELLOS PRODUCTOS QUE FUERON AGREGADOS 
--RECIEMTEMENTE Y NO ESTAN EN ESTA TABLA DE APOYO

---crear la tabla products_new a partir de productos, mediante una consulta

SELECT 
TOP 0
ProductID AS [product_number],
		ProductName AS [product_name],
		UnitPrice AS unit_price,
		UnitsInStock AS [stock],
		(UnitPrice * UnitsInStock) AS [total]
INTO products_new
FROM Products

ALTER TABLE products_new
ADD CONSTRAINT pk_products_new
PRIMARY KEY ([product_number]);

SELECT * FROM products_new

SELECT
	p.ProductID,
	p.ProductName,
	p.UnitPrice,
	p.UnitsInStock,
	(p.UnitPrice * p.UnitsInStock) AS [TOTAL],
	pw.*
FROM Products AS p
LEFT JOIN  products_new AS pw
ON p.ProductID = pw.product_number;

-----
INSERT INTO products_new
SELECT
	p.ProductName,
	p.UnitPrice,
	p.UnitsInStock,
	(p.UnitPrice * p.UnitsInStock) AS [TOTAL]
FROM Products AS p
LEFT JOIN  products_new AS pw
ON p.ProductID = pw.product_number
WHERE pw.product_number is NULL;

  ----
  INSERT INTO products_new
SELECT
	p.ProductName,
	p.UnitPrice,
	p.UnitsInStock,
	(p.UnitPrice * p.UnitsInStock) AS [TOTAL]
FROM Products AS p
LEFT JOIN  products_new AS pw
ON p.ProductID = pw.product_number
WHERE pw.product_number is NULL;
---
select*
FROM products_new;

INSERT INTO products_new
SELECT
	p.ProductName,
	p.UnitPrice,
	p.UnitsInStock,
	(p.UnitPrice * p.UnitsInStock) AS [TOTAL]
FROM Products AS p
INNER JOIN  products_new AS pw
ON p.ProductID = pw.product_number;

 SELECT COUNT (*)
 FROM products_new;

 ----

