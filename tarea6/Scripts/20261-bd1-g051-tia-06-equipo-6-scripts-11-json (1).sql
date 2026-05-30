
-- insercion dato json
INSERT INTO public.lectura_sensor (id_sensor, id_lectura, valor, detalles, fecha)
VALUES (
    400,
	1400,
    28.40, 
    '{
      "temperatura_celsius": 34.2,
      "humedad_porcentaje": 62.5,
      "bateria_sensor": 87,
      "geolocalizacion": {
        "latitud": 7.9865,
        "longitud": -75.1934
      },
      "evento": "monitoreo_rutina"
    }'::jsonb,
    CURRENT_TIMESTAMP 
);


-- consulta 
SELECT id_lectura, id_sensor, valor, detalles, fecha 
FROM public.lectura_sensor 
WHERE id_lectura = 1400;


-- actualizacion temperatura
UPDATE public.lectura_sensor
SET detalles = jsonb_set(detalles, '{temperatura_celsius}', '36.5'::jsonb)
WHERE id_lectura = 1400;
