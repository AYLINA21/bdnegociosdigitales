/* ================Variables en Transact-SQL =============*/

--delcarar variable, SIEMPRE PONER UN ARROBA PRIMERO

DECLARE @edad INT;
SET @edad = 21;

PRINT @edad
SELECT  @edad AS [EDAD];

DECLARE @NOMBRE AS VARCHAR (30) = 'San Gallardo';
SELECT  @NOMBRE AS [Nombre];
SET @NOMBRE = 'San Adonai';
SELECT @NOMBRE AS [Nombre];

/* ================Ejercicios=============*/

/* 
EJERCICIO 1.
-DECLRARAR UN AVARIABLE @PRECIO
-ASIGNAR EL VALOR 150
-CALCULAR EL IVA (16) *1.16
-MOSTRAR EL TOTAL
*/

--iNVESTIGAR TIPOS DE DATOS EN SQL

DECLARE @Precio MONEY;
SET @Precio = 150;
DECLARE @Iva DECIMAL (10,2);
DECLARE @Total MONEY;

SET @Iva = @Precio * 0.16;
SET @Total = @Precio + @Iva ;

SELECT  
@Precio AS [PRECIO], 
CONCAT ('$' , @Iva) AS [IVA (16%)],
@Total AS [TOTAL] AS [TOTAL]

/*======================================== IF/ELSE ============================*/
DECLARE @edad INT ;
SET @edad = 18;

IF @edad >= 18
    PRINT 'Eres mayor de edad';
ELSE
    PRINT 'Eres menaor de edad';

--- Se de una calificacion mayor a 7 entonces imprimir aprovado  de lo contrario reprobado---
DECLARE @calificacion INT ;
SET @calificacion = 5;

IF @calificacion >=0 AND @calificacion <=10 --and se usa para rangos 
    PRINT 'Aprovado';
ELSE
    PRINT 'Reprobado';

GO
---- la calificacion no puede ser negativa ni mayor a 10
--- MULTI CURSOR ALT Y SELECCIONAR RENGLON EN VISUAL
---COMENTAR TODO CNTL K 
DECLARE @calif DECIMAL (10,2) ;
SET @calif = 9.5;

IF @calif >=0 AND @calif <=10 --and se usa para rangos 
BEGIN 
    IF @calif >= 7.0
    BEGIN
        PRINT ('Aprovado')
    END
    ELSE
    BEGIN
        PRINT ('Reprobado')
    END
END
ELSE
BEGIN 
 SELECT CONCAT (@calif, 'ESTA FUERA DE RANGO') AS [RESPUESTA]
GO

/*======================================== WHILE ============================*/

DECLARE @Limite int = 5;
DECLARE @i int = 1;

WHILE(@i<=@Limite)
    BEGIN
        PRINT CONCAT ('NUMERO: ', @i)
        SET @i = @i +1
END 

