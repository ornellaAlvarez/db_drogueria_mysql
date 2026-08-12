--  PUNTO 2.3 - Función de Estadísticas de Financiamiento
--  Crear una función que reciba como parámetro el ID de una provincia y
-- devuelva el porcentaje (un valor numérico o porcentual) de droguerías
-- en esa provincia que poseen financiamiento de origen 'Privado'
-- sobre el total de establecimientos de la misma.

USE farmaprod;

DROP FUNCTION IF EXISTS f_porcentaje_privado;

DELIMITER $$
CREATE FUNCTION f_porcentaje_privado (p_provincia_id TINYINT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE valor_total INT DEFAULT 0;
    DECLARE valor_privados INT DEFAULT 0;

    SELECT COUNT(*) INTO valor_total
    FROM establecimiento AS e
    INNER JOIN localidad AS l ON l.localidad_id = e.localidad_id
    WHERE l.provincia_id = p_provincia_id;

    IF valor_total = 0 THEN
        RETURN 0.00;
    END IF;

    SELECT COUNT(*) INTO valor_privados
    FROM establecimiento AS e
    INNER JOIN localidad AS l ON l.localidad_id = e.localidad_id
    INNER JOIN origen_financiamiento AS f ON f.financiamiento_id = e.financiamiento_id
    WHERE l.provincia_id = p_provincia_id 
		AND f.origen_financiamiento = 'Privado';
    RETURN ROUND((valor_privados * 100.0) / valor_total, 2);
END$$
DELIMITER ;

-- EJEMPLOS USADOS QUE NO FALLAN:
-- SELECT f_porcentaje_privado(2);   -- CABA
-- SELECT f_porcentaje_privado(34);  -- Formosa

-- EJEMPLO USADO QUE FALLA:
-- SELECT f_porcentaje_privado(99);  -- no existe