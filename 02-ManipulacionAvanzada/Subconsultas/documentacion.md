# ¿QUE ES UNA SUBCNSULTA?

Una subconsulta (subquery) es un select dentro de otro SELECT. Puede devolver:
1. Un solo valor (escalar)
2. Una lista de valores ( una columna, varias filas)
3. Una tabla (varias columnas y/o varias filas)
4. Segunlo que devuelva se elige el operador correcto (=, in , exist, etc.).

Una subconsulta es una consulta anidada dentro de otra consulta que permite resolver 
problemas en varios niveles de infomaciòn

```
Dependiendo de donde se coloque y que retorne, cambia su comportamiento 
```

5 grandes formas de usarlas :

1.  Subconsultas escalares.
2.  subconsultas con in, any, all.
3.  subconsultas corelacionadas.
4.  subconsultas  en select.
5.  subconsultas en from (Tablas derivadas).

## 1- ESCALARES:

 Devuelven un unico valor por eso se pueden utilizar con operadores =, >, <.(operadores relacionales)

```
 SELECT * 
FROM pedidos 
WHERE total = (
SELECT MAX (total)
FROM pedidos
);
```

## 2.  subconsultas con in, any, all.

Este devuelve varios valores con una sola columna (IN)

```
-- clientes que han hecho pedidos mayores a 800
--subconsulta que se agregara a la consulta principal
SELECT id_cliente
FROM pedidos
where total > 800 ;

--consulta principal
SELECT *
FROM pedidos
WHERE id_cliente In ( 
	SELECT id_cliente
	FROM pedidos
	where total > 800);

	SELECT *
FROM pedidos
WHERE id_cliente In ( 
	SELECT id_cliente
	FROM pedidos
	where total > 800);

	SELECT *
	FROM pedidos 
	WHERE id_cliente IN (1,3,1) ;

--- SELECCIONAR TODOS LOS CLIENTES DE LA CDMX  QUE HAN HECHO PEDIDOS 

SELECT id_cliente
FROM Pedidos;

---

SELECT *
FROM clientes;
---

SELECT c.id_cliente, c.nombre, c.ciudad
FROM pedidos as p
RIGHT JOIN
clientes as c 
ON p.id_cliente = c.id_cliente
WHERE p.id_cliente IS NULL;

----

SELECT id_cliente
FROM clientes 
WHERE id_cliente NOT IN (
	SELECT id_cliente
	FROM Pedidos);

-- seleccionar los pedidos de clientes de Monterrey
select id_cliente
FROM Clientes 
WHERE ciudad = 'Monterrey'
;

--- Sub consulta
Select  *
from pedidos
where id_cliente IN (
	select id_cliente
	FROM Clientes 
	WHERE ciudad = 'Monterrey');

---  join para ver quien 
SELECT *
FROM clientes as c 
INNER JOIN pedidos as p
ON c.id_cliente = p.id_cliente
WHERE c.ciudad = 'Monterrey';
```

## clausula Any 
- compara un valor contra una lista
- la condicion de cumple si se cumple con al menos uno 

```sql
valor > ANY (SUBCONSULTA)
```
> es como decir: mayor que al menos uno de los valores

-Seleccionar pedidos mayores que algun pedido de luis ( id_cliente = 2)