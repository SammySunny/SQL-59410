USE cosmetologia_integral;


-- --------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS -----------------------------
-- --------------------------------------------------------


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




-- --------------------------------------------------------

-- --------------------------------------------------------