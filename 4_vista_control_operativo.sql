-- Vista de Control Operativo
-- Vista que muestra agrupadas las droguerías de financiamiento 'Público' 
-- (Nacional, Provincial, Municipal).
-- Exponiendo el establecimiento_id, establecimiento_nombre, la tipologia
-- (nombre completo) y el cp (código postal). Esta vista está pensada para exponerse a 
-- reportes de interfaces externas, sin permitir cualquier intento de actualización, 
-- inserción o borrado de datos a través de ella.

USE farmaprod;
 
DROP VIEW IF EXISTS v_control_operativo;
 
CREATE VIEW v_control_operativo AS
    SELECT
        e.establecimiento_id,
        e.establecimiento_nombre,
        e.cp
    FROM  establecimiento AS e
    INNER JOIN  origen_financiamiento AS o ON o.financiamiento_id = e.financiamiento_id
    WHERE o.origen_financiamiento IN ('Nacional', 'Provincial', 'Municipal');


-- EJEMPLOs USADOs QUE NO FALLAN:
-- SELECT COUNT(*) FROM v_control_operativo;
-- SELECT * FROM v_control_operativo WHERE establecimiento_nombre LIKE 'DEPOSITO%' LIMIT 5;
