CREATE TABLE organizacion (
    id_organizacion INT IDENTITY(1,1) PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    tipo            VARCHAR(50)  NOT NULL,
    direccion       VARCHAR(150),
    telefono        VARCHAR(25),
    nit             VARCHAR(20)  NOT NULL UNIQUE
);
GO

CREATE TABLE usuarios (
    id_usuario      INT IDENTITY(1,1) PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    email           VARCHAR(130) NOT NULL UNIQUE,
    contrasena      VARCHAR(260) NOT NULL,
    telefono        VARCHAR(25),
    tipo_usuario    VARCHAR(30)  NOT NULL

        CHECK (tipo_usuario IN ('productor','consumidor','administrador','entidad')),
    fecha_registro  DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    id_organizacion INT,

    CONSTRAINT fk_usuario_organizacion
        FOREIGN KEY (id_organizacion) REFERENCES organizacion(id_organizacion)
);
GO


CREATE TABLE apiario (
    id_apiario      INT IDENTITY(1,1) PRIMARY KEY,
    nombre_apiario  VARCHAR(100) NOT NULL,
    ubicacion       NVARCHAR(MAX) NOT NULL,
    id_usuario      INT NOT NULL,
    descripcion     NVARCHAR(MAX),

    CONSTRAINT fk_apiario_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),

    CONSTRAINT chk_apiario_json  CHECK (ISJSON(ubicacion) = 1)
);
GO

CREATE TABLE colmena (
    id_colmena        INT IDENTITY(1,1) PRIMARY KEY,
    id_apiario        INT NOT NULL,
    codigo_colmena    VARCHAR(30) NOT NULL UNIQUE,
    estado            VARCHAR(50) NOT NULL,
    tipo_abeja        VARCHAR(50) NOT NULL,
    fecha_instalacion DATE NOT NULL,

    CONSTRAINT fk_colmena_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);
GO

CREATE TABLE sensor (
    id_sensor         INT IDENTITY(1,1) PRIMARY KEY,
    tipo_sensor       VARCHAR(50) NOT NULL,
    id_apiario        INT NOT NULL,
    fecha_instalacion DATE NOT NULL,

    CONSTRAINT fk_sensor_apiario  FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);
GO

CREATE TABLE cosecha (
    id_cosecha     INT IDENTITY(1,1) PRIMARY KEY,
    id_apiario     INT NOT NULL,
    fecha_cosecha  DATE NOT NULL,
    cantidad_total DECIMAL(10,2) NOT NULL CHECK (cantidad_total > 0),

    CONSTRAINT fk_cosecha_apiario FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);
GO

CREATE TABLE lote (
    id_lote            INT IDENTITY(1,1) PRIMARY KEY,
    id_cosecha         INT NOT NULL,
    tipo_producto      VARCHAR(50) NOT NULL,
    cantidad_producida DECIMAL(10,2) NOT NULL CHECK (cantidad_producida > 0),
    estado             VARCHAR(30) NOT NULL CHECK (estado IN ('disponible','vendido','reservado')),

    CONSTRAINT fk_lote_cosecha FOREIGN KEY (id_cosecha) REFERENCES cosecha(id_cosecha)
);
GO


CREATE TABLE lectura (
    id_lectura INT IDENTITY(1,1) PRIMARY KEY,
    id_sensor  INT NOT NULL,
    valor      DECIMAL(10,2) NOT NULL,
    detalles   NVARCHAR(MAX),
    fecha      DATETIME2 NOT NULL DEFAULT SYSDATETIME(),

    CONSTRAINT fk_lectura_sensor FOREIGN KEY (id_sensor) REFERENCES sensor(id_sensor),

    CONSTRAINT chk_lectura_json CHECK (detalles IS NULL OR ISJSON(detalles) = 1)
);
GO

CREATE TABLE control (
    id_control    INT IDENTITY(1,1) PRIMARY KEY,
    id_colmena    INT NOT NULL,
    fecha         DATE NOT NULL,
    tratamiento   VARCHAR(150),
    observaciones NVARCHAR(MAX),

    CONSTRAINT fk_control_colmena FOREIGN KEY (id_colmena) REFERENCES colmena(id_colmena)
);
GO


CREATE TABLE inventario (
    id_inventario       INT IDENTITY(1,1) PRIMARY KEY,
    id_lote             INT NOT NULL,
    id_usuario          INT NOT NULL,
    cantidad_disponible DECIMAL(10,2) NOT NULL CHECK (cantidad_disponible >= 0),

    CONSTRAINT fk_inventario_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
    CONSTRAINT fk_inventario_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO

CREATE TABLE publicacion (
    id_publicacion    INT IDENTITY(1,1) PRIMARY KEY,
    id_lote           INT NOT NULL,
    id_usuario        INT NOT NULL,
    precio            DECIMAL(10,2) NOT NULL,
    estado            VARCHAR(30) NOT NULL CHECK (estado IN ('disponible','vendido','pausado')),
    fecha_publicacion DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),

    CONSTRAINT fk_publicacion_lote FOREIGN KEY (id_lote) REFERENCES lote(id_lote),
    CONSTRAINT fk_publicacion_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO


CREATE TABLE pedido (
    id_pedido    INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario   INT NOT NULL,
    fecha_pedido DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    estado       VARCHAR(50) NOT NULL CHECK (estado IN ('pendiente','pagado','enviado','cancelado')),

    CONSTRAINT fk_pedido_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO

CREATE TABLE pedido_lote (
    id_pedido INT NOT NULL,
    id_lote   INT NOT NULL,
    cantidad  DECIMAL(10,2) NOT NULL CHECK (cantidad > 0),

    CONSTRAINT pk_pedido_lote PRIMARY KEY (id_pedido, id_lote),

    CONSTRAINT fk_pedido_lote_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_pedido_lote_lote
        FOREIGN KEY (id_lote) REFERENCES lote(id_lote)
);
GO

CREATE TABLE pago (
    id_pago     INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido   INT NOT NULL UNIQUE,
    monto       DECIMAL(10,2) NOT NULL CHECK (monto > 0),
    metodo_pago VARCHAR(50) NOT NULL,
    estado_pago VARCHAR(30) NOT NULL
        CHECK (estado_pago IN ('pendiente','pagado','rechazado')),
    fecha_pago  DATE NOT NULL,

    CONSTRAINT fk_pago_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
GO

CREATE TABLE envio (
    id_envio       INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido      INT NOT NULL UNIQUE,
    direccion      VARCHAR(150) NOT NULL,
    transportadora VARCHAR(100) NOT NULL,
    estado_envio   VARCHAR(50) NOT NULL
        CHECK (estado_envio IN ('en_bodega','preparando','en_transito','entregado')),

    CONSTRAINT fk_envio_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);
GO


CREATE TABLE documento (
    id_documento   INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario     INT,
    id_apiario     INT,
    id_lote        INT,
    tipo_documento VARCHAR(80) NOT NULL,
    fecha          DATE NOT NULL,
    estado         VARCHAR(30) NOT NULL
        CHECK (estado IN ('vigente','vencido','en_tramite')),

    CONSTRAINT fk_documento_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_documento_apiario
        FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario),
    CONSTRAINT fk_documento_lote
        FOREIGN KEY (id_lote) REFERENCES lote(id_lote),

    CONSTRAINT chk_documento_relacion
        CHECK (id_usuario IS NOT NULL OR id_apiario IS NOT NULL OR id_lote IS NOT NULL)
);
GO

CREATE TABLE actividad_comunidad (
    id_actividad INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario   INT NOT NULL,
    titulo       VARCHAR(100) NOT NULL,
    descripcion  NVARCHAR(MAX),
    tipo         VARCHAR(50) NOT NULL,
    fecha        DATE,

    CONSTRAINT fk_actividad_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO


CREATE TABLE obligacion (
    id_obligacion   INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario      INT NOT NULL,
    id_organizacion INT NOT NULL,
    monto           DECIMAL(12,2) NOT NULL CHECK (monto > 0),
    tipo            VARCHAR(50) NOT NULL  CHECK (tipo IN ('credito','subsidio')),
    fecha_inicio    DATE NOT NULL,
    estado          VARCHAR(30) NOT NULL  CHECK (estado IN ('activo','pagado','vencido')),

    CONSTRAINT fk_obligacion_usuario  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_obligacion_organizacion FOREIGN KEY (id_organizacion) REFERENCES organizacion(id_organizacion)
);
GO



CREATE INDEX idx_usuario_org       ON usuarios(id_organizacion);
CREATE INDEX idx_apiario_usuario   ON apiario(id_usuario);
CREATE INDEX idx_colmena_apiario   ON colmena(id_apiario);
CREATE INDEX idx_sensor_apiario    ON sensor(id_apiario);
CREATE INDEX idx_cosecha_apiario   ON cosecha(id_apiario);
CREATE INDEX idx_lote_cosecha      ON lote(id_cosecha);
CREATE INDEX idx_lectura_sensor    ON lectura(id_sensor);
CREATE INDEX idx_control_colmena   ON control(id_colmena);
CREATE INDEX idx_inventario_lote   ON inventario(id_lote);
CREATE INDEX idx_inventario_usuario ON inventario(id_usuario);
CREATE INDEX idx_publicacion_lote  ON publicacion(id_lote);
CREATE INDEX idx_publicacion_usuario ON publicacion(id_usuario);
CREATE INDEX idx_pedido_usuario    ON pedido(id_usuario);
