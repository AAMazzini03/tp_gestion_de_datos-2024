USE GD2C2024

IF NOT EXISTS ( SELECT * FROM sys.schemas WHERE name = 'DataSALE')
BEGIN
    EXEC ('CREATE SCHEMA DataSALE');
END

-- CREACION DE TABLAS

CREATE TABLE DataSALE.BI_DIM_Tiempo (
    id_tiempo INT IDENTITY (1,1) NOT NULL,
    anio INT NOT NULL,
    cuatrimestre INT NOT NULL,
    mes INT NOT NULL
);


CREATE TABLE DataSALE.BI_DIM_Ubicacion (
    id_ubicacion INT IDENTITY(1,1) NOT NULL,
    provincia NVARCHAR(50),
    localidad NVARCHAR(50)
);

CREATE TABLE DataSALE.BI_DIM_RangoEtario (
    id_rango_etario INT IDENTITY(1,1) NOT NULL,
    rango NVARCHAR(5) NOT NULL
);

CREATE TABLE DataSALE.BI_DIM_RangoHorarioVentas ( --Creamos la tabla de dimension Rango Horario de ventas pero no se llega a aplicar ya que la vista 5 fue desestimada
    rango_horario_id INT IDENTITY(1,1) NOT NULL,
    rango CHAR(11) NOT NULL
);

CREATE TABLE DataSALE.BI_DIM_TipoMedioPago (
    id_tipo_medio_pago INT NOT NULL,
    tipo_medio_pago_detalle NVARCHAR(50)NOT NULL,
);

CREATE TABLE DataSALE.BI_DIM_TipoEnvio (
    tipo_envio_id INT NOT NULL,
    tipo_envio NVARCHAR(50) NOT NULL
);

CREATE TABLE DataSALE.BI_DIM_Rubro_Subrubro (
    id_rubro_subrubro INT IDENTITY(1,1) NOT NULL,
    rubro_Detalle NVARCHAR(50) NOT NULL,
    subrubro_Detalle NVARCHAR(50) NOT NULL,
);

CREATE TABLE DataSALE.BI_DIM_Marca (
    id_marca INT NOT NULL,
    nombre NVARCHAR(50) NOT NULL
);

CREATE TABLE DataSALE.BI_DIM_Concepto (
    id_concepto INT NOT NULL,
    concepto NVARCHAR(50)
);

CREATE TABLE DataSALE.BI_HechosPublicaciones (
    id_rubro_subrubro INT NOT NULL,
	id_tiempo INT NOT NULL,
	id_marca int NOT NULL,
	promedio_tiempo_de_vigencia decimal(12,4),
	stock_promedio decimal(12,4)
);

CREATE TABLE DataSALE.BI_HechosVentas (
    id_tiempo INT NOT NULL,
	id_ubicacion_almacen INT,
	id_ubicacion_cliente INT NOT NULL,
	id_rango_etario INT NOT NULL,
    id_rubro_subrubro INT NOT NULL,
	total_importe_de_ventas decimal(12,4), 
	total_de_ventas decimal(12,4)
);

CREATE TABLE DataSALE.BI_HechosPagos (
	id_ubicacion int NOT NULL,
	id_tipo_medio_pago int NOT NULL,
	id_tiempo int NOT NULL,
	importe_de_pago_en_cuotas decimal(12,4)
);

CREATE TABLE DataSALE.BI_HechosEnvios (
	id_ubicacion_almacen int NOT NULL,
	id_ubicacion_cliente int NOT NULL, 
	id_tiempo int NOT NULL,
	id_tipo_envio int NOT NULL,
	total_costo_envio decimal(12,4), 
	total_de_envios decimal(12,4), 
	total_de_envios_cumplidos decimal(12,4)
);

CREATE TABLE DataSALE.BI_HechosFacturacion (
	id_tiempo int NOT NULL,
	id_ubicacion int NOT NULL,
	id_concepto int NOT NULL,
    facturacion DECIMAL(12,4)
);

-- Agregando Constraints
-- PRIMARY KEYS

ALTER TABLE DataSALE.BI_DIM_Tiempo 
    ADD CONSTRAINT Tiempo_pk PRIMARY KEY (id_tiempo);

ALTER TABLE DataSALE.BI_DIM_Ubicacion 
    ADD CONSTRAINT Ubicacion_pk PRIMARY KEY (id_ubicacion);

ALTER TABLE DataSALE.BI_DIM_RangoEtario 
    ADD CONSTRAINT RangoEtario_pk PRIMARY KEY (id_rango_etario);

ALTER TABLE DataSALE.BI_DIM_RangoHorarioVentas 
    ADD CONSTRAINT RangoHorario_pk PRIMARY KEY (rango_horario_id);

ALTER TABLE DataSALE.BI_DIM_TipoMedioPago 
    ADD CONSTRAINT BI_DIM_TipoMedioPago_pk PRIMARY KEY (id_tipo_medio_pago);

ALTER TABLE DataSALE.BI_DIM_TipoEnvio 
    ADD CONSTRAINT BI_DIM_TipoEnvio_pk PRIMARY KEY (tipo_envio_id);

ALTER TABLE DataSALE.BI_DIM_Rubro_Subrubro 
    ADD CONSTRAINT BI_DIM_Subrubro_pk PRIMARY KEY (id_rubro_subrubro);

ALTER TABLE DataSALE.BI_DIM_Marca 
    ADD CONSTRAINT BI_DIM_Marca_pk PRIMARY KEY (id_marca);

ALTER TABLE DataSALE.BI_DIM_Concepto 
    ADD CONSTRAINT BI_DIM_Concepto_pk PRIMARY KEY (id_concepto);

-- FOREIGN KEYS

ALTER TABLE DataSALE.BI_HechosPublicaciones
    ADD CONSTRAINT FK_HechosPublicaciones_Rubro_SubRubro_pk FOREIGN KEY (id_rubro_subrubro) 
    REFERENCES DataSALE.BI_DIM_Rubro_SubRubro(id_rubro_subrubro);
	
ALTER TABLE DataSALE.BI_HechosPublicaciones
    ADD CONSTRAINT FK_HechosPublicaciones_tiempo_pk FOREIGN KEY (id_tiempo) 
    REFERENCES DataSALE.BI_DIM_Tiempo(id_tiempo);
	
ALTER TABLE DataSALE.BI_HechosPublicaciones
    ADD CONSTRAINT FK_HechosPublicaciones_marca_pk FOREIGN KEY (id_marca) 
    REFERENCES DataSALE.BI_DIM_Marca(id_marca);

ALTER TABLE DataSALE.BI_HechosVentas
    ADD CONSTRAINT FK_HechosVentas_tiempo FOREIGN KEY (id_tiempo) 
    REFERENCES DataSALE.BI_DIM_Tiempo(id_tiempo);

ALTER TABLE DataSALE.BI_HechosVentas
    ADD CONSTRAINT FK_HechosVentas_Ubicacion_Almacen FOREIGN KEY (id_ubicacion_almacen) 
    REFERENCES DataSALE.BI_DIM_Ubicacion(id_ubicacion);

ALTER TABLE DataSALE.BI_HechosVentas
    ADD CONSTRAINT FK_HechosVentas_Ubicacion_Cliente FOREIGN KEY (id_ubicacion_cliente) 
    REFERENCES DataSALE.BI_DIM_Ubicacion (id_ubicacion);

ALTER TABLE DataSALE.BI_HechosVentas
    ADD CONSTRAINT FK_HechosVentas_Rubro_Subrubro FOREIGN KEY (id_rubro_subrubro) 
    REFERENCES DataSALE.BI_DIM_Rubro_Subrubro (id_rubro_subrubro);

ALTER TABLE DataSALE.BI_HechosVentas
    ADD CONSTRAINT FK_HechosVentas_Rango_Etario FOREIGN KEY (id_rango_etario) 
    REFERENCES DataSALE.BI_DIM_RangoEtario (id_rango_etario);

ALTER TABLE DataSALE.BI_HechosPagos
    ADD CONSTRAINT FK_BI_HechosPagos_Rango_Etario FOREIGN KEY (id_ubicacion) 
    REFERENCES DataSALE.BI_DIM_Ubicacion (id_ubicacion);

ALTER TABLE DataSALE.BI_HechosPagos
    ADD CONSTRAINT FK_BI_HechosPagos_Tipo_Medio_Pago FOREIGN KEY (id_tipo_medio_pago) 
    REFERENCES DataSALE.BI_DIM_TipoMedioPago (id_tipo_medio_pago);

ALTER TABLE DataSALE.BI_HechosPagos
    ADD CONSTRAINT FK_BI_HechosPagos_tiempo FOREIGN KEY (id_tiempo) 
    REFERENCES DataSALE.BI_DIM_Tiempo (id_tiempo);

ALTER TABLE DataSALE.BI_HechosFacturacion
    ADD CONSTRAINT FK_HechosFacturacion_Concepto FOREIGN KEY (id_concepto) 
    REFERENCES DataSALE.BI_DIM_Concepto(id_concepto);

ALTER TABLE DataSALE.BI_HechosFacturacion
    ADD CONSTRAINT FK_HechosFacturacion_tiempo FOREIGN KEY (id_tiempo) 
    REFERENCES DataSALE.BI_DIM_Tiempo(id_tiempo);

ALTER TABLE DataSALE.BI_HechosFacturacion
    ADD CONSTRAINT FK_HechosFacturacion_ubicacion FOREIGN KEY (id_ubicacion) 
    REFERENCES DataSALE.BI_DIM_Ubicacion(id_ubicacion);

ALTER TABLE DataSALE.BI_HechosEnvios
    ADD CONSTRAINT FK_HechosEnvios_ubicacion_almacen FOREIGN KEY (id_ubicacion_almacen) 
    REFERENCES DataSALE.BI_DIM_Ubicacion(id_ubicacion);

ALTER TABLE DataSALE.BI_HechosEnvios
    ADD CONSTRAINT FK_HechosEnvios_tipo_envio FOREIGN KEY (id_tipo_envio) 
    REFERENCES DataSALE.BI_DIM_TipoEnvio (tipo_envio_id);

ALTER TABLE DataSALE.BI_HechosEnvios
    ADD CONSTRAINT FK_HechosEnvios_ubicacion_cliente FOREIGN KEY (id_ubicacion_cliente) 
    REFERENCES DataSALE.BI_DIM_Ubicacion(id_ubicacion);

ALTER TABLE DataSALE.BI_HechosEnvios
    ADD CONSTRAINT FK_HechosEnvios_tiempo FOREIGN KEY (id_tiempo) 
    REFERENCES DataSALE.BI_DIM_Tiempo (id_tiempo);


-- MIGRACION DE DATOS

--Migracion dimension tiempo
BEGIN TRANSACTION 
INSERT INTO DataSALE.BI_DIM_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT
    YEAR(fecha_realizacion) AS anio,
    CEILING(MONTH(fecha_realizacion) / 3.0) AS cuatrimestre,
    MONTH(fecha_realizacion) AS mes
FROM DataSale.Venta
WHERE NOT EXISTS (
    SELECT 1
    FROM DataSALE.BI_DIM_Tiempo
    WHERE 
		BI_DIM_Tiempo.anio = year(Venta.fecha_realizacion) and
		BI_DIM_Tiempo.cuatrimestre = CEILING(MONTH(Venta.fecha_realizacion) / 3.0) and
		BI_DIM_Tiempo.mes = month(Venta.fecha_realizacion)
);

INSERT INTO DataSALE.BI_DIM_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT
    YEAR(fecha_publicacion) AS anio,
    CEILING(MONTH(fecha_publicacion) / 3.0) AS cuatrimestre,
    MONTH(fecha_publicacion) AS mes
FROM DataSale.Publicacion
WHERE NOT EXISTS (
    SELECT 1
    FROM DataSALE.BI_DIM_Tiempo
    WHERE 
		BI_DIM_Tiempo.anio = year(Publicacion.fecha_publicacion) and
		BI_DIM_Tiempo.cuatrimestre = CEILING(MONTH(Publicacion.fecha_publicacion) / 3.0) and
		BI_DIM_Tiempo.mes = month(Publicacion.fecha_publicacion)
);

INSERT INTO DataSALE.BI_DIM_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT
    YEAR(fecha_vencimiento) AS anio,
    CEILING(MONTH(fecha_vencimiento) / 3.0) AS cuatrimestre,
    MONTH(fecha_vencimiento) AS mes
FROM DataSale.Publicacion
WHERE NOT EXISTS (
    SELECT 1
    FROM DataSALE.BI_DIM_Tiempo
    WHERE 
		BI_DIM_Tiempo.anio = year(Publicacion.fecha_vencimiento) and
		BI_DIM_Tiempo.cuatrimestre = CEILING(MONTH(Publicacion.fecha_vencimiento) / 3.0) and
		BI_DIM_Tiempo.mes = month(Publicacion.fecha_vencimiento)
);

INSERT INTO DataSALE.BI_DIM_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT
    YEAR(fecha_envio) AS anio,
    CEILING(MONTH(fecha_envio) / 3.0) AS cuatrimestre,
    MONTH(fecha_envio) AS mes
FROM DataSale.Envio
WHERE NOT EXISTS (
    SELECT 1
    FROM DataSALE.BI_DIM_Tiempo
    WHERE 
		BI_DIM_Tiempo.anio = year(Envio.fecha_envio) and
		BI_DIM_Tiempo.cuatrimestre = CEILING(MONTH(Envio.fecha_envio) / 3.0) and
		BI_DIM_Tiempo.mes = month(Envio.fecha_envio)
);

INSERT INTO DataSALE.BI_DIM_Tiempo (anio, cuatrimestre, mes)
SELECT DISTINCT
    YEAR(factura_fecha) AS anio,
    CEILING(MONTH(factura_fecha) / 3.0) AS cuatrimestre,
    MONTH(factura_fecha) AS mes
FROM DataSale.Factura
WHERE NOT EXISTS (
    SELECT 1
    FROM DataSALE.BI_DIM_Tiempo
    WHERE
		BI_DIM_Tiempo.anio = year(Factura.factura_fecha) and
		BI_DIM_Tiempo.cuatrimestre = CEILING(MONTH(Factura.factura_fecha) / 3.0) and
		BI_DIM_Tiempo.mes = month(Factura.factura_fecha)
);

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_Ubicacion (localidad, provincia)
SELECT DISTINCT
	l.nombre,
	p.nombre
FROM DataSale.Localidad l
	JOIN DataSale.Provincia p
		ON l.provincia_id = p.provincia_id

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_RangoEtario (rango)
VALUES 
    ('<25'),
    ('25-35'),
    ('35-50'),
    ('>50');

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_RangoHorarioVentas (rango)
VALUES 
    ('00:00-06:00'),
    ('06:00-12:00'),
    ('12:00-18:00'),
    ('18:00-24:00');

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_TipoMedioPago (id_tipo_medio_pago, tipo_medio_pago_detalle)
SELECT
	tmp.tipo_medio_pago_id,
	tmp.detalle
FROM DataSale.TipoMedioPago tmp

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_TipoEnvio (tipo_envio_id , tipo_envio)
SELECT
	tipo_envio_id,
	tipo_envio
FROM DataSale.TipoEnvio

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_Rubro_Subrubro (rubro_Detalle, subrubro_Detalle)
SELECT
	r.nombre,
	sr.nombre
FROM DataSale.SubRubro sr
	JOIN DataSale.Rubro r
		on sr.id_rubro = r.id_rubro

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_Marca (id_marca, nombre)
SELECT
	m.id_marca,
	m.nombre
FROM DataSale.Marca m

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_DIM_Concepto(id_concepto,concepto)
SELECT
	id_tipo_detalle_factura as id_concepto,
	detalle_tipo as concepto
FROM DataSale.TipoDetalleFactura;

COMMIT;
BEGIN TRANSACTION

INSERT INTO DataSALE.BI_HechosPublicaciones(id_rubro_subrubro, id_tiempo, id_marca, promedio_tiempo_de_vigencia, stock_promedio)--34629
select 
	dim_ru_subru.id_rubro_subrubro,
	ti.id_tiempo,
	dim_mar.id_marca as marca,
	AVG(CAST(DATEDIFF(DAY, pu.fecha_publicacion, pu.fecha_vencimiento) AS DECIMAL(12, 4))),
	AVG(CAST(pu.stock AS DECIMAL(12, 4)))
from
	DataSALE.Publicacion pu
	join DataSALE.Producto pro
		on pu.codigo_producto = pro.codigo_producto
	join DataSALE.BI_DIM_Rubro_Subrubro dim_ru_subru
		on pro.id_subrubro = dim_ru_subru.id_rubro_subrubro
	join DataSALE.BI_DIM_Tiempo ti
		on	year(pu.fecha_publicacion) = ti.anio and
			CEILING(MONTH(pu.fecha_publicacion) / 3.0) = ti.cuatrimestre and
			MONTH(pu.fecha_publicacion) = ti.mes
	join DataSALE.BI_DIM_Marca dim_mar
		on pro.id_marca = dim_mar.id_marca

group by 
	dim_ru_subru.id_rubro_subrubro,
	ti.id_tiempo,
	dim_mar.id_marca

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_HechosVentas(id_ubicacion_cliente, id_ubicacion_almacen, id_tiempo, id_rubro_subrubro, id_rango_etario, total_importe_de_ventas, total_de_ventas) 
SELECT 
	ubicacion_cliente.id_ubicacion,
	ubicacion_almacen.id_ubicacion,
	ti.id_tiempo,
	dim_R_SR.id_rubro_subrubro,
	(
	CASE 
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) < 25 THEN 1 --asumimos que debemos tomar el rango etario de los clientes al momento de realizada la venta, por eso usamos el atributo de la fecha de realización de la venta
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) BETWEEN 25 AND 35 THEN 2
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) BETWEEN 35 AND 50 THEN 3
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) > 50 THEN 4
    END
	), 
	sum(dven.precio) as total_importe_de_ventas,
	count(ven.codigo_venta) as total_de_ventas
from
	DataSALE.Venta ven
	join DataSALE.Cliente cli
		on ven.cliente_id = cli.cliente_id
	join DataSALE.Usuario usu
		on cli.usuario_id = usu.usuario_id
	join DataSALE.Domicilio dom
		on usu.usuario_id = dom.usuario_id
	join DataSALE.Localidad localidad_cliente
		on dom.localidad_id = localidad_cliente.localidad_id
	join DataSALE.Provincia provincia_cliente
		on localidad_cliente.provincia_id = provincia_cliente.provincia_id
	join DataSALE.BI_DIM_Ubicacion ubicacion_cliente
		on localidad_cliente.nombre = ubicacion_cliente.localidad AND provincia_cliente.nombre = ubicacion_cliente.provincia
	join DataSALE.DetalleVenta	dven
		on ven.codigo_venta = dven.codigo_venta
	join DataSALE.Publicacion pub
		on dven.codigo_publicacion = pub.codigo_publicacion
	join DataSALE.Almacen alm
		on pub.codigo_almacen = alm.codigo_almacen
	left join DataSALE.Localidad localidad_almacen
		on alm.localidad_id = localidad_almacen.localidad_id
	left join DataSALE.Provincia provincia_almacen
		on localidad_almacen.provincia_id = provincia_almacen.provincia_id
	left join DataSALE.BI_DIM_Ubicacion ubicacion_almacen
		on localidad_almacen.nombre = ubicacion_almacen.localidad AND provincia_almacen.nombre = ubicacion_almacen.provincia
	join DataSALE.BI_DIM_Tiempo ti
		on year(ven.fecha_realizacion) = ti.anio AND MONTH(ven.fecha_realizacion) = ti.mes AND CEILING(MONTH(ven.fecha_realizacion) / 3.0) = ti.cuatrimestre
	join DataSALE.Producto pro
		on pub.codigo_producto = pro.codigo_producto
	join DataSALE.BI_DIM_Rubro_Subrubro dim_R_SR
		on pro.id_subrubro = dim_R_SR.id_rubro_subrubro
GROUP BY 
    ubicacion_cliente.id_ubicacion,
    ubicacion_almacen.id_ubicacion,
    ti.id_tiempo,
    dim_R_SR.id_rubro_subrubro,
    (
	CASE 
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) < 25 THEN 1
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) BETWEEN 25 AND 35 THEN 2
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) BETWEEN 35 AND 50 THEN 3
        WHEN DATEDIFF(YEAR, cli.fecha_nacimiento, ven.fecha_realizacion) > 50 THEN 4
    END
	)

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_HechosPagos(id_ubicacion, id_tipo_medio_pago, id_tiempo,importe_de_pago_en_cuotas) 
SELECT
	ubi.id_ubicacion,
	tmp.id_tipo_medio_pago,
	ti.id_tiempo,
	sum(p.importe*dp.cant_cuotas)
from
	DataSALE.Pago p
	join DataSALE.MedioPago mp
		on p.medio_pago_id = mp.medio_pago_id
	join DataSALE.BI_DIM_TipoMedioPago tmp
		on mp.tipo_medio_pago_id = tmp.id_tipo_medio_pago
	join DataSALE.BI_DIM_Tiempo ti
		on	year(p.fecha) = ti.anio and
			MONTH(p.fecha) = ti.mes and
			CEILING(MONTH(p.fecha) / 3.0) = ti.cuatrimestre
	join DataSALE.DetallePago dp
		on p.detalle_id = dp.detalle_id
	join DataSALE.Venta v
		on p.codigo_venta = v.codigo_venta
	join DataSALE.Cliente c
		on v.cliente_id = c.cliente_id
	join DataSALE.Usuario u
		on c.usuario_id = u.usuario_id
	join DataSALE.Domicilio d
		on u.usuario_id = d.usuario_id
	join DataSALE.Localidad l
		on d.localidad_id = l.localidad_id
	join DataSALE.Provincia pro
		on l.provincia_id = pro.provincia_id
	join DataSALE.BI_DIM_Ubicacion ubi
		on l.nombre = ubi.localidad AND pro.nombre = ubi.provincia
group by
	ubi.id_ubicacion,
	tmp.id_tipo_medio_pago,
	ti.id_tiempo

COMMIT;
BEGIN TRANSACTION

INSERT INTO DataSALE.BI_HechosFacturacion( id_tiempo,id_concepto,id_ubicacion,facturacion )
SELECT 
	ti.id_tiempo,
	con.id_concepto,
	ubi.id_ubicacion,
	sum(df.precio) as facturacion
FROM 
	DataSale.Factura f
	join DataSALE.DetalleFactura df
		on f.nro_factura = df.nro_factura
	join DataSALE.TipoDetalleFactura tdf
		on df.id_tipo_detalle_factura = tdf.id_tipo_detalle_factura
	join DataSALE.BI_DIM_Concepto con
		on tdf.id_tipo_detalle_factura = con.id_concepto
	join DataSALE.BI_DIM_Tiempo ti
		on	year(f.factura_fecha) = ti.anio and
			MONTH(f.factura_fecha) = ti.mes and
			CEILING(MONTH(f.factura_fecha) / 3.0) = ti.cuatrimestre
	join DataSALE.Usuario u
		on f.usuario_id = u.usuario_id
	join DataSALE.Domicilio domi
		on u.usuario_id = domi.usuario_id
	join DataSALE.Localidad l
		on domi.localidad_id = l.localidad_id
	join DataSALE.Provincia pro
		on l.provincia_id = pro.provincia_id
	join DataSALE.BI_DIM_Ubicacion ubi
		on l.nombre = ubi.localidad AND pro.nombre = ubi.provincia
	
GROUP BY 
	ti.id_tiempo,
	con.id_concepto,
	ubi.id_ubicacion

COMMIT;
BEGIN TRANSACTION 

INSERT INTO DataSALE.BI_HechosEnvios(id_tipo_envio ,id_ubicacion_almacen,id_ubicacion_cliente, id_tiempo, total_costo_envio, total_de_envios, total_de_envios_cumplidos)
SELECT
	t_env2.tipo_envio_id,
	ubicacion_almacen.id_ubicacion as id_ubicacion_almacen,
	ubicacion_cliente.id_ubicacion as id_ubicacion_cliente,
	ti.id_tiempo,
	sum(env.costo_envio) as total_costo_envio,
	count(nro_envio) as total_de_envios,
	SUM(CASE 
			WHEN env.fecha_entrega <= DATEADD(SECOND, cast(env.hora_fin as INT), CAST(env.fecha_envio AS DATETIME)) THEN 1 
			ELSE 0 
		END) AS total_de_envios_cumplidos
from 
	DataSALE.Envio env
	join DataSALE.Venta ven
		on env.codigo_venta = ven.codigo_venta
	join DataSALE.DetalleVenta dven
		on ven.codigo_venta = dven.codigo_venta
	join DataSALE.Publicacion pub
		on dven.codigo_publicacion = pub.codigo_publicacion
	join DataSALE.Almacen alm
		on pub.codigo_almacen = alm.codigo_almacen
	join DataSALE.Localidad localidad_almacen
		on alm.localidad_id = localidad_almacen.localidad_id
	join DataSALE.Provincia provincia_almacen
		on localidad_almacen.provincia_id = provincia_almacen.provincia_id
	join DataSALE.BI_DIM_Ubicacion ubicacion_almacen
		on localidad_almacen.nombre = ubicacion_almacen.localidad AND provincia_almacen.nombre = ubicacion_almacen.provincia
	join DataSALE.Cliente clie
		on ven.cliente_id = clie.cliente_id
	join DataSALE.Usuario usu
		on clie.usuario_id = usu.usuario_id
	join DataSALE.Domicilio domi
		on usu.usuario_id = domi.usuario_id
	join DataSALE.Localidad as cliente_localidad
		on domi.localidad_id = cliente_localidad.localidad_id
	join DataSALE.Provincia provincia_cliente
		on cliente_localidad.provincia_id = provincia_cliente.provincia_id
	join DataSALE.BI_DIM_Ubicacion ubicacion_cliente
		on cliente_localidad.nombre = ubicacion_cliente.localidad AND provincia_cliente.nombre = ubicacion_cliente.provincia
	join DataSALE.BI_DIM_Tiempo ti
		on	year(env.fecha_envio) = ti.anio and
			MONTH(env.fecha_envio) = ti.mes and
			CEILING(MONTH(env.fecha_envio) / 3.0) = ti.cuatrimestre
	join DataSale.TipoEnvio t_env1
		on t_env1.tipo_envio_id = env.tipo_envio_id
	join DataSALE.BI_DIM_TipoEnvio t_env2
		on t_env1.tipo_envio = t_env2.tipo_envio
group by
	ubicacion_almacen.id_ubicacion,
	ubicacion_cliente.id_ubicacion,
	ti.id_tiempo,
	t_env2.tipo_envio_id
COMMIT;

--Vista 1
go
CREATE OR ALTER VIEW DataSALE.BI_Vista_PromedioTiempoPublicaciones AS
Select
	DT.anio,
	DT.cuatrimestre,
	DRSR.subrubro_Detalle as subrubro,
	HP.promedio_tiempo_de_vigencia as promedio_tiempo_de_vigencia
from
	DataSALE.BI_HechosPublicaciones HP
	join DataSALE.BI_DIM_Tiempo DT
		on HP.id_tiempo = DT.id_tiempo
	JOIN DataSALE.BI_DIM_Rubro_Subrubro DRSR
		on HP.id_rubro_subrubro = DRSR.id_rubro_subrubro

--Vista 2
go
CREATE OR ALTER VIEW DataSALE.BI_Vista_PromedioStockInicial AS
SELECT 
	DT.anio,
	HP.stock_promedio,
	DM.nombre AS Marca
FROM
	DataSALE.BI_HechosPublicaciones HP
	join DataSALE.BI_DIM_Tiempo DT
		on HP.id_tiempo = DT.id_tiempo
	join DataSALE.BI_DIM_Marca DM
		on HP.id_marca = DM.id_marca

--Vista 3
go
CREATE OR ALTER VIEW DataSALE.BI_Vista_PromedioVentasPorMesYProvincia AS
select
	tm.mes,
	tm.anio,
	ub.provincia,
	(hv.total_importe_de_ventas/hv.total_de_ventas) as valor_promedio_de_ventas
from 
	DataSale.BI_HechosVentas hv
	join DataSALE.BI_DIM_Ubicacion ub on hv.id_ubicacion_almacen = ub.id_ubicacion
	join DataSALE.BI_DIM_Tiempo tm on hv.id_tiempo = tm.id_tiempo
group by
	tm.mes,
	tm.anio,
	ub.provincia,
	hv.total_importe_de_ventas,
	hv.total_de_ventas

--Vista 4

GO
CREATE or alter VIEW DataSALE.BI_Vista_RendimientoRubros AS
WITH rubroRanking AS (
    SELECT
        ti.anio,
        ti.cuatrimestre,
        ubi.localidad,
        re.rango as rango_etario,
        rusru.rubro_Detalle as rubro,
        hv.total_de_ventas,
        ROW_NUMBER() OVER ( PARTITION BY ti.anio, ti.cuatrimestre, ubi.localidad, re.rango ORDER BY  hv.total_de_ventas DESC ) AS ranking
    FROM DataSALE.BI_HechosVentas hv
	join DataSALE.BI_DIM_Ubicacion ubi
		on hv.id_ubicacion_cliente = ubi.id_ubicacion
	join DataSALE.BI_DIM_RangoEtario re
		on hv.id_rango_etario = re.id_rango_etario
	join DataSALE.BI_DIM_Rubro_Subrubro rusru
		on hv.id_rubro_subrubro = rusru.id_rubro_subrubro
	join DataSALE.BI_DIM_Tiempo ti
		on hv.id_tiempo = ti.id_tiempo
)
SELECT
    anio,
    cuatrimestre,
    localidad,
    rango_etario,
    rubro,
    total_de_ventas
FROM rubroRanking
WHERE ranking <= 5;

--Vista 6
GO
CREATE OR ALTER VIEW DataSALE.BI_Vista_PagoEnCuotas AS
SELECT TOP 3
	ti.anio,
	ti.mes,
	ubi.localidad,
	tmp.tipo_medio_pago_detalle as tipo_medio_de_pago,
	hp.importe_de_pago_en_cuotas

FROM
	DataSALE.BI_HechosPagos hp
	join DataSALE.BI_DIM_Ubicacion ubi
		on hp.id_ubicacion = ubi.id_ubicacion
	join DataSALE.BI_DIM_TipoMedioPago tmp
		on hp.id_tipo_medio_pago = tmp.id_tipo_medio_pago
	join DataSALE.BI_DIM_Tiempo ti
		on hp.id_tiempo = ti.id_tiempo
order by hp.importe_de_pago_en_cuotas desc

--Vista 7
GO 
CREATE OR ALTER VIEW DataSALE.BI_Vista_CumplimientoEnvios AS
SELECT
    t.anio,
    t.mes,
    u.provincia AS provincia_almacen,
    SUM(he.total_de_envios_cumplidos) AS envios_cumplidos_provincia,
    SUM(he.total_de_envios) AS total_envios_provincia,
    CASE 
        WHEN SUM(SUM(he.total_de_envios_cumplidos)) OVER (PARTITION BY t.anio, t.mes) > 0 THEN
            CAST(SUM(he.total_de_envios_cumplidos) * 100.0 /
                 SUM(SUM(he.total_de_envios_cumplidos)) OVER (PARTITION BY t.anio, t.mes) AS DECIMAL(5, 2))
        ELSE 0 --Esto lo añadimos para en caso de que ocurra una division por 0 (cero)
    END AS porcentaje_cumplimiento_provincia
FROM 
	DataSALE.BI_HechosEnvios he
	join DataSALE.BI_DIM_Tiempo t
		on he.id_tiempo = t.id_tiempo
	join DataSALE.BI_DIM_Ubicacion u
		on he.id_ubicacion_almacen = u.id_ubicacion
group by
    t.anio,
    t.mes,
    u.provincia;

--Vista 8
GO
CREATE OR ALTER VIEW DataSALE.BI_Vista_TopLocalidadesCostoEnvio AS
SELECT top 5
	ubi.localidad,
	sum(he.total_costo_envio) as total_costo_envio
FROM 
	DataSALE.BI_HechosEnvios he
	join DataSALE.BI_DIM_Ubicacion ubi
		on he.id_ubicacion_cliente = ubi.id_ubicacion
group by ubi.localidad
order by sum(he.total_costo_envio) desc

--Vista 9
go 
CREATE OR ALTER VIEW DataSale.BI_Vista_PorcentajeFacturacion_PorConcepto AS
WITH TotalFacturacionPorPeriodo AS (
    SELECT
        tm.anio,
        tm.mes,
        SUM(hf.facturacion) AS total_facturacion_periodo
    FROM DataSale.BI_HechosFacturacion hf
    JOIN DataSale.BI_DIM_Tiempo tm ON hf.id_tiempo = tm.id_tiempo
    GROUP BY tm.anio, tm.mes
)
SELECT
    tm.anio,
    tm.mes,
    co.concepto,
    hf.facturacion AS facturacion_concepto_periodo,
    tfp.total_facturacion_periodo,
    ROUND((hf.facturacion * 100.0) / tfp.total_facturacion_periodo, 2) AS porcentaje_facturacion
FROM 
    DataSale.BI_HechosFacturacion hf
    JOIN DataSale.BI_DIM_Tiempo tm ON hf.id_tiempo = tm.id_tiempo
    JOIN DataSale.BI_DIM_Concepto co ON hf.id_concepto = co.id_concepto
    JOIN TotalFacturacionPorPeriodo tfp 
        ON tm.anio = tfp.anio AND tm.mes = tfp.mes

--Vista 10
GO
CREATE OR ALTER VIEW DataSALE.BI_Vista_FacturacionPorProvincia AS
SELECT
    t.anio,
    t.cuatrimestre,
    u.provincia,
    SUM(e.facturacion) AS monto_facturado
FROM DataSALE.BI_HechosFacturacion e
	JOIN DataSALE.BI_DIM_Tiempo t
		ON	e.id_tiempo = t.id_tiempo
	JOIN DataSALE.BI_DIM_Ubicacion u
		ON	e.id_ubicacion = u.id_ubicacion
GROUP BY 
	t.anio, 
	t.cuatrimestre, 
	u.provincia;
