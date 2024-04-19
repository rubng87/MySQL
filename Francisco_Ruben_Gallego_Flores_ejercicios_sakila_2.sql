use sakila_es;

-- 21) Visualiza los 10 actores que han participado en más películas
-- (de mas a menos participaciones)

SELECT a.nombre, count(pea.id_actor) as veces
FROM actor a
INNER JOIN pelicula_actor pea
ON a.id_actor = pea.id_actor
INNER JOIN pelicula pe
ON pea.id_pelicula = pe.id_pelicula
group by pea.id_actor
order by veces desc limit 10;

-- 22) Visualiza los clientes de países que empiezan por S   

SELECT c.nombre, pa.nombre       
FROM cliente c
INNER JOIN direccion di
ON c.id_direccion = di.id_direccion
INNER JOIN ciudad ci
ON di.id_ciudad = ci.id_ciudad
INNER JOIN pais pa
ON ci.id_pais = pa.id_pais
WHERE pa.nombre LIKE 'S%';

-- 23) Visualiza el top-10 de países con más clientes

SELECT pa.nombre, COUNT(cl.id_cliente) AS cantidad_clientes
FROM pais pa
INNER JOIN ciudad ci 
ON pa.id_pais = ci.id_pais
INNER JOIN direccion di 
ON ci.id_ciudad = di.id_ciudad
INNER JOIN cliente cl 
ON di.id_direccion = cl.id_direccion
GROUP BY pa.nombre
ORDER BY cantidad_clientes DESC
LIMIT 10;

-- 24) Saca las 10 primeras películas alfabéticamente y el número de copias que se disponen de cada una de ellas

SELECT pe.titulo, COUNT(inv.id_inventario) AS numero_copias
FROM pelicula pe
INNER JOIN inventario inv 
ON pe.id_pelicula = inv.id_pelicula
GROUP BY pe.titulo
ORDER BY pe.titulo ASC
LIMIT 10;

-- 25 ¿ Cuántas películas ha alquilado Deborah Walker?

SELECT cl.nombre, cl.apellidos, COUNT(*) as numero_alquileres
FROM cliente cl
INNER JOIN alquiler al
ON cl.id_cliente = al.id_cliente
WHERE cl.nombre = 'Deborah' AND cl.apellidos = 'Walker';

-- 26) Crea un procedimiento almacenado llamado 'rentals_by_client'
-- el cual, a partir del nombre y apellido del cliente,
-- muestre : nombre del cliente, apellido del cliente, título de la película, fecha de alquiler
-- ordenado por fecha de alquiler descendente
-- Pruébalo con el cliente 'Deborah Walker'

DELIMITER //
CREATE PROCEDURE rentals_by_client (cliente_nombre VARCHAR(45), cliente_apellidos VARCHAR(45))
BEGIN
    SELECT cl.nombre, cl.apellidos, pe.titulo, al.fecha_alquiler
    FROM cliente cl
    INNER JOIN alquiler al ON cl.id_cliente = al.id_cliente
    INNER JOIN inventario inv ON al.id_inventario = inv.id_inventario
    INNER JOIN pelicula pe ON inv.id_pelicula = pe.id_pelicula
    WHERE cl.nombre = cliente_nombre AND cl.apellidos = cliente_apellidos
    ORDER BY al.fecha_alquiler DESC;
END //
DELIMITER ;

CALL rentals_by_client('Deborah', 'Walker');

drop procedure rentals_by_client;


-- 27) Crea un procedimiento almacenado llamado 'client_rental' que, realizando el alquiler de
-- una pelicula por parte de un cliente, nos retorne cuantos alquileres ha hecho.
-- la fecha del alquiler es la actual
-- Pruébalo así : call client_rental('Deborah', 'Walker', "ALADDIN CALENDAR" )

DELIMITER //
CREATE PROCEDURE client_rental (cliente_nombre VARCHAR(45), cliente_apellidos VARCHAR(45), pelicula_titulo VARCHAR(255))
BEGIN
    DECLARE cliente_id INT;
    DECLARE pelicula_id INT;

    
    SELECT id_cliente INTO cliente_id
    FROM cliente
    WHERE nombre = cliente_nombre AND apellidos = cliente_apellidos;

  
    SELECT id_pelicula INTO pelicula_id
    FROM pelicula
    WHERE titulo = pelicula_titulo;

   
    INSERT INTO alquiler (id_cliente, id_inventario, fecha_alquiler)
    SELECT cliente_id, inventario.id_inventario, CURDATE()
    FROM inventario
    WHERE inventario.id_pelicula = pelicula_id
    LIMIT 1;

  
    SELECT COUNT(*) AS total_alquileres
    FROM alquiler
    WHERE id_cliente = cliente_id;
END //
DELIMITER ;


call client_rental('Deborah', 'Walker', "ALADDIN CALENDAR" );

drop procedure client_rental;