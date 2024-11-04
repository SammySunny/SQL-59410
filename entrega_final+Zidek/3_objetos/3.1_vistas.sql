USE cosmetologia_integral;

-- -----------------------------------------------
-- VISTAS ----------------------------------------
-- -----------------------------------------------

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



-- 2: ¿Cuántas citas tiene el usuario 367 entre los meses de Octubre y Diciembre? 

CREATE VIEW cosmetologia_integral.vw_cant_citas_usuario_367_meses_10_a_12_2024 AS
SELECT COUNT(*) AS cantidad_citas
FROM cosmetologia_integral.cita c
JOIN cosmetologia_integral.tratamiento t ON c.id_tratamiento = t.id_tratamiento
WHERE t.empleado = 367 
AND c.fecha BETWEEN '2024-10-01' AND '2024-12-31';




-- 3: Quiero saber qué productos tenemos y su stock correspondiente:

CREATE VIEW vw_productos_stock AS
SELECT p.id_producto, p.nombre_producto, s.cantidad, s.fecha_entrada, s.fecha_vencimiento
FROM producto p
JOIN stock_producto s ON p.id_producto = s.id_producto;




-- 4: Quiero saber las cancelaciones que hemos tenido de citas: 

CREATE VIEW vw_cancelaciones_citas AS
SELECT cc.id_cancelacion, c.fecha AS fecha_cita, cc.fecha_cancelacion, cc.motivo
FROM citas_canceladas cc
JOIN cita c ON cc.id_cita = c.id_cita;




-- 5: Quiero saber métodos de pago y qué frecuencia tienen:

CREATE VIEW vw_frecuencia_metodos_pago AS
SELECT metodo_pago, COUNT(*) AS cantidad
FROM cita_pago
GROUP BY metodo_pago
ORDER BY metodo_pago;




-- 6: Quiero saber, de las citas abonadas, el tratamiento realizado, su precio y método de pago utilizado por el cliente. Que esté ordenado por método de pago:


CREATE VIEW vw_detalle_citas AS
SELECT 
    c.id_cita,                 -- ID de la cita
    t.nombre_tratamiento,      -- Nombre del tratamiento
    t.precio_tratamiento,      -- Monto del tratamiento
    cp.metodo_pago              -- Método de pago utilizado
FROM cita c
JOIN tratamiento t ON c.id_tratamiento = t.id_tratamiento
JOIN cita_pago cp ON c.id_cita = cp.id_cita -- Unir con cita_pago para obtener el método de pago
ORDER BY cp.metodo_pago;  -- Asegúrate de ordenar por el alias de la tabla cita_pago




-- -----------------------------------------------

-- -----------------------------------------------