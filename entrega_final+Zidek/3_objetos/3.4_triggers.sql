USE cosmetologia_integral;


-- -----------------------------------------------
-- TRIGGERS --------------------------------------
-- -----------------------------------------------


-- ****************************************** TRIGGERS PARA TABLA 'contacto_empleado' ******************************************

-- Trigger de validación de datos duplicados:

DELIMITER //

CREATE TRIGGER trg_validar_duplicados_contacto_empleado
BEFORE INSERT ON cosmetologia_integral.contacto_empleado
FOR EACH ROW
BEGIN
    -- Verifica si ya existe un número de contacto duplicado
    IF EXISTS (
        SELECT 1 FROM cosmetologia_integral.contacto_empleado 
        WHERE numero = NEW.numero
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El número de contacto ya existe.';
    END IF;

    -- Verifica si ya existe un correo electrónico duplicado
    IF EXISTS (
        SELECT 1 FROM cosmetologia_integral.contacto_empleado 
        WHERE email = NEW.email
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El correo electrónico ya existe.';
    END IF;
END //


-- Trigger para validar que el nro de teléfono corresponda:

CREATE TRIGGER trg_validar_numero_contacto_empleado
BEFORE INSERT ON cosmetologia_integral.contacto_empleado
FOR EACH ROW
BEGIN
    -- Valida que el número no esté vacío
    IF NEW.numero IS NULL OR CHAR_LENGTH(NEW.numero) < 8 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El número de contacto debe tener al menos 8 carácteres.';
    END IF;
    
    -- Opcional: Valida que el formato sea numérico
    IF NOT NEW.numero REGEXP '^[0-9]+$' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: El número de contacto debe contener solo dígitos.';
    END IF;
END //


-- Trigger para auditar inserciones

CREATE TRIGGER trg_contacto_empleado_tras_insertar
AFTER INSERT ON cosmetologia_integral.contacto_empleado
FOR EACH ROW
BEGIN
    INSERT INTO cosmetologia_integral.auditoria_contacto_empleado (
        accion, id_contacto_empleado, numero_anterior, numero_nuevo, email_anterior, email_nuevo, empleado, fecha
    ) 
    VALUES (
        'INSERT', NEW.id_contacto_empleado, NULL, NEW.numero, NULL, NEW.email, NEW.empleado, NOW()
    );
END //

-- Trigger para auditar actualizaciones

CREATE TRIGGER trg_contacto_empleado_tras_actualizar
AFTER UPDATE ON cosmetologia_integral.contacto_empleado
FOR EACH ROW
BEGIN
    INSERT INTO cosmetologia_integral.auditoria_contacto_empleado (
        accion, id_contacto_empleado, numero_anterior, numero_nuevo, email_anterior, email_nuevo, empleado, fecha
    )
    VALUES (
        'UPDATE', NEW.id_contacto_empleado, OLD.numero, NEW.numero, OLD.email, NEW.email, NEW.empleado, NOW()
    );
END //

-- Trigger para auditar eliminaciones

CREATE TRIGGER trg_contacto_empleado_tras_eliminar
AFTER DELETE ON cosmetologia_integral.contacto_empleado
FOR EACH ROW
BEGIN
    INSERT INTO cosmetologia_integral.auditoria_contacto_empleado (
        accion, id_contacto_empleado, numero_anterior, numero_nuevo, email_anterior, email_nuevo, empleado, fecha
    ) 
    VALUES (
        'DELETE', OLD.id_contacto_empleado, OLD.numero, NULL, OLD.email, NULL, OLD.empleado, NOW()
    );
END //

DELIMITER ;




-- ****************************************** TRIGGERS PARA TABLA 'cliente' ******************************************


-- Trigger de validación de validación:

DELIMITER //

CREATE TRIGGER trg_cliente_validar
BEFORE INSERT ON cosmetologia_integral.cliente
FOR EACH ROW
BEGIN
    -- Validación: comprobar que el nombre no esté vacío y no exceda 20 caracteres
    IF NEW.nombre IS NULL OR NEW.nombre = '' OR CHAR_LENGTH(NEW.nombre) > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre debe ser un valor no vacío y no exceder 20 caracteres.';
    END IF;

    -- Validación: comprobar que el apellido no esté vacío y no exceda 20 caracteres
    IF NEW.apellido IS NULL OR NEW.apellido = '' OR CHAR_LENGTH(NEW.apellido) > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El apellido debe ser un valor no vacío y no exceder 20 caracteres.';
    END IF;

    -- Validación: comprobar que el cliente no haya sido eliminado anteriormente
    IF EXISTS (SELECT 1 FROM cosmetologia_integral.auditoria_cliente 
               WHERE id_cliente = NEW.id_cliente AND accion = 'DELETE') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede insertar un cliente que ha sido eliminado anteriormente.';
    END IF;
END //

CREATE TRIGGER trg_cliente_validar_update
BEFORE UPDATE ON cosmetologia_integral.cliente
FOR EACH ROW
BEGIN
    -- Validación: comprobar que el nuevo nombre no esté vacío y no exceda 20 caracteres
    IF NEW.nombre IS NULL OR NEW.nombre = '' OR CHAR_LENGTH(NEW.nombre) > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nombre debe ser un valor no vacío y no exceder 20 caracteres.';
    END IF;

    -- Validación: comprobar que el nuevo apellido no esté vacío y no exceda 20 caracteres
    IF NEW.apellido IS NULL OR NEW.apellido = '' OR CHAR_LENGTH(NEW.apellido) > 20 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El apellido debe ser un valor no vacío y no exceder 20 caracteres.';
    END IF;

    -- Validación: comprobar que el cliente no haya sido eliminado anteriormente
    IF EXISTS (SELECT 1 FROM cosmetologia_integral.auditoria_cliente 
               WHERE id_cliente = NEW.id_cliente AND accion = 'DELETE') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede actualizar un cliente que ha sido eliminado anteriormente.';
    END IF;
END //

DELIMITER ;


-- Trigger para auditar inserciones

DELIMITER //

CREATE TRIGGER trg_cliente_tras_insertar
AFTER INSERT ON cosmetologia_integral.cliente
FOR EACH ROW
BEGIN
    INSERT INTO cosmetologia_integral.auditoria_cliente (
        accion, id_cliente, nombre_anterior, nombre_nuevo, apellido_anterior, apellido_nuevo, fecha
    ) 
    VALUES (
        'INSERT', NEW.id_cliente, NULL, NEW.nombre, NULL, NEW.apellido, NOW()
    );
END //


-- Trigger para auditar actualizaciones

CREATE TRIGGER trg_cliente_tras_actualizar
AFTER UPDATE ON cosmetologia_integral.cliente
FOR EACH ROW
BEGIN
    INSERT INTO cosmetologia_integral.auditoria_cliente (
        accion, id_cliente, nombre_anterior, nombre_nuevo, apellido_anterior, apellido_nuevo, fecha
    )
    VALUES (
        'UPDATE', NEW.id_cliente, OLD.nombre, NEW.nombre, OLD.apellido, NEW.apellido, NOW()
    );
END //


-- Trigger para auditar eliminaciones

CREATE TRIGGER trg_cliente_tras_eliminar
AFTER DELETE ON cosmetologia_integral.cliente
FOR EACH ROW
BEGIN
    INSERT INTO cosmetologia_integral.auditoria_cliente (
        accion, id_cliente, nombre_anterior, nombre_nuevo, apellido_anterior, apellido_nuevo, fecha
    ) 
    VALUES (
        'DELETE', OLD.id_cliente, OLD.nombre, NULL, OLD.apellido, NULL, NOW()
    );
END //

DELIMITER ;


-- -----------------------------------------------

-- -----------------------------------------------



