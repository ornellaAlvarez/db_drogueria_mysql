# Registro de Droguerías - Diseño y Desarrollo de Base de Datos Relacional (MySQL)

Proyecto final académico: diseño, normalización y desarrollo de una base de datos relacional en MySQL a partir de un dataset público de droguerías (distribuidoras farmacéuticas) de Argentina, organizadas geográficamente por provincia, departamento y localidad.

# Objetivo

Partir de una tabla plana (no normalizada) con información de establecimientos y transformarla en un modelo relacional normalizado (hasta la 5FN), además de desarrollar lógica del lado de la base de datos: procedimientos almacenados, funciones, vistas y triggers.

# Modelo de datos

El modelo tiene 6 entidades:

| Tabla	                 | Descripción                                                                                                   |
| :--------------------- | :------------------------------------------------------------------------------------------------------------ |
| provincia	             | Provincias de Argentina                                                                                       |
| departamento	         | Departamentos, cada uno perteneciente a una provincia                                                         |
| localidad	             | Localidades, cada una perteneciente a un departamento y provincia                                             |
| tipologia	             | Tipo de establecimiento (ej: droguería, depósito)                                                             |
| origen_financiamiento  | Origen del financiamiento (Nacional, Provincial, Municipal, Privado)                                          |
| establecimiento	       | Entidad principal: cada droguería/establecimiento, con sus relaciones a localidad, tipología y financiamiento |

Todas las relaciones están implementadas con claves foráneas, y departamento y localidad usan claves compuestas (provincia_id + departamento_id) para mantener la integridad jerárquica provincia → departamento → localidad.

El diagrama entidad-relación está disponible en modelo_grafico_DER.mwb (abrir con MySQL Workbench).

Los scripts se deben ejecutar en este orden:
  * SOURCE 01_esquema_tablas.sql;
  * SOURCE 02_datos_origen_muestra.sql;
  * SOURCE 03_migracion_datos.sql;
  * SOURCE 04_procedimiento_reporte_geografico_por_departamento.sql;
  * SOURCE 05_procedimiento_busqueda_por_tipologia.sql;
  * SOURCE 06_funcion_porcentaje_financiamiento_privado.sql;
  * SOURCE 07_vista_control_operativo.sql;
  * SOURCE 08_trigger_control_rango_id.sql;
  * SOURCE 09_trigger_sanitizacion_nombre.sql;

# NOTAS
  * DELIMETER '$$': MySQL usa ; para instrucciones. Como los procedimientos, funciones y triggers contienen múltiples ; en su cuerpo, es necesario cambiar temporalmente el delimitador a $$ para que el cliente interprete todo el bloque como una sola instrucción, y luego volver a ;.
  * SIGNAL SQLSTATE '45000': Es el mecanismo de MySQL para lanzar errores personalizados desde procedimientos, funciones y triggers, cancelando la transacción en curso.
  * NEW: dentro de un trigger BEFORE INSERT/BEFORE UPDATE, representa la fila que se está por insertar o actualizar, permitiendo validar sus valores antes de que se persistan.

# Tecnologías Utilizadas
MySQK Community Edition - MySQL Workbench - SQL (DDL, DML, procedimientos almacenados, funciones, triggers, vistas)
