USE cosmetologia_integral;


-- -------------------------------------------------
-- FUNCIONES CONSULTAS -----------------------------
-- -------------------------------------------------

-- Función para consultar datos en base a usuario solicitado:

-- Validando: -----

SELECT cosmetologia_integral.fn_obtener_datos_empleado(386); -- Valido los datos del usuario 386
SELECT cosmetologia_integral.fn_obtener_datos_empleado(390); -- Sé que el usuario 390 no existe y quiero validar ello

-- -----------------


-- Función para saber qué productos necesito según el nro de tratamiento indicado:

-- Validando: -----

SELECT cosmetologia_integral.fn_obtener_productos_por_tratamiento(10); -- Traeme los productos que sirvan para el tratamiento 10
SELECT cosmetologia_integral.fn_obtener_productos_por_tratamiento(11); -- Yo sé que no existe un tratamiento 11, debe validarme eso

-- -----------------