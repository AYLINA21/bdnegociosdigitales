
-- CREA UNA BASE DE DATOS
CREATE DATABASE tienda;
GO

use tienda;

-- CREAR TABLA CLIENTE
 CReATE TABLE cliente (
 id int not null,
 nombre nvarchar(30) not null,
 apaterno nvarchar(10) not null,
 amaterno nvarchar(10) null,
 sexo nchar (1)not null,
 edad int not null,
 direccion nvarchar(80) not null,
 rfc nvarchar(20) not null,
 limitecredito money not null DEFAULT 500.0
 );
 GO

 --Restriciones
 CREATE TABLE clientes (
 cliente_id INT not null PRIMARY KEY,
 nombre NVARCHAR(30) NOT NULL,
 apellido_paterno NVARCHAR(20) NOT NULL,
 apellido_materno NVARCHAR (20),
 edad INT NOT NULL,
 fecha_nacimiento DATE NOT NULL,
 limite_credito MONEY NOT NULL
 );
 GO

 INSERT INTO clientes
 VALUES (1, 'Goku', 'linterna', 'superman', 450, '1578-01-17', 100)

 INSERT INTO clientes
 VALUES (2, 'PANCRACIO', 'RIVERO', 'PATROCLO', 20, '1005-01-17', 100)

 INSERT INTO clientes
 (nombre, cliente_id, limite_credito, fecha_nacimiento, apellido_paterno, edad)
 VALUES ('Arcadia',3,45800, '2000-01-22', 'Ramirez', 26)

 INSERT INTO clientes
 VALUES (4, 'Vanesa', 'Buena Vista', NULL, 26, '2000-04-25', 3000)

 INSERT INTO clientes
 VALUES 
 (5, 'Soyla', 'Vaca', 'Del corral', 42, '1983-04-06', 78955),
 (6, 'Bad Bunny', 'Perez', 'Sinsentido', 22, '1999-05-06', 85858),
 (7, 'Jose Luis', 'Herrera', 'Gallardo', 42, '1983-04-06', 14000);

 SELECT GETDATE (); --obtiene la fecha del sistema
 
 CREATE TABLE Clientes_2(
 cliente_id INT NOT NULL identity(1,1),
 nombre NVARCHAR (50) NOT NULL,
 edad INT NOT NULL,
 fecha_registro DATE DEFAULT GETDATE(),
 limite_credito MONEY NOT NULL
 CONSTRAINT pk_clientes_2
 PRIMARY KEY (cliente_id),
 );

 SELECT *
 FROM clientes;

 SELECT cliente_id, nombre, edad, limite_credito 
 FROM Clientes;

