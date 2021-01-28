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
