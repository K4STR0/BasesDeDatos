create domain Euros numeric(12,2);

create domain Provincias char(20)
	constraint comprobacion_provincia
		check(value in('Albacete','Alicante','Almería','Álava','Asturias','Ávila','Badajoz','Islas Baleares','Barcelona','Bizkaia','Burgos','Cáceres','Cádiz','Cantabria','Castellón','Ciudad Real','Córdoba','A Coruña','Cuenca','Gipuzkoa','Girona','Granada','Guadalajara','Huelva','Huesca','Jaén','León','Lleida','Lugo','Madrid','Málaga','Murcia','Navarra','Ourense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Santa Cruz de Tenerife','Segovia','Sevilla','Soria','Tarragona','Teruel','Toledo','Valencia','Valladolid','Zamora','Zaragoza','Ceuta','Melilla'));

create domain Telefono numeric(9);

create domain Dni char(9);

create domain Web char(40)
	constraint comprobacion_web
		check(value in('%www..com%','%www..es%'));

create domain Altura numeric(3)
	constraint comprobacion_altura
		check(value between 100 and 240);

create domain Edad numeric(3)
	constraint comprobacion_edad
		check(value between 1 and 100);
		
create domain Color_ojos char(20)
	constraint comprobacion_color 
		check(value in('Azul','Verde','Marrón','Negro'));
create domain Color_pelo char(20)
	constraint comprobacion_color 
		check(value in('Castaño','Moreno','Rubio','Pelirrojo'));


create table cliente(
	cod_cliente char(20),
		primary key(cod_cliente),
	direccion char(40),
	contacto char(40),
	actividad char(2) check(actividad in ('m','pc')) 
);

create table nombre_cliente(
	cod_cliente char(20),
		foreign key(cod_cliente) references cliente,
	nombre char(20),
	apellido1 char(20),
	apellido2 char(20)
);

create table telefono_cliente(
	cod_cliente char(20),
	telefono Telefono,
	foreign key(cod_cliente) references cliente
);

create table agente_casting(
	cod_empleado char(20),
	dni Dni,
	nombre char(20),
	direccion char(40),
	primary key(cod_empleado)
);

create table casting(
	cod_casting char(20),
		primary key(cod_casting),
	nombre char(20),
	descripcion char(40),
	tipo char(1) check(tipo in ('o','p'))
);

create table casting_cliente(
	cod_casting char(20),
	cod_cliente char(20),
	foreign key(cod_casting) references casting,
	foreign key(cod_cliente) references cliente
);



create table casting_online(
	cod_casting char(20),
	num_personas int,
	fecha date,
	web Web,
	foreign key(cod_casting) references casting
);

create table casting_presencial(
	cod_casting char(20),
	num_personas int,
	fecha date,
	cod_empleado char(20),
	foreign key(cod_casting) references casting,
	foreign key(cod_empleado) references agente_casting
);

create table representante(
	dni Dni),
	nombre char(20),
	direccion char(40),
	telefono Telefono,
	primary key(dni)
);
	
create table perfil(
	cod_perfil char(20),
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
	cod_candidato char(20),
	direccion char(40),
	nacimiento date,
	importe Euros,
	dni_representante Dni,
	cod_perfil char(20),
	primary key(cod_candidato),
	foreign key(dni_representante) references representante,
	foreign key(cod_perfil) references perfil
);

create table nombre_candidato(
	cod_candidato char(20),
	nombre char(20),
	apellido1 char(20),
	apellido2 char(20),
	foreign key(cod_candidato) references candidato
);

create table telefono_candidato(
	cod_candidato char(20),
	telefono Telefono,
	foreign key(cod_candidato) references candidato
);

create table adulto(
	cod_candidato char(20),
	dni Dni,
	foreign key(cod_candidato) references candidato
);
	
create table niño(
	cod_candidato char(20),
	nombre_tutor char(20),
	foreign key(cod_candidato) references candidato
);

create table prueba(
	cod_prueba char(20),
	sala char(20),
	descripcion char(40),
	precio Euros,
	primary key(cod_prueba)
);


create table fase(
	cod_fase char(20),
	cod_casting char(20),
	primary key(cod_fase),
	foreign key(cod_casting) references casting
);

create table fase_prueba(
	cod_fase char(20),
	cod_prueba char(20),
	foreign key(cod_fase) references fase,
	foreign key(cod_prueba) references prueba
);

create table resultado_prueba(
	cod_prueba char(20),
	cod_candidato char(20),
	superada boolean,
	foreign key(cod_prueba) references prueba,
	foreign key(cod_candidato) references candidato
);





create role administrador;
create role gestor;
create role recepcionista;

				  

grant all privileges on Casting to administrador;
				   		   
grant insert,select,update,delete on adulto,agente_casting,candidato,casting_cliente,casting_online,casting_presencial,
cliente,fase,fase_prueba,niño,nombre_candidato,nombre_cliente,perfil,prueba,representante,resultado_prueba,
telefono_candidato,telefono_cliente to gestor;

grant select on adulto,agente_casting,candidato,casting_cliente,casting_online,casting_presencial,
cliente,fase,fase_prueba,niño,nombre_candidato,nombre_cliente,perfil,prueba,representante,resultado_prueba,
telefono_candidato,telefono_cliente to recepcionista;	   
				   

