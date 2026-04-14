# 🔥 VALIDACIONES QUE SE PUEDEN HACER 


## 🔹 1. Validar si existe un registro
```SQL
IF NOT EXISTS (SELECT 1 FROM tabla WHERE id = @id)
BEGIN
    PRINT 'No existe';
    RETURN;
END
```


## 🔹 2. Validar si SÍ existe
```SQL
IF EXISTS (SELECT 1 FROM tabla WHERE id = @id)
BEGIN
    PRINT 'Ya existe';
END
```


## 🔹 3. Validar NULL
```SQL 
IF @valor IS NULL
WHERE columna IS NULL
```


## 🔹 4. Validar rangos
```SQL
IF @edad < 0 OR @edad > 100
BEGIN
    PRINT 'Edad inválida';
END
```


## 🔹 5. Validar texto vacío
```SQL
IF LEN(@nombre) = 0
```


## 🔹 6. Validar longitud
```SQL
IF LEN(@id) > 5
```



## 🔹 7. Validar números negativos
```SQL
IF @numero <= 0
```



## 🔹 8. Validar existencia de stock 
```SQL
IF @existencia < @cantidad
BEGIN
    PRINT 'No hay suficiente stock';
    RETURN;
END
```



## 🔹 9. Validar con THROW 
```SQL

IF @edad < 0
BEGIN
    THROW 50001, 'Edad inválida', 1;
END
🔹 10. Validar después de UPDATE
IF @@ROWCOUNT = 0
BEGIN
    PRINT 'No se actualizó nada';
END
```

#💡 RESUMEN FÁCIL

👉 En SP puedes validar:

existencia (EXISTS)
valores inválidos (negativos, vacíos)
rangos
NULL
stock
errores (TRY-CATCH)
resultados (ROWCOUNT)

## 🚀 TIP 

UN  SP casi siempre lleva:

✅ parámetros
✅ validaciones
✅ insert/update
✅ try-catch
✅ transaction