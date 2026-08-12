-- Trigger de Control de Rangos de Identificación
-- Impide insertar nuevos registros en la tabla establecimientos si el el 
-- establecimiento_id se encuentro dentro del rango reservado para uso gubernamental
-- exclusivo (10000000 - 50000000 inclusive), cancelando la operación.

USE farmaprod;
 
 DROP TRIGGER IF EXISTS trg_control_rangos_id;
 
DELIMITER $$
CREATE TRIGGER trg_control_rangos_id
BEFORE INSERT ON establecimiento
FOR EACH ROW
BEGIN
    IF NEW.establecimiento_id BETWEEN 10000000 AND 50000000 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                'El ID se encuentra en el rango reservado para uso gubernamental (10.000.000 - 50.000.000). Operación cancelada.';
    END IF;
END$$
DELIMITER ;

-- EJEMPLO USADO QUE FALLA:
-- INSERT INTO establecimiento 
-- 		(establecimiento_id, establecimiento_nombre, localidad_id, tipologia_id)
-- VALUES 
-- 		(10000000, 'RANGO MIN', 2000010000, 71);

-- EJEMPLO USADO QUE NO FALLA:
-- INSERT INTO establecimiento
-- 		(establecimiento_id, establecimiento_nombre, localidad_id, tipologia_id)
-- VALUES 
-- 		(5000006658, 'DROGUERIA OK RANGO', 2000010000, 71);
