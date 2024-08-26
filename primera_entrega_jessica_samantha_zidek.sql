create database cosmetologia_integral;
use cosmetologia_integral;

-- Tablas dimensionales--------------------------------------------------------------------------------------

create table empleado(
	id_empleado int not null unique,
    dni varchar(11),
    nombre varchar (20),
    apellido varchar(20),
    primary key (id_empleado)
);

create table contacto_empleado(
	id_contacto_empleado int not null auto_increment,
	numero varchar(25),
	email varchar (250),
    empleado int, -- FK
	primary key (id_contacto_empleado),
	foreign key (empleado) references empleado (id_empleado)
);


create table tratamiento(
	id_tratamiento int not null unique,
    nombre_tratamiento varchar (100),
    descripcion_tratamiento varchar (250),
    precio_tratamiento numeric (10,2),
    empleado int, -- FK
    primary key (id_tratamiento),
    foreign key (empleado) references empleado (id_empleado)
);


create table cliente(
	id_cliente int not null auto_increment,
    nombre varchar (20),
    apellido varchar(20),
	primary key (id_cliente)
);


create table contacto_cliente(
	id_contacto_cliente int not null auto_increment,
	numero varchar(25),
	email varchar (250),
    cliente int, -- FK
	primary key (id_contacto_cliente),
	foreign key (cliente) references cliente (id_cliente)
);

-- ---------------------------------------------------------------------------------------------------------


-- Tablas de hechos-----------------------------------------------------------------------------------------


create table cita(
	id_cita int not null auto_increment,
    id_cliente int not null, -- FK
    id_tratamiento int not null, -- FK
	fecha date not null,
    hora time not null,
    primary key (id_cita),
    foreign key (id_cliente) references cliente (id_cliente),
	foreign key (id_tratamiento) references tratamiento (id_tratamiento)
);


-- ---------------------------------------------------------------------------------------------------------

-- Datos insertados a tablas -------------------------------------------------------------------------------


INSERT INTO cliente (id_cliente, nombre, apellido)
VALUES
(1,'Sara', 'Collum'),
(2,'Penelope', 'Durdan'),
(3, 'Jeri', 'Haskew'),
(4, 'Ravi', 'Domel'),
(5, 'Ofella', 'Harmon');


INSERT INTO contacto_cliente (numero, email, cliente)
VALUES
('1009931032', 'sgarthshore0@xrea.com',1),
('8362499230', 'pthickin1@feedburner.com',2),
('6312821315', 'jburet2@paginegialle.it',3),
('4413313968', 'rpoole3@storify.com',4),
('9095897354', 'oornils4@delicious.com',5),
('5211518837', 'apratt0@hibu.com', 3),
('4151655557', 'chryniewicz1@pinterest.com', 2),
('2189158834', 'aveeler2@boston.com', 2);

INSERT INTO empleado (id_empleado,dni, nombre, apellido)
VALUES
('386','38658152', 'Jane', 'Schwartz'),
('367','36789654', 'Daiane', 'Muller'),
('359','35989631', 'Sarah', 'Goldenbear');

INSERT INTO contacto_empleado (numero, email, empleado)
VALUES 
('1168964578', 'jschwartz@cosmeticaintegral.com.ar', '386'),
('1165612353', 'dmuller@cosmeticaintegral.com.ar', '367'),
('1112563214', 'sgoldenbear@cosmeticaintegral.com.ar', '359');

INSERT INTO tratamiento (id_tratamiento, nombre_tratamiento, descripcion_tratamiento, precio_tratamiento, empleado)
VALUES
('10','Láminado de cejas','Tratamiento especialmente indicado para cejas onduladas y/o rebeldes. Consiste en la aplicación de producto específico en toda la extensión de las cejas para alisarlas y peinarlas de forma permanente.','10000','386'),
('12','Láminado de pestañas','Tratamiento donde se consigue lucir unas pestañas más elevadas, oscuras y gruesas sin necesidad de aplicarse un rizador o rímel.','15000','367'),
('14','Tratamiento de acné x 4 sesiones','Tratamiento localizado en reducir la producción de acné, mediante uso de herramientas como Espátula Ultrasónica y Ácidos.','45000','359'),
('16','Tratamiento facial de Radiofrecuencia','Técnica no invasiva e indolora que estimula la producción de colágeno gracias a las ondas electromagnéticas que penetran en la piel.','24000','386');

-- ---------------------------------------------------------------------------------------------------------
