USE cosmetologia_integral;


-- -----------------------------------------------
-- STORED PROCEDURES -----------------------------
-- -----------------------------------------------


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


-- -----------------------------------------------

-- -----------------------------------------------