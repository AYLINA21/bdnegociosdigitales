--- crear base de datos
CREATE DATABASE bdpracticas;
GO
USE bdpracticas;


-- crear tabla cat producto
CREATE TABLE CatProducto (
    id_producto INT PRIMARY KEY,
    nombre_producto NVARCHAR(40),
    existencia INT,
    precio MONEY
);
---insertar datos de northwnd
INSERT INTO CatProducto (id_producto, nombre_producto, existencia, precio)
SELECT ProductID, ProductName, UnitsInStock, UnitPrice
FROM Northwnd.dbo.Products;
--- verificar datos
SELECT *
FROM CatProducto;



---- crear Cat cliente

CREATE TABLE CatCliente (
    id_cliente NCHAR (5)PRIMARY KEY,
    nombre_cliente NVARCHAR(40),
    pais NVARCHAR(15),
    ciudad NVARCHAR(15)
);

--- insertar datos 
INSERT INTO CatCliente (id_cliente, nombre_cliente , pais , ciudad)
SELECT CustomerID, CompanyName, Country, City
FROM Northwnd.dbo.Customers;

SELECT *
FROM CatCliente;



--- crear tblVenta

CREATE TABLE TblVenta (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    id_cliente NCHAR(5),
    FOREIGN KEY (id_cliente) REFERENCES CatCliente(id_cliente)
);
--- verificar que si esta 
SELECT *
FROM TblVenta;

DROP TABLE TblVenta;



--- crear TblDEtalleVenta
CREATE TABLE TblDetalleVenta (
    id_venta INT,
    id_producto INT,
    precio_venta MONEY,
    cantidad_vendida INT,
    FOREIGN KEY (id_venta) REFERENCES TblVenta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES CatProducto(id_producto)
);
--- verificar que si esta 
SELECT *
FROM TblDetalleVenta;
go 

DROP TABLE TblDetalleVenta;
go  



---- Crear el stored procedure usp_agregar_venta

--- validar al cliente 
CREATE OR ALTER PROCEDURE spu_Cliente_Exists
    @id_cliente NCHAR(5)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
    BEGIN
        PRINT 'El cliente no existe';
        RETURN;
    END 
    ELSE
    PRINT 'Cliente válido';
END;
go 

SELECT *
FROM CatCliente;

----- REVISAR ----
EXEC spu_Cliente_Exists 'ANTON';
EXEC spu_Cliente_Exists 'BONAP'
go




--- validar producto 
CREATE OR ALTER PROCEDURE spu_Producto_Exists
    @id_producto INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
    BEGIN
        PRINT 'El producto no existe';
        RETURN;
    END

    PRINT 'Producto válido';
END;

SELECT *
FROM CatProducto;

EXEC spu_Producto_Exists '4'
GO

---- VALIDAR EXISTENCIA 

CREATE OR ALTER PROCEDURE spu_Producto_Existencia
    @id_producto INT,
    @cantidad INT
    AS
    BEGIN
        DECLARE @existencia INT;

        SELECT @existencia = existencia
        FROM CatProducto
        WHERE id_producto = @id_producto;

IF @existencia < @cantidad
    BEGIN
        PRINT 'No hay suficiente existencia';
        RETURN;
    END
ELSE 
    PRINT 'Existencia suficiente';
END;

SELECT *
FROM CatProducto;

---- YA FUNCIONA -----
EXEC spu_Producto_Existencia 1, 2;
EXEC spu_Producto_Existencia 2, 19;
GO




----------------------------------USP COMPLETO--------------------------------
/*CREATE OR ALTER PROC usp_agregar_venta  
   --- @id_venta INT, ---
    @id_cliente NCHAR (5),
    @id_producto INT,
    @cantidad INT
    ---@precio_venta MONEY --
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;

 ---- VALIDACION DE CLIENTE
         IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
    BEGIN
        PRINT 'El cliente no existe';
        ROLLBACK;
        RETURN;
    END

    PRINT 'Cliente válido';


---VALIDACION DE PRODUCTO 

    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
    BEGIN
        PRINT 'El producto no existe';
        ROLLBACK;
        RETURN;
    END

    PRINT 'Producto válido';

---- VERIFICAR EXISTENCIA 
    DECLARE @existencia INT;

        SELECT @existencia = existencia
        FROM CatProducto
        WHERE id_producto = @id_producto;

    IF @existencia < @cantidad
    BEGIN
        PRINT 'No hay suficiente existencia';
        ROLLBACK;
        RETURN;
    END
ELSE 
    PRINT 'Existencia suficiente';


--- insertar venta 

DECLARE @id_venta INT
DECLARE @precio_venta INT


INSERT INTO TblVenta (fecha, id_cliente)
VALUES (GETDATE(), @id_cliente);

SET @id_venta = SCOPE_IDENTITY();

SELECT @precio_venta = precio
FROM CatProducto
WHERE id_producto = @id_producto;

---Insertar detalle 
INSERT  INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida )
VALUES (@id_venta, @id_producto, @precio_venta , @cantidad );

--- actualizar stock 
 UPDATE CatProducto 
 SET existencia = existencia -@cantidad
 WHERE id_producto = @id_producto;

 PRINT 'venta realizada correctamente';
    COMMIT;
END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK;
        END
        PRINT 'error' + ERROR_MESSAGE();
    END CATCH
END;
*/

GO
--throw ¿Qué hace THROW?
--- Sirve para lanzar errores personalizados

-------------------usp con throw agregado -----------------
CREATE OR ALTER PROC usp_agregar_venta  
    @id_cliente NCHAR(5),
    @id_producto INT,
    @cantidad INT
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;

    ---- VALIDACIÓN DE CLIENTE
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
    BEGIN
        THROW 50001, 'El cliente no existe', 1;
    END

    ---- VALIDACIÓN DE PRODUCTO
    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
    BEGIN
        THROW 50002, 'El producto no existe', 1;
    END

    ---- VALIDAR EXISTENCIA
    DECLARE @existencia INT;

    SELECT @existencia = existencia
    FROM CatProducto
    WHERE id_producto = @id_producto;

    IF @existencia < @cantidad
    BEGIN
        THROW 50003, 'No hay suficiente existencia', 1;
    END

    ---- INSERTAR VENTA
    DECLARE @id_venta INT;
    DECLARE @precio_venta MONEY;

    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (GETDATE(), @id_cliente);

    SET @id_venta = SCOPE_IDENTITY();

    ---- OBTENER PRECIO
    SELECT @precio_venta = precio
    FROM CatProducto
    WHERE id_producto = @id_producto;

    ---- INSERTAR DETALLE
    INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
    VALUES (@id_venta, @id_producto, @precio_venta, @cantidad);

    ---- ACTUALIZAR STOCK
    UPDATE CatProducto 
    SET existencia = existencia - @cantidad
    WHERE id_producto = @id_producto;

    PRINT 'Venta realizada correctamente';
    COMMIT;

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH
END;


SELECT *
FROM CatProducto;
SELECT *
FROM CatCliente;


EXEC usp_agregar_venta  'ANTON', 1 , 3 ; -- deberia salir bien
EXEC usp_agregar_venta 'XXXXX', 1, 2; -- deberia salir cliente no existe
EXEC usp_agregar_venta 'ANTON', 999, 2; -- deberia salir producto no existe
EXEC usp_agregar_venta 'ANTON', 1, 999; -- deberia salir sin stock