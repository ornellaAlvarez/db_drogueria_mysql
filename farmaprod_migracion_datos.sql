USE farmaprod;

-- MIGRACION DE DATOS
-- Migración de Provincia
INSERT INTO provincia (provincia_id, provincia_nombre)
SELECT DISTINCT
	provincia_id,
    provincia_nombre
FROM DROGUERIA;

-- Migración de Departamento
INSERT INTO departamento (departamento_id, departamento_nombre, provincia_id)
SELECT DISTINCT
	d.departamento_id,
    d.departamento_nombre,
    d.provincia_id
FROM DROGUERIA AS d;

-- Migración de Localidad
INSERT INTO localidad (localidad_id, localidad_nombre, cod_loc, cod_ent, provincia_id, departamento_id)
SELECT DISTINCT 
	localidad_id,
	localidad_nombre,
	cod_loc,
	cod_ent,
    provincia_id,
    departamento_id
FROM DROGUERIA;

-- Migración de Tipologia
INSERT INTO tipologia (tipologia_id, tipologia_sigla, tipologia)
SELECT DISTINCT
	tipologia_id,
    tipologia_sigla,
    tipologia
FROM DROGUERIA;

-- Migración de Origen Financiamiento
INSERT INTO origen_financiamiento (origen_financiamiento)
SELECT DISTINCT
	origen_financiamiento
FROM DROGUERIA;

-- Migración de Establecimiento
INSERT INTO establecimiento (establecimiento_id, establecimiento_nombre, cp, domicilio, localidad_id, 
							 tipologia_id, financiamiento_id)
SELECT DISTINCT
	d.establecimiento_id,
    d.establecimiento_nombre,
    CAST(d.cp AS CHAR(20)),
    d.domicilio, 
    d.localidad_id,
    d.tipologia_id,
    f.financiamiento_id
FROM DROGUERIA AS d
INNER JOIN origen_financiamiento AS f
	ON f.origen_financiamiento = d.origen_financiamiento;