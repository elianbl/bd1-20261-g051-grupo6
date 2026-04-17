create database if not exists apicultura_db
character set utf8mb4
collate utf8mb4_unicode_ci;

use apicultura_db;

create table organizacion(
    id_organizacion int auto_increment primary key,
    nombre varchar(100) not null,
    tipo varchar(50) not null,
    direccion varchar(150),
    telefono varchar(25),
    nit varchar(20) unique not null
);

create table usuarios(
    id_usuario int auto_increment primary key,
    nombre varchar(100) not null,
    email varchar(130) unique not null,
    contrasena varchar(260) not null,
    telefono varchar(25),
    tipo_usuario varchar(30) not null,
    fecha_registro date not null,
    id_organizacion int,
    
    constraint chk_tipo_usuario 
    check (tipo_usuario in ('productor', 'consumidor', 'administrador', 'entidad')),
    
    constraint fk_usuario_organizacion 
    foreign key (id_organizacion) references organizacion(id_organizacion)
);

create table apiario(
    id_apiario int auto_increment primary key,
    nombre_apiario varchar(100) not null,
    ubicacion json not null,
    id_usuario int not null,
    descripcion text,
    
    constraint fk_apiario_usuario 
    foreign key (id_usuario) references usuarios(id_usuario)
);

create table colmena(
    id_colmena int auto_increment primary key,
    id_apiario int not null,
    codigo_colmena varchar(30) unique not null,
    estado varchar(50) not null,
    tipo_abeja varchar(50) not null,
    fecha_instalacion date not null,
    
    constraint fk_colmena_apiario 
    foreign key (id_apiario) references apiario(id_apiario)
);

create table sensor(
    id_sensor int auto_increment primary key,
    tipo_sensor varchar(50) not null,
    id_apiario int not null,
    fecha_instalacion date not null,
    
    constraint fk_sensor_apiario 
    foreign key (id_apiario) references apiario(id_apiario)
);

create table cosecha(
    id_cosecha int auto_increment primary key,
    id_apiario int not null,
    fecha_cosecha date not null,
    cantidad_total decimal(10,2) not null,
    
    constraint chk_cantidad_total check (cantidad_total > 0),
    
    constraint fk_cosecha_apiario 
    foreign key (id_apiario) references apiario(id_apiario)
);

create table lote(
    id_lote int auto_increment primary key,
    id_cosecha int not null,
    tipo_producto varchar(50) not null,
    cantidad_producida decimal(10,2) not null,
    estado varchar(30) not null,
    
    constraint chk_cantidad_producida check (cantidad_producida > 0),
    constraint chk_estado_lote check (estado in ('disponible', 'vendido', 'reservado')),
    
    constraint fk_lote_cosecha 
    foreign key (id_cosecha) references cosecha(id_cosecha)
);

create table lectura(
    id_lectura int auto_increment primary key,
    id_sensor int not null,
    valor decimal(10,2) not null,
    detalles json,
    fecha datetime not null default current_timestamp,
    
    constraint fk_lectura_sensor 
    foreign key (id_sensor) references sensor(id_sensor)
);

create table control(
    id_control int auto_increment primary key,
    id_colmena int not null,
    fecha date not null,
    tratamiento varchar(150),
    observaciones text,
    
    constraint fk_control_colmena 
    foreign key (id_colmena) references colmena(id_colmena)
);

create table inventario(
    id_inventario int auto_increment primary key,
    id_lote int not null,
    id_usuario int not null,
    cantidad_disponible decimal(10,2) not null,
    
    constraint chk_inventario check (cantidad_disponible >= 0),
    
    constraint fk_inventario_lote 
    foreign key (id_lote) references lote(id_lote),
    
    constraint fk_inventario_usuario 
    foreign key (id_usuario) references usuarios(id_usuario)
);

create table publicacion(
    id_publicacion int auto_increment primary key,
    id_lote int not null,
    id_usuario int not null,
    precio decimal(10,2) not null,
    estado varchar(30) not null,
    fecha_publicacion date not null,
    
    constraint chk_estado_publicacion 
    check (estado in ('disponible', 'vendido', 'pausado')),
    
    constraint fk_publicacion_lote 
    foreign key (id_lote) references lote(id_lote),
    
    constraint fk_publicacion_usuario 
    foreign key (id_usuario) references usuarios(id_usuario)
);

create table pedido(
    id_pedido int auto_increment primary key,
    id_usuario int not null,
    fecha_pedido date not null,
    estado varchar(50) not null,
    
    constraint chk_estado_pedido 
    check (estado in ('pendiente', 'pagado', 'enviado', 'cancelado')),
    
    constraint fk_pedido_usuario 
    foreign key (id_usuario) references usuarios(id_usuario)
);

create table pedido_lote(
    id_pedido int not null,
    id_lote int not null,
    cantidad decimal(10,2) not null,
    
    primary key (id_pedido, id_lote),
    
    constraint chk_cantidad_pedido check (cantidad > 0),
    
    constraint fk_pedido_lote_pedido 
    foreign key (id_pedido) references pedido(id_pedido),
    
    constraint fk_pedido_lote_lote 
    foreign key (id_lote) references lote(id_lote)
);

create table pago(
    id_pago int auto_increment primary key,
    id_pedido int not null unique,
    monto decimal(10,2) not null,
    metodo_pago varchar(50) not null,
    estado_pago varchar(30) not null,
    fecha_pago date not null,
    
    constraint chk_pago check (monto > 0),
    constraint chk_estado_pago check (estado_pago in ('pendiente', 'pagado', 'rechazado')),
    
    constraint fk_pago_pedido 
    foreign key (id_pedido) references pedido(id_pedido)
);

create table envio(
    id_envio int auto_increment primary key,
    id_pedido int not null unique,
    direccion varchar(150) not null,
    transportadora varchar(100) not null,
    estado_envio varchar(50) not null,
    
    constraint chk_estado_envio 
    check (estado_envio in ('en_bodega', 'preparando', 'en_transito', 'entregado')),
    
    constraint fk_envio_pedido 
    foreign key (id_pedido) references pedido(id_pedido)
);

create table documento(
    id_documento int auto_increment primary key,
    id_usuario int,
    id_apiario int,
    id_lote int,
    tipo_documento varchar(80) not null,
    fecha date not null,
    estado varchar(30) not null,
    
    constraint chk_estado_documento 
    check (estado in ('vigente', 'vencido', 'en_tramite')),
    
    constraint fk_documento_usuario 
    foreign key (id_usuario) references usuarios(id_usuario),
    
    constraint fk_documento_apiario 
    foreign key (id_apiario) references apiario(id_apiario),
    
    constraint fk_documento_lote 
    foreign key (id_lote) references lote(id_lote),
    
    constraint chk_documento_relacion 
    check (
        id_usuario is not null or
        id_apiario is not null or
        id_lote is not null
    )
);

create table actividad_comunidad(
    id_actividad int auto_increment primary key,
    id_usuario int not null,
    titulo varchar(100) not null,
    descripcion text,
    tipo varchar(50) not null,
    fecha date,
    
    constraint fk_actividad_usuario 
    foreign key (id_usuario) references usuarios(id_usuario)
);

create table obligacion(
    id_obligacion int auto_increment primary key,
    id_usuario int not null,
    id_organizacion int not null,
    monto decimal(12,2) not null,
    tipo varchar(50) not null,
    fecha_inicio date not null,
    estado varchar(30) not null,
    
    constraint chk_monto check (monto > 0),
    constraint chk_tipo_obligacion check (tipo in ('credito', 'subsidio')),
    constraint chk_estado_obligacion check (estado in ('activo', 'pagado', 'vencido')),
    
    constraint fk_obligacion_usuario 
    foreign key (id_usuario) references usuarios(id_usuario),
    
    constraint fk_obligacion_organizacion 
    foreign key (id_organizacion) references organizacion(id_organizacion)
);