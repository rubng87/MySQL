-- STORE PROCEDURES
-- no devuelven un valor
-- se utilizanpara tareas repetitivas
USE tienda_moviles_2;

-- borrado
drop procedure st_ejemplo;

-- creación
DELIMITER $$
CREATE PROCEDURE st_ejemplo(IN id INT)
-- obtener datos de un cliente por su id
BEGIN
	SELECT * FROM clientes WHERE id_cliente = id;
END $$
DELIMITER ;

-- ejecución
CALL st_ejemplo(200);

drop procedure if exists st_ejemplo_mejorado;

-- creación
DELIMITER $$
CREATE PROCEDURE st_ejemplo_mejorado(IN id INT)
-- obtener datos de un cliente por su id
BEGIN
	set @respuesta = (SELECT id_cliente FROM clientes WHERE id_cliente = id);
	if @respuesta is not null then
		SELECT * FROM clientes WHERE id_cliente = id;
	else
		select ("Este id de cliente no existe") as mensaje;
    end if;
END $$
DELIMITER ;
call st_ejemplo_mejorado(1);

/*========================================================================================*/
-- Procedimiento #2

DELIMITER $$
CREATE PROCEDURE compra(id_cliente INT, id_producto INT, cantidad INT, fecha DATE)
-- Realizar el proceso de compra
BEGIN
	insert into facturas (facturas.id_cliente, facturas.id_producto, facturas.cantidad, facturas.fecha) values
    (id_cliente, id_producto, cantidad, fecha);
END $$
DELIMITER ;

CALL compra(3, 8, 6, DATE(NOW()));

/*========================================================================================*/
-- Procedimiento #3

DELIMITER $$
CREATE PROCEDURE compra_mejorada(id INT, nombre VARCHAR(30), cantidad_compra INT)
BEGIN 
set @id_producto = (select id_producto from productos where nombre_producto = nombre);
set @stock = (select stock from productos where id_producto = @id_producto);
IF @id_producto is not null and @stock >= cantidad_compra THEN
insert into facturas (id_cliente, id_producto, cantidad, fecha) values
(id, @id_producto, cantidad_compra, DATE(NOW()));
update productos set stock = stock - cantidad_compra where id_producto = @id_producto;
select concat_ws(" ", 'Quedan', @stock - cantidad_compra, 'unidades del prodcuto', nombre) as stock;
ELSE
select ("Producto y/o cantidad incorrectos");

END IF;
END $$
DELIMITER ;
drop procedure compra_mejorada;

call compra_mejorada(1, 'Iphone 14' , 2);
select @stock;