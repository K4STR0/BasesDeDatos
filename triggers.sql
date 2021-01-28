			   
create function actualizar_importe() returns trigger
as
$$
begin
update candidato 
set importe = (select importe from candidato where cod_candidato = new.cod_candidato) + (select precio from prueba where cod_prueba = new.cod_prueba)
where cod_candidato = new.cod_candidato;

return new;
end
$$
Language plpgsql;



create trigger importe_total after insert on resultado_prueba for each row
execute procedure actualizar_importe();





create function contrata() returns trigger
as
$$


declare total_pruebas_candidato integer := (select count(cod_candidato) from resultado_pruebas 
											where cod_candidato = new.cod_candidato and cod_prueba 
												in(select cod_prueba from fase_prueba inner join fase on fase_prueba.cod_fase=fase.cod_fase
												   where cod_prueba = new.cod_prueba));
												   
declare total_pruebas_casting integer := (select count(cod_casting) from fase_prueba inner join fase on fase_prueba.cod_fase = fase.cod_fase
											where cod_fase in(select cod_fase from fase_prueba where cod_prueba=new.cod_prueba));


declare codigo_casting varchar(20) := (select cod_casting from fase inner join fase_prueba on fase.cod_fase = fase_prueba.cod_fase 
											where fase_prueba.cod_prueba = new.cod_prueba);

begin


	if total_pruebas_candidato = total_pruebas casting then insert into contrata values(codigo_casting,new.cod_candidato);
	end if;

return new;
end
$$
Language plpgsql;



create trigger contratar after insert on resultado_prueba
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







create function ver_perfil() returns trigger
as
$$

declare perfil varchar(10):= (select cod_perfil from candidato where cod_candidato = new.cod_candidato);

begin
	
	if (perfil in (select cod_perfil from casting_perfil))
		then insert into resultado_prueba values(new.cod_candidato,new.cod_prueba,new.superada);
	end if;
return new;
end
$$
Language plpgsql;


create trigger perfil_requerido before insert on resultado_prueba for each row
execute procedure ver_perfil();
