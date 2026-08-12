-- Trigger de Sanitización y Políticas de Nombre
-- Valida el nombre de la droguería antes de insertarlo o actualizarlo. 
-- No permite nombres de establecimientos que contengan únicamente números, que estén vacíos, o que
-- uncluyan las palabras reservadas: 'PRUEBA', 'TEST', 'SINDATO', 'NINGUNO'.
-- En caso de detectarse, se debe revertir la transacción y retornar un mensaje del rechazo.

USE farmaprod;
 
DROP TRIGGER IF EXISTS trg_sanitizar_nombre_inserciones;
DROP TRIGGER IF EXISTS trg_sanitizar_nombre_actualizaciones;
DROP PROCEDURE IF EXISTS p_validar_establecimiento_nombre;
 
DELIMITER $$
CREATE PROCEDURE p_validar_establecimiento_nombre (IN p_nombre VARCHAR(100))
BEGIN
    DECLARE valor_nombre VARCHAR(100);
    SET valor_nombre = UPPER(TRIM(IFNULL(p_nombre, '')));
 
	-- Regla 1: Nombre vacío o Null
    IF valor_nombre = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nombre rechazado: El nombre del establecimiento no puede estar vacio.';
	END IF;
    
    -- Regla 2: Contiene números 
    IF valor_nombre REGEXP '^[0-9]+$' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nombre rechazado: El nombre del establecimiento no puede estar unicamente compuesto por numeros.';
	END IF;
    
    -- Regla 3: Incluye palabras reservadas
    IF UPPER(valor_nombre) LIKE '%PRUEBA%'
        OR UPPER(valor_nombre) LIKE '%TEST%'
        OR UPPER(valor_nombre) LIKE '%SINDATO%'
        OR UPPER(valor_nombre) LIKE '%NINGUNO%' 
        THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nombre rechazado: No puede contener palabras reservadas (PRUEBA, TEST, SINDATO, NINGUNO).';
    END IF;
END$$
 
CREATE TRIGGER trg_sanitizar_nombre_inserciones
BEFORE INSERT ON establecimiento
FOR EACH ROW
BEGIN
	CALL p_validar_establecimiento_nombre(NEW.establecimiento_nombre);
END$$
 
CREATE TRIGGER trg_sanitizar_nombre_actualizaciones
BEFORE UPDATE ON establecimiento
FOR EACH ROW
BEGIN
	CALL p_validar_establecimiento_nombre(NEW.establecimiento_nombre);
END$$
DELIMITER ;


-- EJEMPLO USADO QUE FALLA:
-- Contiene solo núms:
-- INSERT INTO establecimiento 
-- VALUES
-- 		(88888882, '12345', NULL, '1000', 2000010000, 1, 6);
