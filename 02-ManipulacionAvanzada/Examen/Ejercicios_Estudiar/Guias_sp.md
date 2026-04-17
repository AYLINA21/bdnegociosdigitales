# Guia Para Sp type

# 🧩 Plantilla Reutilizable – Stored Procedure con Table Type

## 🧠 Objetivo
Estructura base para procedimientos que:
- Reciben múltiples registros (carrito)
- Validan datos
- Insertan en tablas relacionadas
- Usan transacciones

---

# 📦 1. CREAR TABLE TYPE

```sql
-- Verificar si el tipo ya existe
IF EXISTS (SELECT * FROM sys.types WHERE name = 'NombreTipo')
    DROP TYPE NombreTipo;
GO

-- Crear tipo de tabla
CREATE TYPE NombreTipo AS TABLE (
    campo1 TIPO_DATO, -- Ej: id_producto INT
    campo2 TIPO_DATO  -- Ej: cantidad INT
);
GO

📝 Aquí debes definir:

Nombre del tipo
Columnas necesarias (según problema)
⚙️ 2. PROCEDIMIENTO
CREATE OR ALTER PROC NombreProcedimiento  
    @parametro1 TIPO_DATO,              -- Ej: id_cliente
    @tabla_param NombreTipo READONLY    -- Tabla tipo
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
🛑 VALIDACIÓN DE TABLA VACÍA
        IF NOT EXISTS (SELECT 1 FROM @tabla_param)
        BEGIN
            THROW 50000, 'Mensaje de error (tabla vacía)', 1;
        END

📝 Aquí validas que sí haya datos

👤 VALIDACIÓN PRINCIPAL (EJ: CLIENTE)
        IF NOT EXISTS (
            SELECT 1 
            FROM NombreTabla 
            WHERE campo = @parametro1
        )
        BEGIN
            THROW 50001, 'Mensaje de error (no existe)', 1;
        END

📝 Aquí validas entidad principal

📦 VALIDACIÓN DE DATOS RELACIONADOS
        IF EXISTS (
            SELECT 1
            FROM @tabla_param t
            LEFT JOIN OtraTabla o ON t.campo = o.campo
            WHERE o.campo IS NULL
               OR condicion_de_error
        )
        BEGIN
            THROW 50002, 'Mensaje de error (validación fallida)', 1;
        END

📝 Aquí validas:

Existencia
Stock
Reglas de negocio
🧾 INSERTAR REGISTRO PRINCIPAL
        DECLARE @id_generado INT;

        INSERT INTO TablaPrincipal (campo1, campo2)
        VALUES (valor1, valor2);

📝 Aquí insertas:

Venta
Pedido
Registro principal
🔑 OBTENER ID GENERADO
        SET @id_generado = SCOPE_IDENTITY();

📝 Guarda el ID recién insertado

📄 INSERTAR DETALLE (MÚLTIPLE)
        INSERT INTO TablaDetalle (campo1, campo2, campo3)
        SELECT 
            @id_generado, 
            t.campo, 
            o.otro_campo
        FROM @tabla_param t
        JOIN OtraTabla o ON t.campo = o.campo;

📝 Aquí:

Insertas múltiples registros
Usas JOIN para traer datos
📉 ACTUALIZAR DATOS (EJ: STOCK)
        UPDATE o
        SET o.campo = o.campo - t.campo
        FROM OtraTabla o
        INNER JOIN @tabla_param t ON o.campo = t.campo;

📝 Aquí actualizas:

Inventario
Saldos
Cantidades
💾 CONFIRMAR CAMBIOS
        COMMIT;

📝 Guarda todo

✅ MENSAJE FINAL
        SELECT 
            @id_generado AS id_resultado,
            'Mensaje de éxito' AS Mensaje;

📝 Devuelve resultado

❌ MANEJO DE ERRORES
    END TRY
    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW;

    END CATCH
END;
GO
```


# Importante esta sera mi guia pero:
Cambia nombres de tablas
Ajusta validaciones
Define columnas del TYPE
Adapta INSERT y UPDATE



# Nota
Si veo:
👉 "agregar varios", "carrito", "lista"

✔ Usa TABLE TYPE
✔ Usa INSERT SELECT
✔ Usa JOIN