-- consulta#1
SELECT municipio 
FROM mercado 
ORDER BY municipio ASC;

-- consulta#2
SELECT departamento, municipio
FROM mercado
ORDER BY departamento ASC, municipio ASC

-- consulta#3

SELECT 
    m.municipio,
    u.nombre AS nombre_apicultor,
    a.nombre_apiario
FROM publicacion pub
JOIN apiario a ON pub.id_usuario = a.id_usuario
JOIN mercado m ON pub.id_mercado = m.id_mercado
JOIN usuarios u ON pub.id_usuario = u.id_usuario;

-- consulta#4

SELECT a.id_usuario AS id_apicultor, a.id_apiario, a.nombre_apiario, pr.nombre_producto
FROM apiario a
JOIN cosecha c ON a.id_apiario = c.id_apiario
JOIN lote l ON c.id_cosecha = l.id_cosecha
JOIN producto pr ON l.id_producto = pr.id_producto
GROUP BY a.id_usuario, a.id_apiario, a.nombre_apiario, pr.nombre_producto
ORDER BY a.id_usuario ASC, a.nombre_apiario ASC, pr.nombre_producto ASC;

-- consulta #5

SELECT 
    pe.id_pedido, 
    pe.fecha_pedido, 
    prod.id_usuario AS cod_productor, 
    prod.nombre AS nombre_productor,
    cons.id_usuario AS cod_consumidor, 
    cons.nombre AS nombre_consumidor
FROM pedido pe
JOIN usuarios cons ON pe.id_usuario = cons.id_usuario
JOIN pedido_lote pl ON pe.id_pedido = pl.id_pedido
JOIN publicacion pub ON pl.id_lote = pub.id_lote
JOIN usuarios prod ON pub.id_usuario = prod.id_usuario
JOIN mercado m ON pub.id_mercado = m.id_mercado
WHERE m.municipio = 'Caucasia'
ORDER BY pe.fecha_pedido DESC;