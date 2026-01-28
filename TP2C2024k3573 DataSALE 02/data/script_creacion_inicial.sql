USE GD2C2024

GO

IF NOT EXISTS ( SELECT * FROM sys.schemas WHERE name = 'DataSALE')
BEGIN
    EXEC ('CREATE SCHEMA DataSALE');
END

GO

--CREACION DE TABLAS
CREATE TABLE DataSALE.DetallePago (
    detalle_id INT IDENTITY(1,1) NOT NULL,
    nro_tarjeta NVARCHAR(50),
    fecha_venc_tarjeta DATE,
    cant_cuotas DECIMAL(18, 0)
);

CREATE TABLE DataSALE.Marca (
	id_marca INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50)
	)

CREATE TABLE DataSALE.Modelo (
	modelo_codigo DECIMAL(18,0) NOT NULL,
	modelo_descripcion NVARCHAR(50)
	)

CREATE TABLE DataSALE.Provincia (
    provincia_id INT IDENTITY(1,1) NOT NULL,
    nombre NVARCHAR(50)
);

CREATE TABLE DataSALE.Rubro (
	id_rubro INT IDENTITY(1,1) NOT NULL,
	nombre NVARCHAR(50)
	)

CREATE TABLE DataSALE.TipoDetalleFactura(
    id_tipo_detalle_factura INT IDENTITY(1,1) NOT NULL,
    detalle_tipo NVARCHAR(50)
)

CREATE TABLE DataSALE.TipoEnvio (
    tipo_envio_id INT IDENTITY(1,1) NOT NULL,
    tipo_envio NVARCHAR(50)
);

CREATE TABLE DataSALE.TipoMedioPago (
    tipo_medio_pago_id INT IDENTITY(1,1) NOT NULL,
    detalle NVARCHAR(50)
);

CREATE TABLE DataSALE.Usuario (
    usuario_id INT IDENTITY(1,1) NOT NULL,
    nombre NVARCHAR(50),
    fecha_creacion DATE,
    pass NVARCHAR(50)
);

CREATE TABLE DataSALE.Cliente (
    cliente_id INT IDENTITY(1,1) NOT NULL,
    usuario_id INT,
    nombre NVARCHAR(50),
    apellido NVARCHAR(50),
    mail NVARCHAR(50),
    fecha_nacimiento DATE,
    dni DECIMAL(18,0)
);

CREATE TABLE DataSALE.Vendedor (
    vendedor_id INT IDENTITY(1,1) NOT NULL,
    usuario_id INT,
    razon_social NVARCHAR(50),
    mail NVARCHAR(50),
    cuit NVARCHAR(50)
);

CREATE TABLE DataSALE.Localidad (
    localidad_id INT IDENTITY(1,1) NOT NULL,
    provincia_id INT,
    nombre NVARCHAR(50),
    codigo_postal NVARCHAR(50)
);

CREATE TABLE DataSALE.Domicilio (
    domicilio_id INT IDENTITY(1,1) NOT NULL,
    usuario_id INT,
    calle NVARCHAR(50),
    nro_calle DECIMAL(18,0),
    piso DECIMAL(18,0),
    departamento NVARCHAR(50),
    localidad_id INT
);

CREATE TABLE DataSALE.Factura(
    nro_factura DECIMAL(18,0) NOT NULL,
    factura_fecha DATE,
    usuario_id INT
)

CREATE TABLE DataSALE.DetalleFactura(
    id_detalle_factura INT IDENTITY(1,1) NOT NULL,
    nro_factura DECIMAL(18,0),
    codigo_publicacion DECIMAL(18,0),
    id_tipo_detalle_factura INT,
    cantidad DECIMAL(18,0),
    precio DECIMAL(18,2)
)

CREATE TABLE DataSALE.Almacen(
    codigo_almacen DECIMAL(18,0) NOT NULL,
    calle NVARCHAR(50),
    nro_calle DECIMAL(18,0),
    costo_dia DECIMAL(18,2),
    localidad_id INT
)

CREATE TABLE DataSALE.Producto (
	codigo_producto NVARCHAR(50) NOT NULL,
	producto_descripcion NVARCHAR(50),
	id_marca INT,
	producto_precio DECIMAL(18,2),
	modelo_codigo DECIMAL(18,0) NOT NULL,
	id_subrubro INT,
	)

CREATE TABLE DataSALE.SubRubro (
	id_subrubro INT IDENTITY(1,1) NOT NULL,
	id_rubro INT,
	nombre NVARCHAR(50),
	rubro_descripcion NVARCHAR(50)
	)

CREATE TABLE DataSALE.Publicacion (
	codigo_publicacion DECIMAL(18,0) NOT NULL,
	publicacion_descripcion NVARCHAR(50),
	fecha_publicacion DATE,
	fecha_vencimiento DATE,
	codigo_producto NVARCHAR(50),
	publicacion_precio DECIMAL(18,2),
	vendedor_id INT,
	codigo_almacen DECIMAL(18,0),
	costo_publicacion DECIMAL(18,2),
	porcentaje_venta DECIMAL(18,2),
	stock DECIMAL(18,0)
	)

CREATE TABLE DataSALE.Venta (
    codigo_venta DECIMAL(18, 0)  NOT NULL,
    cliente_id INT,
    fecha_realizacion DATE
);

CREATE TABLE DataSALE.DetalleVenta (
    detalle_id INT IDENTITY(1,1) NOT NULL,
    codigo_venta DECIMAL(18, 0)  NOT NULL,
    precio DECIMAL(18, 2),
    cant_productos DECIMAL(18, 0),
    codigo_publicacion DECIMAL(18, 0)  NOT NULL
);

CREATE TABLE DataSALE.MedioPago (
    medio_pago_id INT IDENTITY(1,1) NOT NULL,
    tipo_medio_pago_id INT,
    detalle NVARCHAR(50)
);

CREATE TABLE DataSALE.Pago (
    nro_pago INT IDENTITY(1,1) NOT NULL,
    codigo_venta DECIMAL(18, 0)  NOT NULL,
    medio_pago_id INT,
    detalle_id INT,
    importe DECIMAL(18,2),
    fecha DATE
);

CREATE TABLE DataSALE.Envio (
    nro_envio INT IDENTITY(1,1) NOT NULL,
    codigo_venta DECIMAL(18, 0)  NOT NULL,
    fecha_envio DATE,
    hora_inicio DECIMAL(18, 0),
    hora_fin DECIMAL(18, 0),
    costo_envio DECIMAL(18,2),
    fecha_entrega DATETIME,
    tipo_envio_id INT
);

-- AGREGO LAS CONSTRAINS
-- PRIMARY KEY

ALTER TABLE DataSALE.DetallePago
	ADD CONSTRAINT detalle_pago_pk PRIMARY KEY (detalle_id);

ALTER TABLE DataSALE.Marca
	ADD CONSTRAINT marca_pk PRIMARY KEY (id_marca);

ALTER TABLE DataSALE.Modelo
	ADD CONSTRAINT modelo_pk PRIMARY KEY (modelo_codigo);

ALTER TABLE DataSALE.Provincia
ADD CONSTRAINT provincia_pk PRIMARY KEY (provincia_id);

ALTER TABLE DataSALE.Rubro
	ADD CONSTRAINT rubro_pk PRIMARY KEY (id_rubro);

ALTER TABLE DataSALE.TipoDetalleFactura
	ADD CONSTRAINT tipo_detalle_factura_pk PRIMARY KEY (id_tipo_detalle_factura);

ALTER TABLE DataSALE.TipoEnvio
	ADD CONSTRAINT tipo_envio_pk PRIMARY KEY (tipo_envio_id);

ALTER TABLE DataSALE.TipoMedioPago
	ADD CONSTRAINT tipo_medio_pago_pk PRIMARY KEY (tipo_medio_pago_id);

ALTER TABLE DataSALE.Usuario
ADD CONSTRAINT usuario_pk PRIMARY KEY (usuario_id);

ALTER TABLE DataSALE.Producto
	ADD CONSTRAINT producto_pk PRIMARY KEY (codigo_producto);

ALTER TABLE DataSALE.SubRubro
	ADD CONSTRAINT subrubro_pk PRIMARY KEY (id_subrubro);

ALTER TABLE DataSALE.Publicacion
	ADD CONSTRAINT publicacion_pk PRIMARY KEY (codigo_publicacion);

ALTER TABLE DataSALE.Venta
	ADD CONSTRAINT venta_pk PRIMARY KEY (codigo_venta);

ALTER TABLE DataSALE.DetalleVenta
	ADD CONSTRAINT detalle_venta_pk PRIMARY KEY (detalle_id);

ALTER TABLE DataSALE.MedioPago
	ADD CONSTRAINT medio_pago_pk PRIMARY KEY (medio_pago_id);

ALTER TABLE DataSALE.Pago
	ADD CONSTRAINT pago_pk PRIMARY KEY (nro_pago);

ALTER TABLE DataSALE.Envio
	ADD CONSTRAINT envio_pk PRIMARY KEY (nro_envio);

ALTER TABLE DataSALE.Factura
	ADD CONSTRAINT factura_pk PRIMARY KEY (nro_factura);

ALTER TABLE DataSALE.DetalleFactura
	ADD CONSTRAINT detalle_factura_pk PRIMARY KEY (id_detalle_factura);

ALTER TABLE DataSALE.Almacen
	ADD CONSTRAINT almacen_pk PRIMARY KEY (codigo_almacen);

ALTER TABLE DataSALE.Cliente
ADD CONSTRAINT cliente_pk PRIMARY KEY (cliente_id);

ALTER TABLE DataSALE.Vendedor
ADD CONSTRAINT vendedor_pk PRIMARY KEY (vendedor_id);

ALTER TABLE DataSALE.Localidad
ADD CONSTRAINT localidad_pk PRIMARY KEY (localidad_id);

ALTER TABLE DataSALE.Domicilio
ADD CONSTRAINT domicilio_pk PRIMARY KEY (domicilio_id);

-- FOREING KEY

ALTER TABLE DataSALE.Producto
	ADD	CONSTRAINT	marca_fk FOREIGN KEY (id_marca)	
	REFERENCES	DataSALE.Marca(id_marca);

ALTER TABLE DataSALE.Producto
	ADD	CONSTRAINT	modelo_fk FOREIGN KEY (modelo_codigo)	
	REFERENCES	DataSALE.Modelo(modelo_codigo);
	
ALTER TABLE DataSALE.Producto
	ADD	CONSTRAINT	subrubro_fk FOREIGN KEY (id_subrubro)	
	REFERENCES	DataSALE.Subrubro(id_subrubro);

ALTER TABLE DataSALE.Subrubro
	ADD	CONSTRAINT	rubro_fk FOREIGN KEY (id_rubro)	
	REFERENCES	DataSALE.Rubro(id_rubro);

ALTER TABLE DataSALE.Publicacion
	ADD	CONSTRAINT	producto_fk FOREIGN KEY (codigo_producto)	
	REFERENCES	DataSALE.Producto(codigo_producto);

ALTER TABLE DataSALE.Publicacion
	ADD	CONSTRAINT vendedor_fk FOREIGN KEY (vendedor_id)	
	REFERENCES DataSALE.Usuario(usuario_id);

ALTER TABLE DataSALE.Publicacion
	ADD	CONSTRAINT almacen_fk FOREIGN KEY (codigo_almacen)	
	REFERENCES	DataSALE.Almacen(codigo_almacen);

ALTER TABLE DataSALE.Venta
	ADD	CONSTRAINT cliente_id_fk FOREIGN KEY (cliente_id)	
	REFERENCES	DataSALE.Cliente(cliente_id);

ALTER TABLE DataSALE.DetalleVenta
	ADD	CONSTRAINT venta_fk FOREIGN KEY (codigo_venta) 
    REFERENCES DataSALE.Venta(codigo_venta);

ALTER TABLE DataSALE.MedioPago
	ADD	CONSTRAINT tipo_medio_pago_fk FOREIGN KEY (tipo_medio_pago_id) 
    REFERENCES DataSALE.TipoMedioPago(tipo_medio_pago_id);

ALTER TABLE DataSALE.Pago
	ADD	CONSTRAINT pago_codigo_venta_fk FOREIGN KEY (codigo_venta) 
    REFERENCES DataSALE.Venta(codigo_venta);

ALTER TABLE DataSALE.Pago
	ADD	CONSTRAINT medio_pago_fk FOREIGN KEY (medio_pago_id) 
    REFERENCES DataSALE.MedioPago(medio_pago_id);

ALTER TABLE DataSALE.Pago
	ADD	CONSTRAINT detalle_fk FOREIGN KEY (detalle_id)
    REFERENCES DataSALE.DetallePago(detalle_id);

ALTER TABLE DataSALE.Envio
	ADD	CONSTRAINT envio_codigo_venta_fk FOREIGN KEY (codigo_venta) 
    REFERENCES DataSALE.Venta(codigo_venta);

ALTER TABLE DataSALE.Envio
	ADD	CONSTRAINT tipo_envio_fk FOREIGN KEY (tipo_envio_id) 
    REFERENCES DataSALE.TipoEnvio(tipo_envio_id);

ALTER TABLE DataSALE.Factura
	ADD	CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) 
    REFERENCES DataSALE.Usuario(usuario_id);

ALTER TABLE DataSALE.DetalleFactura
	ADD	CONSTRAINT factura_fk FOREIGN KEY (nro_factura) 
    REFERENCES DataSALE.Factura(nro_factura);

ALTER TABLE DataSALE.DetalleFactura
	ADD	CONSTRAINT publicacion_fk FOREIGN KEY (codigo_publicacion) 
    REFERENCES DataSALE.Publicacion(codigo_publicacion);

ALTER TABLE DataSALE.DetalleFactura
	ADD	CONSTRAINT tipo_detalle_factura_fk FOREIGN KEY (id_tipo_detalle_factura) 
    REFERENCES DataSALE.TipoDetalleFactura(id_tipo_detalle_factura);

ALTER TABLE DataSALE.Cliente
	ADD CONSTRAINT cliente_usuario_fk FOREIGN KEY (usuario_id) 
	REFERENCES DataSALE.Usuario(usuario_id);

ALTER TABLE DataSALE.Vendedor
	ADD CONSTRAINT vendedor_usuario_fk FOREIGN KEY (usuario_id) 
	REFERENCES DataSALE.Usuario(usuario_id);

ALTER TABLE DataSALE.Localidad
	ADD CONSTRAINT localidad_provincia_fk FOREIGN KEY (provincia_id) 
	REFERENCES DataSALE.Provincia(provincia_id);

ALTER TABLE DataSALE.Domicilio
	ADD CONSTRAINT domicilio_usuario_fk FOREIGN KEY (usuario_id) 
	REFERENCES DataSALE.Usuario(usuario_id);

ALTER TABLE DataSALE.Domicilio
	ADD CONSTRAINT domicilio_localidad_fk FOREIGN KEY (localidad_id) 
	REFERENCES DataSALE.Localidad(localidad_id);

-- MIGRACION DE DATOS

BEGIN TRANSACTION;

INSERT INTO DataSALE.DetallePago (nro_tarjeta, fecha_venc_tarjeta, cant_cuotas)
SELECT PAGO_NRO_TARJETA, PAGO_FECHA_VENC_TARJETA, PAGO_CANT_CUOTAS
FROM gd_esquema.Maestra
WHERE PAGO_NRO_TARJETA IS NOT NULL AND PAGO_FECHA_VENC_TARJETA IS NOT NULL AND PAGO_CANT_CUOTAS IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Marca (nombre)
SELECT DISTINCT PRODUCTO_MARCA
FROM gd_esquema.Maestra
WHERE PRODUCTO_MARCA IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Modelo (modelo_codigo, modelo_descripcion)
SELECT DISTINCT 
	PRODUCTO_MOD_CODIGO,
	PRODUCTO_MOD_DESCRIPCION
FROM gd_esquema.Maestra
WHERE PRODUCTO_MOD_CODIGO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Provincia (nombre)
SELECT DISTINCT CLI_USUARIO_DOMICILIO_PROVINCIA
FROM gd_esquema.Maestra
WHERE CLI_USUARIO_DOMICILIO_PROVINCIA IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Rubro (nombre)
SELECT DISTINCT PRODUCTO_RUBRO_DESCRIPCION
FROM gd_esquema.Maestra
WHERE PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.TipoDetalleFactura (detalle_tipo)
SELECT DISTINCT FACTURA_DET_TIPO
FROM gd_esquema.Maestra
WHERE FACTURA_DET_TIPO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.TipoEnvio (tipo_envio)
SELECT DISTINCT ENVIO_TIPO
FROM gd_esquema.Maestra
WHERE ENVIO_TIPO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.TipoMedioPago (detalle)
SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO
FROM gd_esquema.Maestra
WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Usuario (nombre, fecha_creacion, pass)
SELECT DISTINCT 
	CLI_USUARIO_NOMBRE, 
	CLI_USUARIO_FECHA_CREACION, 
	CLI_USUARIO_PASS
FROM gd_esquema.Maestra
WHERE CLI_USUARIO_NOMBRE IS NOT NULL AND CLI_USUARIO_PASS IS NOT NULL;

INSERT INTO DataSALE.Usuario (nombre, fecha_creacion, pass)
SELECT DISTINCT
	VEN_USUARIO_NOMBRE, 
	VEN_USUARIO_FECHA_CREACION, 
	VEN_USUARIO_PASS
FROM gd_esquema.Maestra
WHERE VEN_USUARIO_NOMBRE IS NOT NULL AND VEN_USUARIO_PASS IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.SubRubro (nombre, rubro_descripcion, id_rubro)
SELECT DISTINCT 
    PRODUCTO_SUB_RUBRO, 
    r.nombre,
    r.id_rubro
FROM gd_esquema.Maestra AS m
	JOIN DataSALE.Rubro r ON m.PRODUCTO_RUBRO_DESCRIPCION = r.nombre
WHERE PRODUCTO_SUB_RUBRO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Producto (codigo_producto, producto_descripcion, id_marca, producto_precio, modelo_codigo, id_subrubro)
SELECT 
    productos_filtrados.PRODUCTO_CODIGO,
    productos_filtrados.PRODUCTO_DESCRIPCION,
    productos_filtrados.id_marca,
    productos_filtrados.PRODUCTO_PRECIO,
    productos_filtrados.PRODUCTO_MOD_CODIGO,
    productos_filtrados.id_subrubro
FROM (
    SELECT distinct
	m.PRODUCTO_CODIGO,
        m.PRODUCTO_DESCRIPCION,
        mar.id_marca,
        m.PRODUCTO_PRECIO,
        m.PRODUCTO_MOD_CODIGO,
        s.id_subrubro,
        ROW_NUMBER() OVER (PARTITION BY m.PRODUCTO_CODIGO ORDER BY m.PRODUCTO_DESCRIPCION) AS rn
    FROM gd_esquema.Maestra m
    JOIN DataSALE.Marca mar ON m.PRODUCTO_MARCA = mar.nombre
    JOIN DataSALE.Subrubro s ON m.PRODUCTO_SUB_RUBRO = s.nombre
    WHERE mar.id_marca IS NOT NULL 
      AND s.id_subrubro IS NOT NULL
) AS productos_filtrados
WHERE productos_filtrados.rn = 1;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Localidad (provincia_id, nombre, codigo_postal)
SELECT DISTINCT
    p.provincia_id, 
    m.CLI_USUARIO_DOMICILIO_LOCALIDAD, 
    m.CLI_USUARIO_DOMICILIO_CP
FROM DataSALE.Provincia p 
JOIN gd_esquema.Maestra m 
    ON p.nombre = m.CLI_USUARIO_DOMICILIO_PROVINCIA
WHERE m.CLI_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL 
    AND m.CLI_USUARIO_DOMICILIO_CP IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 
        FROM DataSALE.Localidad l
        WHERE l.nombre = m.CLI_USUARIO_DOMICILIO_LOCALIDAD
          AND l.codigo_postal = m.CLI_USUARIO_DOMICILIO_CP
    );

INSERT INTO DataSALE.Localidad (provincia_id, nombre, codigo_postal)
SELECT DISTINCT
    p.provincia_id, 
    m.VEN_USUARIO_DOMICILIO_LOCALIDAD, 
    m.VEN_USUARIO_DOMICILIO_CP
FROM DataSALE.Provincia p 
JOIN gd_esquema.Maestra m 
    ON p.nombre = m.VEN_USUARIO_DOMICILIO_PROVINCIA
WHERE m.VEN_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL 
    AND m.VEN_USUARIO_DOMICILIO_CP IS NOT NULL
    AND NOT EXISTS (
        SELECT 1 
        FROM DataSALE.Localidad l
        WHERE l.nombre = m.VEN_USUARIO_DOMICILIO_LOCALIDAD
          AND l.codigo_postal = m.VEN_USUARIO_DOMICILIO_CP
    );

COMMIT;
BEGIN TRANSACTION;

WITH AlmacenesUnicos AS (
    SELECT 
        m.ALMACEN_CODIGO,
        m.ALMACEN_CALLE,
        m.ALMACEN_NRO_CALLE,
        m.ALMACEN_COSTO_DIA_AL,
        l.localidad_id,
        ROW_NUMBER() OVER(PARTITION BY m.ALMACEN_CODIGO ORDER BY m.ALMACEN_CODIGO) AS rn
    FROM gd_esquema.Maestra m
    LEFT JOIN DataSALE.Localidad l ON m.ALMACEN_Localidad = l.nombre
    WHERE m.ALMACEN_CODIGO IS NOT NULL
)

INSERT INTO DataSALE.Almacen (codigo_almacen, calle, nro_calle, costo_dia, localidad_id)
SELECT 
    ALMACEN_CODIGO, 
    ALMACEN_CALLE, 
    ALMACEN_NRO_CALLE, 
    ALMACEN_COSTO_DIA_AL, 
    localidad_id
FROM AlmacenesUnicos
WHERE rn = 1
    AND NOT EXISTS (
        SELECT 1 
        FROM DataSALE.Almacen a 
        WHERE a.codigo_almacen = AlmacenesUnicos.ALMACEN_CODIGO
    );

COMMIT;
BEGIN TRANSACTION;

WITH VendedoresUnicos AS (
    SELECT 
        u.usuario_id, 
        m.VENDEDOR_RAZON_SOCIAL, 
        m.VENDEDOR_MAIL, 
        m.VENDEDOR_CUIT,
        ROW_NUMBER() OVER (PARTITION BY m.VENDEDOR_RAZON_SOCIAL ORDER BY m.VENDEDOR_RAZON_SOCIAL) AS rn
    FROM gd_esquema.Maestra m
    JOIN DataSALE.Usuario u 
        ON u.nombre = m.VEN_USUARIO_NOMBRE 
        AND u.fecha_creacion = m.VEN_USUARIO_FECHA_CREACION
)
INSERT INTO DataSALE.Vendedor (usuario_id, razon_social, mail, cuit)
SELECT 
    usuario_id, 
    VENDEDOR_RAZON_SOCIAL, 
    VENDEDOR_MAIL, 
    VENDEDOR_CUIT
FROM VendedoresUnicos
WHERE rn = 1;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Cliente (nombre, apellido, usuario_id, mail, fecha_nacimiento, dni )
SELECT DISTINCT
	m.CLIENTE_NOMBRE,
	m.CLIENTE_APELLIDO,
	u.usuario_id,
	m.CLIENTE_MAIL,
	m.CLIENTE_FECHA_NAC,
	m.CLIENTE_DNI
FROM DataSALE.Usuario u JOIN gd_esquema.Maestra m 
	ON u.nombre = m.CLI_USUARIO_NOMBRE AND 
        u.fecha_creacion = m.CLI_USUARIO_FECHA_CREACION
WHERE NOT EXISTS (
    SELECT 1 
    FROM DataSALE.Cliente c 
    WHERE c.nombre = m.CLIENTE_NOMBRE
      AND c.apellido = m.CLIENTE_MAIL
      AND c.dni = m.CLIENTE_DNI
	  AND c.fecha_nacimiento = m.CLIENTE_FECHA_NAC
);

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Publicacion (codigo_publicacion, publicacion_descripcion, fecha_publicacion, fecha_vencimiento, codigo_producto, publicacion_precio, costo_publicacion, porcentaje_venta, stock, vendedor_id, codigo_almacen)
SELECT DISTINCT
    m.PUBLICACION_CODIGO,
    m.PUBLICACION_DESCRIPCION,
    m.PUBLICACION_FECHA,
    m.PUBLICACION_FECHA_V,
    m.PRODUCTO_CODIGO,
    m.PUBLICACION_PRECIO,
    m.PUBLICACION_COSTO,
    m.PUBLICACION_PORC_VENTA,
    m.PUBLICACION_STOCK,
	u.usuario_id,
	a.codigo_almacen
FROM gd_esquema.Maestra m 
	JOIN DataSALE.Almacen a
		ON m.ALMACEN_CODIGO = a.codigo_almacen
	JOIN DataSALE.Usuario u
		ON m.VEN_USUARIO_NOMBRE = u.nombre 
WHERE PRODUCTO_CODIGO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Venta (fecha_realizacion, cliente_id, codigo_venta)
SELECT VENTA_FECHA, usuario_id, VENTA_CODIGO
FROM (
    SELECT 
        VENTA_FECHA,
        s.usuario_id,
        VENTA_CODIGO,
        ROW_NUMBER() OVER(PARTITION BY VENTA_CODIGO ORDER BY VENTA_FECHA) AS rn
    FROM gd_esquema.Maestra m
    JOIN DataSALE.Usuario s
        ON m.CLI_USUARIO_NOMBRE = s.nombre
        AND m.CLI_USUARIO_PASS = s.pass
    WHERE VENTA_CODIGO IS NOT NULL
) AS ventas_filtradas
WHERE rn = 1;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.DetalleVenta (codigo_venta, precio, cant_productos, codigo_publicacion)
SELECT 
	m.VENTA_CODIGO, 
	m.VENTA_DET_PRECIO, 
	m.VENTA_DET_CANT, 
	m.PUBLICACION_CODIGO
FROM gd_esquema.Maestra m
WHERE m.VENTA_CODIGO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.MedioPago (tipo_medio_pago_id, detalle)
SELECT DISTINCT 
    tmp.tipo_medio_pago_id, 
    m.PAGO_MEDIO_PAGO
FROM gd_esquema.Maestra m JOIN DataSALE.TipoMedioPago tmp 
    ON m.PAGO_TIPO_MEDIO_PAGO = tmp.detalle
WHERE m.PAGO_MEDIO_PAGO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Pago (codigo_venta, medio_pago_id, detalle_id, importe, fecha)
SELECT 
    m.VENTA_CODIGO, 
    mp.medio_pago_id, 
    dp.detalle_id, 
    m.PAGO_IMPORTE, m.PAGO_FECHA
FROM gd_esquema.Maestra m
    JOIN DataSALE.MedioPago mp 
        ON m.PAGO_MEDIO_PAGO = mp.detalle
    JOIN DataSALE.DetallePago AS dp 
        ON m.PAGO_NRO_TARJETA = dp.nro_tarjeta
WHERE m.PAGO_IMPORTE IS NOT NULL AND m.PAGO_FECHA IS NOT NULL AND m.VENTA_CODIGO IS NOT NULL;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.Envio (codigo_venta, fecha_envio, hora_inicio, hora_fin, costo_envio, fecha_entrega, tipo_envio_id)
SELECT 
    m.VENTA_CODIGO, 
    m.ENVIO_FECHA_PROGAMADA, 
    m.ENVIO_HORA_INICIO,
    m.ENVIO_HORA_FIN_INICIO, 
    m.ENVIO_COSTO, 
    m.ENVIO_FECHA_ENTREGA, 
    te.tipo_envio_id
FROM gd_esquema.Maestra m JOIN DataSALE.TipoEnvio te 
    ON m.ENVIO_TIPO = te.tipo_envio
WHERE m.ENVIO_FECHA_PROGAMADA IS NOT NULL AND m.VENTA_CODIGO IS NOT NULL;

COMMIT
BEGIN TRANSACTION;

INSERT INTO DataSALE.Domicilio (usuario_id, calle, nro_calle, piso, departamento, localidad_id)
SELECT 
    u.usuario_id, 
    m.CLI_USUARIO_DOMICILIO_CALLE, 
    m.CLI_USUARIO_DOMICILIO_NRO_CALLE, 
    m.CLI_USUARIO_DOMICILIO_PISO, 
    m.CLI_USUARIO_DOMICILIO_DEPTO, 
    l.localidad_id
FROM GD2C2024.gd_esquema.Maestra m
    JOIN DataSALE.Usuario u ON u.nombre = m.CLI_USUARIO_NOMBRE AND 
    u.fecha_creacion = m.CLI_USUARIO_FECHA_CREACION
        JOIN DataSALE.Localidad l ON l.nombre = m.CLI_USUARIO_DOMICILIO_LOCALIDAD AND 
        l.codigo_postal = m.CLI_USUARIO_DOMICILIO_CP;

COMMIT;
BEGIN TRANSACTION; -- HASTA ACA ANDA	

WITH PublicacionesF AS (
    SELECT 
        p.codigo_publicacion,
        p.fecha_publicacion,
        m.FACTURA_NUMERO,
        m.FACTURA_FECHA
    FROM gd_esquema.Maestra m
    JOIN DataSALE.Publicacion p 
        ON m.PUBLICACION_CODIGO = p.codigo_publicacion
),
UsuariosF AS (
    SELECT 
        u.usuario_id,
        m.PUBLICACION_CODIGO,
        m.PUBLICACION_FECHA
    FROM gd_esquema.Maestra m
    JOIN DataSALE.Usuario u 
        ON m.CLI_USUARIO_NOMBRE = u.nombre
),
FacturasUnicas AS (
    SELECT DISTINCT 
        pub.FACTURA_NUMERO,
        pub.FACTURA_FECHA,
        usr.usuario_id,
        ROW_NUMBER() OVER (PARTITION BY pub.FACTURA_NUMERO ORDER BY pub.FACTURA_FECHA) AS rn
    FROM PublicacionesF pub
    JOIN UsuariosF usr
        ON pub.codigo_publicacion = usr.PUBLICACION_CODIGO
        AND pub.fecha_publicacion = usr.PUBLICACION_FECHA
    WHERE pub.FACTURA_NUMERO IS NOT NULL
)
INSERT INTO DataSALE.Factura (nro_factura, factura_fecha, usuario_id)
SELECT 
    FACTURA_NUMERO,
    FACTURA_FECHA,
    usuario_id
FROM FacturasUnicas
WHERE rn = 1;

COMMIT;
BEGIN TRANSACTION;

INSERT INTO DataSALE.DetalleFactura (nro_factura, codigo_publicacion,id_tipo_detalle_factura,cantidad,precio)
SELECT 
	f.nro_factura,
	p.codigo_publicacion,
	det.id_tipo_detalle_factura,
	m.FACTURA_DET_CANTIDAD,
	m.FACTURA_DET_PRECIO
from gd_esquema.Maestra m
	JOIN DataSALE.Factura f on f.nro_factura = m.FACTURA_NUMERO 
	JOIN DataSALE.Publicacion p on p.codigo_publicacion = m.PUBLICACION_CODIGO
	JOIN DataSALE.TipoDetalleFactura det on m.FACTURA_DET_TIPO = det.detalle_tipo

COMMIT;