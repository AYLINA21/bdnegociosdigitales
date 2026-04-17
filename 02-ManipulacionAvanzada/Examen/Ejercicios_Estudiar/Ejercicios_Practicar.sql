--Crear un procedimiento que reciba un ID y muestre el usuario correspondiente.

USE bdpracticas;
go 

SELECT *
FROM CatProducto;
SELECT *
FROM CatCliente;
SELECT *
FROM TblVenta;
SELECT *
FROM TblDetalleVenta;
go 

 /* EJERCICIO 1 – Venta simple con validaciones

 🎯 Enunciado
Crear un procedimiento que:
- Valide cliente
- Valide producto
- Valide stock
- Inserte venta
- Inserte detalle
- Actualice stock */

CREATE OR ALTER PROC usp_venta_simple
    @id_cliente NCHAR(5),
    @id_producto INT,
    @cantidad INT
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;

    -- Validar cliente
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
        THROW 50001, 'Cliente no existe', 1;

    -- Validar producto
    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
        THROW 50002, 'Producto no existe', 1;

    -- Validar stock
    DECLARE @existencia INT;

    SELECT @existencia = existencia
    FROM CatProducto
    WHERE id_producto = @id_producto;

    IF @existencia < @cantidad
        THROW 50003, 'Sin stock', 1;

    -- Insertar venta
    DECLARE @id_venta INT, @precio MONEY;

    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (GETDATE(), @id_cliente);

    SET @id_venta = SCOPE_IDENTITY();

    -- Obtener precio
    SELECT @precio = precio
    FROM CatProducto
    WHERE id_producto = @id_producto;

    -- Insertar detalle
    INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
    VALUES (@id_venta, @id_producto, @precio, @cantidad);

    -- Actualizar stock
    UPDATE CatProducto
    SET existencia = existencia - @cantidad
    WHERE id_producto = @id_producto;

    COMMIT;

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    PRINT ERROR_MESSAGE();
END CATCH
END;

--Comprobar procedimiento
EXEC usp_venta_simple 
    @id_cliente = 'ALFKI',
    @id_producto = 1,
    @cantidad = 2;
go



/*EJERCICIO 2 – Venta con validaciones extra
🎯 Enunciado

Agregar validaciones:

No permitir NULL
Cantidad > 0
*/

CREATE OR ALTER PROC usp_venta_validada
    @id_cliente NCHAR(5),
    @id_producto INT,
    @cantidad INT
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;

    -- Validar NULL
    IF @id_cliente IS NULL OR @id_producto IS NULL OR @cantidad IS NULL
        THROW 50000, 'No se permiten valores NULL', 1;

    -- Validar cantidad
    IF @cantidad <= 0
        THROW 50000, 'Cantidad inválida', 1;

    -- Validar cliente
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
        THROW 50001, 'Cliente no existe', 1;

    -- Validar producto
    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
        THROW 50002, 'Producto no existe', 1;

    -- Validar stock
    DECLARE @existencia INT;

    SELECT @existencia = existencia
    FROM CatProducto
    WHERE id_producto = @id_producto;

    IF @existencia < @cantidad
        THROW 50003, 'Sin stock', 1;

    -- Insertar venta
    DECLARE @id_venta INT, @precio MONEY;

    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (GETDATE(), @id_cliente);

    SET @id_venta = SCOPE_IDENTITY();

    -- Obtener precio
    SELECT @precio = precio
    FROM CatProducto
    WHERE id_producto = @id_producto;

    -- Insertar detalle
    INSERT INTO TblDetalleVenta
    VALUES (@id_venta, @id_producto, @precio, @cantidad);

    -- Actualizar stock
    UPDATE CatProducto
    SET existencia = existencia - @cantidad
    WHERE id_producto = @id_producto;

    COMMIT;

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    PRINT ERROR_MESSAGE();
END CATCH
END;


--Comprobar procedimiento
EXEC usp_venta_validada
    @id_cliente = 'ALFKI',
    @id_producto = 1,
    @cantidad = 2;  

/* EJERCICIO 3 – Venta con TABLE TYPE (Carrito)
🎯 Enunciado

Crear un procedimiento que:

Reciba múltiples productos
Valide carrito
Valide cliente
Valide productos y stock
Inserte venta
Inserte múltiples detalles
Actualice stock
*/

-- Tipo de tabla
CREATE TYPE DetalleVentaType2 AS TABLE (
    id_producto INT,
    cantidad INT
);
GO

-- Procedimiento
CREATE OR ALTER PROC usp_venta_carrito
    @id_cliente NCHAR(5),
    @productos DetalleVentaType READONLY
AS
BEGIN
    SET NOCOUNT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    -- Validar carrito
    IF NOT EXISTS (SELECT 1 FROM @productos)
        THROW 50004, 'Carrito vacío', 1;

    -- Validar cliente
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
        THROW 50001, 'Cliente no existe', 1;

    -- Validar productos y stock
    IF EXISTS (
        SELECT 1
        FROM @productos p
        LEFT JOIN CatProducto cp ON p.id_producto = cp.id_producto
        WHERE cp.id_producto IS NULL
           OR cp.existencia < p.cantidad
    )
        THROW 50003, 'Error en productos o stock', 1;

    -- Insertar venta
    DECLARE @id_venta INT;

    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (GETDATE(), @id_cliente);

    SET @id_venta = SCOPE_IDENTITY();

    -- Insertar detalles
    INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
    SELECT @id_venta, p.id_producto, cp.precio, p.cantidad
    FROM @productos p
    JOIN CatProducto cp ON p.id_producto = cp.id_producto;

    -- Actualizar stock
    UPDATE cp
    SET cp.existencia = cp.existencia - p.cantidad
    FROM CatProducto cp
    JOIN @productos p ON cp.id_producto = p.id_producto;

    COMMIT;

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    THROW;
END CATCH
END;
GO

-- Comprobar procedimiento
DECLARE @carrito DetalleVentaType;
INSERT INTO @carrito VALUES (1, 2), (2, 1);
EXEC usp_venta_carrito
    @id_cliente = 'ALFKI',
    @productos = @carrito;
GO

---COMPROBAR CON SELECT 
--VERIFICAR QUE INSERTE LA VENTA 
SELECT * FROM TblVenta ORDER BY id_venta DESC;

-- VERIFICAR QUE INSERTE LOS DETALLES
SELECT * FROM TblDetalleVenta ORDER BY id_venta DESC;

---VERIFICAR QUE ACTUALICE EL STOCK
SELECT id_producto, existencia 
FROM CatProducto 
WHERE id_producto = 1;

---VERIFICAR ERRORES
-- cliente no existe
EXEC usp_venta_simple 'XXXXX', 1, 2;
-- producto no existe
EXEC usp_venta_simple 'ALFKI', 999, 2;  
-- sin stock
EXEC usp_venta_simple 'ALFKI', 1, 1000;

---VERIFICAR TODO JUNTO 
SELECT TOP 5 * FROM TblVenta ORDER BY id_venta DESC;
SELECT TOP 5 * FROM TblDetalleVenta ORDER BY id_venta DESC;
SELECT * FROM CatProducto;

--VERIFICAR TRANSACCION 
SELECT @@TRANCOUNT;

--LIMPIAR SI SE BUGEA
WHILE @@TRANCOUNT > 0 ROLLBACK;