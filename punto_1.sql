-- PUNTO 2.1 - Procedimiento de Reporte Geográfico por Coincidencia
-- Escribir un procedimiento almacenado que reciba como parámetro el nombre (o parte del nombre) de un
-- Departamento (por ejemplo: 'AVELLANEDA' o 'ROSARIO'). El procedimiento debe listar
-- todas las droguerías ubicadas en dicho departamento, detallando el nombre del
-- establecimiento, la localidad y la provincia a la que pertenecen.

USE farmaprod;

DROP PROCEDURE IF EXISTS p_reporte_geografico_por_coincidencia;

DELIMITER $$
CREATE PROCEDURE p_reporte_geografico_por_coincidencia (IN p_departamento_nombre VARCHAR(100))
BEGIN 
	SELECT
        e.establecimiento_nombre,
        l.localidad_nombre,
        p.provincia_nombre
    FROM establecimiento AS e
    INNER JOIN localidad AS l ON e.localidad_id = l.localidad_id
    INNER JOIN departamento AS d ON d.departamento_id = l.departamento_id
		AND d.provincia_id = l.provincia_id
    INNER JOIN provincia AS p ON p.provincia_id = d.provincia_id
    WHERE UPPER(d.departamento_nombre) LIKE CONCAT('%', p_departamento_nombre, '%')
    ORDER BY d.departamento_nombre, p.provincia_nombre, l.localidad_nombre, e.establecimiento_nombre;
END$$
DELIMITER ;

-- EJEMPLOS USADOS QUE NO FALLAN:
-- CALL p_reporte_geografico_por_coincidencia('AZUL'); 
-- CALL p_reporte_geografico_por_coincidencia('ROS');