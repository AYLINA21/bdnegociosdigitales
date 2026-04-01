# 📘 Documentación: Stored Procedure con múltiples productos

---

## 🧠 ¿Qué es una tabla tipo TYPE?

Una **tabla tipo TYPE (User-Defined Table Type)** es una estructura definida por el usuario en SQL Server que permite crear un “molde” de tabla para enviar múltiples registros como parámetro a un procedimiento almacenado.


```
--Nota:
Un TYPE es como una tabla que yo creo para poder guardar varios datos y enviarlos juntos a un procedimiento.
👉 Es como un carrito donde meto varios productos.
```
---

## 🎯 ¿Para qué sirve?

* Permite enviar **varios datos al mismo tiempo** a un Stored Procedure
* Evita hacer múltiples llamadas al procedimiento
* Mejora el rendimiento
* Facilita el manejo de datos tipo “lista” o “carrito”

```
--Nota:
Sirve para enviar varios datos al mismo tiempo y no uno por uno.

Hace el proceso más rápido y ordenado
```
---

## ⚙️ ¿Cómo se usa?

1. Se crea un TYPE (estructura de tabla)
2. Se declara una variable basada en ese TYPE
3. Se insertan datos en esa variable
4. Se pasa como parámetro a un Stored Procedure

```
--Nota:
Creo el TYPE
Declaro una variable con ese TYPE
Inserto datos
Lo mando al procedimiento
```
---

## 🏗️ ¿Cómo se crea?

Se usa CREATE TYPE y se define como si fuera una tabla.

```sql
CREATE TYPE DetalleVentaType AS TABLE (
    id_producto INT,
    cantidad INT
);
```
Se crea escribiendo el nombre del tipo y las columnas que va a tener, igual que una tabla normal.

---
## ⚙️ ¿Cómo se usa un TYPE?
Se utiliza declarando una variable basada en el TYPE.
```sql
DECLARE @Carrito DetalleVentaType;
```
Se usa declarando una variable que funcionará como una tabla donde guardaré los datos.

## 📥 ¿Cómo se insertan datos?

Se usa INSERT INTO como si fuera una tabla.

```sql
DECLARE @Carrito DetalleVentaType;

INSERT INTO @Carrito (id_producto, cantidad)
VALUES (1,2), (2,3);
```
Se insertan datos igual que en una tabla normal, agregando filas con valores.
---

## 🚀 ¿Cómo se manda a llamar en un Stored Procedure?

Se pasa como parámetro al ejecutar el procedimiento.

```sql
EXEC usp_agregar_venta2 
    @id_cliente = 'ANTON', 
    @productos = @Carrito;
```
Se manda como parámetro, igual que cualquier variable, pero en este caso es una tabla completa.
---

# 🧩 Paso a paso del código

## 🔹 1. Creación del TYPE

```sql
IF EXISTS (SELECT * FROM sys.types WHERE name = 'DetalleVentaType')
    DROP TYPE DetalleVentaType;
```

👉 Elimina el TYPE si ya existe para evitar errores

```sql
CREATE TYPE DetalleVentaType AS TABLE (
    id_producto INT,
    cantidad INT
);
```

👉 Crea la estructura que almacenará múltiples productos

---

## 🔹 2. Creación del Stored Procedure

```sql
CREATE OR ALTER PROC usp_agregar_venta2  
```

👉 Crea o modifica el procedimiento

```sql
@id_cliente NCHAR(5),
@productos DetalleVentaType READONLY
```

👉 Parámetros:

* id_cliente: cliente que realiza la compra
* productos: tabla con los productos a vender

---

## 🔹 3. Configuración inicial

```sql
SET NOCOUNT ON;
```

👉 Evita mensajes innecesarios de filas afectadas

---

## 🔹 4. Manejo de errores

```sql
BEGIN TRY
BEGIN TRANSACTION;
```

👉 Inicia una transacción para asegurar integridad

---

## 🔹 5. Validaciones

### 🛒 Carrito vacío

```sql
IF NOT EXISTS (SELECT 1 FROM @productos)
```

👉 Verifica que haya productos

---

### 👤 Cliente

```sql
IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
```

👉 Verifica que el cliente exista

---

### 📦 Productos y stock

```sql
LEFT JOIN CatProducto
```

👉 Valida:

* Que el producto exista
* Que tenga suficiente stock

---

## 🔹 6. Inserción de venta

```sql
INSERT INTO TblVenta (fecha, id_cliente)
```

👉 Inserta la venta principal

```sql
SET @id_venta = SCOPE_IDENTITY();
```

👉 Obtiene el ID generado

---

## 🔹 7. Inserción de detalles

```sql
INSERT INTO TblDetalleVenta
SELECT ...
```

👉 Inserta todos los productos en una sola operación

---

## 🔹 8. Actualización de stock

```sql
UPDATE cp
SET cp.existencia = cp.existencia - p.cantidad
```

👉 Resta el stock de todos los productos

---

## 🔹 9. Confirmación

```sql
COMMIT;
```

👉 Guarda los cambios

---

## 🔹 10. Mensaje final

```sql
SELECT @id_venta AS id_venta, 'Venta registrada con éxito.' AS Mensaje;
```

👉 Devuelve resultado limpio

---

## 🔹 11. Manejo de errores

```sql
BEGIN CATCH
ROLLBACK;
THROW;
```

👉 Revierte cambios si ocurre error

---

# 🧪 Pruebas realizadas

## ✔ Caso correcto

* Inserción de varios productos
* Venta registrada correctamente

---

## ❌ Cliente no existe

* Se valida correctamente
* Se lanza error con THROW

---

## ❌ Producto no existe

* Detectado mediante LEFT JOIN

---

## ❌ Sin stock

* Se evita la venta

---

## ❌ Carrito vacío

* Se bloquea la ejecución

---

# ⚠️ Errores encontrados y soluciones

## 🔴 Error: Must declare the scalar variable "@Carrito"

✔ Causa: ejecutar el código en partes
✔ Solución: ejecutar todo en un mismo bloque

---

## 🔴 Error con THROW mostrando mensajes en rojo (no me gusta como se ve 🫣)

✔ Causa: comportamiento de SQL Server
✔ Solución: usar SELECT para mostrar mensajes limpios (pero lo pidio con throw)

---

## 🔴 Error en validación de producto (SP anterior)

✔ Causa: validación incorrecta usando tabla de clientes
✔ Solución: usar CatProducto correctamente

---

# 📝 Nota importante

La cantidad **no se envía como parámetro independiente**, ya que cada producto puede tener una cantidad distinta.
Por ello, la cantidad se incluye dentro del TYPE, permitiendo manejar múltiples productos de forma eficiente.

---

# 🏆 Conclusión

El procedimiento desarrollado permite:

* Insertar múltiples productos en una sola operación
* Validar datos de forma eficiente
* Mantener la integridad de la información mediante transacciones
* Optimizar el rendimiento evitando procesos repetitivos

Esto representa una mejora respecto al procedimiento anterior, ya que permite manejar múltiples productos de forma más eficiente y profesional.

---
# 📘 Script documentado (comentado línea por línea)

```sql
USE bdpracticas; 
-- Selecciona la base de datos donde se trabajará

---=====================AGREGAR MAS DE UN PRODUCTO======-----
-----------------------------------------------------------
-- 1. CREACIÓN DEL TIPO DE TABLA (User-Defined Table Type)
-----------------------------------------------------------

IF EXISTS (SELECT * FROM sys.types WHERE name = 'DetalleVentaType')
-- Verifica si el TYPE ya existe en la base de datos
    DROP TYPE DetalleVentaType;
-- Si existe, lo elimina para poder crearlo de nuevo sin error
GO
-- Finaliza el bloque de ejecución

CREATE TYPE DetalleVentaType AS TABLE (
    id_producto INT,   -- Columna que guarda el ID del producto
    cantidad INT       -- Columna que guarda la cantidad de ese producto
);
-- Crea un TYPE que funcionará como una tabla para enviar múltiples productos
GO

-----------------------------------------------------------
-- 2. PROCEDIMIENTO ALMACENADO
-----------------------------------------------------------

CREATE OR ALTER PROC usp_agregar_venta2  
-- Crea o modifica el procedimiento almacenado

    @id_cliente NCHAR(5),
    -- Parámetro que recibe el ID del cliente

    @productos DetalleVentaType READONLY
    -- Parámetro tipo tabla que recibe múltiples productos (solo lectura)
AS
BEGIN
    SET NOCOUNT ON;
    -- Evita mostrar mensajes de filas afectadas

    BEGIN TRY
    -- Inicia bloque de ejecución controlada

        BEGIN TRANSACTION;
        -- Inicia una transacción para asegurar integridad

        -- VALIDAR CARRITO VACÍO
        IF NOT EXISTS (SELECT 1 FROM @productos)
        -- Verifica si la tabla de productos está vacía
        BEGIN
            THROW 50004, 'Error: El carrito está vacío.', 1;
            -- Lanza error si no hay productos
        END

        -- VALIDACIÓN DE CLIENTE
        IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
        -- Verifica si el cliente existe en la tabla
        BEGIN
            THROW 50001, 'Error: El cliente no existe en el sistema.', 1;
            -- Lanza error si el cliente no existe
        END

        -- VALIDACIÓN DE PRODUCTOS Y STOCK
        IF EXISTS (
            SELECT 1 
            FROM @productos p
            LEFT JOIN CatProducto cp ON p.id_producto = cp.id_producto
            -- Relaciona los productos enviados con los del catálogo
            WHERE cp.id_producto IS NULL
               -- Detecta productos que no existen
               OR cp.existencia < p.cantidad
               -- Detecta productos sin suficiente stock
        )
        BEGIN
            THROW 50003, 'Error: Uno o más productos no existen o no tienen stock suficiente.', 1;
            -- Lanza error si hay problemas con productos o stock
        END

        -- INSERTAR CABECERA DE VENTA
        DECLARE @id_venta INT;
        -- Declara variable para guardar el ID de la venta

        INSERT INTO TblVenta (fecha, id_cliente)
        VALUES (GETDATE(), @id_cliente);
        -- Inserta la venta principal con fecha actual y cliente

        SET @id_venta = SCOPE_IDENTITY();
        -- Obtiene el ID generado automáticamente

        -- INSERTAR DETALLE
        INSERT INTO TblDetalleVenta (id_venta, id_producto, precio_venta, cantidad_vendida)
        SELECT @id_venta, p.id_producto, cp.precio, p.cantidad
        FROM @productos p
        JOIN CatProducto cp ON p.id_producto = cp.id_producto;
        -- Inserta todos los productos en una sola operación

        -- ACTUALIZAR STOCK
        UPDATE cp
        SET cp.existencia = cp.existencia - p.cantidad
        FROM CatProducto cp
        INNER JOIN @productos p ON cp.id_producto = p.id_producto;
        -- Resta del inventario la cantidad vendida

        COMMIT;
        -- Guarda todos los cambios realizados

        -- MENSAJE DE ÉXITO
        SELECT @id_venta AS id_venta, 'Venta registrada con éxito.' AS Mensaje;
        -- Devuelve el ID de la venta y un mensaje

    END TRY
    BEGIN CATCH
        -- Bloque que captura errores

        IF @@TRANCOUNT > 0
            ROLLBACK;
        -- Si hay una transacción activa, se cancela

        THROW;
        -- Muestra el error ocurrido
    END CATCH
END;
GO

-----------------------------------------------------------
-- 3. EJEMPLO DE USO
-----------------------------------------------------------

DECLARE @Carrito DetalleVentaType;
-- Declara una variable tipo tabla

INSERT INTO @Carrito (id_producto, cantidad)
VALUES 
    (1, 5),
    (2, 10),
    (3, 1);
-- Inserta varios productos en el carrito

EXEC usp_agregar_venta2 
    @id_cliente = '0152', 
    @productos = @Carrito;
-- Ejecuta el procedimiento enviando el carrito

-----------------------------------------------------------
-- PRUEBAS DE VALIDACIÓN
-----------------------------------------------------------

-- ✔ Todo bien
DECLARE @Carrito DetalleVentaType;
INSERT INTO @Carrito VALUES (1,2), (2,3);
EXEC usp_agregar_venta2 'ANTON', @Carrito;
-- Debe registrar la venta correctamente

-- ❌ Cliente no existe
DECLARE @Carrito DetalleVentaType;
INSERT INTO @Carrito VALUES (1,2), (2,3);
EXEC usp_agregar_venta2 'XXXXX', @Carrito;
-- Debe lanzar error de cliente inexistente

-- ❌ Producto no existe
DECLARE @Carrito DetalleVentaType;
INSERT INTO @Carrito VALUES (999,2), (2,3);
EXEC usp_agregar_venta2 'ANTON', @Carrito;
-- Debe lanzar error de producto inexistente

-- ❌ Carrito vacío
DECLARE @Carrito DetalleVentaType;
EXEC usp_agregar_venta2 'ANTON', @Carrito;
-- Debe lanzar error de carrito vacío
```

---