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
