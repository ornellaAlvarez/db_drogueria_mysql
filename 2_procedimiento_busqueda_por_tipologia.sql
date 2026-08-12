-- Buscador Avanzado por Tipología
-- Permite buscar establecimientos filtrando simultáneamente por la sigla de su
-- tipología (ej: 'DI', 'DF') y un patrón de nombre del establecimiento de al menos
-- 5 caracteres. Si el patrón es más corto, lanza un error informando la restricción.
 
USE farmaprod;

DROP PROCEDURE IF EXISTS p_buscar_por_tipologia;

DELIMITER $$
CREATE PROCEDURE p_buscar_por_tipologia (IN p_tipologia_sigla VARCHAR(30), 
										 IN p_establecimiento_nombre   VARCHAR(100))
BEGIN
    IF CHAR_LENGTH(TRIM(p_establecimiento_nombre)) < 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El patron de busqueda de nombre debe tener al menos 5 caracteres.';
    END IF;
    SELECT
        e.establecimiento_id,
        e.establecimiento_nombre,
        t.tipologia_sigla,
        t.tipologia,
        l.localidad_nombre,
        p.provincia_nombre
    FROM establecimiento AS e
    INNER JOIN tipologia AS t ON t.tipologia_id = e.tipologia_id
    INNER JOIN localidad AS l ON l.localidad_id = e.localidad_id
    INNER JOIN departamento AS d ON d.departamento_id = l.departamento_id
    INNER JOIN provincia AS p ON p.provincia_id = d.provincia_id
    WHERE t.tipologia_sigla LIKE CONCAT('%', p_tipologia_sigla, '%')
      AND e.establecimiento_nombre LIKE CONCAT('%', p_establecimiento_nombre, '%')
    ORDER BY e.establecimiento_nombre;
END$$
DELIMITER ;

-- EJEMPLOS USADOS QUE NO FALLAN:
-- CALL sp_buscar_por_tipologia('DROGUERIA', 'FLORI');
-- CALL sp_buscar_por_tipologia('DROGUERIA', 'DISPR');

-- EJEMPLOS USADOS QUE FALLAN:
-- CALL sp_buscar_por_tipologia('DROGUERIA', 'FL');
