# 📚 Stored Procedures en SQL Server

## 🧠 ¿Qué es un Stored Procedure?
Un **Stored Procedure** es un bloque de código SQL guardado dentro de la base de datos que se puede ejecutar cuando se necesite.

### 📌 ¿Para qué sirve?
- Reutilizar código
- Evitar repetir consultas
- Mejorar el rendimiento
- Implementar lógica (condiciones, ciclos, etc.)

---

## ✍️ Estructura básica

```sql
CREATE PROCEDURE NombreProcedimiento
AS
BEGIN
    -- Código SQL aquí
    SELECT * FROM Tabla;
END;

##  Ejecutar un procedimiento

```sql
EXEC NombreProcedimiento;

```
## 📥 Procedimientos con parámetros
```sql
CREATE PROCEDURE ObtenerUsuario
    @Id INT
AS
BEGIN
    SELECT * FROM Usuarios WHERE Id = @Id;
END;
```

## Ejecutar con parámetro
```sql
EXEC ObtenerUsuario @Id = 1;
```
## 📤 Parámetros de salida (OUTPUT)
```sql
CREATE PROCEDURE ContarUsuarios
    @Total INT OUTPUT
AS
BEGIN
    SELECT @Total = COUNT(*) FROM Usuarios;
END;
```

## ▶️ Ejecutar con OUTPUT
```sql
DECLARE @Resultado INT;
EXEC ContarUsuarios @Total = @Resultado OUTPUT;
PRINT @Resultado;
```

## 🔀 Condicionales (IF)
```sql
IF @Edad >= 18
    PRINT 'Mayor de edad';
ELSE
    PRINT 'Menor de edad';
```
## ➕ Uso con INSERT
```sql

CREATE PROCEDURE AgregarUsuario
    @Nombre VARCHAR(50)
AS
BEGIN
    INSERT INTO Usuarios (Nombre)
    VALUES (@Nombre);
END;
```

# NOTA
## 📌 Puntos clave: Stored Procedures vs Functions

### 🔹 Diferencia entre:
- **PROCEDURE**
  - Puede modificar datos
  - Usa: `INSERT`, `UPDATE`, `DELETE`

- **FUNCTION**
  - Normalmente devuelve un valor
  - Se usa dentro de consultas (`SELECT`)

---

### 🔹 Uso de:
- `EXEC` → Ejecutar un procedimiento
- `OUTPUT` → Obtener valores de salida
- **Parámetros** → Pasar datos al procedimiento

---

### 🔹 Errores comunes:
- ❌ Variable no declarada
- ❌ Objeto no existe

---

### 🔹 Uso correcto de:
- `BEGIN` y `END` → Delimitan el bloque de código

---

✨ Tip: Si algo falla, revisa primero nombres de variables y tablas.

# Importante 

Primero escribe la consulta normal (SELECT, INSERT, etc.)
Luego colócala dentro del PROCEDURE

-------------------------------------------------------------------

## EJERCICIO EXPLICADO

# 🔴 Stored Procedure Documentado (Línea por Línea)

## 🧠 Descripción
Este procedimiento realiza una venta validando:
- Cliente
- Producto
- Stock

Y ejecuta:
- Inserción de venta
- Inserción de detalle
- Actualización de inventario

👉 Todo dentro de una transacción

---

## 💻 Código documentado

```sql
USE bdpracticas;
GO

-- Crear o modificar el procedimiento almacenado
CREATE OR ALTER PROC usp_venta_practicar_examen
    @id_cliente NCHAR(5), -- ID del cliente
    @id_producto INT,     -- ID del producto
    @cantidad INT         -- Cantidad a vender
AS
BEGIN

-- Inicia bloque de control de errores
BEGIN TRY

    -- Inicia una transacción (todo se ejecuta o nada)
    BEGIN TRANSACTION;

    -------------------------------------------------
    -- VALIDAR CLIENTE
    -------------------------------------------------

    -- Verifica si el cliente NO existe en la tabla
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
    BEGIN
        -- Lanza un error personalizado
        THROW 50001, 'Cliente no existe', 1;
    END

    -------------------------------------------------
    -- VALIDAR PRODUCTO
    -------------------------------------------------

    -- Verifica si el producto NO existe
    IF NOT EXISTS (SELECT 1 FROM CatProducto WHERE id_producto = @id_producto)
    BEGIN
        -- Error si no existe
        THROW 50002, 'Producto no existe', 1;
    END

    -------------------------------------------------
    -- VALIDAR STOCK
    -------------------------------------------------

    -- Declara variable para almacenar el stock actual
    DECLARE @existencia INT;

    -- Obtiene la existencia del producto
    SELECT @existencia = existencia
    FROM CatProducto
    WHERE id_producto = @id_producto;

    -- Verifica si el stock es insuficiente
    IF @existencia < @cantidad
    BEGIN
        -- Error si no hay suficiente inventario
        THROW 50003, 'Sin stock', 1;
    END

    -------------------------------------------------
    -- INSERTAR VENTA
    -------------------------------------------------

    -- Variable para guardar el ID generado de la venta
    DECLARE @id_venta INT;

    -- Variable para guardar el precio del producto
    DECLARE @precio MONEY;

    -- Inserta la venta con fecha actual y cliente
    INSERT INTO TblVenta (fecha, id_cliente)
    VALUES (GETDATE(), @id_cliente);

    -- Obtiene el último ID insertado (ID de la venta)
    SET @id_venta = SCOPE_IDENTITY();

    -------------------------------------------------
    -- OBTENER PRECIO
    -------------------------------------------------

    -- Obtiene el precio actual del producto
    SELECT @precio = precio
    FROM CatProducto
    WHERE id_producto = @id_producto;

    -------------------------------------------------
    -- INSERTAR DETALLE DE VENTA
    -------------------------------------------------

    -- Inserta el detalle de la venta
    INSERT INTO TblDetalleVenta (
        id_venta, 
        id_producto, 
        precio_venta, 
        cantidad_vendida
    )
    VALUES (
        @id_venta, 
        @id_producto, 
        @precio, 
        @cantidad
    );

    -------------------------------------------------
    -- ACTUALIZAR STOCK
    -------------------------------------------------

    -- Resta la cantidad vendida al inventario
    UPDATE CatProducto
    SET existencia = existencia - @cantidad
    WHERE id_producto = @id_producto;

    -------------------------------------------------
    -- CONFIRMAR CAMBIOS
    -------------------------------------------------

    -- Guarda todos los cambios realizados
    COMMIT;

END TRY

-- Bloque de manejo de errores
BEGIN CATCH

    -- Si hay una transacción activa, se revierte todo
    IF @@TRANCOUNT > 1
        ROLLBACK;

    -- Muestra el mensaje de error
    PRINT ERROR_MESSAGE();

END CATCH

END;
GO

```

## 🧠 Resumen rápido
🔹 TRY / CATCH → Manejo de errores
🔹 TRANSACTION → Seguridad de datos
🔹 THROW → Errores personalizados
🔹 SCOPE_IDENTITY() → Último ID insertado
🔹 ROLLBACK → Deshace cambios si falla


## 💥 Lógica del proceso
Validar cliente
Validar producto
Validar stock
Insertar venta
Obtener ID
Insertar detalle
Actualizar stock
Confirmar cambios

# Solo repasa mentalmente esto:

NOT EXISTS → validar
SCOPE_IDENTITY() → ID
INSERT + SELECT → múltiples
TRANSACTION → COMMIT / ROLLBACK
Orden:
Validar → Insertar → Detalle → Update → Commit