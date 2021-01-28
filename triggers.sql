create function contrata() returns trigger
as
$$
declare
codigo_casting char(20) := (select prueba.cod_casting 
	   from prueba 
	   where prueba.cod_prueba = new.cod_prueba);
begin
insert into contrata(cod_cliente,codigo_casting)
values(new.cod_candidato, codigo_casting);

return new;
end
$$
Language plpgsql;



create trigger importe_total after insert on resultado_prueba
for each row
execute procedure contrata();	




create function seleccionados() returns trigger
as
$$

declare numero_vacantes_totales integer := 0;
declare tipo char(1) := (select tipo from casting where cod_casting=new.cod_casting);
declare numero_vacantes_cogidas integer := (select count(cod_candidato) from contrata where cod_casting = new.cod_casting);

begin
	
	
	if tipo =='o' then numero_vacantes_totales = (select num_personas from casting_online where cod_casting = new.cod_casting);
	else numero_vacantes_totales = (select num_personas from casting_online where cod_casting = new.cod_casting);
	end if;
	if numero_vacantes_cogidas < numero_vacantes_totales then insert into contrata values(new.cod_casting,new.cod_candidato);
	end if;
return new;
end
$$
Language plpgsql;


create trigger seleccion before insert on contrata for each row
execute procedure seleccionados();

