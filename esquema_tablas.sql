-- Creación de la base de datos y las 6 tablas normalizadas del modelo:
-- provincia, departamento, localidad, tipologia, origen_financiamiento y establecimiento.
-- departamento y localidad usan claves compuestas para mantener la jerarquía
-- provincia -> departamento -> localidad, y establecimiento se relaciona con
-- localidad, tipologia y origen_financiamiento mediante claves foráneas.

CREATE DATABASE IF NOT EXISTS farmaprod;

USE farmaprod;

DROP TABLE IF EXISTS establecimiento;
DROP TABLE IF EXISTS localidad;
DROP TABLE IF EXISTS departamento;
DROP TABLE IF EXISTS provincia;
DROP TABLE IF EXISTS tipologia;
DROP TABLE IF EXISTS origen_financiamiento;

-- CREACIÓN DE TABLAS
-- Tabla Provincia
CREATE TABLE provincia (
	provincia_id TINYINT NOT NULL,
    provincia_nombre VARCHAR(100),
    PRIMARY KEY (provincia_id)
);

-- Tabla Departamento
CREATE TABLE departamento (
	departamento_id INT NOT NULL,
    departamento_nombre VARCHAR(100),
    provincia_id TINYINT NOT NULL,
    PRIMARY KEY (provincia_id, departamento_id),
    FOREIGN KEY (provincia_id) REFERENCES provincia (provincia_id)
);

-- Tabla Localidad
CREATE TABLE localidad (
	localidad_id BIGINT NOT NULL,
    localidad_nombre VARCHAR(100),
    cod_loc SMALLINT,
    cod_ent TINYINT,
    departamento_id INT NOT NULL,
    provincia_id TINYINT NOT NULL,
    PRIMARY KEY (localidad_id),
    FOREIGN KEY (provincia_id, departamento_id) REFERENCES departamento (provincia_id, departamento_id)
);

-- Tabla Tipologia
CREATE TABLE tipologia (
	tipologia_id SMALLINT NOT NULL,
    tipologia_sigla VARCHAR(30),
    tipologia VARCHAR(100),
    PRIMARY KEY (tipologia_id, tipologia)
);

-- Tabla Origen_financiamiento
CREATE TABLE origen_financiamiento (
	financiamiento_id BIGINT AUTO_INCREMENT,
    origen_financiamiento VARCHAR(40),
    PRIMARY KEY (financiamiento_id)
);

-- Tabla Establecimiento
CREATE TABLE establecimiento (
	establecimiento_id BIGINT NOT NULL,
    establecimiento_nombre VARCHAR(100),
    cp SMALLINT,
    domicilio VARCHAR(100),
    localidad_id BIGINT NOT NULL,
    tipologia_id SMALLINT NOT NULL,
    financiamiento_id BIGINT,
    PRIMARY KEY (establecimiento_id),
    FOREIGN KEY (localidad_id) REFERENCES LOCALIDAD (localidad_id),
    FOREIGN KEY (tipologia_id) REFERENCES TIPOLOGIA (tipologia_id),
	FOREIGN KEY (financiamiento_id) REFERENCES origen_financiamiento (financiamiento_id)
);
