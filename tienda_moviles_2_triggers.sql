-- TRIGGERS

/* ----------- TRIGGER PARA ACTUALIZAR LISTA DE HISTORICO (TRIGGER DESPUES DEL INSERT)*/

DELIMITER $$
CREATE TRIGGER tr_after_insert_producto
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
	INSERT INTO historico_productos (id_producto, nombre_producto, id_familia_producto, precio_producto, iva_producto, id_proveedor) values (NEW.id_producto, NEW.nombre_producto, NEW.id_familia_producto, NEW.precio_producto, NEW.iva_producto, NEW.id_proveedor);
END $$
DELIMITER ;

DROP TRIGGER tr_after_insert_producto;

INSERT INTO productos (nombre_producto, id_familia_producto, precio_producto, iva_producto, id_proveedor, stock) values
('Samsung X', 2, 500, 0.21, 11, 5);


/* ----------- TRIGGER PARA ACTUALIZAR NOMBRE DEL PRODUCTO */

DELIMITER $$
CREATE TRIGGER tr_after_update_nombre_producto
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
IF OLD.nombre_producto != NEW.nombre_producto THEN
UPDATE historico_productos SET nombre_producto = NEW.nombre_producto WHERE id_producto = NEW.id_producto;
END IF;
IF OLD.familia_producto != NEW.familia_producto THEN
UPDATE historico_productos SET familia_producto = NEW.familia_producto WHERE id_producto = NEW.id_producto;
END IF;
END $$

DELIMITER ;

DROP TRIGGER tr_after_insert_producto;

UPDATE productos SET nombre_producto =  "Samsung X", id_familia_producto
WHERE nombre_producto = "Iphone XI";

/* ----------- TRIGGER PARA ACTUALIZAR ELIMICACION DEL PRODUCTO */

DELIMITER $$
CREATE TRIGGER tr_after_eliminacion_producto
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
	UPDATE historico_productos set fecha_baja = NOW()
    WHERE id_producto = OLD.id_producto;
END $$
DELIMITER ;

DELETE FROM productos WHERE nombre_producto = 'Iphone X';

/* ----------- TRIGGER PARA ACTUALIZAR UNIDADES VENDIDAS */

DELIMITER $$
CREATE TRIGGER tr_after_actualizar_unidades_vendidas
AFTER INSERT ON facturas
FOR EACH ROW
BEGIN
    UPDATE historico_productos
    SET unidades_vendidas = unidades_vendidas + NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END $$

DELIMITER ;

DROP TRIGGER tr_after_actualizar_unidades_vendidas;
CALL compra_mejorada('8', 'Apple Watch', 5);
