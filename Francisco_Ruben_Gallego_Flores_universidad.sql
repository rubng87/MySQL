use universidad2;

-- 1. Lista de profesores ordenados alfabéticamente.

SELECT nombre, apellido
FROM profesores
ORDER BY nombre;

-- 2. Lista de alumnos ordenados por ciudad y por apellido, alfabéticamente.

SELECT ciudad, apellido
FROM alumnos
WHERE ciudad IS NOT NULL AND ciudad != ''
ORDER BY ciudad, apellido;

-- 3. Lista de alumnos solo de Barcelona, alfabéticamente en sentido descendente.

SELECT ciudad, nombre, apellido
FROM alumnos
WHERE ciudad = 'Barcelona'
ORDER BY nombre DESC;

-- 4. Lista de alumnos no matriculados en ninguna asignatura: 
-- nif, nombre, apellido

SELECT al.nif, al.nombre, al.apellido
FROM alumnos al
INNER JOIN alumno_asignatura alas
ON al.id_alumno = alas.id_alumno
INNER JOIN asignatura asi
ON asi.id_asignatura = alas.id_asignatura
where asi.id_asignatura = null;

-- 5. Alumno hombre más joven matriculado en 2017: 
-- nombre, apellido (atención, que hay personas no matriculadas)

SELECT al.nombre, al.apellido, sexo, anyo_inicio, al.fecha_nacimiento
FROM alumnos al
INNER JOIN alumno_asignatura alas 
ON al.id_alumno = alas.id_alumno
INNER JOIN curso_escolar cues 
ON alas.id_curso_escolar = cues.id_curso_escolar
WHERE (cues.anyo_inicio) = 2017 AND al.sexo = 'M'
ORDER BY al.fecha_nacimiento desc
LIMIT 1;

-- 6. Profesor de más edad que dio cursos en 2018

SELECT pro.nombre, pro.apellido, pro.fecha_nacimiento, anyo_inicio
FROM curso_escolar cues
INNER JOIN alumno_asignatura alas
on cues.id_curso_escolar = alas.id_curso_escolar
inner join asignatura asi
on alas.id_asignatura = asi.id_asignatura
inner join profesores pro
on asi.id_profesor = pro.id_profesor
where anyo_inicio = '2018'
order by fecha_nacimiento 
limit 1;

-- 7. Asignatura con más alumnos por año

SELECT cues.anyo_inicio, asi.nombre, COUNT(*) AS cantidad_alumnos
FROM alumnos al
INNER JOIN alumno_asignatura alsi 
ON al.id_alumno = alsi.id_alumno
INNER JOIN asignatura asi 
ON alsi.id_asignatura = asi.id_asignatura
INNER JOIN curso_escolar cues 
ON alsi.id_curso_escolar = cues.id_curso_escolar
GROUP BY cues.anyo_inicio, asi.nombre;


-- 8. Asignatura con más alumnos mujeres y cuantas son

SELECT asi.nombre, COUNT(asi.nombre) AS cantidad_alumnas
FROM alumnos al
INNER JOIN alumno_asignatura alas 
ON al.id_alumno = alas.id_alumno
INNER JOIN asignatura asi 
ON alas.id_asignatura = asi.id_asignatura
WHERE al.sexo = 'M'
GROUP BY asi.id_asignatura
ORDER BY cantidad_alumnas desc
LIMIT 1;

-- 9. Asignatura con menos alumnos hombres en 2018

SELECT asi.nombre, COUNT(asi.nombre) AS 'cantidad alumnos hombres'
FROM alumnos al
INNER JOIN alumno_asignatura alsi
ON al.id_alumno = alsi.id_alumno
INNER JOIN asignatura asi
ON alsi.id_asignatura = asi.id_asignatura
INNER JOIN curso_escolar cues
ON asi.id_curso_escolar = cues.id_curso_escolar
WHERE al.sexo = 'H' AND cues.anyo_fin = '2018'
GROUP BY asi.nombre
ORDER BY 'cantidad alumnos hombres' desc
LIMIT 1;

-- 10.	Añade el alumno “John Wayne”, de Texas, sexo ‘H’, nif 98765432Z, nacido el 1 de febrero de 1999, y matricúlalo en Cálculo

INSERT INTO alumnos (nif, nombre, apellido, ciudad, fecha_nacimiento, sexo)
VALUES ('98765432Z', 'John', 'Wayne', 'Texas', '1999-02-01', 'H');

SELECT id_alumno FROM alumnos WHERE nif = '98765432Z';

INSERT INTO alumno_asignatura (id_alumno, id_asignatura, id_curso_escolar)
VALUES ('1048', '3', '3');

-- 11.	Por un error, los alumnos de Sabadell se quedaron sin que constara su población. Debes incorporarla a la tabla.

UPDATE alumnos
SET ciudad = 'Sabadell'
WHERE ciudad = 'Sabadell';

-- 12.	Muestra cantidad de alumnos de cada género.

SELECT sexo, COUNT(*) AS cantidad_alumnos
FROM alumnos
GROUP BY sexo;

-- 13.	Hay que actualizar la tabla alumnos. Resulta que aquellos de Girona, de sexo M y cuya fecha de nacimiento es 0000-00-00, nacieron todos el 1 de junio de 2001.

UPDATE alumnos
SET fecha_nacimiento = '2001-06-01'
WHERE ciudad = 'Girona' AND sexo = 'M' AND fecha_nacimiento = '0000-00-00';

-- 14.	Qué profesor tiene más asignaturas.

SELECT MAX(pr.nombre) AS nombre_profesor, COUNT(*) AS cantidad_asignaturas
FROM asignatura asi
INNER JOIN profesores pr 
ON asi.id_profesor = pr.id_profesor
GROUP BY pr.id_profesor
ORDER BY cantidad_asignaturas DESC
LIMIT 1;

-- 15.	¿Cuántas profesoras hay de Berlín? (sólo mujeres)

SELECT COUNT(*) AS cantidad_profesoras_berlin
FROM profesores
WHERE ciudad = 'Berlin' AND sexo = 'Mujer';


-- 16.	10 nombres de alumnos más usuales, ordenados de mayor a menor

SELECT nombre, COUNT(*) AS cantidad
FROM alumnos
GROUP BY nombre
ORDER BY cantidad DESC
LIMIT 10;

-- 17.	Ciudad con más alumnos hombres en 2016: ciudad, cantidad de alumnos

SELECT ciudad, COUNT(*) AS cantidad_alumnos_hombres
FROM alumnos
WHERE sexo = 'H'
AND fecha_nacimiento = '2016'
GROUP BY ciudad
ORDER BY cantidad_alumnos_hombres DESC
LIMIT 1;

-- 18.	Las tres asignaturas con mayor número de alumnos inscritos en toda la historia de más a menos, indicando la cantidad: 
-- Nombre de la asignatura, cantidad de alumnos

SELECT asi.nombre AS nombre_asignatura, COUNT(*) AS cantidad_alumnos
FROM alumno_asignatura alasi
INNER JOIN asignatura asi 
ON alasi.id_asignatura = asi.id_asignatura
GROUP BY alasi.id_asignatura
ORDER BY cantidad_alumnos DESC
LIMIT 3;

-- 19.	Se ha decidido conceder una beca a los tres alumnos casados de mayor edad. Identifica quienes son, mostrando su nif, nombre y apellido.

SELECT nif, nombre, apellido, fecha_nacimiento
FROM alumnos
WHERE casado = 'S' 
ORDER BY fecha_nacimiento
LIMIT 3;

-- 20. Mostrar por parejas los alumnos que viven en la misma ciudad. Deben aparecer los apellidos de cada uno y la ciudad, sin parejas duplicadas. El orden debe ser por el nombre de la ciudad y el apellido de la primera columna. Ejemplo:  

SELECT CONCAT(a1.apellido) AS 'alumno 1', CONCAT(a2.apellido) AS 'alumno 2', a1.ciudad
FROM alumnos a1
INNER JOIN alumnos a2 
ON a1.ciudad = a2.ciudad
WHERE a1.id_alumno < a2.id_alumno
ORDER BY a1.ciudad, a1.apellido;

-- 21. Gestión de usuarios. Has de guardar de código de cada acción:
-- a. Muestra los usuarios y sus permisos.

SELECT * FROM mysql.user;
SHOW GRANTS FOR 'nombre_usuario'@'localhost';

-- b. Crea un usuario llamado cliente que solo se pueda conectar por localhost y permisos para hacer select y update. Su contraseña será ‘1234abcd’.

CREATE USER 'cliente'@'localhost' IDENTIFIED BY '1234abcd';
GRANT SELECT, UPDATE ON nombre_base_de_datos.* TO 'cliente'@'localhost';

-- c. Quítale el permiso de update. 

REVOKE UPDATE ON nombre_base_de_datos.* FROM 'cliente'@'localhost';

-- d. Borra el usuario.

DROP USER 'cliente'@'localhost';

-- Bloque 3 : Automatización
-- 1. Procedimiento Almacenado para obtener la ciudad con más alumnos por año y sexo (serán los parámetros). Se llamará pa_ciudad_sexo_anyo: 
-- ciudad, cantidad de alumnos hombres, cantidad de mujeres, año

DELIMITER //

CREATE PROCEDURE pa_ciudad_sexo_anyo(IN año_consulta INT)
BEGIN
    SELECT ciudad, SUM(CASE WHEN sexo = 'H' THEN 1 ELSE 0 END) AS cantidad_hombres,
           SUM(CASE WHEN sexo = 'M' THEN 1 ELSE 0 END) AS cantidad_mujeres, YEAR(fecha_nacimiento) AS año
    FROM alumnos
    WHERE YEAR(fecha_nacimiento) = año_consulta
    GROUP BY ciudad, YEAR(fecha_nacimiento)
    ORDER BY cantidad_hombres + cantidad_mujeres DESC
    LIMIT 1;
END //

DELIMITER ;

CALL pa_ciudad_sexo_anyo(2004);

DROP PROCEDURE pa_ciudad_sexo_anyo;

-- 2. Procedimiento almacenado para obtener los alumnos matriculados por asignatura, sexo y año de inicio (serán los parámetros). 
-- Se llamará pa_alumnos_asig_sexo_anyo. 
-- Por ejemplo, cuando tendrá esta respuesta cuando se ejecute así : 
-- call pa_alumnos_asig_sexo_anyo (‘Estadistica’, ‘M’, 2017):

DELIMITER //

CREATE PROCEDURE pa_alumnos_asig_sexo_anyo(IN asignatura_consulta VARCHAR(100), IN sexo_consulta CHAR(1), IN año_consulta INT)
BEGIN
    SELECT al.nombre, al.apellido, sexo, anyo_inicio AS 'Año de inicio'
    FROM alumnos al
    INNER JOIN alumno_asignatura alasi 
    ON al.id_alumno = alasi.id_alumno
    INNER JOIN asignatura asi 
    ON alasi.id_asignatura = asi.id_asignatura
    INNER JOIN curso_escolar cues 
    ON asi.id_curso_escolar = cues.id_curso_escolar
    WHERE asi.nombre = asignatura_consulta
    AND al.sexo = sexo_consulta
    AND YEAR(cues.anyo_inicio) = año_consulta;
END //

DELIMITER ;

CALL pa_alumnos_asig_sexo_anyo('Cálculo', 'M', 2017);

DROP PROCEDURE pa_alumnos_asig_sexo_anyo;





