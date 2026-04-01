
USE bdpracticas;
---=====================AGREGAR MAS DE UN PRODUCTO======-----
-----------------------------------------------------------
-- 1. CREACIÓN DEL TIPO DE TABLA (User-Defined Table Type)
-----------------------------------------------------------
IF EXISTS (SELECT * FROM sys.types WHERE name = 'DetalleVentaType')
    DROP TYPE DetalleVentaType;
GO

CREATE TYPE DetalleVentaType AS TABLE (
    id_producto INT,
    cantidad INT
);
GO

-----------------------------------------------------------
-- 2. PROCEDIMIENTO ALMACENADO
-----------------------------------------------------------
CREATE OR ALTER PROC usp_agregar_venta2  
    @id_cliente NCHAR(5),
    @productos DetalleVentaType READONLY
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        -- VALIDAR CARRITO VACÍO
        IF NOT EXISTS (SELECT 1 FROM @productos)
        BEGIN
            THROW 50004, 'Error: El carrito está vacío.', 1;
        END

        -- VALIDACIÓN DE CLIENTE
        IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
        BEGIN
            THROW 50001, 'Error: El cliente no existe en el sistema.', 1;
        END

        -- VALIDACIÓN DE PRODUCTOS Y STOCK
        IF EXISTS (
            SELECT 1 
            FROM @productos p
            LEFT JOIN CatProducto cp ON p.id_producto = cp.id_producto
            WHERE cp.id_producto IS NULL
               OR cp.existencia < p.cantidad
        )
        BEGIN
            THROW 50003, 'Error: Uno o más productos no existen o no tienen stock suficiente.', 1;
        END

        -- INSERTAR CABECERA DE VENTA
        DECLARE @id_venta INT;

        INSERT INTO TblVenta (fecha, id_cliente)
        VALUES (GETDATE(), @id_cliente);

        SET @id_venta = SCOPE_IDENTITY();

        -- INSERTAR DETALLE
        INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
        SELECT @id_venta, p.id_producto, cp.precio, p.cantidad
        FROM @productos p
        JOIN CatProducto cp ON p.id_producto = cp.id_producto;

        -- ACTUALIZAR STOCK
        UPDATE cp
        SET cp.existencia = cp.existencia - p.cantidad
        FROM CatProducto cp
        INNER JOIN @productos p ON cp.id_producto = p.id_producto;

        COMMIT;

        -- MENSAJE DE ÉXITO
        SELECT @id_venta AS id_venta, 'Venta registrada con éxito.' AS Mensaje;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW;
    END CATCH
END;
GO

-----------------------------------------------------------
-- 3. EJEMPLO DE USO
-----------------------------------------------------------

DECLARE @Carrito DetalleVentaType;

INSERT INTO @Carrito (id_producto, cantidad)
VALUES 
    (1, 5),
    (2, 10),
    (3, 1);

EXEC usp_agregar_venta2 
    @id_cliente = '0152', 
    @productos = @Carrito;
GO
-- PRUEBAS DE VALIDACIÓN      
--- Todo Bien 

DECLARE @Carrito DetalleVentaType;
GO

INSERT INTO @Carrito VALUES (1,2), (2,3);
GO

EXEC usp_agregar_venta2 'ANTON', @Carrito;
GO
--- Cliente no existe

DECLARE @Carrito DetalleVentaType;
INSERT INTO @Carrito VALUES (1,2), (2,3);
EXEC usp_agregar_venta2 'XXXXX', @Carrito;
GO

--- Producto no existe

DECLARE @Carrito DetalleVentaType;
INSERT INTO @Carrito VALUES (999,2), (2,3);
EXEC usp_agregar_venta2 'ANTON', @Carrito;
GO

--- Carrito vacío
DECLARE @Carrito DetalleVentaType;
EXEC usp_agregar_venta2 'ANTON', @Carrito;
