-- D1
SELECT 
r.Num_Empl,
r.Nombre,
re.Jefe,
r.Fecha_Contrato,
r.Fecha_Contrato
FROM Representantes AS r
JOIN Representantes AS re 
    ON r.Num_Empl = re.Jefe
ORDER BY r.Num_Empl DESC;

-- D2

SELECT 
r.Nombre,
r.Puesto,
o.Ciudad,
o.Region,
r.Cuota,
r.Ventas
FROM Representantes AS r
JOIN Oficinas AS o 
    ON r.Oficina_Rep = O.Oficina
Where 
ORDER BY Region DESC;

--D3 

SELECT 
c.Num_Cli
FROM Clientes AS c
JOIN Productos as p
ON c.Num_Cli = p.Id_fab
and c.Rep_Cli = p.Id_producto;

--D4
SELECT 
Id_fab,
Id_producto,
Descripcion,
Precio,
Stock
FROM Productos
WHERE Descripcion like '%brazo%' 
ORDER BY Precio DESC;

--D5

SELECT 
Count (Num_Pedido),
sum (Importe) as [TOTAL IMPORTE]
FROM Pedidos AS p
JOIN Representantes as r
ON p.Rep = r.Num_Empl;

-- D6

--D7 
create OR alter view vw_CumplimientoRep_D 
as 
SELECT 
r.Num_empl,
r.Nombre,
r.Cuota,
r.Ventas
from Representantes AS r
INNER JOIN Representantes AS re
ON r.Num_Empl = re.Jefe
group by pr.Descripcion;