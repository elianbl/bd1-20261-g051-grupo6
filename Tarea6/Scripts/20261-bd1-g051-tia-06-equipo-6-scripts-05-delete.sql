INSERT INTO producto (id_producto, nombre_producto, descripcion) 
VALUES (700, 'Miel de Caña Erronea', 'Miel de prueba ingresada por error');

DELETE FROM producto WHERE id_producto = 700;


INSERT INTO usuarios (id_usuario, nombre, email, contrasena, telefono, tipo_usuario, fecha_registro, id_organizacion) 
VALUES (9999, 'Apicultor Inactivo de Prueba', 'prueba.apicultor9999@gmail.com', 'salu2jaimesoto', '3109999999', 'productor', CURRENT_DATE, NULL);

DELETE FROM usuarios WHERE id_usuario = 9999;
