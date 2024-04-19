-- ¿ Qué es un CRUD?
-- Create -> insert
-- Read -> select
-- Update -> update
-- Delete -> delete, drop, truncate


-- Ver todas las bases de datos
show databases;

-- Para usar la bse de datos
use tienda_moviles;

-- Mostrar toda la información de la tabla productos
select *
from productos;

-- Muestre sólo los valores de algunos campos (columnas)
select nombre_producto, precio_producto from productos;

-- Cambiar la cabecera de la salida por pantalla
select nombre_producto as nombre, precio_producto as precio from productos;

-- Funciones de agregación:
-- promedio
select avg(precio_producto) from productos;

-- max - min
select max(precio_producto) from productos;
-- esta consulta de abajo devuelve mal la información
select nombre_producto, max(precio_producto) from productos;

-- contar la cantidad de items
select count(*) from productos;

-- insertar un elemento nuevo
insert into productos (nombre_producto, id_familia_producto, precio_producto, id_proveedor) value
('Oppo A52', 2, 500, 11);

-- ver los productos diferentes
select distinct nombre_producto from productos;

-- comtar los productos con nombre diferente
select count(distinct nombre_producto) from productos;

-- sumar los precios
select sum(precio_producto) from productos;

select * from clientes;
-- ordenar la lista por algun criterio
select apellido_cliente, nombre_cliente 
from clientes
order by apellido_cliente asc, nombre_cliente asc;

-- limitar las filas de la lista de datos
select apellido_cliente, nombre_cliente 
from clientes
order by apellido_cliente asc, nombre_cliente asc
limit 3;

-- esta query no funciona con MySQL:
select top 3 * from clientes;

-- salida por pantalla con condiciones
select nombre_cliente
from clientes
where nombre_cliente like "a%";

select nombre_cliente
from clientes
where nombre_cliente like "__an%";

select nombre_cliente
from clientes
where nombre_cliente like "[a-j]%";

select *
from productos
where id_familia_producto IN (1, 3, 5); -- IN muestra los valores que se asignan

select *
from productos
where id_familia_producto NOT IN (1, 3, 5); -- NOT IN no muestra los valores de id que se asigna

-- selección por rango de precio
select nombre_producto, precio_producto
from productos
where precio_producto between 800 and 1500;

select nombre_producto, precio_producto
from productos
where precio_producto > 1200;

-- Top 5 de precios
select nombre_producto, precio_producto
from productos
order by precio_producto desc 
limit 5;

-- Utilización de group para agrupar los precios
select nombre_producto, precio_producto
from productos
group by precio_producto -- Agrupar los repetidos para que sea el top 5 real
order by precio_producto desc 
limit 5;

-- Lista de productos por categorias
select id_familia_producto, count(id_familia_producto)
from productos
group by id_familia_producto
order by id_familia_producto asc;

-- De cada famila_producto cual es el mas alto de precio
select id_familia_producto, max(precio_producto)
from productos
group by id_familia_producto
order by id_familia_producto asc;

select nombre_producto, precio_producto
from productos
group by precio_producto
having precio_producto > (select avg(precio_producto) from productos);

-- No funciona
select nombre_producto, precio_producto
from productos
group by precio_producto
having precio_producto > promedio;

-- Inner join
select fa.nombre_familia, pr.nombre_producto
from productos pr
inner join familia_producto fa
on pr.id_familia_producto = fa.id_familia_producto
order by fa.nombre_familia, nombre_producto;

-- Obtener por cada factura el precio del producto, la cantidad y el nombre
select cl.apellido_cliente, fa.id_factura, pr.nombre_producto, pr.precio_producto, fa.cantidad,
(pr.precio_producto * fa.cantidad * (1 + pr.iva_producto)) as total
from clientes cl
inner join facturas fa
on cl.id_cliente = fa.id_cliente
inner join productos pr
on fa.id_producto = pr.id_producto;

-- compras totales de cada cliente
select concat(cl.apellido_cliente, ", ", cl.nombre_cliente) as nombre,
sum((pr.precio_producto * fa.cantidad * (1 + pr.iva_producto))) as total
from clientes cl
inner join facturas fa
on cl.id_cliente = fa.id_cliente
inner join productos pr
on fa.id_producto = pr.id_producto
group by cl.id_cliente;

-- clientes que no han comprado nada
select concat(cl.apellido_cliente, ", ", cl.nombre_cliente) as nombre,
cl.id_cliente
from clientes cl
left join facturas fa
on cl.id_cliente = fa.id_cliente
where fa.id_cliente is null;

select * from  facturas;

-- cuanto vende cada proveedor =
-- ventas totales de cada proveedor

select pr.nombre_proveedor,
sum(pd.precio_producto * fa. cantidad) as venta_total
from proveedores pr
inner join productos pd
on pr.id_proveedor = pd.id_proveedor
inner join facturas fa
on fa.id_producto = pd.id_producto
group by pr.id_proveedor
order by venta_total desc;

-- las poblaciones que más venden
select po.nombre_poblacion,
sum(pd.precio_producto * fa. cantidad) as venta_total
from poblaciones po
inner join proveedores pr
on pr.id_poblaciones = po.id_poblaciones
inner join productos pd
on pd.id_proveedor = pr.id_proveedor
inner join facturas fa
on fa.id_producto = pd.id_producto;

-- información de la fidelidad de los clientes
select cl.nombre_cliente, sum(fa.id_cliente) as compras,
case 
    when compras > 10 THEN "Compra mucho"
    when compras < 5 THEN "Compra a veces"
    else "Compra muy poco"
END as resultados
from clientes cl
left join facturas fa
on fa.id_cliente = cl.id_cliente
group by fa.id_cliente
order by cl.nombre_cliente desc;



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
use tienda_moviles;

-- Que dia se vende mas de la semana

select dayname(fecha), count(id_factura)
from facturas
group by dayname(fecha)
order by count(id_factura) desc;


