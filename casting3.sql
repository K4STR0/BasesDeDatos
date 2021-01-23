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
	telefono int,
	foreign key(cod_cliente) references cliente
)

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
	foreign key(cod_empleado) references empleado
);

create table candidato(
	cod_candidato char(20),
	direccion char(40),
	telefono int,
	nacimiento date,
	importe int,
	dni_representante char(40),
	cod_perfil char(20),
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
