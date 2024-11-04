USE cosmetologia_integral;


-- -----------------------------------------------
-- FUNCIONES -------------------------------------
-- -----------------------------------------------


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

-- -----------------------------------------------

-- -----------------------------------------------