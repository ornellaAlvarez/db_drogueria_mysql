-- PUNTO 2.4 - Vista de Control Operativo
-- Construir una vista que muestre agrupadas las droguerías de financiamiento 'Público'.
-- La vista debe exponer el establecimiento_id, establecimiento_nombre, la tipologia
-- (nombre completo) y el cp (código postal). Esta vista se utilizará exclusivamente 
-- reportes de interfaces externas, por lo que se debe bloquear explícitamente cualquier
-- intento de actualización, inserción o borrado de datos a través de ella.

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