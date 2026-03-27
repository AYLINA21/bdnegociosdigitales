# Práctica: Stored Procedures y Gestión de Ventas en SQL Server

## Descripción: 
Se desarrolló un sistema de ventas utilizando SQL Server, en el cual se implementaron tablas relacionadas y stored procedures para gestionar clientes, productos y ventas, aplicando validaciones y control de errores.

## Estructura de la Base de Datos

Se crearon las siguientes tablas:

- CatProducto: almacena productos, precios y existencia.
- CatCliente: almacena información de clientes.
- TblVenta: registra las ventas realizadas.
- TblDetalleVenta: guarda el detalle de cada venta.

Se utilizaron llaves primarias y foráneas para mantener la integridad referencial.

## Stored Procedures Implementados

Se desarrollaron procedimientos almacenados para validar:

- Existencia de clientes
- Existencia de productos
- Disponibilidad de inventario

### Finalmente, se creó el procedimiento principal:

#### usp_agregar_venta

Este procedimiento:

- Valida que el cliente exista
- Valida que el producto exista
- Verifica que haya suficiente existencia
- Inserta la venta
- Inserta el detalle de la venta
- Actualiza el inventario
---

# Pasos

## 💕 1. Creación de la Base de Datos

Se creó la base de datos donde se almacenará toda la información del sistema de ventas.
```sql
CREATE DATABASE bdpracticas;
GO
USE bdpracticas;
```
![Conexión con la base](imagenes/Creacion%20de%20la%20base%20.png)


## 📌 2. Creación de la Tabla CatProducto

Esta tabla almacena la información de los productos disponibles.

```sql
CREATE TABLE CatProducto (
    id_producto INT PRIMARY KEY,
    nombre_producto NVARCHAR(40),
    existencia INT,
    precio MONEY
);
```
![CatProducto](imagenes/Captura%20de%20pantalla%202026-03-26%20142723.png)

### 🔹 Inserción de datos desde Northwind

```sql
INSERT INTO CatProducto (id_producto, nombre_producto, existencia, precio)
SELECT ProductID, ProductName, UnitsInStock, UnitPrice
FROM Northwnd.dbo.Products;
```

### 🔹 Verificación

```sql
SELECT * FROM CatProducto;
```

---

## 📌 3. Creación de la Tabla CatCliente

Esta tabla almacena la información de los clientes.

```sql
CREATE TABLE CatCliente (
    id_cliente NCHAR(5) PRIMARY KEY,
    nombre_cliente NVARCHAR(40),
    pais NVARCHAR(15),
    ciudad NVARCHAR(15)
);
```
![CatCliente](imagenes/Captura%20de%20pantalla%202026-03-26%20143635.png)

### 🔹 Inserción de datos

```sql
INSERT INTO CatCliente (id_cliente, nombre_cliente, pais, ciudad)
SELECT CustomerID, CompanyName, Country, City
FROM Northwnd.dbo.Customers;
```

### 🔹 Verificación

```sql
SELECT * FROM CatCliente;
```

---

## 🧩 4. Creación de la Tabla TblVenta

Esta tabla registra las ventas realizadas.

```sql
CREATE TABLE TblVenta (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    id_cliente NCHAR(5),
    FOREIGN KEY (id_cliente) REFERENCES CatCliente(id_cliente)
);
```

### 🔹 Verificación
```sql
SELECT * FROM TblVenta;
```
---

## 📌 5. Creación de la Tabla TblDetalleVenta

Esta tabla almacena el detalle de cada venta.

```sql
CREATE TABLE TblDetalleVenta (
    id_venta INT,
    id_producto INT,
    precio_venta MONEY,
    cantidad_vendida INT,
    FOREIGN KEY (id_venta) REFERENCES TblVenta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES CatProducto(id_producto)
);
```

### 🔹 Verificación
```sql
SELECT * FROM TblDetalleVenta;
```

---

## Diagrama

![Diagrama](imagenes/Captura%20de%20pantalla%202026-03-26%20221736.png)

## 📌 6. Stored Procedures

### 🔹 6.1 Validar Cliente

Este procedimiento verifica si un cliente existe en la base de datos.

```sql
CREATE OR ALTER PROCEDURE spu_Cliente_Exists
    @id_cliente NCHAR(5)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM CatCliente WHERE id_cliente = @id_cliente)
    BEGIN
        PRINT 'El cliente no existe';
        RETURN;
    END

    PRINT 'Cliente válido';
END;
```

### 🔹 Prueba

```sql
EXEC spu_Cliente_Exists 'ANTON';
EXEC spu_Cliente_Exists 'BONAP';
```

---

### 🔹 6.2 Validar Producto

Este procedimiento valida si un producto existe.

```sql
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
```

### 🔹 Prueba

```sql
EXEC spu_Producto_Exists 4;
```

---

### 🔹 6.3 Validar Existencia

Este procedimiento verifica si hay suficiente stock disponible.

```sql
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

    PRINT 'Existencia suficiente';
END;
```

### 🔹 Prueba

```sql
EXEC spu_Producto_Existencia 1, 2;
EXEC spu_Producto_Existencia 2, 17;
```

---
## 7 📌 usp_agregar_venta

Una vez comprovado el funcionamiento de los spu de integraron en uno solo llamado usp_agregar_venta, donde se agregaron comentarios para diferenciar cada paso

```sql
CREATE OR ALTER PROC usp_agregar_venta  
--*Declarar variables---
   --- @id_venta INT, --- esta ya no se uso 
    @id_cliente NCHAR (5),
    @id_producto INT,
    @cantidad INT
    ---@precio_venta MONEY -- esta ya no se uso 
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;---- inicia transaccion 

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

--- Una vez integrados los usp se continuo con la indicacion de actualizar la existencia 

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
```

## 📌 8 Se uso THROW 

Sugerencia del maestro para el manejo de errores, implementandose en el usp
```sql
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
```
## 📌 9. Revision de tablas
Se revisaron los datos de las tablas para poder hacer pruebas y comporbar s el usp es funcional
```sql
SELECT *
FROM CatProducto;
SELECT *
FROM CatCliente;
```
## 📌 10. Pruebas 
Se usaron distintos datos para comprobar un correcto funcionamiento 
```sql
EXEC usp_agregar_venta  'ANTON', 1 , 3 ; -- deberia salir bien
EXEC usp_agregar_venta 'XXXXX', 1, 2; -- deberia salir cliente no existe
EXEC usp_agregar_venta 'ANTON', 999, 2; -- deberia salir producto no existe
EXEC usp_agregar_venta 'ANTON', 1, 999; -- deberia salir sin stock
```
## Problemas Encontrados

Durante el desarrollo se presentaron varios errores:

* Incompatibilidad de tipos de datos entre tablas y procedimientos

* Error al insertar valores NULL en la clave primaria

* Problemas al eliminar tablas debido a restricciones de llaves foráneas

* Validaciones que inicialmente no detenían la ejecución correctamente

## Soluciones 

* Se corrigieron los tipos de datos para que coincidieran entre tablas y parámetros

* Se implementó IDENTITY en la tabla de ventas para generar IDs automáticamente

* Se eliminó primero la tabla dependiente antes de modificar la tabla principal

* Se reemplazó PRINT por THROW para un manejo de errores más profesional

## 🧩 7. Conclusión

En esta práctica se implementaron tablas y stored procedures para gestionar un sistema básico de ventas. Se aplicaron validaciones para asegurar la integridad de los datos, como la verificación de existencia de clientes, productos y stock disponible. Además, se utilizaron datos de la base Northwind para simular un entorno real, permitiendo comprender mejor el uso de procedimientos almacenados en SQL Server.

Esta práctica permitió comprender el uso de stored procedures en SQL Server, así como la importancia de validar datos, manejar errores y mantener la integridad de la información. Además, se reforzó el uso de transacciones y buenas prácticas en el desarrollo de bases de datos.

---
