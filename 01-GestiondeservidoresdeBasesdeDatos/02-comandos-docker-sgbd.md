# Documentación de comandos de contenedores Docker para SGBD
## Comando para contenedor de SQL server sin volumen

```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
   -p 1435:1433 --name servidorsqlserver \
   -d \
   mcr.microsoft.com/mssql/server:2019-latest
   
```
## Comando para contenedor de sql server con volumen

```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
   -p 1435:1433 --name servidorsqlserver \
   -v volume-mssqlevnd:/var/opt/mssql \
-d \
   mcr.microsoft.com/mssql/server:2019-latest  
```

/var/opt/mssql/data

CREATE DATABASE bdevnd;
GO

USE bdevnd;
GO

CREATE TABLE tbl1(
id INT not null IDENTITY (1,1),
nombre NVARCHAR(20) not null,
CONSTRAINT pk_tbl1
PRIMARY KEY (id)
);
GO

INSERT INTO tbl1
VALUES ('Docker'),
       ('Git'),
	   ('Github'),
	   ('Postgres');
GO

SELECT *
FROM tbl1;

SELECT nombre
FROM tbl1;