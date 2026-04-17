
-- 1.1.- Agregar un campo a la tabla de "productor" de la red apicola
-- En nuestro diseño los productores son administrados en la tabla usuarios
ALTER TABLE usuarios ADD COLUMN registro_papiola VARCHAR(20);

-- 1.2.- Modificar un campo de la tabla de "productor"
-- Aumentamos el tamaño del campo para permitir roles más largos a futuro
ALTER TABLE usuarios ALTER COLUMN tipo_usuario TYPE VARCHAR(50);


-- 1.3.1 y 1.3.2.
CREATE TABLE certificacion_temporal (
    id_certificacion SERIAL PRIMARY KEY,
    nombre_certificado VARCHAR(100),
    entidad_emisora VARCHAR(100),
    puntaje_obtenido INT
);

-- 1.3.3.- Quitar uno de los campos de la tabla "nueva"
ALTER TABLE certificacion_temporal DROP COLUMN entidad_emisora;

-- 1.3.4.- Cambiar el nombre de la tabla "nueva" a otro nombre
ALTER TABLE certificacion_temporal RENAME TO certificacion_oficial;

-- 1.3.5.- Agregar un campo único a la tabla 
ALTER TABLE certificacion_oficial ADD COLUMN codigo_serial VARCHAR(50) UNIQUE;

-- 1.3.6.- Agregar 2 fechas de inicio y fin; y colocar un control de orden de fechas
ALTER TABLE certificacion_oficial 
ADD COLUMN fecha_inicio DATE,
ADD COLUMN fecha_fin DATE,
ADD CONSTRAINT chk_orden_fechas CHECK (fecha_fin > fecha_inicio);

-- 1.3.7.- Agregar 1 campo entero y colocar un control para que no sea negativo
ALTER TABLE certificacion_oficial 
ADD COLUMN horas_validez INT,
ADD CONSTRAINT chk_horas_positivo CHECK (horas_validez >= 0);

-- 1.3.8.- Modificar el tamaño de un campo texto de la tabla renombrada
ALTER TABLE certificacion_oficial ALTER COLUMN nombre_certificado TYPE VARCHAR(200);

-- 1.3.7 (Bis).- Modificar el campo numérico y colocar un control de rango 
ALTER TABLE certificacion_oficial 
ADD CONSTRAINT chk_rango_puntaje CHECK (puntaje_obtenido BETWEEN 1 AND 100);

-- 1.3.8 (Bis).- Agregar un índice a la tabla (cualquier campo)
CREATE INDEX idx_codigo_serial ON certificacion_oficial(codigo_serial);

-- 1.3.9.- Eliminar una de las fechas
ALTER TABLE certificacion_oficial DROP COLUMN fecha_inicio;

-- 1.3.10.- Borrar todos los datos de una tabla sin dejar traza
TRUNCATE TABLE certificacion_oficial;