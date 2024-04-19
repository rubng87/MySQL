-- EVALUACION PRACTICA

-- ALUMNO : (pon aquí tu nombre)
-- FECHA : 15-04-2024

/*
Los ejercicios se organizan en tres bloques, segun su dificultad.
Hay por tanto tres niveles de puntuacion: 0.50, 1.00 y 1.50 puntos.
La resolucion de cada ejercicio se valora siguiendo este criterio:

* Ejercicio perfectamente resuelto o con algun error no relevante: 100%.
* Ejercicio bien planteado pero no resuelto, con algun error importante 
o varios errores leves, pero que no afecten a la comprension global del tema: 50%.
* Ejercicio no resuelto o con errores graves, que muestren falta de comprension
del tema : 0%.

Por tanto:

* un ejercicio bien resuelto del bloque 1 valdra : 0.50 x 100% = 0.50 puntos
* un ejercicio con algun error importante del bloque 2 valdra : 1.00 x 50% = 0.50 puntos

NOTA IMPORTANTE #1: No debes 'hardcodear' los ids, es decir, introducirlos a mano después de mirar las tablas. 
Si los necesitas, han de ser el resultado de alguna consulta.

NOTA IMPORTANTE #2 : Debe entregarse solo este fichero sin la base de datos y sin comprimir,
de este modo :  UF_1845_AP_Tu_Nombre.sql

*/
-- usamos la base de datos cine para que este cargado y asi poder hacer los ejercicios
use cine;

/*
EJERCICIO #1 : 0.50 puntos
Muestra solo las actrices.
Ha de aparecer apellido, nombre, fecha_nacimiento
Ordenadas por apellido y nombre, descendente 
*/

SELECT pe.apellido, pe.nombre, fecha_nacimiento
FROM people pe -- hacemos inner join con la tabla people y genero
INNER JOIN genero ge
ON ge.id_genero = pe.genero -- le decimos la relacion
INNER JOIN profesion pr
ON pr.id_profesion = pe.profesion 
WHERE ge.genero = 'mujer' AND pr.profesion = 'actuacion' -- que busque el genero mujer y profesion para mostrar las actrices
ORDER BY pe.apellido DESC, pe.nombre DESC; -- ordenamos apellido y nombre descendente
/*
EJERCICIO #2 : 0.50 puntos
Muestra solo los personajes nacidos en el siglo XIX.
Debe aparecer : nombre y apellido juntos como 'personajes nacidos en el siglo XIX'
ordenados por profesión y nombre ascendente.
*/

SELECT concat(nombre, ", ", apellido) AS 'personajes nacidos en el siglo XIX', profesion -- concatenamos el nombre y apellido para que se vea
FROM people
WHERE fecha_nacimiento < 1900 -- para indicar siglo XIX le decimos que de a tabla people en la feha nacimineto sea inferior a 1900 para tener el resultado
ORDER BY profesion, nombre;

/*
EJERCICIO #3 : 0.50 puntos
Muestro solo la información del personaje dedicado a la música con la 
fecha de nacimiento más reciente. Todos los datos, excepto el id.
*/

SELECT  pe.nombre, pe.apellido, pr.profesion, pe.genero, pe.oscars, pe.fecha_nacimiento -- en el select le marcamos todo lo que queremos er y omitimos el id para que no lo muestre
FROM people pe -- hacemos inner join para relacionar y obtener todos los datos
INNER JOIN genero g
ON g.id_genero = pe.genero
INNER JOIN profesion pr
ON pr.id_profesion = pe.profesion 
WHERE pr.profesion = 'musica' -- en la de profesion le decimos 'musica' para que filtre por dicha profesion
ORDER BY fecha_nacimiento DESC -- que lo ordene
LIMIT 1; -- lo limitamos a 1

/*
EJERCICIO #4 : 0.50 puntos
Personas dedicadas a la interpretación (de cualquier género) que únicamente han ganado un Óscar.
Ha de aparecer el nombre y el apellido combinados como 'actores que solo han ganado un oscar' y el género
Ordenados por apellido en forma ascendente.
*/

SELECT   concat(pe.nombre, ' ', pe.apellido) AS 'actores que solo han ganado un oscar' -- al concatenar le pones el 'as' con la frase que queremos que aparezca
FROM people pe
INNER JOIN profesion pr
ON pr.id_profesion = pe.profesion
WHERE pr.profesion = 'actuacion' AND pe.oscars = 1 -- le decimos para que muestre los interpretes que cumplan en profesion y numero de oscars
ORDER BY pe.apellido;

/*
EJERCICIO #5 : 0.50 puntos
Muestra cuántos personajes no han ganado nunca un Óscar. Debe aparecer solo la cantidad.
*/

SELECT count(pe.oscars) AS 'personajes que nunca han ganado un óscar' -- con el 'count' cuenta que personajes y le damos el alias 
FROM people pe
WHERE pe.oscars  = 0; -- en la tabla de people que muestre que personajes han tenido ningun oscar '0'

/*
EJERCICIO #6 : 0.50 puntos
Borra de la lista el personaje:  "Arthur Rubinstein"
*/

DELETE -- Le decimos que borre de la tabla people los datos de la lista y le damos el nombre y el apellido para que los elimine.
FROM people pe
WHERE pe.nombre = 'Arthur' AND pe.apellido = 'Rubinstein';

/*
EJERCICIO #7 : 0.50 puntos
La fecha de nacimiento de "John Williams" está mal, ya que debe ser 1932. Cámbiala.
*/

UPDATE people -- acutalizamos los datos que ya estan dandole el nombre y apellido y con el 'set' le decimos los datos que son
SET fecha_nacimiento = '1932'
WHERE nombre = 'John' AND apellido = 'Williams';

/*
EJERCICIO #8 : 1.00 puntos
Muestra que director que no ha ganado ningún Óscar es el que tiene la fecha de nacimiento más antigua.
Debe aparecer el nombre completo del director y su profesión
*/

SELECT CONCAT(p.nombre, ' ', p.apellido) AS 'nombre completo', pr.profesion
FROM people p
INNER JOIN profesion pr 
ON p.profesion = pr.id_profesion
WHERE p.oscars = 0 -- despues de crear la relacion le decimos que la people.oscars es igual a 0 para saber quien no a ganado ninguno
ORDER BY p.fecha_nacimiento -- ordenamos por fecha 'asc'
LIMIT 1;

/*
EJERCICIO #9 : 1.00 puntos
Muestra sólo las personas dedicadas a la interpretación de género masculino nacidas entre 1920 y 1940
Ha de aparecer : nombre, apellido, profesión y la fecha de nacimiento como 'nacimiento'
Ordenado por la fecha de nacimiento en forma descendente.
*/

SELECT pe.nombre, pe.apellido, pr.profesion, pe.fecha_nacimiento AS nacimiento -- le ponemos el alias a 'fecha_nacimiento'
FROM people pe
INNER JOIN profesion pr 
ON pe.profesion = pr.id_profesion
WHERE pe.genero = 2 -- 2 es el ID del genero masculino
AND pr.profesion = 'actuacion' -- la profesion que queremos filtrar
AND pe.fecha_nacimiento BETWEEN '1920' AND '1940' -- usamos el 'between' para poner entre que años nos interesa
ORDER BY pe.fecha_nacimiento DESC; -- ordenamos descendente

/*
EJERCICIO #10 : 1.00 puntos
Muestra los personajes que han ganado más Óscars, pero sólo los que están en primera posición.
Debe aparecer nombre, apellido y profesión
Ordenados por apellido descendente
*/

SELECT pe.nombre, pe.apellido, pr.profesion
FROM people pe
INNER JOIN profesion pr 
ON pe.profesion = pr.id_profesion
WHERE pe.oscars = (SELECT MAX(oscars) -- para encontrar el máximo número de Óscars entre todos los personajes y los que cumplan son los selecionados ya se 1 o muchos
    FROM people
)
ORDER BY pe.apellido DESC;

/*
EJERCICIO #11 : 1.50 puntos
¿Cuántos personajes hay de cada género?
La respuesta debe ser : 'Hay X mujeres, Y hombres y Z otros' como 'Genero de los personajes'
*/

SET @mujeres = (SELECT COUNT(*) -- hacemos la variable de mujeres para que cuente los de cada genero
FROM people 
WHERE genero = 1);

SET @hombres = (SELECT COUNT(*) -- hacemos la variable de hombres para que cuente los de cada genero
FROM people 
WHERE genero = 2);

SET @otros = (SELECT COUNT(*) -- hacemos la variable de otros para que cuente los de cada genero
FROM people 
WHERE genero = 3);


SELECT CONCAT('Hay ', @mujeres, ' mujeres, ', @hombres, ' hombres y ', @otros, ' otros') AS 'Genero de los personajes'; -- mostramos la frase con las cantidades

/*
EJERCICIO #12 : 1.50 puntos
Crea un procedimiento almacenado para añadir personajes a la base de datos.
Se llamará st_poblar_bd 
Los parámetros serán : nombre, apellido, profesion, genero, oscars y fecha de nacimiento

Pruébalo con estos ejemplos:
st_poblar_bd('Groucho', 'Marx', 'interpretacion', 'hombre', 1, 1980);
st_poblar_bd('Howard', 'Shore', 'musica', 'hombre', 1, 1946);

*/



DELIMITER $$


CREATE PROCEDURE st_poblar_bd(  -- se crea el procedimiento
nombre varchar(20), 
apellido varchar(30), 
profesion varchar(25),
genero varchar(10), 
oscars int, 
fecha_nacimiento varchar(10))

BEGIN

SET @profesion=(SELECT id_profesion -- hacemos una variable para saber el ID de la profesion
				FROM profesion 
                WHERE profesion = profesion 
                LIMIT 1);


SET @genero=(SELECT id_genero -- hacemos una variable para saber el ID del genero
			FROM genero 
            WHERE genero = genero 
            LIMIT 1);


INSERT INTO people(nombre, apellido, profesion, genero, oscars, fecha_nacimiento) -- se inserta datos
VALUES (nombre, apellido, @profesion, @genero, oscars, fecha_nacimiento);	
END $$
DELIMITER ;

CALL st_poblar_bd('Groucho', 'Marx', 'interpretacion', 'hombre', 1, 1980); -- usamos los siguientes ejemplos
CALL st_poblar_bd('Howard', 'Shore', 'musica', 'hombre', 1, 1946);

DROP PROCEDURE st_poblar_bd;
/*
REALIZAR CORRECTAMENTE LA ENTREGA DE LOS EJERCICIOS
SEGÚN LAS INSTRUCCIONES INDICADAS : 0.50 puntos
*/








