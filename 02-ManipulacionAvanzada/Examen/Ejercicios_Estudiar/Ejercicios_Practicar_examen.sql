/*📝 EJERCICIO TIPO EXAMEN (SP)

👉 Instrucciones:

Completa el procedimiento para:

- Validar que el cliente exista
- Validar que el producto exista
- Validar que haya stock
- Insertar la venta
- Insertar el detalle
- Actualizar el stock
*/

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
---
CREATE OR ALTER PROC usp_venta_practicar_examen
    @id_cliente NCHAR(5), -- parámetro: id del cliente
    @id_producto INT,     -- parámetro: id del producto
    @cantidad INT         -- parámetro: cantidad a vender
AS
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; -- inicia una transacción (todo o nada)

    ---- VALIDAR CLIENTE
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente) 
    BEGIN
        THROW 50001, 'Cliente no existe', 1; -- lanza error si no existe
    END

    ---- VALIDAR PRODUCTO
    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto) 
    BEGIN
        THROW 50002, 'Producto no existe', 1; -- lanza error si no existe
    END

    ---- VALIDAR STOCK
    DECLARE @existencia INT; -- variable para guardar el stock actual

    SELECT @existencia = existencia -- guardamos el stock real del producto
    FROM CatProducto
    WHERE id_producto = @id_producto;

    IF @existencia < @cantidad -- si el stock es menor a lo que se quiere vender
    BEGIN
        THROW 50003, 'Sin stock', 1; -- error por falta de inventario
    END

    ---- INSERTAR VENTA
    DECLARE @id_venta INT; -- variable para guardar el id generado
    DECLARE @precio MONEY; -- variable para guardar el precio del producto

    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (GETDATE(), @id_cliente); -- inserta la venta con fecha actual

    SET @id_venta = SCOPE_IDENTITY(); -- obtiene el id de la venta recién insertada

    ---- OBTENER PRECIO
    SELECT @precio = precio
    FROM CatProducto
    WHERE id_producto = @id_producto; -- obtiene el precio del producto

    ---- INSERTAR DETALLE
    INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
    VALUES (@id_venta, @id_producto, @precio, @cantidad); -- inserta el detalle de la venta

    ---- ACTUALIZAR STOCK
    UPDATE CatProducto
    SET existencia = existencia - @cantidad -- resta la cantidad vendida al stock
    WHERE id_producto = @id_producto;

    COMMIT; -- guarda definitivamente todos los cambios

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 1 -- verifica si hay una transacción activa
        ROLLBACK; -- deshace todo si hubo error

    PRINT ERROR_MESSAGE(); -- muestra el error
END CATCH

END;
go 









--- =========== Validaciones extras ---==========

CREATE OR ALTER PROC usp_venta_practicar_examen1
    @id_cliente NCHAR(5), -- id del cliente
    @id_producto INT,     -- id del producto
    @cantidad INT         -- cantidad a vender
AS
BEGIN

BEGIN TRY
    BEGIN TRANSACTION; -- inicia la transacción

    -------------------------------------------------
    -- VALIDACIONES GENERALES
    -------------------------------------------------

    -- validar que los parámetros no vengan nulos
    IF @id_cliente IS NULL OR @id_producto IS NULL OR @cantidad IS NULL
    BEGIN
        THROW 50000, 'No se permiten valores NULL', 1;
    END

    -- validar que la cantidad sea mayor a 0
    IF @cantidad <= 0
    BEGIN
        THROW 50000, 'La cantidad debe ser mayor a 0', 1;
    END

    -------------------------------------------------
    -- VALIDAR CLIENTE
    -------------------------------------------------

    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
    BEGIN
        THROW 50001, 'Cliente no existe', 1;
    END

    -------------------------------------------------
    -- VALIDAR PRODUCTO
    -------------------------------------------------

    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
    BEGIN
        THROW 50002, 'Producto no existe', 1;
    END

    -------------------------------------------------
    -- VALIDAR STOCK
    -------------------------------------------------

    DECLARE @existencia INT; -- variable para stock

    SELECT @existencia = existencia
    FROM CatProducto
    WHERE id_producto = @id_producto;

    IF @existencia < @cantidad
    BEGIN
        THROW 50003, 'No hay suficiente stock', 1;
    END

    -------------------------------------------------
    -- INSERTAR VENTA
    -------------------------------------------------

    DECLARE @id_venta INT; -- id de la venta
    DECLARE @precio MONEY; -- precio del producto

    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (GETDATE(), @id_cliente); -- inserta la venta

    SET @id_venta = SCOPE_IDENTITY(); -- obtiene el id generado

    -------------------------------------------------
    -- OBTENER PRECIO
    -------------------------------------------------

    SELECT @precio = precio
    FROM CatProducto
    WHERE id_producto = @id_producto;

    -------------------------------------------------
    -- INSERTAR DETALLE
    -------------------------------------------------

    INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
    VALUES (@id_venta, @id_producto, @precio, @cantidad);

    -------------------------------------------------
    -- ACTUALIZAR STOCK
    -------------------------------------------------

    UPDATE CatProducto
    SET existencia = existencia - @cantidad
    WHERE id_producto = @id_producto;

    -------------------------------------------------
    -- FINALIZAR
    -------------------------------------------------

    PRINT 'Venta realizada correctamente';
    COMMIT; -- guarda cambios

END TRY
BEGIN CATCH

    IF @@TRANCOUNT >= 0
        ROLLBACK;

    PRINT 'Error: ' + ERROR_MESSAGE();

END CATCH

END;

-- cliente no existe
EXEC usp_venta_practicar_examen1 'XXXXX', 1, 2;

-- producto no existe
EXEC usp_venta_practicar_examen1 'ALFKI', 999, 2;

-- sin stock
EXEC usp_venta_practicar_examen1 'ALFKI', 1, 9999;

-- cantidad inválida
EXEC usp_venta_practicar_examen1 'ALFKI', 1, 0;

--- probar si hay transaccion abierta 
SELECT @@TRANCOUNT as [transaccion abierta];

--- parar o borrar transaccion abierta 
ROLLBACK;

--Muchas abiertas	
WHILE @@TRANCOUNT > 0 ROLLBACK

----rangos
SELECT 
    @Total AS TotalGastado,
    CASE
        WHEN @Total > 5000 THEN 'VIP'
        WHEN @Total BETWEEN 2000 AND 5000 THEN 'Frecuente'
        ELSE 'Normal'
    END AS Categoria;

--- investigar como hacer tabla tipe como se consulta como se inserta y hacer un script donde se use y hacer un store 