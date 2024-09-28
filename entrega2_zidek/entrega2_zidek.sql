DROP DATABASE IF EXISTS cosmetologia_integral;
CREATE DATABASE cosmetologia_integral;
USE cosmetologia_integral;


-- Tablas dimensionales--------------------------------------------------------------------------------------

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
	FOREIGN KEY (cliente) REFERENCES cliente (id_cliente)
);

-- ----------------------------------------------------------------------------------------------------------



-- Tablas de hechos -----------------------------------------------------------------------------------------


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
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_tratamiento) REFERENCES tratamiento (id_tratamiento)
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

INSERT INTO tratamiento (id_tratamiento, nombre_tratamiento, descripcion_tratamiento, precio_tratamiento, tiempo_estimado_duracion_por_sesion, empleado)
VALUES
('10','Láminado de cejas','Tratamiento especialmente indicado para cejas onduladas y/o rebeldes. Consiste en la aplicación de producto específico en toda la extensión de las cejas para alisarlas y peinarlas de forma permanente.','10000','1:30','386'),
('12','Láminado de pestañas','Tratamiento donde se consigue lucir unas pestañas más elevadas, oscuras y gruesas sin necesidad de aplicarse un rizador o rímel.','15000','1:30','367'),
('14','Tratamiento de acné x 4 sesiones','Tratamiento localizado en reducir la producción de acné, mediante uso de herramientas como Espátula Ultrasónica y Ácidos.','45000','2:00','359'),
('16','Tratamiento facial de Radiofrecuencia','Técnica no invasiva e indolora que estimula la producción de colágeno gracias a las ondas electromagnéticas que penetran en la piel.','23000','1:00','386'),
('18','Limpieza facial profunda','Tratamiento que elimina impurezas, puntos negros y células muertas de la piel del rostro. Suele incluir exfoliación, extracción, mascarilla y masaje facial.','13500','2:30','367'),
('20','Tratamiento con ácido hialurónico','Aplicación de productos que contienen ácido hialurónico para hidratar profundamente la piel y reducir líneas de expresión y arrugas.','11500','1:45','359');

INSERT INTO producto (id_producto, nombre_producto, funcion_producto)
VALUES
(100000000001, 'Sérum de ácido hialurónico', 'Hidrata profundamente la piel y reduce líneas de expresión.'),
(100000000002, 'Gel limpiador facial suave', 'Limpia la piel eliminando impurezas sin resecarla, ideal para preparación de tratamientos.'),
(100000000003, 'Tónico calmante', 'Equilibra el pH de la piel tras la limpieza y calma irritaciones.'),
(100000000004, 'Mascarilla purificante de arcilla', 'Absorbe el exceso de grasa y purifica los poros en profundidad.'),
(100000000005, 'Gel conductor para radiofrecuencia', 'Facilita la transmisión de las ondas de radiofrecuencia durante el tratamiento.'),
(100000000006, 'Crema calmante post tratamiento', 'Alivia la piel tras tratamientos intensivos, reduce rojeces e inflamación.'),
(100000000007, 'Solución antiséptica para acné', 'Desinfecta y controla el brote de acné antes de la extracción.'),
(100000000008, 'Laminador de pestañas', 'Producto especializado para el levantamiento y curvado de las pestañas.'),
(100000000009, 'Laminador de cejas', 'Fija y alisa las cejas, dándoles una forma definida y duradera.'),
(100000000010, 'Sérum hidratante post-laminado', 'Nutre y suaviza las pestañas y cejas tras el tratamiento de laminado.');

INSERT INTO producto_por_tratamiento (id_producto, id_tratamiento)
VALUES
-- Productos para "Láminado de cejas"
(100000000009, 10),  -- Laminador de cejas
(100000000010, 10),  -- Sérum hidratante post-laminado

-- Productos para "Láminado de pestañas"
(100000000008, 12),  -- Laminador de pestañas
(100000000010, 12),  -- Sérum hidratante post-laminado

-- Productos para "Tratamiento de acné x 4 sesiones"
(100000000007, 14),  -- Solución antiséptica para acné
(100000000004, 14),  -- Mascarilla purificante de arcilla

-- Productos para "Tratamiento facial de Radiofrecuencia"
(100000000005, 16),  -- Gel conductor para radiofrecuencia
(100000000006, 16),  -- Crema calmante post tratamiento

-- Productos para "Limpieza facial profunda"
(100000000002, 18),  -- Gel limpiador facial suave
(100000000003, 18),  -- Tónico calmante
(100000000004, 18),  -- Mascarilla purificante de arcilla

-- Productos para "Tratamiento con ácido hialurónico"
(100000000001, 20),  -- Sérum de ácido hialurónico
(100000000003, 20);  -- Tónico calmante

INSERT INTO cita (id_cliente, id_tratamiento, fecha, hora)
VALUES
-- Citas para Sara Collum (id_cliente: 1)
(1, 10, '2024-10-01', '09:00:00'),  -- Láminado de cejas
(1, 20, '2024-11-05', '11:00:00'),  -- Tratamiento con ácido hialurónico

-- Citas para Penelope Durdan (id_cliente: 2)
(2, 12, '2024-12-02', '10:30:00'),  -- Láminado de pestañas
(2, 18, '2024-10-10', '13:00:00'),  -- Limpieza facial profunda

-- Citas para Jeri Haskew (id_cliente: 3)
(3, 14, '2024-11-03', '14:00:00'),  -- Tratamiento de acné x 4 sesiones
(3, 16, '2024-10-12', '16:00:00'),  -- Tratamiento facial de Radiofrecuencia

-- Citas para Ravi Domel (id_cliente: 4)
(4, 18, '2024-10-04', '09:30:00'),  -- Limpieza facial profunda
(4, 16, '2024-10-15', '12:00:00'),  -- Tratamiento facial de Radiofrecuencia

-- Citas para Ofella Harmon (id_cliente: 5)
(5, 10, '2024-10-07', '08:00:00'),  -- Láminado de cejas
(5, 14, '2024-12-17', '14:30:00');  -- Tratamiento de acné x 4 sesiones

-- ----------------------------------------------------------------------------------------------------------



-- VISTAS ---------------------------------------------------------------------------------------------------

-- 1: ¿Cuántas citas y para qué tratamientos hay programadas en el Mes de Octubre? Tener en cuenta el nombre del empleado
 
CREATE VIEW cosmetologia_integral.vw_citas_y_tratamientos_octubre_2024 AS
SELECT 
    t.id_tratamiento,
    t.nombre_tratamiento,
    e.id_empleado,
    e.nombre AS nombre_empleado,
    COUNT(c.id_cita) AS total_citas
FROM 
    cita c
JOIN 
    tratamiento t ON c.id_tratamiento = t.id_tratamiento
JOIN 
    empleado e ON t.empleado = e.id_empleado
WHERE 
    c.fecha BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY 
    t.id_tratamiento, t.nombre_tratamiento;


SELECT * FROM cosmetologia_integral.vw_citas_y_tratamientos_octubre_2024; -- Para invocar la vista

-- 2: ¿Cuántas citas tiene el usuario 367 entre los meses de Octubre y Diciembre? 

CREATE VIEW cosmetologia_integral.vw_cant_citas_usuario_367_meses_10_a_12_2024 AS
SELECT COUNT(*) AS cantidad_citas
FROM cosmetologia_integral.cita c
JOIN cosmetologia_integral.tratamiento t ON c.id_tratamiento = t.id_tratamiento
WHERE t.empleado = 367 
AND c.fecha BETWEEN '2024-10-01' AND '2024-12-31';

SELECT * FROM cosmetologia_integral.vw_cant_citas_usuario_367_meses_10_a_12_2024; -- Para invocar la vista

-- ---------------------------------------------------------------------------------------------------------



-- FUNCIONES -----------------------------------------------------------------------------------------------

-- Función para consultar datos en base a usuario solicitado:

DELIMITER //

CREATE FUNCTION cosmetologia_integral.fn_obtener_datos_empleado(emp_id INT)
RETURNS VARCHAR(150)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE nombre_empleado VARCHAR(20);
    DECLARE apellido_empleado VARCHAR(20);
	DECLARE telefono_empleado VARCHAR(25);
    DECLARE resultado VARCHAR(150);
    
	-- Quiero que si se indica un nro erróneo de tratamiento, me lo indique:
    IF NOT EXISTS (SELECT 1 FROM cosmetologia_integral.empleado WHERE id_empleado = emp_id) THEN
        RETURN 'El número de empleado es incorrecto';
    END IF;
    
    SELECT 
    e.nombre, e.apellido, ce.numero
    INTO 
    nombre_empleado, apellido_empleado, telefono_empleado
    FROM
    cosmetologia_integral.empleado e
    JOIN 
	cosmetologia_integral.contacto_empleado ce ON e.id_empleado = ce.empleado
    WHERE e.id_empleado = emp_id;
    SET resultado = CONCAT(nombre_empleado, ' ', apellido_empleado, ' - Tel: ', telefono_empleado);

    RETURN resultado;
    
END //

DELIMITER ;

-- Validando: -----

SELECT cosmetologia_integral.fn_obtener_datos_empleado(386); -- Valido los datos del usuario 386
SELECT cosmetologia_integral.fn_obtener_datos_empleado(390); -- Sé que el usuario 390 no existe y quiero validar ello

-- -----------------


-- Función para saber qué productos necesito según el nro de tratamiento indicado:

DELIMITER //

CREATE FUNCTION cosmetologia_integral.fn_obtener_productos_por_tratamiento(trat_id INT)
RETURNS VARCHAR(250)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE productos_resultado VARCHAR(250);  -- Variable para almacenar el resultado

    SET productos_resultado = '';  -- Inicializa la variable de resultado
    
	-- Quiero que si se indica un nro erróneo de tratamiento, me lo indique:
    IF NOT EXISTS (SELECT 1 FROM cosmetologia_integral.tratamiento WHERE id_tratamiento = trat_id) THEN
        RETURN 'El tratamiento no existe.';
    END IF;
    
    -- Concatenar los nombres de los productos relacionados con el tratamiento
    SELECT GROUP_CONCAT(p.nombre_producto SEPARATOR ', ') INTO productos_resultado
    FROM cosmetologia_integral.producto p
    JOIN cosmetologia_integral.producto_por_tratamiento pf ON p.id_producto = pf.id_producto
    WHERE pf.id_tratamiento = trat_id;

    -- Si no hay productos asociados:
    IF productos_resultado IS NULL OR productos_resultado = '' THEN
        RETURN 'No hay productos asociados a este tratamiento.';
    ELSE
        RETURN productos_resultado;

    END IF;

END //

DELIMITER ;

-- Validando: -----

SELECT cosmetologia_integral.fn_obtener_productos_por_tratamiento(10); -- Traeme los productos que sirvan para el tratamiento 10
SELECT cosmetologia_integral.fn_obtener_productos_por_tratamiento(11); -- Yo sé que no existe un tratamiento 11, debe validarme eso

-- -----------------

-- ----------------------------------------------------------------------------------------------------------




-- STORED PROCEDURES -----------------------------------------------------------------------------------------------


-- Procedimiento para poder agregar nueva Cita:

DELIMITER //

CREATE PROCEDURE cosmetologia_integral.sp_agregar_cita(
    IN p_id_cliente INT,
    IN p_id_tratamiento INT,
    IN p_fecha DATE,
    IN p_hora TIME
)
BEGIN
    INSERT INTO cosmetologia_integral.cita (id_cliente, id_tratamiento, fecha, hora)
    VALUES (p_id_cliente, p_id_tratamiento, p_fecha, p_hora);
END //

DELIMITER ;

-- Llamando al procedimiento y verificándolo --

CALL cosmetologia_integral.sp_agregar_cita(1, 20, '2024-10-01', '10:00:00'); -- Cita agregada
SELECT * FROM cosmetologia_integral.cita WHERE id_cliente=1 AND id_tratamiento=20; -- Corroboro que se haya agregado

-- --------------------------------------------


-- Procedimiento para actualizar datos de empleado según su id_empleado/usuario empleado:

DELIMITER //

CREATE PROCEDURE cosmetologia_integral.sp_actualizar_contacto_empleado_por_id(
    IN p_id_empleado INT,
    IN p_numero VARCHAR(25),
    IN p_email VARCHAR(250)
)
BEGIN
    UPDATE cosmetologia_integral.contacto_empleado
    SET numero = p_numero,
        email = p_email
    WHERE empleado = p_id_empleado; 
END //

DELIMITER ;

-- Llamando al procedimiento y verificándolo --

CALL cosmetologia_integral.sp_actualizar_contacto_empleado_por_id(367, '1189636563', 'daianemuller@cosmeticaintegral.com.ar'); -- Datos que quiero actualizar

-- SHOW PROCEDURE STATUS WHERE Db = 'cosmetologia_integral';  -- > Me lo dejo anotado para mi, es para verificar que el procedimiento exista.

SELECT * FROM cosmetologia_integral.contacto_empleado WHERE empleado=367; -- Consulto que la tabla haya sido modificada

-- --------------------------------------------


-- ----------------------------------------------------------------------------------------------------------