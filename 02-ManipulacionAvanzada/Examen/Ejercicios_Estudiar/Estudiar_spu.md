# 🧩 ESTRUCTURA DE UN STORED PROCEDURE (SP)
## 🔹 Forma básica

```sql
CREATE OR ALTER PROC nombre_procedimiento
AS
BEGIN

    -- instrucciones SQL
    SELECT * FROM tabla;

END;
```

## 🔹 Con parámetros (lo MÁS común)

```sql
CREATE OR ALTER PROC nombre_procedimiento
    @parametro1 TIPO,
    @parametro2 TIPO
AS
BEGIN

    SELECT *
    FROM tabla
    WHERE columna = @parametro1;

END;
```

## 🔹 Ejemplo real
```sql
CREATE OR ALTER PROC spu_buscar_cliente
    @id_cliente NCHAR(5)
AS
BEGIN

    SELECT *
    FROM Customers
    WHERE CustomerID = @id_cliente;

END;
```

## 👉 Ejecutarlo:
```sql
EXEC spu_buscar_cliente 'ALFKI';

```

## 🔹 Con VALIDACIONES 
```sql
CREATE OR ALTER PROC ejemplo_validacion
    @numero INT
AS
BEGIN

    IF @numero <= 0
    BEGIN
        PRINT 'Número no válido';
        RETURN;
    END

    SELECT @numero * 5 AS resultado;

END;

```

### 🔹 Con TRY - CATCH + TRANSACTION 
```sql
CREATE OR ALTER PROC ejemplo_completo
    @id INT,
    @nombre VARCHAR(50)
AS
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO tabla
    VALUES (@id, @nombre);

    COMMIT;
    PRINT 'Insertado correctamente';

END TRY

BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH

END;

```

## 🔹 Con OUTPUT
```sql
CREATE OR ALTER PROC sumar
    @a INT,
    @b INT,
    @resultado INT OUTPUT
AS
BEGIN

    SET @resultado = @a + @b;

END;
```

👉 Ejecutar:
```sql
DECLARE @res INT;
EXEC sumar 5, 7, @res OUTPUT;
SELECT @res;
```

# EXPLICACION DEL EJERCICIO DE PRACTICA LINA A LINEA 
```SQL
CREATE OR ALTER PROC usp_agregar_venta  -- Crea o actualiza el procedimiento almacenado
    @id_cliente NCHAR(5),               -- Parámetro: ID del cliente
    @id_producto INT,                  -- Parámetro: ID del producto
    @cantidad INT                      -- Parámetro: cantidad a vender
AS
BEGIN                                  -- Inicio del procedimiento

BEGIN TRY                              -- Bloque que intenta ejecutar el código
    BEGIN TRANSACTION;                 -- Inicia una transacción (todo o nada)

    ---- VALIDACIÓN DE CLIENTE
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)  -- Verifica si el cliente existe
    BEGIN
        THROW 50001, 'El cliente no existe', 1;  -- Lanza error si no existe
    END

    ---- VALIDACIÓN DE PRODUCTO
    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto) -- Verifica si el producto existe
    BEGIN
        THROW 50002, 'El producto no existe', 1; -- Lanza error si no existe
    END

    ---- VALIDAR EXISTENCIA
    DECLARE @existencia INT;           -- Declara variable para guardar el stock

    SELECT @existencia = existencia    -- Obtiene la existencia actual del producto
    FROM CatProducto
    WHERE id_producto = @id_producto;

    IF @existencia < @cantidad         -- Verifica si hay suficiente stock
    BEGIN
        THROW 50003, 'No hay suficiente existencia', 1; -- Error si no hay suficiente
    END

    ---- INSERTAR VENTA
    DECLARE @id_venta INT;             -- Variable para guardar el ID de la venta
    DECLARE @precio_venta MONEY;       -- Variable para guardar el precio del producto

    INSERT INTO TblVenta (fecha, id_cliente)  -- Inserta una nueva venta
    VALUES (GETDATE(), @id_cliente);          -- Guarda la fecha actual y el cliente

    SET @id_venta = SCOPE_IDENTITY(); -- Obtiene el ID de la venta recién creada

    ---- OBTENER PRECIO
    SELECT @precio_venta = precio      -- Obtiene el precio del producto
    FROM CatProducto
    WHERE id_producto = @id_producto;

    ---- INSERTAR DETALLE
    INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
    VALUES (@id_venta, @id_producto, @precio_venta, @cantidad); -- Inserta el detalle de la venta

    ---- ACTUALIZAR STOCK
    UPDATE CatProducto                -- Actualiza la tabla de productos
    SET existencia = existencia - @cantidad  -- Resta la cantidad vendida
    WHERE id_producto = @id_producto;        -- Solo al producto vendido

    PRINT 'Venta realizada correctamente'; -- Mensaje si todo salió bien
    COMMIT;                                -- Confirma la transacción (guarda cambios)

END TRY
BEGIN CATCH                             -- Bloque que se ejecuta si ocurre un error
    IF @@TRANCOUNT > 0                  -- Verifica si hay una transacción activa
        ROLLBACK;                       -- Cancela todos los cambios realizados

    PRINT 'Error: ' + ERROR_MESSAGE();  -- Muestra el mensaje de error
END CATCH

END;                                    -- Fin del procedimiento
```
# EJERCICIOS DE PRATICA 

## 📝 EJERCICIO TIPO EXAMEN (SP)

👉 Instrucciones:

Completa el procedimiento para:

- Validar que el cliente exista
- Validar que el producto exista
- Validar que haya stock
- Insertar la venta
- Insertar el detalle
- Actualizar el stock

---

``` SQL 
CREATE OR ALTER PROC usp_venta_examen
    @id_cliente NCHAR(5),
    @id_producto INT,
    @cantidad INT
AS
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

    ---- VALIDAR CLIENTE
    IF NOT EXISTS (_______________________________)
    BEGIN
        THROW 50001, 'Cliente no existe', 1;
    END

    ---- VALIDAR PRODUCTO
    IF NOT EXISTS (_______________________________)
    BEGIN
        THROW 50002, 'Producto no existe', 1;
    END

    ---- VALIDAR STOCK
    DECLARE @existencia INT;

    SELECT @existencia = ____________
    FROM CatProducto
    WHERE __________________________;

    IF __________________________
    BEGIN
        THROW 50003, 'Sin stock', 1;
    END

    ---- INSERTAR VENTA
    DECLARE @id_venta INT;
    DECLARE @precio MONEY;

    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (__________, ____________);

    SET @id_venta = __________________;

    ---- OBTENER PRECIO
    SELECT @precio = ____________
    FROM CatProducto
    WHERE _______________________;

    ---- INSERTAR DETALLE
    INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
    VALUES (__________, ____________, ____________, ____________);

    ---- ACTUALIZAR STOCK
    UPDATE CatProducto
    SET existencia = __________________
    WHERE ____________________________;

    COMMIT;

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    PRINT ERROR_MESSAGE();
END CATCH

END;
```
