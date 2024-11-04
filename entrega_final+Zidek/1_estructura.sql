DROP DATABASE IF EXISTS cosmetologia_integral;
CREATE DATABASE cosmetologia_integral;
USE cosmetologia_integral;

-- -----------------------------------------------
-- Tablas dimensionales---------------------------
-- -----------------------------------------------

CREATE TABLE cosmetologia_integral.empleado(
	id_empleado INT NOT NULL UNIQUE,
    dni VARCHAR(11),
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    PRIMARY KEY (id_empleado)
);

CREATE TABLE cosmetologia_integral.contacto_empleado(
	id_contacto_empleado INT NOT NULL AUTO_INCREMENT,
	numero VARCHAR(25),
	email VARCHAR(250),
    empleado INT, -- FK
	PRIMARY KEY (id_contacto_empleado),
	FOREIGN KEY (empleado) REFERENCES empleado (id_empleado)
);


CREATE TABLE cosmetologia_integral.tratamiento(
	id_tratamiento INT NOT NULL UNIQUE,
    nombre_tratamiento VARCHAR (100),
    descripcion_tratamiento VARCHAR (250),
    precio_tratamiento NUMERIC (10,2),
    tiempo_estimado_duracion_por_sesion TIME, -- En formato HH:MM:SS
    empleado INT, -- FK
    PRIMARY KEY (id_tratamiento),
    FOREIGN KEY (empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE cosmetologia_integral.producto(
	id_producto BIGINT NOT NULL UNIQUE, -- id_producto debe ser un cód. barras
    nombre_producto VARCHAR (100),
    funcion_producto VARCHAR (250),
    PRIMARY KEY (id_producto)
);

CREATE TABLE cosmetologia_integral.stock_producto (
    id_stock INT NOT NULL AUTO_INCREMENT,
    id_producto BIGINT NOT NULL, -- FK
    cantidad INT NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_vencimiento DATE,
    PRIMARY KEY (id_stock),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE cosmetologia_integral.cliente(
	id_cliente INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR (20),
    apellido VARCHAR(20),
	PRIMARY KEY (id_cliente)
);


CREATE TABLE cosmetologia_integral.contacto_cliente(
	id_contacto_cliente INT NOT NULL AUTO_INCREMENT,
	numero VARCHAR(25),
	email VARCHAR (250),
    cliente INT, -- FK
	PRIMARY KEY (id_contacto_cliente),
	FOREIGN KEY (cliente) REFERENCES cliente (id_cliente) ON DELETE CASCADE
);

CREATE TABLE cosmetologia_integral.forma_pago_aceptadas (
    id_forma_pago INT NOT NULL AUTO_INCREMENT,
    tipo_pago VARCHAR(50),
    descripcion VARCHAR(250),
    PRIMARY KEY (id_forma_pago)
);


-- -----------------------------------------------
-- Tablas de hechos ------------------------------
-- -----------------------------------------------

CREATE TABLE cosmetologia_integral.producto_por_tratamiento(
	id_producto_por_tratamiento INT NOT NULL AUTO_INCREMENT,
	id_producto BIGINT NOT NULL, -- FK
    id_tratamiento INT NOT NULL, -- FK
    PRIMARY KEY (id_producto_por_tratamiento),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto),
	FOREIGN KEY (id_tratamiento) REFERENCES tratamiento (id_tratamiento)
);


CREATE TABLE cosmetologia_integral.cita(
	id_cita INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL, -- FK
    id_tratamiento INT NOT NULL, -- FK
	fecha DATE NOT NULL,
    hora TIME NOT NULL,
    PRIMARY KEY (id_cita),
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) ON DELETE CASCADE,
	FOREIGN KEY (id_tratamiento) REFERENCES tratamiento (id_tratamiento)
);



-- -----------------------------------------------
-- Tablas de Transacciones ------------------------------
-- -----------------------------------------------


CREATE TABLE cosmetologia_integral.cita_pago (
    id_pago INT NOT NULL AUTO_INCREMENT,
    id_cita INT NOT NULL, -- FK hacia la tabla de citas
    id_forma_pago INT NOT NULL, -- FK hacia forma_pago_aceptadas
    monto NUMERIC(10,2),
    metodo_pago VARCHAR(50), -- Efectivo, Tarjeta, etc.
    fecha_pago DATE NOT NULL,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_cita) REFERENCES cita (id_cita) ON DELETE CASCADE,
    FOREIGN KEY (id_forma_pago) REFERENCES cosmetologia_integral.forma_pago_aceptadas (id_forma_pago) ON DELETE CASCADE
);

CREATE TABLE cosmetologia_integral.citas_canceladas (
    id_cancelacion INT NOT NULL AUTO_INCREMENT,
    id_cita INT NOT NULL, -- FK de cita
    fecha_cancelacion DATE NOT NULL,
    motivo VARCHAR(250),
    PRIMARY KEY (id_cancelacion),
    FOREIGN KEY (id_cita) REFERENCES cosmetologia_integral.cita(id_cita) ON DELETE CASCADE
);

CREATE TABLE cosmetologia_integral.tratamiento_cliente (
    id_tratamiento_cliente INT NOT NULL AUTO_INCREMENT,
    id_cita INT NOT NULL, -- FK de la cita
    id_empleado INT NOT NULL, -- FK del empleado que realizó el tratamiento
    fecha_tratamiento DATE NOT NULL,
    duracion TIME NOT NULL,
    PRIMARY KEY (id_tratamiento_cliente),
    FOREIGN KEY (id_cita) REFERENCES cosmetologia_integral.cita(id_cita) ON DELETE CASCADE,
    FOREIGN KEY (id_empleado) REFERENCES cosmetologia_integral.empleado(id_empleado) ON DELETE CASCADE
);

-- -----------------------------------------------
-- Tablas de Auditoría ---------------------------
-- -----------------------------------------------

-- Tabla de auditoría para la tabla 'contacto_empleado':
CREATE TABLE cosmetologia_integral.auditoria_contacto_empleado (
    id_auditoria INT NOT NULL AUTO_INCREMENT,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,  -- Acción registrada (INSERT, UPDATE, DELETE)
    id_contacto_empleado INT,                             -- ID del contacto de empleado afectado
    numero_anterior VARCHAR(25),                          -- Número de contacto anterior (para UPDATE)
    numero_nuevo VARCHAR(25),                             -- Número de contacto nuevo (para INSERT o UPDATE)
    email_anterior VARCHAR(250),                          -- Email anterior (para UPDATE)
    email_nuevo VARCHAR(250),                             -- Email nuevo (para INSERT o UPDATE)
    empleado INT,                                         -- ID del empleado asociado
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,            -- Fecha y hora de la acción
    PRIMARY KEY (id_auditoria)
    -- Comentado para evitar problemas de integridad en la auditoría, ya que al querer eliminar valores, no me permitirá utilizando una llave foránea
    -- FOREIGN KEY (id_contacto_empleado) REFERENCES cosmetologia_integral.contacto_empleado(id_contacto_empleado)
);


-- Tabla de auditoría para la tabla 'cliente':
CREATE TABLE cosmetologia_integral.auditoria_cliente (
    id_auditoria INT NOT NULL AUTO_INCREMENT,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,  -- Acción realizada: INSERT, UPDATE, DELETE
    id_cliente INT,                                      -- ID del cliente afectado
    nombre_anterior VARCHAR(20),                         -- Nombre antes de la modificación (para UPDATE)
    nombre_nuevo VARCHAR(20),                            -- Nombre después de la modificación (para INSERT o UPDATE)
    apellido_anterior VARCHAR(20),                       -- Apellido antes de la modificación (para UPDATE)
    apellido_nuevo VARCHAR(20),                          -- Apellido después de la modificación (para INSERT o UPDATE)
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,           -- Fecha y hora de la acción
    PRIMARY KEY (id_auditoria)
);




