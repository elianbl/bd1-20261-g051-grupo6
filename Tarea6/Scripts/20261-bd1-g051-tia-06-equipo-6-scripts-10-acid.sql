-- SCRIPT DE VERIFICACIÓN DE PROPIEDADES ACID

-- 1. ATOMICIDAD
-- Realice una operación BEGIN-ROLLBACK que involucre 2 tablas 
-- (una actualización de un registro por tabla)

-- PANTALLA 1: SELECT ANTES

SELECT id_usuario, nombre, tipo_usuario FROM usuarios WHERE id_usuario = 11;
SELECT id_apiario, nombre_apiario, descripcion FROM apiario WHERE id_apiario = 5;
BEGIN;
    UPDATE usuarios 
    SET tipo_usuario = 'administrador' 
    WHERE id_usuario = 11;

UPDATE apiario 
    SET descripcion = 'Zona restringida y monitoreada' 
    WHERE id_apiario = 5;
    ROLLBACK;

-- PANTALLA 2: SELECT DESPUÉS
SELECT id_usuario, nombre, tipo_usuario FROM usuarios WHERE id_usuario = 11;
SELECT id_apiario, nombre_apiario, descripcion FROM apiario WHERE id_apiario = 5;

-- 2. CONSISTENCIA
-- Realice 3 operaciones (un INSERT, un UPDATE y un DELETE) 
-- que demuestren la consistencia de la base de datos. 
-- Escoja el escenario y explique porqué fallaron. 
-- Ejemplo: inserción de un registro con la misma PK, 
-- actualizar un dato que no respete un CHECK, 
-- borrar una cabecera de pedido sin borrar el detalle.

INSERT INTO producto (id_producto, nombre_producto, descripcion)
VALUES (100, 'Miel de Bosque', 'Nuevo tipo de miel');

UPDATE apicultor_producto
SET precio = -5000
WHERE id_usuario = 11 AND id_producto = 70;

DELETE FROM pedido WHERE id_pedido = 1;

-- 3. AISLAMIENTO
-- Proponga un caso hipotético. No tiene que realizar la transacción

-- CASO HIPOTETICO:
-- Tenemos dos usuarios (Transacción A y Transacción B) trabajando al mismo tiempo 
-- sobre el mismo lote de producto con id_lote = 50.
-- Transacción A: Actualiza la cantidad del lote restando lo vendido, pero AÚN NO HACE COMMIT.
  BEGIN;
    UPDATE lote SET cantidad_producida = cantidad_producida - 5 WHERE id_lote = 50;
  COMMIT;
-- Transacción B: Quiere consultar la cantidad disponible de ese mismo lote en este instante.

-- 4. DURABILIDAD
-- Realice una operación COMMIT. 
-- Muestre 2 pantallas en el Quey Tool. 
-- Demuestre con consulta (SELECT) antes y después de la ejecución del COMMIT 
-- la actualización del dato.

-- PANTALLA 1: SELECT ANTES
SELECT id_lote, estado, cantidad_producida 
FROM lote 
WHERE id_lote = 10;

BEGIN;
    UPDATE lote 
    SET estado = 'vendido', 
        cantidad_producida = 0 
    WHERE id_lote = 10;

    COMMIT;

-- PANTALLA 2: SELECT DESPUES
SELECT id_lote, estado, cantidad_producida 
FROM lote 
WHERE id_lote = 10;