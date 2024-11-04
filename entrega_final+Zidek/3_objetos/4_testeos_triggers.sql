USE cosmetologia_integral;


-- ************************************************************************************

-- 							TESTEOS PARA TRIGGERS

-- ************************************************************************************

/* No sé si la solución para poder evitar que no se bloquee la ejecución del código tras
dar mensaje de error debido a los Triggers que validan que no haya datos duplicados o
mal escritos es la correcta. Por lo que estuve investigando, ésto se debe a los SIGNAL
SQLSTATE que están colocados en los Triggers y que en MySQL, cuando un SIGNAL SQLSTATE 
provoca un error, no hay forma directa de continuar con el siguiente bloque dentro de 
la misma sesión de ejecución o transacción.*/


-- ****************************************** TABLA 'contacto_empleado' ******************************************



/* Comprobando el Trigger de validación, éste trigger debe fallarme, 
pero al fallar me paraba la ejecución de la prueba, así que la mejor
forma que encontré para que no realice eso, fue generando un procedimiento.
En el mismo pido que me indique el error que da el intento de inserción de
datos y que se va a continuar con el procedimiento: */

DELIMITER //

CREATE PROCEDURE prueba_insert()
BEGIN
    DECLARE error_msg VARCHAR(255);

    -- Maneja el error y continúa, almacenando el mensaje del error
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 error_msg = MESSAGE_TEXT;
        -- Mostrar el mensaje de error capturado
        SELECT CONCAT('Error atrapado: ', error_msg) AS error_mensaje;
    END;

    -- Intento de inserción que podría fallar
    INSERT INTO cosmetologia_integral.contacto_empleado (numero, email, empleado) 
    VALUES ('123', 'email@ejemplo.com', 386);

    -- Mensaje para indicar que la ejecución continúa después del error
    SELECT 'La inserción se intentó, la ejecución continúa con las siguientes sentencias.' AS estado;
END//

DELIMITER ;

-- Llamo al procedimiento generado para la prueba:

CALL prueba_insert();

/* Aquí comienzo una transacción para que se realicen las pruebas,
las cuales quiero que luego no afecten mi tabla real:*/

START TRANSACTION;
-- Si inserto valores:

INSERT INTO cosmetologia_integral.contacto_empleado (numero, email, empleado) 
VALUES ('1234567890', 'nuevo@ejemplo.com', 386);

-- Si actualizo valores:

UPDATE cosmetologia_integral.contacto_empleado 
SET numero = '0987654321', email = 'actualizado@ejemplo.com' 
WHERE id_contacto_empleado = 1;  -- Asumiendo que el ID del contacto es 1

-- Si elimino valores:

DELETE FROM cosmetologia_integral.contacto_empleado 
WHERE id_contacto_empleado = 1;  -- Asumiendo que el ID del contacto es 1


-- Para ver los cambios en la tabla de auditoría: 

SELECT * FROM cosmetologia_integral.auditoria_contacto_empleado 
ORDER BY fecha DESC;

ROLLBACK;-- Aplico ROLLBACK tras la consulta a la tabla de auditoría, así se observan los cambios y luego, al consultar la tabla real, se mantienen los datos originales.


-- Para consultar la tabla original:

SELECT * FROM cosmetologia_integral.contacto_empleado;

-- ******************************************


-- ****************************************** TABLA 'cliente' ******************************************

/* Aquí comienzo una transacción para que se realicen las pruebas,
las cuales quiero que luego no afecten mi tabla real:*/

START TRANSACTION;

-- Si agrego un nuevo cliente:

INSERT INTO cosmetologia_integral.cliente (nombre, apellido) VALUES ('María', 'González');

-- Si actualizo un cliente:

UPDATE cosmetologia_integral.cliente SET nombre = 'Juan Carlos' WHERE id_cliente = 1;

-- Si elimino un cliente:
DELETE FROM cosmetologia_integral.cliente WHERE id_cliente = 1; -- Se resolvió el poder eliminar registro, colocando ON DELETE CASCADE en tablas 'cita' y 'contacto_cliente'


-- Para ver los cambios en la tabla de auditoría: 

SELECT * FROM cosmetologia_integral.auditoria_cliente
ORDER BY fecha DESC;

ROLLBACK; -- Aplico ROLLBACK tras la consulta a la tabla de auditoría, así se observan los cambios y luego, al consultar la tabla real, se mantienen los datos originales.

-- Para consultar la tabla original:

SELECT * FROM cosmetologia_integral.cliente;

-- ******************************************


