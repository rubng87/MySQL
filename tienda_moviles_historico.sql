use tienda_moviles_2;

CREATE TABLE historico_productos (
  id_producto int,
  nombre_producto varchar(30),
  id_familia_producto int,
  precio_producto decimal(8,2),
  iva_producto decimal(3,2),
  id_proveedor int,
  fecha_alta timestamp default current_timestamp,
  fecha_baja timestamp default current_timestamp,
  unidades_vendidas INT default 0
)ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
  /!40101 SET character_set_client = @saved_cs_client/;
  
  
insert into historico_productos (id_producto, nombre_producto, id_familia_producto, precio_producto, iva_producto, id_proveedor) 
select id_producto, nombre_producto, id_familia_producto, precio_producto, iva_producto, id_proveedor
from productos;

/* Crear una vista con las unidades vendidas hasta ahora 
LAS VISTAS, empiezan por donde se van a crear
luego se crea importante poner el AS
luego se actualiza la tabla hostorico_productos con las unidades vendidas
*/

CREATE VIEW vw_productos_vendidos AS
SELECT id_producto, sum(cantidad) AS cantidad
from facturas 
group by id_producto
order by id_producto;


-- Actualizar historico

UPDATE historico_productos hp
INNER JOIN vw_productos_vendidos vw 
ON hp.id_producto = vw.id_producto
SET hp.unidades_vendidas = vw.cantidad;