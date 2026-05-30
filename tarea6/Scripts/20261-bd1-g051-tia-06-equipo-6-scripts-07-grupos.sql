-- Consulta #1: Agrupar los productores por departamento y municipio
SELECT 
    m.departamento,
    m.municipio,
    COUNT(DISTINCT u.id_usuario) AS cantidad_productores
FROM usuarios u
JOIN apiario a ON u.id_usuario = a.id_usuario
JOIN mercado m ON m.departamento = m.departamento 
             AND m.municipio = m.municipio
WHERE u.tipo_usuario = 'productor'
GROUP BY m.departamento, m.municipio
ORDER BY m.departamento, m.municipio;

-- Consulta #2: Agrupar los consumidores por departamento y municipio
SELECT 
    m.departamento,
    m.municipio,
    COUNT(DISTINCT u.id_usuario) AS cantidad_consumidores
FROM usuarios u
JOIN pedido p ON u.id_usuario = p.id_usuario
JOIN mercado m ON p.id_mercado = m.id_mercado
WHERE u.tipo_usuario = 'consumidor'
GROUP BY m.departamento, m.municipio
ORDER BY m.departamento, m.municipio;

-- Consulta #3: Agrupar los productores de un departamento por municipio y apiarios
SELECT 
    m.municipio,
    u.nombre AS nombre_productor,
    COUNT(a.id_apiario) AS cantidad_apiarios
FROM usuarios u
JOIN apiario a ON u.id_usuario = a.id_usuario
JOIN mercado m ON m.departamento = 'Antioquia' 
             AND m.municipio = m.municipio
WHERE u.tipo_usuario = 'productor'
GROUP BY m.municipio, u.id_usuario, u.nombre
ORDER BY m.municipio, cantidad_apiarios DESC;

-- Consulta #4: Agrupar los pedidos de un departamento por municipio y apiario
-- Debe tener el total de los pedidos en COP
-- Debe utilizar un HAVING para filtrar un total en COP que puede escoger arbitrariamente
SELECT 
    m.departamento,
    m.municipio,
    a.nombre_apiario,
    SUM(pl.cantidad * pl.precio_unitario) AS total_pedidos_cop
FROM pedido p
JOIN mercado m ON p.id_mercado = m.id_mercado
JOIN pedido_lote pl ON p.id_pedido = pl.id_pedido
JOIN lote l ON pl.id_lote = l.id_lote
JOIN cosecha c ON l.id_cosecha = c.id_cosecha
JOIN apiario a ON c.id_apiario = a.id_apiario
WHERE m.departamento = 'Antioquia'
GROUP BY m.departamento, m.municipio, a.id_apiario, a.nombre_apiario
HAVING SUM(pl.cantidad * pl.precio_unitario) > 500000 
ORDER BY total_pedidos_cop DESC;

-- Consulta #5: Agrupar los productos pedidos en todos los departamentos y municipios
-- Con cantidad total de pedidos de mayor a menor
SELECT 
    pr.nombre_producto,
    m.departamento,
    m.municipio,
    SUM(pl.cantidad) AS cantidad_total_pedida
FROM pedido p
JOIN mercado m ON p.id_mercado = m.id_mercado
JOIN pedido_lote pl ON p.id_pedido = pl.id_pedido
JOIN lote l ON pl.id_lote = l.id_lote
JOIN producto pr ON l.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre_producto, m.departamento, m.municipio
ORDER BY cantidad_total_pedida DESC;

-- RESPUESTAS A LAS PREGUNTAS

-- ¿Quién fue el productor que más recibió pedidos?
SELECT 
    u.id_usuario,
    u.nombre AS nombre_productor,
    SUM(pl.cantidad) AS total_pedidos_recibidos
FROM usuarios u
JOIN apiario a ON u.id_usuario = a.id_usuario
JOIN cosecha c ON a.id_apiario = c.id_apiario
JOIN lote l ON c.id_cosecha = l.id_cosecha
JOIN pedido_lote pl ON l.id_lote = pl.id_lote
WHERE u.tipo_usuario = 'productor'
GROUP BY u.id_usuario, u.nombre
ORDER BY total_pedidos_recibidos DESC
LIMIT 1;

-- ¿Cuál departamento recibió más pedidos y cuál recibió menos?
(
    SELECT 
        m.departamento,
        COUNT(p.id_pedido) AS cantidad_pedidos,
        'MAYOR CANTIDAD' AS tipo_resultado
    FROM pedido p
    JOIN mercado m ON p.id_mercado = m.id_mercado
    GROUP BY m.departamento
    ORDER BY cantidad_pedidos DESC
    LIMIT 1
)
UNION ALL
(
    SELECT 
        m.departamento,
        COUNT(p.id_pedido) AS cantidad_pedidos,
        'MENOR CANTIDAD' AS tipo_resultado
    FROM pedido p
    JOIN mercado m ON p.id_mercado = m.id_mercado
    GROUP BY m.departamento
    ORDER BY cantidad_pedidos ASC
    LIMIT 1
);

-- ¿Cuál fue el producto que recibió menos pedidos?
SELECT 
    pr.id_producto,
    pr.nombre_producto,
    SUM(pl.cantidad) AS cantidad_total_pedida
FROM producto pr
JOIN lote l ON pr.id_producto = l.id_producto
JOIN pedido_lote pl ON l.id_lote = pl.id_lote
GROUP BY pr.id_producto, pr.nombre_producto
ORDER BY cantidad_total_pedida ASC
LIMIT 1;

-- ¿Cuál fue el municipio con el mayor monto (COP) de pedidos?
SELECT 
    m.departamento,
    m.municipio,
    SUM(pl.cantidad * pl.precio_unitario) AS monto_total_cop
FROM pedido p
JOIN mercado m ON p.id_mercado = m.id_mercado
JOIN pedido_lote pl ON p.id_pedido = pl.id_pedido
GROUP BY m.departamento, m.municipio
ORDER BY monto_total_cop DESC
LIMIT 1;
