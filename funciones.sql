-- FUNCIONES

DELIMITER $$
CREATE FUNCTION fu_ventas_totales()
RETURNS DECIMAL (10, 2) DETERMINISTIC -- SINO CAMBIA NADA SIEMPRE ME VA A DEVOLVER LO MISMO AL PONER EL DETERMINISTIC
BEGIN
set @ventas_totales = (select sum(fa.cantidad * pd.precio_producto) 
as total
from facturas fa
inner join productos pd
on fa.id_producto = pd.id_producto); 
return @ventas_totales;
END $$
DELIMITER ;

select sum(fa.cantidad * pd.precio_producto) as total
from facturas fa
inner join productos pd
on fa.id_producto = pd.id_producto;

select fu_ventas_totales();

select cl.id_cliente, sum(fa.cantidad * pd.precio_producto) as ventas_cliente,
format((100*(sum(fa.cantidad * pd.precio_producto)/fu_ventas_totales())),2) as procentaje
from clientes cl
inner join facturas fa
on cl.id_cliente = fa.id_cliente
inner join productos pd
on fa.id_producto = pd.id_producto
group by id_cliente
order by ventas_cliente desc
;