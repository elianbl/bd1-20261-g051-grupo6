-- Vista: Resumen de Producción y Comercialización por Mercado.
-- Mostrar el total de producción y valor comercial por municipio, 
-- solo para productos disponibles y grupos que superen una cantidad mínima

CREATE VIEW vw_resumen_produccion_comercio AS
SELECT
    m.departamento,
    m.municipio,
    p.nombre_producto,
    COUNT(DISTINCT l.id_lote) AS numero_lotes,
    SUM(l.cantidad_producida) AS cantidad_total_producida,
    AVG(ap.precio) AS precio_promedio_cop,
    SUM(l.cantidad_producida * ap.precio) AS valor_total_estimado_cop
FROM lote l

JOIN producto p 
    ON l.id_producto = p.id_producto
	
JOIN apicultor_producto ap 
    ON p.id_producto = ap.id_producto
	
JOIN publicacion pub 
    ON l.id_lote = pub.id_lote
	
JOIN mercado m 
    ON pub.id_mercado = m.id_mercado

WHERE 
    l.estado = 'disponible'
    AND pub.estado = 'disponible'
    AND m.departamento IN ('Antioquia', 'Cundinamarca', 'Boyacá')
GROUP BY 
    m.departamento,
    m.municipio,
    p.nombre_producto
HAVING 
    SUM(l.cantidad_producida) > 20
    AND SUM(l.cantidad_producida * ap.precio) > 500000
ORDER BY 
    m.departamento ASC,
    valor_total_estimado_cop DESC;


SELECT * FROM vw_resumen_produccion_comercio;