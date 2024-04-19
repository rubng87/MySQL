-- Utiliza la base de datos sakila, disponible en MySQL Workbench,
-- para resolver estos ejercicios 
use sakila_es;

-- 1) Actores que tienen el primer nombre "Gary"

SELECT nombre, apellidos
FROM actor 
WHERE nombre LIKE 'Gary';

-- 2) Actores que tiene de primer apellido "Streep"

SELECT apellidos, nombre
FROM actor 
WHERE apellidos LIKE 'Streep';

-- 3) Actores que contengan una "o" en su nombre

SELECT nombre 
FROM actor 
WHERE nombre LIKE '%o%';

-- 4) Actores que contengan una "a" en su nombre y una "e" en su apellido

SELECT nombre, apellidos
FROM Actor
WHERE nombre LIKE '%a%' 
AND apellidos LIKE '%e%';

-- 5) Actores que contengan dos "o" en su nombre (en cualquier posicion) y una "a" en su apellido

SELECT nombre, apellidos
FROM actor
WHERE nombre LIKE '%o%o%' 
AND apellidos LIKE '%a%';

-- 6) Actores cuya tercera letra del nombre sea "b"

SELECT nombre
FROM Actor
WHERE LENGTH(Nombre) >= 3 AND SUBSTRING(Nombre, 3, 1) = 'b';

-- 7) Ciudades que empiezan por "a"

SELECT nombre 
FROM ciudad
WHERE nombre LIKE 'a%';

-- 8) Ciudades que acaban por "s"

SELECT nombre 
FROM ciudad
WHERE nombre LIKE '%s';

-- 9) Ciudades del country "France"

SELECT ciudad.nombre, pais.nombre
FROM ciudad
INNER JOIN pais
ON ciudad.id_pais = pais.id_pais
WHERE pais.nombre = 'France';

-- 10) Ciudades con nombres compuestos (como New York)

SELECT nombre
FROM ciudad
WHERE nombre LIKE "% %";

-- 11) películas con una duración entre 80 y 100 m.

SELECT titulo
FROM pelicula
WHERE duracion between 80 and 100;

-- 12) películas con un rental_rate entre 1 y 3

SELECT titulo
FROM pelicula
WHERE rental_rate between 1 and 3;

-- 13) películas con un título de más de 11 letras.

SELECT titulo
FROM pelicula
WHERE length(titulo>11);

-- 14) películas con un rating de PG o G.

SELECT titulo
FROM pelicula
WHERE clasificacion like 'PG' or clasificacion like 'G' ;

-- 15) ¿Cuantas ciudades tiene el country ‘France’? 

SELECT count(ciudad.nombre), pais.nombre
FROM ciudad
INNER JOIN pais
ON ciudad.id_pais = pais.id_pais
WHERE pais.nombre = 'France';

-- 16) Películas que no tengan un rating de NC-17

SELECT titulo
FROM pelicula
WHERE clasificacion != 'NC-17';

-- 17) Películas con un rating PG y duración de más de 120.

SELECT titulo
FROM pelicula
WHERE clasificacion like 'PG' AND duracion > 120;

-- 18) ¿Cuantos actores hay?

SELECT count(nombre) as cantidad_actores
FROM actor;

-- 19) Película con mayor duración.

SELECT titulo as peliculas_con_maxima_duracion
FROM pelicula
WHERE duracion = (select max(duracion) from pelicula);

-- 20) ¿Cuantos clientes viven en Indonesia?

SELECT COUNT(*)
FROM cliente AS c
INNER JOIN direccion as di
ON c.id_direccion = di.id_direccion
INNER JOIN ciudad AS ciu 
ON di.id_ciudad = ciu.id_ciudad
INNER JOIN pais AS p 
ON ciu.id_pais = p.id_pais
WHERE p.nombre = 'Spain';
