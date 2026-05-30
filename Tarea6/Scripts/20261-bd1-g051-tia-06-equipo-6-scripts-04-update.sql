UPDATE mercado 
SET direccion = 'Calle 45A # 52-21' 
WHERE id_mercado = 1;

UPDATE mercado 
SET direccion = 'Carrera 70 # 44-15' 
WHERE id_mercado = 2;

UPDATE mercado 
SET direccion = 'Avenida El Poblado # 10-40' 
WHERE id_mercado = 3;

-- =======================================================

UPDATE apicultor_producto 
SET precio = 18500 
WHERE id_producto = 100 AND id_usuario = 15;

UPDATE apicultor_producto
SET precio = 29900.00 
WHERE id_producto = 50;

UPDATE apicultor_producto 
SET precio = 3500
WHERE id_producto = 300;
--================================================================
