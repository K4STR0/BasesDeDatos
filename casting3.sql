create domain Euros numeric(12,2);
create domain Provincias char(20)
	constraint comprobacion_provincia
		check(value in('Albacete','Alicante','Almería','Álava','Asturias','Ávila','Badajoz','Islas Baleares','Barcelona','Bizkaia','Burgos','Cáceres','Cádiz','Cantabria','Castellón','Ciudad Real','Córdoba','A Coruña','Cuenca','Gipuzkoa','Girona','Granada','Guadalajara','Huelva','Huesca','Jaén','León','Lleida','Lugo','Madrid','Málaga','Murcia','Navarra','Ourense','Palencia','Las Palmas','Pontevedra','La Rioja','Salamanca','Santa Cruz de Tenerife','Segovia','Sevilla','Soria','Tarragona','Teruel','Toledo','Valencia','Valladolid','Zamora','Zaragoza','Ceuta','Melilla'));
create domain Telefono numeric(9);



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
	dni char(40),
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
	web char(40),
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
	dni char(40),
	nombre char(20),
	direccion char(40),
	telefono Telefono,
	primary key(dni)
);
	
create table perfil(
	cod_perfil char(20),
	provincia Provincias,
	sexo char (1) check(sexo in('M','F')),
	rango_edad char(10),
	rango_altura char(10),
	color_pelo char(10),
	color_ojos char(10),
	especialidad char(1) check(especialidad in('A','M')),
	experiencia boolean,
	primary key(cod_perfil)
);

create table candidato(
	cod_candidato char(20),
	direccion char(40),
	nacimiento date,
	importe Euros,
	dni_representante char(40),
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
	dni char(40),
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

	
	




























