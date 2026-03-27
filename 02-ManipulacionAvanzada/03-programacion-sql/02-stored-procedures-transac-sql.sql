/** ===================Stored procedures ===================*/

CREATE DATABASE bdstored;
GO

use bdstored;
go
---ejemplo simple

CREATE PROCEDURE usp_Mensaje_Saludar
---no tendra parametros
AS
BEGIN
    PRINT 'HOLA MUNDO TRANSACT SQL DESDE SQL SERVER';
END;
GO

---EJECUTAR

EXECUTE usp_Mensaje_Saludar;

----
go 
CREATE PROC usp_Mensaje_Saludar2
---no tendra parametros
AS
BEGIN
    PRINT 'Hola mundo en Ing TI';
END;

GO

EXECUTE usp_Mensaje_Saludar2;

---
go 
CREATE OR ALTER PROC usp_Mensaje_Saludar3
---no tendra parametros
AS
BEGIN
    PRINT 'Hola mundo ENTORNOS VIRTUALES Y NEGOCIOS DIGITALES';
END;

GO

EXECUTE usp_Mensaje_Saludar3;
GO

---CREAR UN SP QUE MUESTRE LA FECHA ACTUAL DEL SISTEMA

CREATE OR ALTER PROC usp_Servidor_FechaActual

AS
BEGIN
    SELECT CAST( GETDATE () AS date) AS [FECHA DEL SISTEMA]
END;
GO

EXECUTE usp_Servidor_FechaActual;

-- CREAR UN SP QUE MUESTRE EL NOMBRE DE LA BASE DE DATOS UTILIZANDO LA FUNCION (DB_NAME())
go 
CREATE OR ALTER PROC usp_Base_Utilizada

AS
BEGIN
    SELECT (DB_NAME())
END;
GO

EXECUTE usp_Base_Utilizada;

---
go 
CREATE OR ALTER PROC usp_Dbname_get

AS
BEGIN
    SELECT 
    HOST_NAME() AS [MACHINE],
    SUSER_NAME() AS [SQLUSER],
    SYSTEM_USER AS [SYSTEMUSER],
    DB_NAME() as [DATABASE NAME],
    APP_NAME() AS [APLICATION];
END;

GO

EXECUTE usp_Dbname_get;

/*============STORED PROCEDURES CON PARAMETROS=============*/
go 
CREATE OR ALTER PROC usp_Persona_Saludar
    @nombre VARCHAR(50) -- Parametro de entrada
AS
BEGIN
    PRINT 'Hola ' + @nombre
END;
GO

EXECUTE usp_Persona_Saludar 'Israel';
EXECUTE usp_Persona_Saludar 'Artemio';
EXECUTE usp_Persona_Saludar 'Irais';
EXECUTE usp_Persona_Saludar @nombre = 'Israel';

DECLARE @name VARCHAR(50);
SET @name = 'Yael';

EXEC usp_Persona_Saludar @name
GO

-- 2PARÁMETROS EN LOS STORED PROCEDURES 

--- TODO: Ejemplo con consultas, vamos a crear una tabla de clientes basada en la tabla de customers de northwind---
go 
SELECT CustomerID, CompanyName
INTO Customers
FROM NORTHWND.dbo.Customers;

SELECT *
FROM Customers;
go 
--- crear sp que busque un cliente espeifico
CREATE OR ALTER PROC spu_Customer_buscar
@id NCHAR(10)
AS
BEGIN
    
    SET @id = TRIM(@id) --ELIMINA LOS ESPACIOS EN BLANCO RTRIM L TRIM TRIM 
    IF LEN(@id) <= 0  or  LEN(@id) > 5
    BEGIN
    PRINT ('el id debe estar en el rango de 1 a 5 de tamaño');
    RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @id)
    BEGIN
        PRINT ' EL CLIENTE NO EXIXTE EN LA BD';
        RETURN;
    /*--ESTA ES OTRA FORMA DE HACERLO
    -->IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @id)
    BEGIN
        SELECT CustomerID AS [Numero], CompanyName as [cliente]
        FROM Customers
        WHERE CustomerID = @id;
        END
        ELSE 
         PRINT ' EL CLIENTE NO EXIXTE EN LA BD'*/
    END
    SELECT CustomerID AS [Numero], CompanyName as [cliente]
    FROM Customers
    WHERE CustomerID = @id;
END;

GO

SELECT * 
FROM  Customers
WHERE CustomerID = '';

EXEC spu_Customer_buscar '';

SELECT 1
FROM NORTHWND.dbo.Categories
WHERE NOT EXISTS (
SELECT 1
FROM Customers
WHERE CustomerID = 'ANTONI');

---- SI ESTO EXISTE MUESTRA LO QUE TIENE EL SELECT  SI SE LE PONE NOT EXISTS LO NIEGA 

--- EJERCICOS PARA EL MARTES  CREAR UN SP QUE RECIBA UN NUMERO Y QUE VERIFIQUE QUE NO SEA NEGATIVO, 
-- SI ES NEGATIVO IMPRIMIR VALOR NO VALIDO Y SI NO MULTIPLICARLO POR 5 Y MOSTRARLO 
-- PARA MOSTRAR USAR UN SELECT 
go  
USE bdstored;
go 
CREATE OR ALTER PROCEDURE usp_numero_multiplicar
@number INT
AS 
BEGIN 
    IF @number<=0
    BEGIN
        PRINT 'EL NUMERO NO PUEDE SER NEGATIVO NI CERO'
        RETURN ;
    END

    SELECT (@number * 5) AS [OPERACIÓN]
END;

GO
EXEC usp_numero_multiplicar -34;
EXEC usp_numero_multiplicar 0;
EXEC usp_numero_multiplicar 5;
GO 
---EJERCICIO 2 CREAR UN SP QUE RECIBA UN NOMBRE Y LO IMPRIMA EN MAYUSCULAS 
--- TO DO: PARAMETROS DE SALIDA 

USE bdstored;
go 
CREATE OR ALTER PROC usp_nombre_mayusculas
@name VARCHAR (15)
AS
 BEGIN
    SELECT UPPER(@name) as [NAME]
END;

GO
GO
EXEC usp_nombre_mayusculas 'aylin';
GO
/* ========================= PARAMETROS DE SALIDA=============================*/

CREATE OR ALTER PROC spu_numeros_sumar
 @a INT, 
 @b INT,
 @resultado INT OUTPUT 
    AS
    BEGIN
        SET @resultado = @a + @b 
END;
GO 

DECLARE @res INT;
EXEC spu_numeros_sumar 5,7, @res OUTPUT;
SELECT @res AS [RESULTADO];
Go 
--SEGUNDA FORMA 

CREATE OR ALTER PROC spu_numeros_sumar2
 @a INT, 
 @b INT,
 @resultado INT OUTPUT 
    AS
    BEGIN
        SELECT @resultado = @a + @b 
END;
GO 

DECLARE @res INT;
EXEC spu_numeros_sumar2 5,7, @res OUTPUT;
SELECT @res AS [RESULTADO];
GO

---CREAR UN SP QUE DEVUELVA EL AREA DE UN CIRCULO 

CREATE OR ALTER PROC usp_area_circulo
@radio DECIMAL (10,2),
@area DECIMAL (10, 2) OUTPUT
AS
BEGIN
 --SET @area = PI () * @radio * @radio
 SET @area = PI () * POWER(@radio,2);
 END;
 GO

DECLARE @r DECIMAL (10,2)
 EXEC usp_area_circulo 2.4, @r output;
 SELECT @r AS [area del circulo];
 GO
 --- crear un sp qu ereciba un id de cliente y devuelva el nombre 

 CREATE or ALTER PROC spu_cliente_obtener 
    @id nchar(10),
    @name NVARCHAR (40) OUTPUT
 AS
 BEGIN
     IF LEN(@id) = 5
    BEGIN
        IF EXISTS ( SELECT 1 FROM Customers WHERE CustomerID = @id)
        BEGIN
     SELECT @name = CompanyName
     FROM Customers
     WHERE CustomerID = @id;

     RETURN;
     END
     PRINT 'EL CUSTOMER NO EXISTE';
 END
    RETURN;
    PRINT 'EL ID DEBE SER DE TAMAÑO 5';
END

DECLARE @name NVARCHAR(40)
EXEC spu_cliente_obtener 'AROUX', @name OUTPUT
SELECT @name AS [NOMBRE DEL CLIENTE];

 SELECT * FROM  Customers;
GO
/*=====================CASE========================*/

CREATE OR ALTER PROC spu_Evaluar_Calificacion
@calif INT
AS
BEGIN
    SELECT 
         CASE 
         WHEN @calif >=90 THEN 'EXCELENTE'
         WHEN @calif >=70 THEN 'APROVADO'
         WHEN @calif >=60 THEN 'REGULAR'
         ELSE 'NO ACREDITO'
         END AS [RESULTADO];
END;

EXEC spu_Evaluar_Calificacion 100;
EXEC spu_Evaluar_Calificacion 75;
EXEC spu_Evaluar_Calificacion 55;
EXEC spu_Evaluar_Calificacion 65;

GO

use bdstored;
GO 
--- Casa dentro de un select caso real
use NORTHWND;

CREATE TABLE bdstored.dbo.Productos
(
    nombre VARCHAR (50),
    precio money
);

--- inserta los datos basados en la consulta (select)
INSERT into bdstored.dbo.Productos
SELECT 
ProductName, UnitPrice
 FROM NORTHWND.dbo.Products;

SELECT * FROM NORTHWND.dbo.products;

--- ejercico con case

SELECT 
    nombre,
    precio,
    CASE  
         WHEN precio >= 200 then 'Caro'
         WHEN precio >= 200 then 'Medio'
        ELSE 'Barato'
        END as [Categoria]
FROM bdstored.dbo.Productos;
 go 

--- selecciona los clientes, con su nombre, pais, ciudad y region 
--(los valores nulos, visualizalos con la leyenda sin region), 
--ademas quiero qu etodo el resultado este  mayuscula 

use NORTHWND;
go 

USE NORTHWND;
GO

CREATE OR ALTER VIEW vw_buena
AS
SELECT 
    UPPER(CompanyName) AS [CompanyName],
    UPPER(c.Country) AS [Country],
    UPPER(c.City) AS [City],
    UPPER (ISNULL(c.Region, 'Sin Region')) AS [RegionLimpia],
    LTRIM(UPPER(CONCAT(e.FirstName,'',e.LastName))) AS [FULLNAME],
    ROUND(SUM(od.Quantity * od.UnitPrice),2) AS [Total],
  CASE
    WHEN SUM(od.Quantity * od.UnitPrice) >= 30000 AND 
    SUM(od.Quantity * od.UnitPrice) <= 60000 THEN 'GOLD'
    when 
    SUM(od.Quantity * od.UnitPrice) >= 10000 AND 
    SUM(od.Quantity * od.UnitPrice) <= 30000 THEN 'SILVER'
    ELSE 'BRONCE'
    END AS [MEDALLON]
FROM NORTHWND.dbo.Customers AS c
INNER JOIN
NORTHWND.dbo.Orders AS o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
INNER JOIN Employees AS e
ON e.EmployeeID = o.EmployeeID
GROUP BY c.CompanyName,c.Country,c.City, c.Region, CONCAT(e.FirstName,'',e.LastName);
go  
----------
SELECT 
    UPPER(CompanyName) AS [CompanyName],
    UPPER(c.Country) AS [Country],
    UPPER(c.City) AS [City],
    UPPER (ISNULL(c.Region, 'Sin Region')) AS [RegionLimpia],
    LTRIM(UPPER(CONCAT(e.FirstName,'',e.LastName))) AS [FULLNAME],
    ROUND(SUM(od.Quantity * od.UnitPrice),2) AS [Total],
  CASE
    WHEN SUM(od.Quantity * od.UnitPrice) >= 30000 AND 
    SUM(od.Quantity * od.UnitPrice) <= 60000 THEN 'GOLD'
    when 
    SUM(od.Quantity * od.UnitPrice) >= 10000 AND 
    SUM(od.Quantity * od.UnitPrice) <= 30000 THEN 'SILVER'
    ELSE 'BRONCE'
    END AS [MEDALLON]
FROM NORTHWND.dbo.Customers AS c
INNER JOIN
NORTHWND.dbo.Orders AS o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON o.OrderID = od.OrderID
INNER JOIN Employees AS e
ON e.EmployeeID = o.EmployeeID
WHERE UPPER(CONCAT(e.FirstName,'',e.LastName)) =  UPPER('ANDREWFULLER')
AND UPPER (ISNULL(c.Region, 'Sin Region')) = UPPER('Sin Region')
GROUP BY c.CompanyName,c.Country,c.City, c.Region, CONCAT(e.FirstName,'',e.LastName)
ORDER BY  FULLNAME ASC,[Total] DESC;

GO  

GO 
CREATE OR ALTER PROC spu_informe_clienres_empleados
@nombre VARCHAR(50),
@region VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM vw_vista_buena
    WHERE [FULL NAME] = @nombre
    AND [REGION LIMPIA] = @region;
END;
GO

EXEC spu_informe_clienres_empleados 'ANDREW FULLER', 'SIN REGION';

/*===============Manejo de errores con TRY ... Catch =================================*/
-- sin try catch 
SELECT 10/0;

--con TRY Catch 
BEGIN TRY 
SELECT 10/0;
END TRY 
BEGIN CATCH
    PRINT 'Ocurrio un error';
END CATCH;
GO 
---- EJEMPLO DE USO DE FUNCIONES PARA OBTENER INFO DEL ERROR
BEGIN TRY 
    SELECT 10/0;
END TRY 
BEGIN CATCH
        PRINT 'MENSAJE:' + ERROR_MESSAGE();
        --- TODO LO QUE SEA ENTERO Y TENGA UNA CADENA HAY QUE CASTEARLO
        PRINT 'NUMERO DE ERROR:' + CAST(ERROR_NUMBER() AS VARCHAR) ;
        PRINT 'LINEA DE ERROR:' + CAST(ERROR_LINE () AS VARCHAR);
        PRINT 'ESTADO DEL ERROR' + CAST(ERROR_STATE() AS VARCHAR);
END CATCH;

USE bdstored;

CREATE TABLE clientes(
    id INT PRIMARY KEY,
    nombre VARCHAR (35)
);

GO
INSERT INTO clientes
VALUES (1,'FANI');
go 

BEGIN TRY 
    INSERT INTO clientes
    VALUES (1,'FANI');
END TRY 
BEGIN CATCH
        PRINT 'ERROR AL INSERTAR: ' + ERROR_MESSAGE();
        --- TODO LO QUE SEA ENTERO Y TENGA UNA CADENA HAY QUE CASTEARLO
        PRINT 'ERROR EN LA LINEA: ' + CAST(ERROR_LINE () AS VARCHAR);
END CATCH; 


---- TRANSACCION 

BEGIN TRANSACTION;

INSERT INTO clientes
VALUES (2,'AYLIN');

SELECT * FROM CLIENTES;

--- SI TERMINASTE LA TRANSACCION 
COMMIT;
--- CAMBIAR DATOS 
ROLLBACK;

----Ejemplo de uso de transacciones junto con el try catch

USE bdstored;
GO
SELECT *FROM clientes;

BEGIN TRY 
    BEGIN TRANSACTION;

    INSERT INTO clientes
    VALUES (3,'Ana');
    INSERT INTO clientes
    VALUES (4, 'Roles Alina');

    COMMIT;--- confirma la transaccion 

END TRY 
BEGIN CATCH
    IF @@TRANCOUNT > 1 -- verifica si hay una trasaccion abierta
    ---doble arroba son como variables globales del sistema /funciones escalares de configuracion 
    --ya echas en sql que me permiten hacer algo o avisan que se hizo en la ultima linea, atajos 
    BEGIN
      ROLLBACK;
    END
        PRINT 'Se hizo rollback por error ';
        --- TODO LO QUE SEA ENTERO Y TENGA UNA CADENA HAY QUE CASTEARLO
        PRINT 'ERROR: ' + + ERROR_MESSAGE();
END CATCH; 
GO
--- crear un store procedure que inserte un cliente, con las validaciones
--- necesarias.

CREATE or ALTER PROC usp_insertar_cliente
 @id INT,
 @nombre VARCHAR (35)
AS
BEGIN

    BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO clientes
        VALUES(@id, @nombre);
        COMMIT;
        PRINT 'cliente insertado';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT >1
        BEGIN
            ROLLBACK;
        END
        PRINT 'error' + ERROR_MESSAGE();
    END CATCH
END;


SELECT * FROM clientes;

UPDATE clientes
SET nombre = 'Americo azul'
WHERE id = 2;

IF @@ROWCOUNT < 1
BEGIN
    PRINT @@ROWCOUNT
    PRINT 'no xiste el cliente'
END
ELSE
    PRINT ' cliente actualizado';


CREATE TABLE teams
(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    nombre NVARCHAR(15)

);

select * FROM teams;

INSERT INTO teams (nombre)
VALUES ('Cruz Azul');

---- forma de obtener un identity insertado forma 1
DECLARE @id_insertado INT 
SET @id_insertado = @@IDENTITY -- me va a decir que identity inserto 
PRINT 'ID INSERTADO: ' + CAST( @id_insertado as VARCHAR);
SELECT @id_insertado = @@IDENTITY
PRINT 'ID insertado forma 2: ' + CAST( @id_insertado as VARCHAR);

---- forma de obtener un identity insertado forma 2
DECLARE @id_insertado2 INT 
SET @id_insertado2 = SCOPE_IDENTITY() --- para usar en un sp es mejor este porque da el del momento 
PRINT 'ID INSERTADO: ' + CAST( @id_insertado2 as VARCHAR);
SELECT @id_insertado2 = @@IDENTITY
PRINT 'ID insertado forma 2: ' + CAST( @id_insertado2 as VARCHAR);A