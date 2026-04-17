

-- MODIFICA 2: DATOS SEMI-ESTRUCTURADOS (JSONB)

-- 1.- DATOS SEMI-ESTRUCTURADOS PARA IOT (Sensores)
ALTER TABLE lectura_sensor ADD COLUMN datos_ambientales JSONB;

-- 1.2 Agregar un par de registros
INSERT INTO lectura_sensor (id_sensor, valor, datos_ambientales)
VALUES
(1, 42.5, '{
    "temperatura_c": 28.5,
    "humedad_relativa": 72,
    "alertas": {"sobrecalentamiento": false}
}'),
(1, 43.1, '{
    "temperatura_c": 31.0,
    "humedad_relativa": 68,
    "alertas": {"sobrecalentamiento": true}
}');

--1.3 Consultar la información agregada
SELECT 
    id_lectura, 
    valor AS peso, 
    datos_ambientales->>'temperatura_c' AS temperatura,
    datos_ambientales->'alertas'->>'sobrecalentamiento' AS alerta_calor
FROM lectura_sensor;

/* 1.4
DESCRIPCIÓN 1: El campo 'datos_ambientales' almacena paquetes
enviados por el nodo IoT, su propósito es capturar métricas secundarias como clima y batería 
sin alterar el esquema estricto de la tabla principal de lecturas.
*/

-- 2.- DATOS SEMI-ESTRUCTURADOS (PARA BIG DATA o IOT)

-- 2.1
ALTER TABLE colmena ADD COLUMN detalles_tecnicos JSONB;

-- Actualizamos las colmenas 1 y 2 que creamos en el Paso 1
UPDATE colmena 
SET detalles_tecnicos = '{"material": "Pino", "reina": {"linaje": "Buckfast", "color": "Azul"}}'
WHERE id_colmena = 1;

UPDATE colmena 
SET detalles_tecnicos = '{"material": "Cedro", "reina": {"linaje": "Carnica", "color": "Blanco"}}'
WHERE id_colmena = 2;

-- Consultamos la información
SELECT 
    codigo_colmena, 
    tipo_abeja,
    detalles_tecnicos->'reina'->>'linaje' AS genetica_especifica
FROM colmena
WHERE detalles_tecnicos IS NOT NULL;

/*
DESCRIPCIÓN 2: El campo 'detalles_tecnicos' (JSONB) permite documentar variables 
físicas y biológicas de cada colmena de manera flexible. Su propósito es facilitar 
consultas analíticas sobre características que no aplican a todos los panales.
*/