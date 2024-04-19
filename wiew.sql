-- Qué clientes han comprado productos de Apple y cúales

CREATE VIEW clientes_apple_vw as
SELECT cl.nombre_cliente, cl.apellido_cliente, pd.nombre_producto
from clientes cl
inner join facturas fa
on cl.id_cliente = fa.id_cliente
inner join productos pd
on fa.id_producto = pd.id_producto
inner join familia_producto fp
on pd.id_familia_producto = fp.id_familia_producto
where fp.nombre_familia like "%apple%"
order by pd.nombre_producto;

show tables;

select * from clientes_apple_vw;

-- Qué clientes han comprado productos de Apple y cúales
-- Modificar la table

CREATE OR REPLACE VIEW clientes_apple_vw as
SELECT cl.nombre_cliente, cl.apellido_cliente, pd.nombre_producto, fa. fecha
from clientes cl
inner join facturas fa
on cl.id_cliente = fa.id_cliente and fa.fecha > curdate() - interval 10 day
inner join productos pd
on fa.id_producto = pd.id_producto
inner join familia_producto fp
on pd.id_familia_producto = fp.id_familia_producto
where fp.nombre_familia like "%apple%"
order by pd.nombre_producto;

show tables;
drop view clientes_apple_vw;

select * from clientes_apple_vw;