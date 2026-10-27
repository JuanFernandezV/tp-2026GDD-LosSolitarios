use GD2C_2026
go

-- Borramos las tablas por si ya existian para evitar conflictos

if exists (select * from sys.tables where name = 'Detalle_Reparacion' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Detalle_Reparacion
if exists (select * from sys.tables where name = 'Reparacion' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Reparacion
if exists (select * from sys.tables where name = 'Repuesto' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Repuesto
if exists (select * from sys.tables where name = 'Categoria_Repuesto' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Categoria_Repuesto
if exists (select * from sys.tables where name = 'Estado_Reparacion' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Estado_Reparacion
if exists (select * from sys.tables where name = 'Alquiler' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Alquiler
if exists (select * from sys.tables where name = 'Bicicleta_Alquiler' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Bicicleta_Alquiler
if exists (select * from sys.tables where name = 'Estado_Alquiler' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Estado_Alquiler
if exists (select * from sys.tables where name = 'Estado_Bici_Alquiler' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Estado_Bici_Alquiler
if exists (select * from sys.tables where name = 'Detalle_Compra' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Detalle_Compra
if exists (select * from sys.tables where name = 'Compra' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Compra
if exists (select * from sys.tables where name = 'Detalle_Venta' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Detalle_Venta
if exists (select * from sys.tables where name = 'Venta' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Venta
if exists (select * from sys.tables where name = 'Producto_Local' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Producto_Local
if exists (select * from sys.tables where name = 'Accesorio' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Accesorio
if exists (select * from sys.tables where name = 'Categoria_Accesorio' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Categoria_Accesorio
if exists (select * from sys.tables where name = 'Bicicleta_Venta' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Bicicleta_Venta
if exists (select * from sys.tables where name = 'Producto' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Producto
if exists (select * from sys.tables where name = 'Tipo_Producto' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Tipo_Producto
if exists (select * from sys.tables where name = 'Modelo_Bicicleta' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Modelo_Bicicleta
if exists (select * from sys.tables where name = 'Categoria_Bicicleta' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Categoria_Bicicleta
if exists (select * from sys.tables where name = 'Marca' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Marca
if exists (select * from sys.tables where name = 'Forma_Pago' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Forma_Pago
if exists (select * from sys.tables where name = 'Proveedor' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Proveedor
if exists (select * from sys.tables where name = 'Cliente' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Cliente
if exists (select * from sys.tables where name = 'Empleado' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Empleado
if exists (select * from sys.tables where name = 'Puesto_Empleado' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Puesto_Empleado
if exists (select * from sys.tables where name = 'Local' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Local
if exists (select * from sys.tables where name = 'Localidad' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Localidad
if exists (select * from sys.tables where name = 'Provincia' and schema_id = schema_id('LOS_SIN_GRUPO'))
    drop table LOS_SIN_GRUPO.Provincia
go


-- Hacemos lo mismo con los SP

if object_id('LOS_SIN_GRUPO.migrar_ubicaciones', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_ubicaciones
if object_id('LOS_SIN_GRUPO.migrar_locales_empleados', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_locales_empleados
if object_id('LOS_SIN_GRUPO.migrar_clientes_proveedores', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_clientes_proveedores
if object_id('LOS_SIN_GRUPO.migrar_catalogo', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_catalogo
if object_id('LOS_SIN_GRUPO.migrar_ventas', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_ventas
if object_id('LOS_SIN_GRUPO.migrar_compras', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_compras
if object_id('LOS_SIN_GRUPO.migrar_alquileres', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_alquileres
if object_id('LOS_SIN_GRUPO.migrar_reparaciones', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_reparaciones
if object_id('LOS_SIN_GRUPO.migrar_todo', 'P') is not null drop procedure LOS_SIN_GRUPO.migrar_todo
go


-- Creamos el schema 

if not exists (select * from sys.schemas where name = 'LOS_SIN_GRUPO')
begin
    exec('create schema LOS_SIN_GRUPO')
end
go


-- Empezamos a crear las tablas

create table LOS_SIN_GRUPO.Provincia (
    pcia_id bigint identity(1,1),
    pcia_nombre nvarchar(255) not null,
    constraint pk_provincia primary key (pcia_id)
)

create table LOS_SIN_GRUPO.Localidad (
    loca_id bigint identity(1,1),
    loca_provincia bigint not null,
    loca_nombre nvarchar(255) not null,
    constraint pk_localidad primary key (loca_id),
    constraint fk_localidad_provincia foreign key (loca_provincia) references LOS_SIN_GRUPO.Provincia(pcia_id)
)


create table LOS_SIN_GRUPO.Local (
    loc_id bigint identity(1,1),
    loc_localidad bigint not null,
    loc_nombre nvarchar(255) not null,
    loc_telefono nvarchar(255),
    loc_email nvarchar(255),
    loc_direccion nvarchar(255),
    constraint pk_local primary key (loc_id),
    constraint fk_local_localidad foreign key (loc_localidad) references LOS_SIN_GRUPO.Localidad(loca_id)
)

create table LOS_SIN_GRUPO.Puesto_Empleado (
    pues_id bigint identity(1,1),
    pues_nombre nvarchar(100) not null,
    constraint pk_puesto_empleado primary key (pues_id)
)

create table LOS_SIN_GRUPO.Empleado (
    empl_id bigint identity(1,1),
    empl_local bigint not null,
    empl_puesto bigint not null,
    empl_localidad bigint not null,
    empl_nombre nvarchar(100),
    empl_apellido nvarchar(100),
    empl_dni nvarchar(20) not null,
    empl_fecha_nac date,
    empl_fecha_ingreso date,
    empl_telefono nvarchar(255),
    empl_email nvarchar(255),
    empl_domicilio nvarchar(255),
    constraint pk_empleado primary key (empl_id),
    constraint fk_empleado_local foreign key (empl_local) references LOS_SIN_GRUPO.Local(loc_id),
    constraint fk_empleado_puesto foreign key (empl_puesto) references LOS_SIN_GRUPO.Puesto_Empleado(pues_id),
    constraint fk_empleado_localidad foreign key (empl_localidad) references LOS_SIN_GRUPO.Localidad(loca_id)
)


create table LOS_SIN_GRUPO.Cliente (
    clie_id bigint identity(1,1),
    clie_localidad bigint not null,
    clie_nombre nvarchar(100),
    clie_apellido nvarchar(100),
    clie_dni nvarchar(20) not null,
    clie_fecha_nac date,
    clie_telefono nvarchar(255),
    clie_email nvarchar(255),
    clie_direccion nvarchar(255),
    constraint pk_cliente primary key (clie_id),
    constraint fk_cliente_localidad foreign key (clie_localidad) references LOS_SIN_GRUPO.Localidad(loca_id)
)

create table LOS_SIN_GRUPO.Proveedor (
    prov_id bigint identity(1,1),
    prov_cuit nvarchar(50) not null,
    prov_localidad bigint not null,
    prov_razon_social nvarchar(255),
    prov_telefono nvarchar(255),
    prov_email nvarchar(255),
    prov_direccion nvarchar(255),
    constraint pk_proveedor primary key (prov_id),
    constraint fk_proveedor_localidad foreign key (prov_localidad) references LOS_SIN_GRUPO.Localidad(loca_id)
)

create table LOS_SIN_GRUPO.Forma_Pago (
    pago_id bigint identity(1,1),
    pago_descripcion nvarchar(50) not null,
    constraint pk_forma_pago primary key (pago_id)
)


create table LOS_SIN_GRUPO.Marca (
    marc_id bigint identity(1,1),
    marc_nombre nvarchar(255) not null,
    constraint pk_marca primary key (marc_id)
)

create table LOS_SIN_GRUPO.Categoria_Bicicleta (
    cat_bici_id bigint identity(1,1),
    cat_bici_nombre nvarchar(255) not null,
    constraint pk_categoria_bicicleta primary key (cat_bici_id)
)

create table LOS_SIN_GRUPO.Modelo_Bicicleta (
    mod_id bigint identity(1,1),
    mod_marca bigint not null,
    mod_categoria bigint not null,
    mod_nombre nvarchar(255) not null,
    mod_rodado nvarchar(50),
    mod_cuadro nvarchar(50),
    mod_color nvarchar(50),
    constraint pk_modelo_bicicleta primary key (mod_id),
    constraint fk_modelo_marca foreign key (mod_marca) references LOS_SIN_GRUPO.Marca(marc_id),
    constraint fk_modelo_categoria foreign key (mod_categoria) references LOS_SIN_GRUPO.Categoria_Bicicleta(cat_bici_id)
)

create table LOS_SIN_GRUPO.Tipo_Producto (
    tipo_prod_id bigint identity(1,1),
    tipo_prod_descripcion nvarchar(50) not null,
    constraint pk_tipo_producto primary key (tipo_prod_id)
)

create table LOS_SIN_GRUPO.Producto (
    prod_codigo nvarchar(50) not null,
    prod_tipo bigint not null,
    prod_nombre nvarchar(255),
    prod_descripcion nvarchar(max),
    prod_precio_venta decimal(18,2),
    constraint pk_producto primary key (prod_codigo),
    constraint fk_producto_tipo foreign key (prod_tipo) references LOS_SIN_GRUPO.Tipo_Producto(tipo_prod_id)
)

create table LOS_SIN_GRUPO.Bicicleta_Venta (
    bici_prod_codigo nvarchar(50) not null,
    bici_modelo bigint not null,
    bici_meses_garantia int,
    constraint pk_bicicleta_venta primary key (bici_prod_codigo),
    constraint fk_bici_venta_producto foreign key (bici_prod_codigo) references LOS_SIN_GRUPO.Producto(prod_codigo),
    constraint fk_bici_venta_modelo foreign key (bici_modelo) references LOS_SIN_GRUPO.Modelo_Bicicleta(mod_id)
)

create table LOS_SIN_GRUPO.Categoria_Accesorio (
    cat_acc_id bigint identity(1,1),
    cat_acc_nombre nvarchar(255) not null,
    constraint pk_categoria_accesorio primary key (cat_acc_id)
)

create table LOS_SIN_GRUPO.Accesorio (
    acc_prod_codigo nvarchar(50) not null,
    acc_categoria bigint not null,
    acc_marca bigint not null,
    acc_talle nvarchar(50),
    acc_color nvarchar(50),
    constraint pk_accesorio primary key (acc_prod_codigo),
    constraint fk_accesorio_producto foreign key (acc_prod_codigo) references LOS_SIN_GRUPO.Producto(prod_codigo),
    constraint fk_accesorio_categoria foreign key (acc_categoria) references LOS_SIN_GRUPO.Categoria_Accesorio(cat_acc_id),
    constraint fk_accesorio_marca foreign key (acc_marca) references LOS_SIN_GRUPO.Marca(marc_id)
)

create table LOS_SIN_GRUPO.Producto_Local (
    prodloc_codigo nvarchar(50) not null,
    prodloc_local bigint not null,
    constraint pk_producto_local primary key (prodloc_codigo, prodloc_local),
    constraint fk_prodloc_producto foreign key (prodloc_codigo) references LOS_SIN_GRUPO.Producto(prod_codigo),
    constraint fk_prodloc_local foreign key (prodloc_local) references LOS_SIN_GRUPO.Local(loc_id)
)


create table LOS_SIN_GRUPO.Venta (
    vent_nro_venta bigint not null,
    vent_local bigint not null,
    vent_empleado bigint not null,
    vent_cliente bigint not null,
    vent_forma_pago bigint not null,
    vent_fecha_hora datetime,
    vent_total decimal(18,2),
    constraint pk_venta primary key (vent_nro_venta),
    constraint fk_venta_local foreign key (vent_local) references LOS_SIN_GRUPO.Local(loc_id),
    constraint fk_venta_empleado foreign key (vent_empleado) references LOS_SIN_GRUPO.Empleado(empl_id),
    constraint fk_venta_cliente foreign key (vent_cliente) references LOS_SIN_GRUPO.Cliente(clie_id),
    constraint fk_venta_forma_pago foreign key (vent_forma_pago) references LOS_SIN_GRUPO.Forma_Pago(pago_id)
)

create table LOS_SIN_GRUPO.Detalle_Venta (
    det_vent_nro_venta bigint not null,
    det_vent_producto nvarchar(50) not null,
    det_vent_cantidad int,
    det_vent_precio_unitario decimal(18,2),
    det_vent_subtotal decimal(18,2),
    constraint pk_detalle_venta primary key (det_vent_nro_venta, det_vent_producto),
    constraint fk_det_venta_venta foreign key (det_vent_nro_venta) references LOS_SIN_GRUPO.Venta(vent_nro_venta),
    constraint fk_det_venta_producto foreign key (det_vent_producto) references LOS_SIN_GRUPO.Producto(prod_codigo)
)


create table LOS_SIN_GRUPO.Compra (
    comp_nro_compra bigint not null,
    comp_local bigint not null,
    comp_proveedor bigint not null,
    comp_empleado bigint not null,
    comp_fecha datetime,
    comp_total decimal(18,2),
    constraint pk_compra primary key (comp_nro_compra),
    constraint fk_compra_local foreign key (comp_local) references LOS_SIN_GRUPO.Local(loc_id),
    constraint fk_compra_proveedor foreign key (comp_proveedor) references LOS_SIN_GRUPO.Proveedor(prov_id),
    constraint fk_compra_empleado foreign key (comp_empleado) references LOS_SIN_GRUPO.Empleado(empl_id)
)

create table LOS_SIN_GRUPO.Detalle_Compra (
    det_comp_nro_compra bigint not null,
    det_comp_producto nvarchar(50) not null,
    det_comp_cantidad int,
    det_comp_precio_costo decimal(18,2),
    det_comp_subtotal decimal(18,2),
    constraint pk_detalle_compra primary key (det_comp_nro_compra, det_comp_producto),
    constraint fk_det_compra_compra foreign key (det_comp_nro_compra) references LOS_SIN_GRUPO.Compra(comp_nro_compra),
    constraint fk_det_compra_producto foreign key (det_comp_producto) references LOS_SIN_GRUPO.Producto(prod_codigo)
)


create table LOS_SIN_GRUPO.Estado_Bici_Alquiler (
    est_bici_id bigint identity(1,1),
    est_bici_descripcion nvarchar(50) not null,
    constraint pk_estado_bici_alquiler primary key (est_bici_id)
)

create table LOS_SIN_GRUPO.Bicicleta_Alquiler (
    bici_alq_nro_serie nvarchar(100) not null,
    bici_alq_local bigint not null,
    bici_alq_modelo bigint not null,
    bici_alq_estado bigint not null,
    bici_alq_precio_hora decimal(18,2),
    bici_alq_precio_dia decimal(18,2),
    constraint pk_bicicleta_alquiler primary key (bici_alq_nro_serie),
    constraint fk_bici_alq_local foreign key (bici_alq_local) references LOS_SIN_GRUPO.Local(loc_id),
    constraint fk_bici_alq_modelo foreign key (bici_alq_modelo) references LOS_SIN_GRUPO.Modelo_Bicicleta(mod_id),
    constraint fk_bici_alq_estado foreign key (bici_alq_estado) references LOS_SIN_GRUPO.Estado_Bici_Alquiler(est_bici_id)
)

create table LOS_SIN_GRUPO.Estado_Alquiler (
    est_alq_id bigint identity(1,1),
    est_alq_descripcion nvarchar(50) not null,
    constraint pk_estado_alquiler primary key (est_alq_id)
)

create table LOS_SIN_GRUPO.Alquiler (
    alq_nro_alquiler bigint not null,
    alq_cliente bigint not null,
    alq_empleado bigint not null,
    alq_bici_nro_serie nvarchar(100) not null,
    alq_forma_pago bigint not null,
    alq_estado bigint not null,
    alq_fecha_inicio datetime,
    alq_fecha_fin_pactada datetime,
    alq_fecha_devolucion_real datetime,
    alq_importe_total decimal(18,2),
    constraint pk_alquiler primary key (alq_nro_alquiler),
    constraint fk_alquiler_cliente foreign key (alq_cliente) references LOS_SIN_GRUPO.Cliente(clie_id),
    constraint fk_alquiler_empleado foreign key (alq_empleado) references LOS_SIN_GRUPO.Empleado(empl_id),
    constraint fk_alquiler_bici foreign key (alq_bici_nro_serie) references LOS_SIN_GRUPO.Bicicleta_Alquiler(bici_alq_nro_serie),
    constraint fk_alquiler_forma_pago foreign key (alq_forma_pago) references LOS_SIN_GRUPO.Forma_Pago(pago_id),
    constraint fk_alquiler_estado foreign key (alq_estado) references LOS_SIN_GRUPO.Estado_Alquiler(est_alq_id)
)


create table LOS_SIN_GRUPO.Estado_Reparacion (
    est_rep_id bigint identity(1,1),
    est_rep_descripcion nvarchar(50) not null,
    constraint pk_estado_reparacion primary key (est_rep_id)
)

create table LOS_SIN_GRUPO.Categoria_Repuesto (
    cat_rep_id bigint identity(1,1),
    cat_rep_nombre nvarchar(255) not null,
    constraint pk_categoria_repuesto primary key (cat_rep_id)
)

create table LOS_SIN_GRUPO.Repuesto (
    rep_codigo nvarchar(50) not null,
    rep_categoria bigint not null,
    rep_descripcion nvarchar(255),
    rep_compatibilidad nvarchar(255),
    rep_precio decimal(18,2),
    constraint pk_repuesto primary key (rep_codigo),
    constraint fk_repuesto_categoria foreign key (rep_categoria) references LOS_SIN_GRUPO.Categoria_Repuesto(cat_rep_id)
)

create table LOS_SIN_GRUPO.Reparacion (
    repa_nro_reparacion bigint not null,
    repa_local bigint not null,
    repa_cliente bigint not null,
    repa_empleado bigint not null,
    repa_modelo_bici bigint not null,
    repa_estado bigint not null,
    repa_nro_serie_bici nvarchar(100),
    repa_fecha_ingreso datetime,
    repa_fecha_entrega_estimada datetime,
    repa_fecha_entrega_real datetime,
    repa_diagnostico nvarchar(max),
    repa_precio_mano_obra decimal(18,2),
    repa_precio_repuestos decimal(18,2),
    repa_precio_total decimal(18,2),
    constraint pk_reparacion primary key (repa_nro_reparacion),
    constraint fk_reparacion_local foreign key (repa_local) references LOS_SIN_GRUPO.Local(loc_id),
    constraint fk_reparacion_cliente foreign key (repa_cliente) references LOS_SIN_GRUPO.Cliente(clie_id),
    constraint fk_reparacion_empleado foreign key (repa_empleado) references LOS_SIN_GRUPO.Empleado(empl_id),
    constraint fk_reparacion_modelo foreign key (repa_modelo_bici) references LOS_SIN_GRUPO.Modelo_Bicicleta(mod_id),
    constraint fk_reparacion_estado foreign key (repa_estado) references LOS_SIN_GRUPO.Estado_Reparacion(est_rep_id)
)

create table LOS_SIN_GRUPO.Detalle_Reparacion (
    det_repa_nro_reparacion bigint not null,
    det_repa_repuesto nvarchar(50) not null,
    det_repa_cantidad int,
    det_repa_precio_unitario decimal(18,2),
    det_repa_subtotal decimal(18,2),
    constraint pk_detalle_reparacion primary key (det_repa_nro_reparacion, det_repa_repuesto),
    constraint fk_det_repa_reparacion foreign key (det_repa_nro_reparacion) references LOS_SIN_GRUPO.Reparacion(repa_nro_reparacion),
    constraint fk_det_repa_repuesto foreign key (det_repa_repuesto) references LOS_SIN_GRUPO.Repuesto(rep_codigo)
)
go





