create domain Euros numeric(12,2);

create domain Provincias varchar(20)
	constraint comprobacion_provincia
		check(value in('Albacete','Alicante','Almería','Álava','Asturias','Ávila','Badajoz','Islas Baleares','Barcelona','Bizkaia','Burgos','Cáceres','Cádiz','Cantabria','Castellón','Ciudad Real','Córdoba','A Coruña','Cuenca','Gipuzkoa','Girona','Granada','Guadalajara','Huelva','Huesca','Jaén','León','Lleida','Lugo','Madrid','Málaga','Murcia','Navarra','Ourense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Santa Cruz de Tenerife','Segovia','Sevilla','Soria','Tarragona','Teruel','Toledo','Valencia','Valladolid','Zamora','Zaragoza','Ceuta','Melilla'));

create domain Telefono numeric(9);

create domain Dni char(9);

create domain Web varchar(40)
	constraint comprobacion_web
		check(value like ('%www.%%.com%')or value like ('%www.%%.es%'));

create domain Altura varchar(10)
	constraint comprobacion_altura
		check(value in('100-130','130-160','160-180','170-200','170-195','160-175','150-190','190-210','140-190','120-160'));

create domain Edad varchar(10)
	constraint comprobacion_edad
		check(value in('2-10','10-15','15-20','20-30','30-40','40-50','50-60','60-70','70-80','80-90','35-60','20-60','18-30','20-25','35-50'));
		
create domain Color_ojos varchar(20)
	constraint comprobacion_colorOjos 
		check(value in('Azul','Verde','Marrón','Negro'));
create domain Color_pelo varchar(20)
	constraint comprobacion_colorPelo
		check(value in('Castaño','Moreno','Rubio','Pelirrojo'));
create domain Correo varchar(40)
		constraint comprobacion_correo
			check(value like ('%@%'));


			  

create table cliente(
	cod_cliente varchar(20),
		primary key(cod_cliente),
	nombre varchar(40),
	direccion varchar(40),
	correo Correo,
	actividad char(2) check(actividad in ('m','pc'))
);


create table nombre_cliente(
	cod_cliente varchar(20),
		foreign key(cod_cliente) references cliente,
	nombre varchar(20),
	apellido1 varchar(20),
	apellido2 char(20)
);

create table telefono_cliente(
	cod_cliente varchar(20),
	telefono Telefono,
	foreign key(cod_cliente) references cliente
);

create table agente_casting(
	cod_empleado varchar(20),
	dni Dni,
	nombre varchar(20),
	direccion varchar(40),
	primary key(cod_empleado)
);

create table casting(
	cod_casting varchar(20),
		primary key(cod_casting),
	nombre varchar(20),
	descripcion varchar(40),
	fecha_contratacion date,
	tipo char(1) check(tipo in ('o','p'))
);

create table casting_cliente(
	cod_casting varchar(20),
	cod_cliente varchar(20),
	foreign key(cod_casting) references casting,
	foreign key(cod_cliente) references cliente
);



create table casting_online(
	cod_casting varchar(20),
	num_personas int,
	fecha date,
	web Web,
	foreign key(cod_casting) references casting
);

create table casting_presencial(
	cod_casting varchar(20),
	num_personas int,
	cod_empleado varchar(20),
	foreign key(cod_casting) references casting,
	foreign key(cod_empleado) references agente_casting
);

create table representante(
	dni Dni,
	nombre varchar(20),
	direccion varchar(40),
	telefono Telefono,
	primary key(dni)
);
	
create table perfil(
	cod_perfil varchar(20),
	provincia Provincias,
	sexo char (1) check(sexo in('M','F')),
	rango_edad Edad,
	rango_altura Altura,
	color_pelo Color_pelo,
	color_ojos Color_ojos,
	especialidad char(1) check(especialidad in('A','M')),
	experiencia boolean,
	primary key(cod_perfil)
);

create table candidato(
	cod_candidato varchar(20),
	nombre varchar(20),
	direccion varchar(40),
	nacimiento date,
	importe Euros,
	dni_representante Dni,
	cod_perfil varchar(20),
	primary key(cod_candidato),
	foreign key(dni_representante) references representante,
	foreign key(cod_perfil) references perfil
);

create table nombre_candidato(
	cod_candidato varchar(20),
	nombre varchar(20),
	apellido1 varchar(20),
	apellido2 varchar(20),
	foreign key(cod_candidato) references candidato
);

create table telefono_candidato(
	cod_candidato varchar(20),
	telefono Telefono,
	foreign key(cod_candidato) references candidato
);

create table adulto(
	cod_candidato varchar(20),
	dni Dni,
	foreign key(cod_candidato) references candidato
);
	
create table niño(
	cod_candidato varchar(20),
	nombre_tutor varchar(20),
	foreign key(cod_candidato) references candidato
);

create table prueba(
	cod_prueba varchar(20),
	sala varchar(20),
	descripcion varchar(40),
	precio Euros,
	primary key(cod_prueba)
);


create table fase(
	cod_casting varchar(20),
	cod_fase varchar(20),
	primary key(cod_fase),
	foreign key(cod_casting) references casting
);

create table fase_prueba(
	cod_fase varchar(20),
	cod_prueba varchar(20),
	foreign key(cod_fase) references fase,
	foreign key(cod_prueba) references prueba
);

create table resultado_prueba(
	cod_prueba varchar(20),
	cod_candidato varchar(20),
	superada boolean,
	foreign key(cod_prueba) references prueba,
	foreign key(cod_candidato) references candidato
);

create table casting_perfil(
	cod_casting varchar(20),
	cod_perfil varchar(20),
	foreign key(cod_casting) references casting,
	foreign key(cod_perfil) references perfil
);

create table contrata(
	cod_casting varchar(20),
	cod_candidato varchar(20),
	foreign key(cod_candidato) references candidato,
	foreign key(cod_casting) references casting
);
		

				   
				   
				   
				   
				   
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
				   
				   
				   
		   
				   
				   
				   
create user administrador with password 'administrador';
create user gestor with password 'gestor';
create user recepcionista with password 'recepcionista';

				  

grant all privileges on database Casting to administrador;
				   		   
grant insert,select,update,delete on adulto,agente_casting,candidato,casting_cliente,casting_online,casting_presencial,
cliente,fase,fase_prueba,niño,nombre_candidato,nombre_cliente,perfil,prueba,representante,resultado_prueba,
telefono_candidato,telefono_cliente to gestor;

grant select on adulto,agente_casting,candidato,casting_cliente,casting_online,casting_presencial,
cliente,fase,fase_prueba,niño,nombre_candidato,nombre_cliente,perfil,prueba,representante,resultado_prueba,
telefono_candidato,telefono_cliente to recepcionista;	 			   
				   
				   
				   
				   
				  			   
				   
				   
				   
				   
insert into cliente values('paco2345','paco','barcelona','paco2345@gmail.com','m');
insert into cliente values('pedro2212','pedro','madrid','pedro2212@gmail.com','pc');
insert into cliente values('juan1412','juan','santander','juan1412@gmail.com','m');
insert into cliente values('mario1123','mario','madrid','brachosaurius@gmail.com','pc');
insert into cliente values('alberto5621','alberto','salamanca','alberto5621@gmail.com','pc');
insert into cliente values('miguel4344','miguel','vigo','miguelperez@gmail.com','m');



insert into nombre_cliente values('paco2345','Paco','Perez','García');
insert into nombre_cliente values('pedro2212','Pedro','Gutierrez','Dominguez');
insert into nombre_cliente values('juan1412','Juan','Gomez','Ramos');
insert into nombre_cliente values('mario1123','Mario','Fernandez','Sanz');
insert into nombre_cliente values('alberto5621','Alberto','Lopez','Castillo');
insert into nombre_cliente values('miguel4344','Miguel','Gutierrez','Cruz');




insert into telefono_cliente values('paco2345',623456213);
insert into telefono_cliente values('paco2345',622456123);
insert into telefono_cliente values('paco2345',614326225);
insert into telefono_cliente values('paco2345',623324542);
insert into telefono_cliente values('paco2345',624567423);
insert into telefono_cliente values('paco2345',623324554);



insert into casting values('casting1','enp','casting para obra de teatro','2020/12/12','o');
insert into casting values('casting2','masterchef','casting de cocina','2021/08/23','p');
insert into casting values('casting3','star wars','casting para pelicula star wars','2021-02-24','p');
insert into casting values('casting4','netlix','casting para nueva serie netflix','2020-12-13','o');
insert into casting values('casting5','doblaje','casting para anuncio tv vdeojuego','2021-05-15','o');
insert into casting values('casting6','coches','casting para pelicula de conduccion','2020-12-12','p');


insert into casting_online values('casting1',20,'2020/12/12','www.enp.com');
insert into casting_online values('casting4',43,'2020-12-13','www.netlix.es');
insert into casting_online values('casting5',32,'2021-05-15','www.cochesfilm.com');



insert into casting_presencial values('casting2',35,'empleado3321');
insert into casting_presencial values('casting3',50,'empleado3321');
insert into casting_presencial values('casting6',20,'empleado2341');


insert into agente_casting values('empleado2341','08564324D','martin','pamplona');
insert into agente_casting values('empleado3321','07654343P','julian','bilbao');
insert into agente_casting values('empleado1564','06545663C','pablo','madrid');
insert into agente_casting values('empleado5532','08654324K','pedro','pamplona');



insert into fase values('casting2','fase1c2');
insert into fase values('casting2','fase2c2');
insert into fase values('casting2','fase3c2');
insert into fase values('casting3','fase1c3');
insert into fase values('casting6','fase1c6');
insert into fase values('casting6','fase2c6');
insert into fase values('casting6','fase3c6');
insert into fase values('casting6','fase4c6');



insert into perfil values('perfil1','Barcelona','M','35-50','160-180','Castaño','Azul','A',false);
insert into perfil values('perfil2','Madrid','F','20-60','170-200','Moreno','Marrón','M',true);
insert into perfil values('perfil7','Madrid','M','20-30','170-200','Moreno','Marrón','M',true);
insert into perfil values('perfil3','Sevilla','M','18-30','150-190','Rubio','Negro','M',false);
insert into perfil values('perfil4','Valencia','M','10-15','130-160','Moreno','Marrón','M',true);
insert into perfil values('perfil8','Valencia','F','10-15','130-160','Moreno','Marrón','M',true);
insert into perfil values('perfil5','Cantabria','F','20-25','170-195','Moreno','Verde','M',false);
insert into perfil values('perfil6','Lugo','M','60-70','160-175','Castaño','Azul','A',true);




insert into representante values('08654654P','fernado','salamanca',645324321); 
insert into representante values('07543214P','juan','asturias',743543221); 
insert into representante values('09654363Y','maria','pontevedra',765436547); 
insert into representante values('07654322P','alberto','sevilla',985436548); 
insert into representante values('08543432C','raul','alicante',622677881); 




insert into candidato values('candidato1','Miguel','Castellon','2009/06/25',0,'08654654P','perfil4');
insert into candidato values('candidato2','Alberto','Barcelona','1980/07/13',0,'08543432C','perfil1');
insert into candidato values('candidato3','Miguel','Alicante','2008/01/15',0,null,'perfil4');
insert into candidato values('candidato4','Teresa','Valencia','1975/05/26',0,'09654363Y','perfil8');
insert into candidato values('candidato5','Ruben','Málaga','1996/03/10',0,'08654654P','perfil3');
insert into candidato values('candidato6','Alfonso','Sevilla','2000/02/28',0,'07543214P','perfil3');
insert into candidato values('candidato7','Alicia','Madrid','1999/10/17',0,null,'perfil2');
insert into candidato values('candidato8','Jose Manuel','Madrid','2001/12/01',0,'07543214P','perfil7');
insert into candidato values('candidato9','Francisco','Vigo','1955/09/23',0,'08654654P','perfil6');



insert into nombre_candidato values('candidato1','Miguel','Fernandez','Sanchez');
insert into nombre_candidato values('candidato2','Alberto','Gonzalez','Sancho');
insert into nombre_candidato values('candidato3','Miguel','Ruglez','Antonio');
insert into nombre_candidato values('candidato4','Teresa','Garrido','Gil');
insert into nombre_candidato values('candidato5','Ruben','Castro','Sanz');
insert into nombre_candidato values('candidato6','Alfonso','Fernandez','Perez');
insert into nombre_candidato values('candidato7','Alicia','Saez','Lopez');
insert into nombre_candidato values('candidato8','Jose Manuel','Fando','Alamo');
insert into nombre_candidato values('candidato9','Francisco','Ortega','Maldonado');




insert into telefono_candidato values('candidato1',654342321);
insert into telefono_candidato values('candidato2',683234564);
insert into telefono_candidato values('candidato3',676548764);
insert into telefono_candidato values('candidato4',675443561);
insert into telefono_candidato values('candidato5',686546784);
insert into telefono_candidato values('candidato6',754654768);
insert into telefono_candidato values('candidato7',917546876);
insert into telefono_candidato values('candidato8',843564678);
insert into telefono_candidato values('candidato9',676789876);




insert into adulto values('candidato2','07543564F');
insert into adulto values('candidato4','09954673F');
insert into adulto values('candidato5','0986576P');
insert into adulto values('candidato6','08754658C');
insert into adulto values('candidato7','09095436G');
insert into adulto values('candidato8','07456378B');
insert into adulto values('candidato9','08546743J');


insert into niño values('candidato1','08543453G');
insert into niño values('candidato3','09765453P');


insert into prueba values('prueba1-c2f1','avion','freir un huevo',20);
insert into prueba values('prueba2-c2f1','avion','preparan un postre',15);
insert into prueba values('prueba1-c2f2','flor','hacer costillas',31);
insert into prueba values('prueba2-c2f2','flor','cocinar un risotto',24);
insert into prueba values('prueba1-c3f1','coche','modular la voz',17);
insert into prueba values('prueba2-c3f1','rosa','interpretar un personaje',24);
insert into prueba values('prueba3-c3f1','amapola','hacer una escena',50);
insert into prueba values('prueba1-c6f1','flor','conducir un coche',33);
insert into prueba values('prueba1-c6f2','anuncio','hacer un trompo',64);
insert into prueba values('prueba2-c6f1','perro','hacer una interpretacion en coche',32);
insert into prueba values('prueba1-c6f3','maquina','hacer una carrera',10);
insert into prueba values('prueba2-c6f3','flor','tirarse de un coche en marcha',4);
insert into prueba values('prueba3-c6f3','garaje','saltar de un avion',43);
				   
				   


insert into fase_prueba values('fase1c2','prueba1-c2f1');
insert into fase_prueba values('fase1c2','prueba2-c2f1');
insert into fase_prueba values('fase2c2','prueba1-c2f2');
insert into fase_prueba values('fase2c2','prueba2-c2f2');
insert into fase_prueba values('fase1c3','prueba1-c3f1');
insert into fase_prueba values('fase1c3','prueba2-c3f1');
insert into fase_prueba values('fase1c3','prueba3-c3f1');
insert into fase_prueba values('fase1c6','prueba1-c6f1');
insert into fase_prueba values('fase2c6','prueba1-c6f2');
insert into fase_prueba values('fase2c6','prueba2-c6f2');
insert into fase_prueba values('fase3c6','prueba1-c6f3');
insert into fase_prueba values('fase3c6','prueba2-c6f3');
insert into fase_prueba values('fase3c6','prueba3-c6f3');


				   

				   
				   
insert into casting_perfil values('casting1','perfil7');
insert into casting_perfil values('casting2','perfil4');
insert into casting_perfil values('casting2','perfil8');
insert into casting_perfil values('casting3','perfil6');
insert into casting_perfil values('casting4','perfil2');
insert into casting_perfil values('casting4','perfil3');
insert into casting_perfil values('casting5','perfil5');
insert into casting_perfil values('casting6','perfil8');
insert into casting_perfil values('casting6','perfil1');




insert into resultado_prueba values('candidato1','prueba1-c2f1',true);
insert into resultado_prueba values('candidato1','prueba2-c2f1',true);
insert into resultado_prueba values('candidato1','prueba1-c2f2',false);
insert into resultado_prueba values('candidato3','prueba1-c2f1',true);
insert into resultado_prueba values('candidato3','prueba2-c2f1',true);
insert into resultado_prueba values('candidato3','prueba1-c2f2',true);
insert into resultado_prueba values('candidato3','prueba2-c2f2',true);
insert into resultado_prueba values('candidato4','prueba1-c3f1',false);
insert into resultado_prueba values('candidato9','prueba1-c6f1',true);
insert into resultado_prueba values('candidato9','prueba2-c6f1',false);
insert into resultado_prueba values('candidato4','prueba1-c6f1',true);
insert into resultado_prueba values('candidato4','prueba1-c6f2',true);
insert into resultado_prueba values('candidato4','prueba1-c6f3',true);
insert into resultado_prueba values('candidato4','prueba2-c6f3',false);
insert into resultado_prueba values('candidato2','prueba1-c6f1',true);
insert into resultado_prueba values('candidato2','prueba1-c6f2',true);
insert into resultado_prueba values('candidato2','prueba1-c6f3',true);
insert into resultado_prueba values('candidato2','prueba2-c6f3',true);
insert into resultado_prueba values('candidato2','prueba3-c6f3',true);					   
				   
				   
				   
				   
				   
				   
				   
				   

