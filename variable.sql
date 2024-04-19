
 -- Obtener fecha actual
set @ahora = now();

-- Mostrar variable
select @ahora;

select date (@ahora);

-- extraer año, mes, día, hora, minuto, segundo
select year (@ahora), month(@ahora), week(@ahora),
day(@ahora), hour(@ahora), minute(@ahora), second(@ahora);
-- qué día de la semana, del mes y del año es
select dayofweek(@ahora), dayofmonth(@ahora), dayofyear(@ahora), dayname(@ahora);

use tienda_moviles;
show tables;

select * from poblaciones;