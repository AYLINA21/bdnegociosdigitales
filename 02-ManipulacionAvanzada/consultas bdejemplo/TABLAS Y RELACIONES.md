# TABLAS
## 1. Clientes

Campos:
```shell
Num_Cli (PK)

Empresa

Rep_Cli (FK → Representantes.Num_Empl)

Limite_Credito
```
## 2. Oficinas

Campos:
```shell
Oficina (PK)

Ciudad

Region

Jef (FK → Representantes.Num_Empl)

Objetivo

Ventas
```
## 3. Pedidos

Campos:
```shell
Num_Pedido (PK)

Fecha_Pedido

Cliente (FK → Clientes.Num_Cli)

Rep (FK → Representantes.Num_Empl)

Fab (FK compuesta → Productos.Id_fab)

Producto (FK compuesta → Productos.Id_producto)

Cantidad

Importe
```
## 4. Productos

Campos:
```shell
Id_fab (PK compuesta)

Id_producto (PK compuesta)

Descripcion

Precio

Stock
```
## 5. Representantes

Campos:
```shell
Num_Empl (PK)

Nombre

Edad

Oficina_Rep (FK → Oficinas.Oficina)

Puesto

Fecha_Contrato

Jefe (FK → Representantes.Num_Empl)

Cuota

Ventas
```
# RELACIONES ENTRE TABLAS


### Representantes — Clientes
Un representante puede tener muchos clientes.
(1 a muchos)

## Representantes — Oficinas
Un representante puede ser jefe de una oficina.
(1 a muchos)

## Oficinas — Representantes
Una oficina puede tener muchos representantes.
(1 a muchos)

## Clientes — Pedidos
Un cliente puede hacer muchos pedidos.
(1 a muchos)

## Representantes — Pedidos
Un representante puede registrar muchos pedidos.
(1 a muchos)

## Productos — Pedidos
Un producto puede aparecer en muchos pedidos.
(1 a muchos, mediante clave compuesta)

## Representantes — Representantes
Un representante puede ser jefe de otros representantes.
(relación recursiva 1 a muchos)

# PASOS 

## EJEMPLO: 
### Ejercicio 1

Muestra:

Número de pedido

Fecha del pedido

Nombre del cliente

Nombre del representante

Solo de los pedidos que existan.
## Paso 1: ¿Cuál es la tabla principal?

Pedidos
Porque estamos mostrando información de pedidos.

### Paso 2: ¿Qué tablas necesito unir?

Clientes (para el nombre del cliente)

Representantes (para el nombre del representante)

### Paso 3: ¿Cómo se conectan?

Pedidos.Cliente = Clientes.Num_Cli

Pedidos.Rep = Representantes.Num_Empl

### Solución
```shell
SELECT 
    P.Num_Pedido,
    P.Fecha_Pedido,
    C.Empresa,
    R.Nombre
FROM Pedidos P
JOIN Clientes C 
    ON P.Cliente = C.Num_Cli
JOIN Representantes R 
    ON P.Rep = R.Num_Empl;
```

### Ejercicio 2

Muestra:

Número de pedido

Descripción del producto

Cantidad

Precio

#### SOLUCION 
```shell
SELECT 
    P.Num_Pedido,
    PR.Descripcion,
    P.Cantidad,
    PR.Precio
FROM Pedidos P
JOIN Productos PR
    ON P.Fab = PR.Id_fab
   AND P.Producto = PR.Id_producto;
```

## EJERCICIO 3

 Muestra:

Número de pedido

Fecha del pedido

Nombre del cliente

Importe

Pero solo:

Pedidos entre '1990-01-01' y '1990-02-15'

Que el importe sea mayor a 5000

Ordenados por importe de mayor a menor

```shell

SELECT 
    P.Num_Pedido,
    P.Fecha_Pedido,
    C.Empresa,
    P.Importe
FROM Pedidos P
JOIN Clientes C 
    ON P.Cliente = C.Num_Cli
WHERE P.Fecha_Pedido BETWEEN '1990-01-01' AND '1990-02-15'
AND P.Importe > 5000
ORDER BY P.Importe DESC;
```
## NOTAS
Si el profe dice:

"Que sea igual a" → usa =

"Que contenga" → usa LIKE

"Entre fechas" → usa BETWEEN

"Mayor que" → usa >

"Distinto de" → usa <>

```shell
SELECT 
    C.Empresa,
    R.Nombre,
    P.Importe
FROM Pedidos P
JOIN Clientes C 
    ON P.Cliente = C.Num_Cli
JOIN Representantes R 
    ON P.Rep = R.Num_Empl
WHERE C.Empresa LIKE '%S.A%'
AND P.Importe < 10000;
```
```shell
SELECT 
    R.Nombre,
    SUM(P.Importe) AS Total_Vendido
FROM Pedidos P
JOIN Representantes R
    ON P.Rep = R.Num_Empl
GROUP BY R.Nombre
HAVING SUM(P.Importe) > 20000;
```
```SHELL
SELECT 
    PR.Descripcion,
    SUM(P.Importe) AS Total_Vendido
FROM Pedidos P
INNER JOIN Productos PR
    ON P.Fab = PR.Id_fab
   AND P.Producto = PR.Id_producto
GROUP BY PR.Descripcion
HAVING SUM(P.Importe) > 30000;
``` 