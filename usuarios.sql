-- USUARIOS

-- queremos saber qué usuarios hay en el sistema
select * from mysql.user;

-- crear nuevo usuario
CREATE USER usuario_select@'localhost' identified by '1234';
-- asignar sus privilegios
GRANT select, insert, update 
on tienda_moviles_2.* 
to usuario_select@'localhost';

-- Quitar todos los privilegios que le dimos antes
revoke all 
on tienda_moviles_2.* 
from usuario_select@'localhost';

drop user usuario_select@'localhost';

show grants for usuario_select@'localhost';

-- dar premisos totales al root
CREATE USER root@'%' IDENTIFIED BY '';
GRANT ALL on *.* TO root@'%' WITH GRANT OPTION;