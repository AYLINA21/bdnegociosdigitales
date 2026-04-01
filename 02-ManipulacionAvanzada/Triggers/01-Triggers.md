# Triggers en sql server

## 1.¿ que es un trigger?

Un trigger (disparador) es un bloque de codigo SQL que se 
ejecuta automaticamente cuando ocurre un evento en una tabla 

🍭🍭Eventos principales:
- insert
- delete
- update 

NOTA: No se ejecutan manualmente, se activan solos 

## 2.¿para que sirven ?

- validaciones 
- auditoria(guardar historial)
- Reglas de negocio
- Automatización

## 3.Tipos de triggers en sql server

- After trigger

Se ejecuta despues del evento

- Instead of trigger

reemplaza la operacion original

## 4.Sintaxis basica

```sql
CREATE OR ALTER TRIGGER nombre_trigger
ON nombre_tabla
AFTER INSERT
AS
BEGIN
END;
```

## 5.TABLAS ESPECIALES 

| TABLA | CONTENIDO |
| :--- | :--- |
| INSERTED | NUEVOS DATOS |
| Deleted | Datos anteriores |