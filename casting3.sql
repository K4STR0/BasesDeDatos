create domain Euros numeric(12,2);

create domain Provincias varchar(20)
	constraint comprobacion_provincia
		check(value in('Albacete','Alicante','Almería','Álava','Asturias','Ávila','Badajoz','Islas Baleares','Barcelona','Bizkaia','Burgos','Cáceres','Cádiz','Cantabria','Castellón','Ciudad Real','Córdoba','A Coruña','Cuenca','Gipuzkoa','Girona','Granada','Guadalajara','Huelva','Huesca','Jaén','León','Lleida','Lugo','Madrid','Málaga','Murcia','Navarra','Ourense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Santa Cruz de Tenerife','Segovia','Sevilla','Soria','Tarragona','Teruel','Toledo','Valencia','Valladolid','Zamora','Zaragoza','Ceuta','Melilla'));

create domain Telefono numeric(9);

create domain Dni char(9);

create domain Web varchar(40)
	constraint comprobacion_web
		check(value like ('%www.%%.com%')or value like ('%www.%%.es%'));

create domain Altura numeric(3)
	constraint comprobacion_altura
		check(value between 100 and 240);

create domain Edad numeric(3)
	constraint comprobacion_edad
		check(value between 1 and 100);
		
create domain Color_ojos varchar(20)
	constraint comprobacion_color 
		check(value in('Azul','Verde','Marrón','Negro'));
create domain Color_pelo varchar(20)
	constraint comprobacion_color 
		check(value in('Castaño','Moreno','Rubio','Pelirrojo'));
create domain Correo varchar(40)
		constraint comprobacion_correo
			check(value like ('%@%'));


			  

create table cliente(
	cod_cliente varchar(20),
		primary key(cod_cliente),
	nombre varchar(40),
	direccion varchar(40),
	telefono Telefono,
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
	telefono Telefono,
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
		
				   
				   
				   
INSERT INTO CLIENTE VALUES('paco2345','paco','barcelona',623456213,'paco2345@gmail.com','m');
INSERT INTO CLIENTE VALUES('pedro2212','pedro','madrid',622456123,'pedro2212@gmail.com','pc');
INSERT INTO CLIENTE VALUES('juan1412','juan','santander',614326225,'juan1412@gmail.com','m');
INSERT INTO CLIENTE VALUES('mario1123','mario','madrid',623324542,'brachosaurius@gmail.com','pc');
INSERT INTO CLIENTE VALUES('alberto5621','alberto','salamanca',624567423,'alberto5621@gmail.com','pc');
INSERT INTO CLIENTE VALUES('miguel4344','miguel','vigo',623324554,'miguelperez@gmail.com','m');



INSERT INTO casting VALUES('casting1','enp','casting para obra de teatro','2020/12/12','o');
INSERT INTO casting VALUES('casting2','masterchef','casting de cocina','2021/08/23','p');
INSERT INTO casting VALUES('casting3','star wars','casting para pelicula star wars','2021-02-24','p');
INSERT INTO casting VALUES('casting4','netlix','casting para nueva serie netflix','2020-12-13','o');
INSERT INTO casting VALUES('casting5','doblaje','casting para anuncio tv vdeojuego','2021-05-15','o');
INSERT INTO casting VALUES('casting6','coches','casting para pelicula de conduccion','2020-12-12','p');


INSERT INTO casting_online VALUES('casting1',20,'2020/12/12','www.enp.com');
INSERT INTO casting_online VALUES('casting4',43,'2020-12-13','www.netlix.es');
INSERT INTO casting_online VALUES('casting5',32,'2021-05-15','www.cochesfilm.com');



INSERT INTO casting_presencial VALUES('casting2',35,'empleado3321');
INSERT INTO casting_presencial VALUES('casting3',50,'empleado3321');
INSERT INTO casting_presencial VALUES('casting6',20,'empleado2341');


INSERT INTO agente_casting VALUES('empleado2341','08564324D','martin','pamplona');
INSERT INTO agente_casting VALUES('empleado3321','07654343P','julian','bilbao');
INSERT INTO agente_casting VALUES('empleado1564','06545663C','pablo','madrid');
INSERT INTO agente_casting VALUES('empleado5532','08654324K','pedro','pamplona');



INSERT INTO fase VALUES('casting2','fase1c2');
INSERT INTO fase VALUES('casting2','fase2c2');
INSERT INTO fase VALUES('casting2','fase3c2');
INSERT INTO fase VALUES('casting3','fase1c3');
INSERT INTO fase VALUES('casting6','fase1c6');
INSERT INTO fase VALUES('casting6','fase2c6');
INSERT INTO fase VALUES('casting6','fase3c6');
INSERT INTO fase VALUES('casting6','fase4c6');



INSERT INTO perfil VALUES('perfil1','Barcelona','M','35-50','160-180','Castaño','Azules','A',false);
INSERT INTO perfil VALUES('perfil2','Madrid','F','20-60','170-200','Rubio','Marrón','M',true);
INSERT INTO perfil VALUES('perfil7','Madrid','M','20-60','170-200','Negro','Marrón','M',true);
INSERT INTO perfil VALUES('perfil3','Sevilla','M','18-30','150-190','Rubio','Marrón','M',false);
INSERT INTO perfil VALUES('perfil4','Valencia','M','10-15','130-160','Negro','Marrón','M',true);
INSERT INTO perfil VALUES('perfil8','Valencia','F','10-15','130-160','Negro','Marrón','M',true);
INSERT INTO perfil VALUES('perfil5','Cantabria','F','20-25','170-195','Negro','Verdes','M',false);
INSERT INTO perfil VALUES('perfil6','Lugo','M','60-70','160-175','Castaño','Azules','A',true);




INSERT INTO representante VALUES('08654654P','fernado','salamanca',645324321); 
INSERT INTO representante VALUES('07543214P','juan','asturias',743543221); 
INSERT INTO representante VALUES('09654363Y','maria','pontevedra',765436547); 
INSERT INTO representante VALUES('07654322P','alberto','sevilla',985436548); 
INSERT INTO representante VALUES('08543432C','raul','alicante',622677881); 




INSERT INTO candidato VALUES('candidato1','Miguel','Castellon',654342321,'2009/06/25',0,'08654654P','perfil4');
INSERT INTO candidato VALUES('candidato2','Alberto','Barcelona',683234564,'1980/07/13',0,'08543432C','perfil1');
INSERT INTO candidato VALUES('candidato3','Miguel','Alicante',676548764,'2008/01/15',0,null,'perfil4');
INSERT INTO candidato VALUES('candidato4','Teresa','Valencia',675443561,'1975/05/26',0,'09654363Y','perfil8');
INSERT INTO candidato VALUES('candidato5','Ruben','Málaga',686546784,'1996/03/10',0,'08654654P','perfil3');
INSERT INTO candidato VALUES('candidato6','Alfonso','Sevilla',754654768,'2000/02/28',0,'07543214P','perfil3');
INSERT INTO candidato VALUES('candidato7','Alicia','Madrid',917546876,'1999/10/17',0,null,'perfil2');
INSERT INTO candidato VALUES('candidato8','Jose','Madrid',843564678,'2001/12/01',0,'07543214P','perfil7');
INSERT INTO candidato VALUES('candidato9','Francisco','Vigo',676789876,'1955/09/23',0,'08654654P','perfil6');




INSERT INTO adulto VALUES('candidato2','07543564F');
INSERT INTO adulto VALUES('candidato4','09954673F');
INSERT INTO adulto VALUES('candidato5','0986576P');
INSERT INTO adulto VALUES('candidato6','08754658C');
INSERT INTO adulto VALUES('candidato7','09095436G');
INSERT INTO adulto VALUES('candidato8','07456378B');
INSERT INTO adulto VALUES('candidato9','08546743J');


INSERT INTO niño VALUES('candidato1','08543453G');
INSERT INTO niño VALUES('candidato3','09765453P');


INSERT INTO pruebas VALUES('prueba1-c2f1','avion','freir un huevo',20,'fase1c2');
INSERT INTO pruebas VALUES('prueba2-c2f1','avion','preparan un postre',15,'fase1c2');
INSERT INTO pruebas VALUES('prueba1-c2f2','flor','hacer costillas',31,'fase2c2');
INSERT INTO pruebas VALUES('prueba2-c2f2','flor','cocinar un risotto',24,'fase2c2');
INSERT INTO pruebas VALUES('prueba1-c3f1','coche','modular la voz',17,'fase1c3');
INSERT INTO pruebas VALUES('prueba2-c3f1','rosa','interpretar un personaje',24,'fase1c3');
INSERT INTO pruebas VALUES('prueba3-c3f1','amapola','hacer una escena',50,'fase1c3');
INSERT INTO pruebas VALUES('prueba1-c6f1','flor','conducir un coche',33,'fase1c6');
INSERT INTO pruebas VALUES('prueba1-c6f2','anuncio','hacer un trompo',64,'fase2c6');
INSERT INTO pruebas VALUES('prueba2-c6f2','perro','hacer una interpretacion en coche',32,'fase2c6');
INSERT INTO pruebas VALUES('prueba1-c6f3','maquina','hacer una carrera',10,'fase3c6');
INSERT INTO pruebas VALUES('prueba2-c6f3','flor','tirarse de un coche en marcha',4,'fase3c6');
INSERT INTO pruebas VALUES('prueba3-c6f3','garaje','saltar de un avion',43,'fase3c6');


INSERT INTO casting_perfil VALUES('casting1','perfil7');
INSERT INTO casting_perfil VALUES('casting2','perfil4');
INSERT INTO casting_perfil VALUES('casting2','perfil8');
INSERT INTO casting_perfil VALUES('casting3','perfil6');
INSERT INTO casting_perfil VALUES('casting4','perfil2');
INSERT INTO casting_perfil VALUES('casting4','perfil3');
INSERT INTO casting_perfil VALUES('casting5','perfil5');
INSERT INTO casting_perfil VALUES('casting6','perfil8');
INSERT INTO casting_perfil VALUES('casting6','perfil1');




INSERT INTO resultado_pruebas VALUES('casting2','candidato1','prueba1-c2f1',true);
INSERT INTO resultado_pruebas VALUES('casting2','candidato1','prueba2-c2f1',true);
INSERT INTO resultado_pruebas VALUES('casting2','candidato1','prueba1-c2f2',false);
INSERT INTO resultado_pruebas VALUES('casting2','candidato3','prueba1-c2f1',true);
INSERT INTO resultado_pruebas VALUES('casting2','candidato3','prueba2-c2f1',true);
INSERT INTO resultado_pruebas VALUES('casting2','candidato3','prueba1-c2f2',true);
INSERT INTO resultado_pruebas VALUES('casting2','candidato3','prueba2-c2f2',true);
INSERT INTO resultado_pruebas VALUES('casting3','candidato4','prueba1-c3f1',false);
INSERT INTO resultado_pruebas VALUES('casting6','candidato9','prueba1-c6f1',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato9','prueba2-c6f1',false);
INSERT INTO resultado_pruebas VALUES('casting6','candidato4','prueba1-c6f1',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato4','prueba1-c6f2',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato4','prueba2-c6f2',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato4','prueba1-c6f3',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato4','prueba2-c6f3',false);
INSERT INTO resultado_pruebas VALUES('casting6','candidato2','prueba1-c6f1',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato2','prueba1-c6f2',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato2','prueba2-c6f2',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato2','prueba1-c6f3',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato2','prueba2-c6f3',true);
INSERT INTO resultado_pruebas VALUES('casting6','candidato2','prueba3-c6f3',true);				   
				   
				   
				   
				   
				   
				   
				   
				   
				   
			   
				   
				   
				   
				   
				   		   
				   
				   
create function actualizar_importe() returns trigger
as
$$
begin
update candidato 
set importe = importe + (select precio from prueba where cod_prueba = new.cod_prueba)
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
				   

