PREPARE consulta_publicaciones_resumida (TEXT, DATE, NUMERIC) AS
SELECT
    m.departamento,
    m.municipio,
    p.nombre_producto,
    COUNT(pub.id_publicacion) AS cantidad_publicaciones,
    SUM(l.cantidad_producida) AS cantidad_total_publicada
FROM publicacion pub
JOIN mercado m 
  ON pub.id_mercado = m.id_mercado
JOIN lote l 
  ON pub.id_lote = l.id_lote
JOIN producto p 
  ON l.id_producto = p.id_producto
WHERE 
    m.departamento = $1
    AND pub.fecha_publicacion >= $2
GROUP BY 
    m.departamento,
    m.municipio,
    p.nombre_producto
HAVING 
    SUM(l.cantidad_producida) >= $3
ORDER BY 
    cantidad_total_publicada DESC;
