-- concat
select concat("Buenos", " ", "días") as saludo;
select concat_ws("-", "Buenos", "días", "a", "todo", "el", "mundo") as saludo;

-- length (contar la longitud)
select length("MySql");

use tienda_moviles;

select nombre_cliente
from clientes
where length(trim(nombre_cliente)) > 5;

-- Upper para poner nombres en mayusculas
select upper(nombre_cliente)
from clientes;