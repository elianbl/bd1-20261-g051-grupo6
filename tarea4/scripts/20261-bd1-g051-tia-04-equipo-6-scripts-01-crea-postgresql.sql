CREATE TABLE organizacion(

	id_organizacion SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	tipo VARCHAR(50) NOT NULL,
	direccion VARCHAR(150),
	telefono VARCHAR(25),
	nit VARCHAR(20)  UNIQUE NOT NULL


);


CREATE TABLE usuarios(

	id_usuario SERIAL PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	email VARCHAR(130) UNIQUE NOT NULL,
	contrasena VARCHAR(260) NOT NULL,
	telefono VARCHAR(25),
	tipo_usuario VARCHAR(30) NOT NULL CHECK(tipo_usuario IN ('productor', 'consumidor', 'administrador', 'entidad')),
	fecha_registro DATE NOT NULL,
	id_organizacion INT,

	CONSTRAINT fk_usuario_organizacion FOREIGN KEY (id_organizacion) REFERENCES organizacion(id_organizacion)


);


CREATE TABLE apiario(

	id_apiario SERIAL PRIMARY KEY,
	nombre_apiario VARCHAR(100) NOT NULL,
	ubicacion JSONB NOT NULL,
	id_usuario INT NOT NULL,
	descripcion TEXT,

	CONSTRAINT fk_apiario_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)


);


CREATE TABLE colmena(

	id_colmena SERIAL PRIMARY KEY,
	id_apiario INT NOT NULL,
	codigo_colmena  VARCHAR(30) UNIQUE NOT NULL,
	estado VARCHAR(50) NOT NULL,
	tipo_abeja VARCHAR(50) NOT NULL,
	fecha_instalacion DATE NOT NULL,

	CONSTRAINT fk_colmena_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)

);



CREATE TABLE sensor(

	id_sensor SERIAL PRIMARY KEY,
	tipo_sensor VARCHAR(50) NOT NULL,
	id_apiario INT NOT NULL,
	fecha_instalacion DATE NOT NULL,

	CONSTRAINT fk_sensor_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)

);


CREATE TABLE cosecha(

	id_cosecha SERIAL PRIMARY KEY,
	id_apiario INT NOT NULL,
	fecha_cosecha DATE NOT NULL,
	cantidad_total DECIMAL(10,2) NOT NULL CHECK(cantidad_total > 0),

	CONSTRAINT fk_cosecha_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
	
	
);


CREATE TABLE lote( 

	id_lote SERIAL PRIMARY KEY,
	id_cosecha INT NOT NULL,
	tipo_producto VARCHAR(50) NOT NULL,
	cantidad_producida DECIMAL(10,2) NOT NULL CHECK(cantidad_producida > 0),
	estado VARCHAR(30) NOT NULL CHECK(estado IN ('disponible', 'vendido', 'reservado')),

	CONSTRAINT fk_lote_cosecha FOREIGN key (id_cosecha) REFERENCES cosecha(id_cosecha)
	
);


CREATE TABLE lectura_sensor(

	id_lectura SERIAL PRIMARY KEY,
	id_sensor INT NOT NULL,
	valor DECIMAL(10,2) NOT NULL,
	detalles JSONB,
	fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_lectura_sensor FOREIGN KEY (id_sensor) REFERENCES sensor(id_sensor)

);


CREATE TABLE control(

	id_control SERIAL PRIMARY KEY,
	id_colmena INT NOT NULL,
	fecha DATE NOT NULL,
	tratamiento VARCHAR(150),
	observaciones TEXT,

	CONSTRAINT fk_control_colmena FOREIGN KEY (id_colmena) REFERENCES colmena(id_colmena)

);


CREATE TABLE inventario(

	id_inventario SERIAL PRIMARY KEY,
	id_lote INT NOT NULL,
	id_usuario INT NOT NULL,
	cantidad_disponible DECIMAL(10,2) NOT NULL CHECK( cantidad_disponible >=0),

	CONSTRAINT fk_inventario_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
	CONSTRAINT fk_inventario_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)

);



CREATE TABLE publicacion(

	id_publicacion SERIAL PRIMARY KEY,
	id_lote INT NOT NULL, 
	id_usuario INT NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
	estado VARCHAR(30) NOT NULL CHECK( estado IN ('disponible', 'vendido', 'pausado')),
	fecha_publicacion DATE NOT NULL,

	CONSTRAINT fk_publicacion_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
	CONSTRAINT fk_publicacion_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)

);


CREATE TABLE pedido(

	id_pedido SERIAL PRIMARY KEY,
	id_usuario INT NOT NULL,
	fecha_pedido DATE NOT NULL,
	estado VARCHAR(50) NOT NULL CHECK (estado IN ('pendiente', 'pagado', 'enviado', 'cancelado')),

	CONSTRAINT fk_pedido_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)

);



CREATE TABLE pedido_lote(

	id_pedido INT NOT NULL,
	id_lote INT NOT NULL,
	cantidad DECIMAL(10,2) NOT NULL CHECK (cantidad > 0),

	CONSTRAINT pk_pedido_lote PRIMARY KEY (id_pedido, id_lote),

	CONSTRAINT fk_pedido_lote_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),

	CONSTRAINT fk_pedido_lote_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote)

);



CREATE TABLE pago(

	id_pago SERIAL PRIMARY KEY,
	id_pedido INT NOT NULL UNIQUE,
	monto DECIMAL(10,2) NOT NULL CHECK(monto > 0 ),
	metodo_pago VARCHAR(50) NOT NULL,
	estado_pago VARCHAR(30) NOT NULL CHECK(estado_pago IN ('pendiente', 'pagado', 'rechazado')),
	fecha_pago DATE NOT NULL,

	CONSTRAINT fk_pago_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
	
);


CREATE TABLE envio(

	id_envio SERIAL PRIMARY KEY,
	id_pedido INT NOT NULL UNIQUE,
	direccion VARCHAR(150) NOT NULL,
	transportadora VARCHAR(100) NOT NULL,
	estado_envio VARCHAR(50) NOT NULL CHECK(estado_envio IN ('en_bodega', 'preparando', 'en_transito', 'entregado')),

	CONSTRAINT fk_envio_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
	
);



CREATE TABLE documento(

	id_documento SERIAL PRIMARY KEY,
	id_usuario INT,
	id_apiario INT,
	id_lote INT,
	tipo_documento VARCHAR(80) NOT NULL,
	fecha DATE NOT NULL,
	estado VARCHAR(30) NOT NULL CHECK(estado IN ('vigente', 'vencido', 'en_tramite')),

	CONSTRAINT fk_documento_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	CONSTRAINT fk_documento_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario),
	CONSTRAINT fk_documento_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote),

	CONSTRAINT chk_documento_relacion CHECK (
		id_usuario IS NOT NULL OR
		id_apiario IS NOT NULL OR
		id_lote IS NOT NULL
	)
	

);



CREATE TABLE actividad_comunidad(

	id_actividad SERIAL PRIMARY KEY,
	id_usuario INT NOT NULL,
	titulo VARCHAR(100) NOT NULL,
	descripcion TEXT,
	tipo VARCHAR(50) NOT NULL,
	fecha DATE,

	CONSTRAINT fk_actividad_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)


);

CREATE TABLE obligacion(

	id_obligacion SERIAL PRIMARY KEY,
	id_usuario INT NOT NULL,
	id_organizacion INT NOT NULL,
	monto DECIMAL(12,2) NOT NULL CHECK(monto > 0),
	tipo VARCHAR(50) NOT NULL CHECK( tipo IN ('credito', 'subsidio')),
	fecha_inicio DATE NOT NULL,
	estado VARCHAR(30) NOT NULL CHECK (estado IN ('activo', 'pagado', 'vencido')),

	CONSTRAINT fk_obligacion_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	CONSTRAINT fk_obligacion_organizacion FOREIGN KEY (id_organizacion)
	REFERENCES organizacion(id_organizacion)
	

);
