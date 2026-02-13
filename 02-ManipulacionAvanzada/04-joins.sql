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

