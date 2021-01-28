create domain Euros numeric(12,2);

create domain Provincias varchar(20)
	constraint comprobacion_provincia
		check(value in('Albacete','Alicante','Almería','Álava','Asturias','Ávila','Badajoz','Islas Baleares','Barcelona','Bizkaia','Burgos','Cáceres','Cádiz','Cantabria','Castellón','Ciudad Real','Córdoba','A Coruña','Cuenca','Gipuzkoa','Girona','Granada','Guadalajara','Huelva','Huesca','Jaén','León','Lleida','Lugo','Madrid','Málaga','Murcia','Navarra','Ourense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Santa Cruz de Tenerife','Segovia','Sevilla','Soria','Tarragona','Teruel','Toledo','Valencia','Valladolid','Zamora','Zaragoza','Ceuta','Melilla'));

create domain Telefono numeric(9);

create domain Dni char(9);

create domain Web varchar(40)
	constraint comprobacion_web
		check(value in('%www..com%','%www..es%'));

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


create table cliente(
	cod_cliente varchar(20),
		primary key(cod_cliente),
	direccion varchar(40),
	contacto varchar(40),
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
	fecha date,
	cod_empleado varchar(20),
	foreign key(cod_casting) references casting,
	foreign key(cod_empleado) references agente_casting
);

create table representante(
	dni Dni),
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
	cod_fase varchar(20),
	cod_casting varchar(20),
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
	cod_cliente varchar(20),
	cod_casting varchar(20),
	foreign key(cod_cliente) references cliente,
	foreign key(cod_casting) references casting
);

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
				   

