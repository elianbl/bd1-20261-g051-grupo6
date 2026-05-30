

INSERT INTO producto (id_producto, nombre_producto, descripcion) VALUES
(100, 'Miel', 'Miel pura de abejas - 1 kg'),
(200, 'Polen', 'Polen granulado recolectado - 250 g'),
(300, 'Propóleo', 'Extracto de propóleo concentrado - 30 ml'),
(400, 'Jalea Real', 'Jalea real pura de alta concentración - 10-20 g'),
(500, 'Cera', 'Cera de abejas en bloques - 1 kg'),
(600, 'Apitoxina', 'Apitoxina pura cristalizada - 1 g');

INSERT INTO organizacion (id_organizacion, nombre, tipo, direccion, telefono, nit) VALUES
(1, 'Agrosavia', 'entidad', 'Km 14 Vía Mosquera', '6014227300', '800.123.456-1'),
(2, 'Fedabejas Colombia', 'entidad', 'Cra 15 # 34-12', '6013456789', '900.234.567-2'),
(3, 'Cooperativa Mieles de Antioquia', 'productor', 'Cl 50 # 45-20', '6045123456', '890.987.654-3'),
(4, 'Asociación Apícola del Valle', 'productor', 'Cra 5 # 12-40', '6023154879', '810.112.233-4');

INSERT INTO mercado (id_mercado, nombre_mercado, departamento, municipio, direccion) VALUES
(1, 'Plaza Caucasia', 'Antioquia', 'Caucasia', 'Cra 2 # 15-20'),
(2, 'Mercado El Bagre', 'Antioquia', 'El Bagre', 'Cl 40 # 12-11'),
(3, 'Plaza Zaragoza', 'Antioquia', 'Zaragoza', 'Cra 1 # 10-5'),
(4, 'Plaza Santa Fe', 'Antioquia', 'Santa Fe de Antioquia', 'Parque Principal'),
(5, 'Mercado Santa Elena', 'Antioquia', 'Medellín (Santa Elena)', 'Vía Principal'),
(6, 'Mercado Fusagasugá', 'Cundinamarca', 'Fusagasugá', 'Cra 6 # 8-15'),
(7, 'Plaza Girardot', 'Cundinamarca', 'Girardot', 'Cl 10 # 12-40'),
(8, 'Plaza Ubaté', 'Cundinamarca', 'Ubaté', 'Cra 4 # 6-22'),
(9, 'Mercado Zipaquirá', 'Cundinamarca', 'Zipaquirá', 'Cra 8 # 5-10'),
(10, 'Plaza La Mesa', 'Cundinamarca', 'La Mesa', 'Cl 3 # 4-50'),
(11, 'Mercado Tunja', 'Boyacá', 'Tunja', 'Avenida Universitaria'),
(12, 'Plaza Duitama', 'Boyacá', 'Duitama', 'Cl 15 # 14-20'),
(13, 'Mercado Sogamoso', 'Boyacá', 'Sogamoso', 'Cra 11 # 12-30'),
(14, 'Plaza Chiquinquirá', 'Boyacá', 'Chiquinquirá', 'Parque Julio Flórez'),
(15, 'Mercado Paipa', 'Boyacá', 'Paipa', 'Cl 25 # 22-10'),
(16, 'Plaza Bucaramanga', 'Santander', 'Bucaramanga', 'Cl 34 # 15-20'),
(17, 'Mercado San Gil', 'Santander', 'San Gil', 'Cl 12 # 9-45'),
(18, 'Plaza Socorro', 'Santander', 'Socorro', 'Cra 14 # 13-20'),
(19, 'Mercado Barbosa', 'Santander', 'Barbosa', 'Cl 9 # 8-15'),
(20, 'Plaza Neiva', 'Huila', 'Neiva', 'Cra 2 # 21-10'),
(21, 'Mercado Pitalito', 'Huila', 'Pitalito', 'Cl 5 # 4-30'),
(22, 'Plaza Garzón', 'Huila', 'Garzón', 'Cra 4 # 3-15'),
(23, 'Mercado La Plata', 'Huila', 'La Plata', 'Cl 4 # 5-10'),
(24, 'Plaza Villavicencio', 'Meta', 'Villavicencio', 'Cra 30 # 40-20'),
(25, 'Mercado Granada', 'Meta', 'Granada', 'Cl 14 # 15-30'),
(26, 'Plaza Acacías', 'Meta', 'Acacías', 'Cra 15 # 14-40'),
(27, 'Mercado Montería', 'Córdoba', 'Montería', 'Cl 35 # 2-15'),
(28, 'Plaza Planeta Rica', 'Córdoba', 'Planeta Rica', 'Cra 7 # 18-20'),
(29, 'Mercado Sahagún', 'Córdoba', 'Sahagún', 'Cl 14 # 12-10'),
(30, 'Plaza Sincelejo', 'Sucre', 'Sincelejo', 'Cra 18 # 22-30'),
(31, 'Mercado Corozal', 'Sucre', 'Corozal', 'Cl 25 # 24-15'),
(32, 'Plaza Sampués', 'Sucre', 'Sampués', 'Cra 12 # 11-20'),
(33, 'Mercado Santa Marta', 'Magdalena', 'Santa Marta', 'Cra 5 # 12-20'),
(34, 'Plaza Ciénaga', 'Magdalena', 'Ciénaga', 'Cl 10 # 15-30'),
(35, 'Mercado Fundación', 'Magdalena', 'Fundación', 'Cra 8 # 7-40'),
(36, 'Plaza Cali', 'Valle del Cauca', 'Cali', 'Cl 15 # 10-20'),
(37, 'Mercado Palmira', 'Valle del Cauca', 'Palmira', 'Cra 28 # 30-15'),
(38, 'Plaza Buga', 'Valle del Cauca', 'Buga', 'Cl 4 # 14-20'),
(39, 'Mercado Tuluá', 'Valle del Cauca', 'Tuluá', 'Cra 22 # 25-10');

WITH arreglos AS (
    SELECT 
        ARRAY['Elian', 'Alejandro', 'Carlos', 'Andres', 'Mateo', 'Santiago', 'Juan', 'Diego', 'Sebastian', 'Daniel', 'Laura', 'Valentina', 'Sofia', 'Camila', 'Mariana', 'Isabella', 'Ana', 'Luisa', 'Juliana', 'Andrea'] AS n,
        ARRAY['Blandon', 'Legarda', 'Restrepo', 'Mejia', 'Gomez', 'Perez', 'Lopez', 'Garcia', 'Martinez', 'Rodriguez', 'Hernandez', 'Ramirez', 'Torres', 'Cardona', 'Zapata', 'Osorio', 'Montoya', 'Uribe', 'Arias', 'Castrillon'] AS a1,
        ARRAY['Rios', 'Guzman', 'Ortega', 'Delgado', 'Castro', 'Ortiz', 'Rubio', 'Marin', 'Serna', 'Rojas', 'Salazar', 'Gallego', 'Henao', 'Velez', 'Ochoa', 'Pineda', 'Jaramillo', 'Cano', 'Molina', 'Rendon'] AS a2,
        ARRAY['gmail.com', 'hotmail.com', 'outlook.com', 'yahoo.es', 'pascualbravo.edu.co'] AS d,
        ARRAY['300', '301', '310', '311', '312', '314', '315', '316', '320', '321'] AS pref
)
INSERT INTO usuarios (id_usuario, nombre, email, contrasena, telefono, tipo_usuario, fecha_registro, id_organizacion)
SELECT 
    gs,
    (SELECT n[((gs - 1) % 20) + 1] FROM arreglos) || ' ' || 
    (SELECT a1[(((gs - 1) / 20) % 20) + 1] FROM arreglos) || ' ' || 
    (SELECT a2[(((gs - 1) / 400) % 20) + 1] FROM arreglos),
    LOWER(
        (SELECT n[((gs - 1) % 20) + 1] FROM arreglos) || '.' || 
        (SELECT a1[(((gs - 1) / 20) % 20) + 1] FROM arreglos) || 
        gs::TEXT || '@' || 
        (SELECT d[((gs - 1) % 5) + 1] FROM arreglos)
    ),
    MD5(gs::TEXT),
    (SELECT pref[((gs - 1) % 10) + 1] FROM arreglos) || LPAD((((gs * 9973) % 8999999) + 1000000)::TEXT, 7, '0'),
    CASE 
        WHEN gs <= 10 THEN (ARRAY['administrador', 'entidad'])[((gs - 1) % 2) + 1]
        WHEN gs > 10 AND gs <= 110 THEN 'productor' 
        ELSE 'consumidor' 
    END,
    CURRENT_DATE - (gs % 365),
    CASE WHEN gs <= 10 THEN ((gs - 1) % 4) + 1 ELSE NULL END
FROM generate_series(1, 2110) gs;

INSERT INTO apicultor_producto (id_usuario, id_producto, precio)
SELECT DISTINCT 
    gs,
    (ARRAY[100, 200, 300, 400, 500, 600])[((gs + i) % 6) + 1],
    15000 + (gs * 100) + (i * 50)
FROM generate_series(11, 110) gs
CROSS JOIN generate_series(1, 3) i;

INSERT INTO apiario (id_apiario, nombre_apiario, ubicacion, id_usuario, descripcion)
SELECT 
    gs,
    (ARRAY['El Sol', 'La Esperanza', 'Santa María', 'Los Pinos', 'El Recuerdo', 'Dulce Amanecer', 'Flor de Loto', 'El Bosque', 'La Pradera', 'Valle Verde'])[((gs - 1) % 10) + 1] || ' - Sector ' || (((gs * 7) % 50) + 1)::TEXT,
    jsonb_build_object('lat', 6.0 + (gs * 0.01), 'lng', -75.0 - (gs * 0.01)),
    10 + ((gs % 100) + 1),
    (ARRAY['Producción enfocada en floración de bosque seco.', 'Apiario de rescate y conservación ecológica.', 'Extracción de miel multifloral y polen.', 'Cultivo orgánico con polinización inducida.', 'Zona de alta floración cafetera.'])[((gs - 1) % 5) + 1]
FROM generate_series(1, 200) gs;

INSERT INTO colmena (id_colmena, id_apiario, codigo_colmena, estado_abeja, tipo_abeja, fecha_instalacion)
SELECT 
    gs, 
    ((gs - 1) % 200) + 1, 
    'COL-' || LPAD(gs::TEXT, 4, '0'), 
    (ARRAY['activa', 'enferma', 'inactiva'])[(gs % 3) + 1], 
    (ARRAY['Carniola', 'Italiana', 'Scutellata'])[(gs % 3) + 1], 
    CURRENT_DATE - (gs % 700)
FROM generate_series(1, 600) gs;

INSERT INTO sensor (id_sensor, tipo_sensor, id_apiario, fecha_instalacion)
SELECT 
    gs, 
    (ARRAY['Temperatura', 'Humedad', 'Peso', 'Acústico'])[(gs % 4) + 1], 
    ((gs - 1) % 200) + 1, 
    CURRENT_DATE - (gs % 365)
FROM generate_series(1, 400) gs;

INSERT INTO lectura_sensor (id_lectura, id_sensor, valor, detalles, fecha)
SELECT 
    gs,
    ((gs - 1) % 400) + 1,
    20.0 + (gs % 15),
    jsonb_build_object('estado', 'ok', 'bateria', 100 - (gs % 20)),
    CURRENT_TIMESTAMP - (gs * INTERVAL '1 hour')
FROM generate_series(1, 1200) gs;

INSERT INTO control (id_control, id_colmena, fecha, tratamiento, observaciones)
SELECT 
    gs,
    ((gs - 1) % 600) + 1,
    CURRENT_DATE - (gs % 100),
    'Revisión preventiva ' || gs::TEXT,
    'Control de plagas rutinario'
FROM generate_series(1, 600) gs;

INSERT INTO cosecha (id_cosecha, id_apiario, fecha_cosecha, cantidad_total)
SELECT 
    gs, 
    ((gs - 1) % 200) + 1, 
    CURRENT_DATE - (gs % 180), 
    20.0 + (gs % 200)
FROM generate_series(1, 500) gs;

INSERT INTO lote (id_lote, id_cosecha, id_producto, cantidad_producida, estado)
SELECT 
    gs, 
    ((gs - 1) % 500) + 1, 
    (ARRAY[100, 200, 300, 400, 500, 600])[(gs % 6) + 1], 
    10.0 + (gs % 40), 
    'disponible'
FROM generate_series(1, 1000) gs;

INSERT INTO publicacion (id_publicacion, id_lote, id_usuario, id_mercado, precio, estado, fecha_publicacion)
SELECT 
    gs,
    l.id_lote,
    a.id_usuario, 
    (gs % 39) + 1, 
    25000.00 + (gs % 10000),
    'disponible',
    CURRENT_DATE - (gs % 30)
FROM generate_series(1, 1000) gs
JOIN lote l ON l.id_lote = gs
JOIN cosecha c ON l.id_cosecha = c.id_cosecha
JOIN apiario a ON c.id_apiario = a.id_apiario;

INSERT INTO pedido (id_pedido, id_usuario, id_mercado, fecha_pedido, estado)
SELECT 
    gs,
    110 + ((gs % 2000) + 1), 
    (gs % 39) + 1, 
    CURRENT_DATE - (gs % 90),
    (ARRAY['pagado', 'enviado', 'cancelado', 'pendiente'])[(gs % 4) + 1]
FROM generate_series(1, 2000) gs;

INSERT INTO pedido_lote (id_pedido, id_lote, cantidad, precio_unitario)
SELECT 
    p.id_pedido,
    pub.id_lote,
    (p.id_pedido % 4) + 1,
    pub.precio
FROM pedido p
JOIN publicacion pub ON pub.id_mercado = p.id_mercado
WHERE pub.id_publicacion = (
    SELECT id_publicacion 
    FROM publicacion p2 
    WHERE p2.id_mercado = p.id_mercado 
    ORDER BY id_publicacion ASC 
    LIMIT 1
);

INSERT INTO pago (id_pago, id_pedido, monto, metodo_pago, estado_pago, fecha_pago)
SELECT 
    pe.id_pedido, 
    pe.id_pedido, 
    SUM(pl.cantidad * pl.precio_unitario), 
    (ARRAY['PSE', 'Tarjeta Crédito', 'Efecty'])[(pe.id_pedido % 3) + 1], 
    CASE 
        WHEN pe.estado IN ('pagado', 'enviado') THEN 'pagado'
        WHEN pe.estado = 'cancelado' THEN 'rechazado'
        ELSE 'pendiente'
    END, 
    pe.fecha_pedido + 1
FROM pedido pe
JOIN pedido_lote pl ON pe.id_pedido = pl.id_pedido
GROUP BY pe.id_pedido, pe.estado, pe.fecha_pedido;

WITH tipos_via AS (
    SELECT 
        ARRAY['Calle', 'Carrera', 'Avenida', 'Transversal', 'Diagonal', 'Circular'] AS tv,
        ARRAY['A', 'B', 'C', ' Sur', ' Norte', ''] AS suf
)
INSERT INTO envio (id_envio, id_pedido, direccion, transportadora, estado_envio)
SELECT 
    p.id_pedido, 
    p.id_pedido, 
    (SELECT tv[((p.id_pedido - 1) % 6) + 1] FROM tipos_via) || ' ' || 
    ((p.id_pedido % 150) + 1)::TEXT || 
    (SELECT suf[((p.id_pedido - 1) % 6) + 1] FROM tipos_via) || ' # ' || 
    ((p.id_pedido % 120) + 1)::TEXT || '-' || 
    ((p.id_pedido % 99) + 1)::TEXT,
    (ARRAY['Servientrega', 'Inter Rapidísimo', 'Coordinadora'])[(p.id_pedido % 3) + 1], 
    (ARRAY['en_bodega', 'preparando', 'en_transito', 'entregado'])[(p.id_pedido % 4) + 1]
FROM pedido p 
WHERE p.estado = 'enviado';

INSERT INTO documento (id_documento, id_usuario, id_apiario, id_lote, tipo_documento, fecha, estado)
SELECT 
    gs,
    CASE WHEN gs % 3 = 0 THEN (gs % 2110) + 1 ELSE NULL END, 
    CASE WHEN gs % 3 = 1 THEN (gs % 200) + 1 ELSE NULL END,  
    CASE WHEN gs % 3 = 2 THEN (gs % 1000) + 1 ELSE NULL END, 
    (ARRAY['Certificado ICA', 'Cámara de Comercio', 'Análisis de Laboratorio'])[(gs % 3) + 1],
    CURRENT_DATE - (gs % 300),
    (ARRAY['vigente', 'vencido', 'en_tramite'])[(gs % 3) + 1]
FROM generate_series(1, 300) gs;

INSERT INTO actividad_comunidad (id_actividad, id_usuario, titulo, descripcion, tipo, fecha)
SELECT 
    gs,
    (gs % 2110) + 1, 
    'Aporte en foro ' || gs::TEXT, 
    'Contenido técnico de apicultura y polinización.', 
    'foro', 
    CURRENT_DATE - (gs % 30)
FROM generate_series(1, 50) gs;

INSERT INTO obligacion (id_obligacion, id_usuario, id_organizacion, monto, tipo, fecha_inicio, estado)
SELECT 
    gs,
    10 + ((gs % 100) + 1),
    (gs % 4) + 1,
    500000.00 + (gs * 10000),
    (ARRAY['credito', 'subsidio'])[(gs % 2) + 1],
    CURRENT_DATE - (gs % 300),
    (ARRAY['activo', 'pagado', 'vencido'])[(gs % 3) + 1]
FROM generate_series(1, 50) gs;