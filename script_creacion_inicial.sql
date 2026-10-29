use GD2C_2026
go

CREATE SCHEMA LOS_SIN_GRUPO
GO

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

--if not exists (select * from sys.schemas where name = 'LOS_SIN_GRUPO')
--begin
--    exec('create schema LOS_SIN_GRUPO')
--end
--go

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
    empl_local bigint null, --: CORREGIR, ES DE N:M
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
    prod_local nvarchar(50) null,
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
    vent_cliente bigint null,
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
    bici_alq_local bigint null,
    bici_alq_modelo bigint null,
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
    alq_cliente bigint null,
    alq_empleado bigint null,
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
    repa_local bigint null,
    repa_cliente bigint null,
    repa_empleado bigint null,
    repa_modelo_bici bigint null,
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

--CREACIÓN DE STORED PROCEDURES PARA MIGRACIÓN-------------------------

create procedure LOS_SIN_GRUPO.migrar_ubicaciones
as
begin
    set nocount on;

    insert into LOS_SIN_GRUPO.Provincia (pcia_nombre)
    select distinct x.pcia
    from (
        select Local_Provincia as pcia from gd_esquema.Maestra
        union select Cliente_Provincia from gd_esquema.Maestra
        union select Proveedor_Provincia from gd_esquema.Maestra
        union select Empleado_Provincia from gd_esquema.Maestra
    ) x
    where x.pcia is not null;

    insert into LOS_SIN_GRUPO.Localidad (loca_provincia, loca_nombre)
    select distinct p.pcia_id, x.loca
    from (
        select Local_Provincia as pcia, Local_Localidad as loca from gd_esquema.Maestra
        union select Cliente_Provincia, Cliente_Localidad from gd_esquema.Maestra
        union select Proveedor_Provincia, Proveedor_Localidad from gd_esquema.Maestra
        union select Empleado_Provincia, Empleado_Localidad from gd_esquema.Maestra
    ) x
    join LOS_SIN_GRUPO.Provincia p on p.pcia_nombre = x.pcia
    where x.loca is not null;
end
go

create procedure LOS_SIN_GRUPO.migrar_catalogo
as
begin
    set nocount on;

    insert into LOS_SIN_GRUPO.Puesto_Empleado (pues_nombre)
    select distinct Empleado_Puesto_Empleado from gd_esquema.Maestra
    where Empleado_Puesto_Empleado is not null;

    insert into LOS_SIN_GRUPO.Forma_Pago (pago_descripcion)
    select distinct Forma_Pago_Forma_Pago from gd_esquema.Maestra
    where Forma_Pago_Forma_Pago is not null;

    insert into LOS_SIN_GRUPO.Tipo_Producto (tipo_prod_descripcion)
    select distinct Tipo_Producto_Tipo_Producto from gd_esquema.Maestra
    where Tipo_Producto_Tipo_Producto is not null;

    insert into LOS_SIN_GRUPO.Marca (marc_nombre)
    select distinct Marca_Marca from gd_esquema.Maestra
    where Marca_Marca is not null;

    insert into LOS_SIN_GRUPO.Categoria_Bicicleta (cat_bici_nombre)
    select distinct Categoria_Bicicleta_Categoria_Bicicleta from gd_esquema.Maestra
    where Categoria_Bicicleta_Categoria_Bicicleta is not null;

    insert into LOS_SIN_GRUPO.Categoria_Accesorio (cat_acc_nombre)
    select distinct Categoria_Accesorios_Categoria_Accesorio from gd_esquema.Maestra
    where Categoria_Accesorios_Categoria_Accesorio is not null;

    insert into LOS_SIN_GRUPO.Categoria_Repuesto (cat_rep_nombre)
    select distinct Categoria_Repuestos_Categoria_Respuesto from gd_esquema.Maestra
    where Categoria_Repuestos_Categoria_Respuesto is not null;

    insert into LOS_SIN_GRUPO.Estado_Reparacion (est_rep_descripcion)
    select distinct Estado_Reparacion_Estado_Reparacion from gd_esquema.Maestra
    where Estado_Reparacion_Estado_Reparacion is not null;

    insert into LOS_SIN_GRUPO.Estado_Alquiler (est_alq_descripcion)
    select distinct Estado_Alquiler_Estado_Alquiler from gd_esquema.Maestra
    where Estado_Alquiler_Estado_Alquiler is not null;

    insert into LOS_SIN_GRUPO.Estado_Bici_Alquiler (est_bici_descripcion)
    select distinct Estado_Bici_Alquiler_Estado_Bici_Alquiler from gd_esquema.Maestra
    where Estado_Bici_Alquiler_Estado_Bici_Alquiler is not null;

    insert into LOS_SIN_GRUPO.Modelo_Bicicleta
        (mod_marca, mod_categoria, mod_nombre, mod_rodado, mod_cuadro, mod_color)
    select distinct m.marc_id, c.cat_bici_id, o.Modelo_Bicicleta_Modelo_Bicicleta,
           o.Modelo_Bicicleta_Rodado_Modelo_Bicicleta,
           o.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta,
           o.Modelo_Bicicleta_Color_Modelo_Bicicleta
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Marca m on m.marc_nombre = o.Marca_Marca
    join LOS_SIN_GRUPO.Categoria_Bicicleta c on c.cat_bici_nombre = o.Categoria_Bicicleta_Categoria_Bicicleta
    where o.Modelo_Bicicleta_Modelo_Bicicleta is not null;

    insert into LOS_SIN_GRUPO.Producto
        (prod_codigo, prod_tipo, prod_nombre, prod_descripcion, prod_precio_venta)
    select distinct o.Producto_Cod_Producto, t.tipo_prod_id, o.Producto_Nombre_Producto,
           o.Producto_Descripcion_Producto, o.Producto_Precio_Venta_Producto
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Tipo_Producto t on t.tipo_prod_descripcion = o.Tipo_Producto_Tipo_Producto
    where o.Producto_Cod_Producto is not null;

    insert into LOS_SIN_GRUPO.Bicicleta_Venta (bici_prod_codigo, bici_modelo, bici_meses_garantia)
    select distinct o.Producto_Cod_Producto, mb.mod_id, o.Bicicleta_Venta_Meses_Garantia_Bici_Venta
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Marca m on m.marc_nombre = o.Marca_Marca
    join LOS_SIN_GRUPO.Categoria_Bicicleta c on c.cat_bici_nombre = o.Categoria_Bicicleta_Categoria_Bicicleta
    join LOS_SIN_GRUPO.Modelo_Bicicleta mb
         on mb.mod_marca = m.marc_id
        and mb.mod_categoria = c.cat_bici_id
        and mb.mod_nombre = o.Modelo_Bicicleta_Modelo_Bicicleta
        and isnull(mb.mod_rodado, '') = isnull(o.Modelo_Bicicleta_Rodado_Modelo_Bicicleta, '')
        and isnull(mb.mod_cuadro, '') = isnull(o.Modelo_Bicicleta_Cuadro_Modelo_Bicicleta, '')
        and isnull(mb.mod_color, '') = isnull(o.Modelo_Bicicleta_Color_Modelo_Bicicleta, '')
    where o.Bicicleta_Venta_Meses_Garantia_Bici_Venta is not null;

    insert into LOS_SIN_GRUPO.Accesorio (acc_prod_codigo, acc_categoria, acc_marca, acc_talle, acc_color)
    select distinct o.Producto_Cod_Producto, ca.cat_acc_id, m.marc_id,
           o.Accesorio_Talle_Accesorio, o.Accesorio_Color_Accesorio
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Categoria_Accesorio ca on ca.cat_acc_nombre = o.Categoria_Accesorios_Categoria_Accesorio
    join LOS_SIN_GRUPO.Marca m on m.marc_nombre = o.Marca_Marca
    where o.Producto_Cod_Producto is not null;

    insert into LOS_SIN_GRUPO.Repuesto (rep_codigo, rep_categoria, rep_descripcion, rep_compatibilidad, rep_precio)
    select distinct o.Repuesto_Cod_Repuesto, c.cat_rep_id, o.Repuesto_Desc_Repuesto,
           o.Repuesto_Compatibilidad_Repuesto, o.Repuesto_Precio_Repuesto
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Categoria_Repuesto c on c.cat_rep_nombre = o.Categoria_Repuestos_Categoria_Respuesto
    where o.Repuesto_Cod_Repuesto is not null;
end
go

create procedure LOS_SIN_GRUPO.migrar_locales_empleados
as
begin
    set nocount on;

    insert into LOS_SIN_GRUPO.Local
        (loc_localidad, loc_nombre, loc_telefono, loc_email, loc_direccion)
    select distinct l.loca_id, o.Local_Nombre_Local, o.Local_Telefono_Local,
           o.Local_Email_Local, o.Local_Direccion_Local
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Provincia p on p.pcia_nombre = o.Local_Provincia
    join LOS_SIN_GRUPO.Localidad l on l.loca_provincia = p.pcia_id and l.loca_nombre = o.Local_Localidad
    where o.Local_Nombre_Local is not null;

    insert into LOS_SIN_GRUPO.Empleado
        (empl_local, empl_puesto, empl_localidad, empl_nombre, empl_apellido, empl_dni,
         empl_fecha_nac, empl_fecha_ingreso, empl_telefono, empl_email, empl_domicilio)
    select null, pe.pues_id, l.loca_id,
           x.nombre, x.apellido, x.dni, x.fecha_nac, x.fecha_ingreso,
           x.telefono, x.email, x.domicilio
    from (
        select Empleado_Dni_Empleado            as dni,
               min(Empleado_Nombre_Empleado)        as nombre,
               min(Empleado_Apellido_Empleado)      as apellido,
               min(Empleado_Fecha_Nac_Empleado)     as fecha_nac,
               min(Empleado_Fecha_Ingreso_Empleado) as fecha_ingreso,
               min(Empleado_Telefono_Empleado)      as telefono,
               min(Empleado_Email_Empleado)         as email,
               min(Empleado_Domicilio_Empleado)     as domicilio,
               min(Empleado_Puesto_Empleado)        as puesto,
               min(Empleado_Provincia)              as pcia,
               min(Empleado_Localidad)              as loca
        from gd_esquema.Maestra
        where Empleado_Dni_Empleado is not null
        group by Empleado_Dni_Empleado
    ) x
    join LOS_SIN_GRUPO.Puesto_Empleado pe on pe.pues_nombre = x.puesto
    join LOS_SIN_GRUPO.Provincia p        on p.pcia_nombre  = x.pcia
    join LOS_SIN_GRUPO.Localidad l        on l.loca_provincia = p.pcia_id and l.loca_nombre = x.loca
    order by x.dni;
end
go

create procedure LOS_SIN_GRUPO.migrar_clientes_proveedores
as
begin
    set nocount on;

    insert into LOS_SIN_GRUPO.Cliente
        (clie_localidad, clie_nombre, clie_apellido, clie_dni, clie_fecha_nac,
         clie_telefono, clie_email, clie_direccion)
    select l.loca_id, x.nombre, x.apellido, x.dni, x.fecha_nac,
           x.telefono, x.email, x.direccion
    from (
        select Cliente_Dni_Cliente as dni,
               min(Cliente_Nombre_Cliente)           as nombre,
               min(Cliente_Apellido_Cliente)         as apellido,
               min(Cliente_Fecha_Nacimiento_Cliente) as fecha_nac,
               min(Cliente_Telefono_Cliente)         as telefono,
               min(Cliente_Email_Cliente)            as email,
               min(Cliente_Direccion_Cliente)        as direccion,
               min(Cliente_Provincia)                as provincia,
               min(Cliente_Localidad)                as localidad
        from gd_esquema.Maestra
        where Cliente_Dni_Cliente is not null
        group by Cliente_Dni_Cliente
    ) x
    join LOS_SIN_GRUPO.Provincia p on p.pcia_nombre = x.provincia
    join LOS_SIN_GRUPO.Localidad l on l.loca_provincia = p.pcia_id and l.loca_nombre = x.localidad;

    insert into LOS_SIN_GRUPO.Proveedor
        (prov_cuit, prov_localidad, prov_razon_social, prov_telefono, prov_email, prov_direccion)
    select x.cuit, l.loca_id, x.razon_social, x.telefono, x.email, x.direccion
    from (
        select Proveedor_Cuit_Proveedor as cuit,
               min(Proveedor_Razon_Social_Proveedor) as razon_social,
               min(Proveedor_Telefono_Proveedor)     as telefono,
               min(Proveedor_Email_Proveedor)        as email,
               min(Proveedor_Direccion_Proveedor)    as direccion,
               min(Proveedor_Provincia)              as provincia,
               min(Proveedor_Localidad)              as localidad
        from gd_esquema.Maestra
        where Proveedor_Cuit_Proveedor is not null
        group by Proveedor_Cuit_Proveedor
    ) x
    join LOS_SIN_GRUPO.Provincia p on p.pcia_nombre = x.provincia
    join LOS_SIN_GRUPO.Localidad l on l.loca_provincia = p.pcia_id and l.loca_nombre = x.localidad;
end
go

create or alter procedure LOS_SIN_GRUPO.migrar_ventas
as
begin
    set nocount on;

    insert into LOS_SIN_GRUPO.Venta
        (vent_nro_venta, vent_local, vent_empleado, vent_cliente, vent_forma_pago, vent_fecha_hora, vent_total)
    select x.nro, loc.loc_id, emp.empl_id, c.clie_id, f.pago_id, x.fecha, x.total
    from (
        select Venta_Nro_Venta               as nro,
               min(Venta_Fecha_Hora_Venta)   as fecha,
               min(Venta_Total_Venta)        as total,
               min(Cliente_Dni_Cliente)      as dni_cliente,
               min(Forma_Pago_Forma_Pago)    as forma,
               min(Local_Nombre_Local)       as nombre_local,
               min(Empleado_Dni_Empleado)    as dni_empleado
        from gd_esquema.Maestra
        where Venta_Nro_Venta is not null
        group by Venta_Nro_Venta
    ) x
    left join LOS_SIN_GRUPO.Local loc     on loc.loc_nombre = x.nombre_local
    left join LOS_SIN_GRUPO.Empleado emp  on emp.empl_dni   = x.dni_empleado
    left join LOS_SIN_GRUPO.Cliente c     on c.clie_dni     = x.dni_cliente
    join      LOS_SIN_GRUPO.Forma_Pago f  on f.pago_descripcion = x.forma;

    -- Detalle: una fila por (venta, producto), sumando las líneas repetidas
    insert into LOS_SIN_GRUPO.Detalle_Venta
        (det_vent_nro_venta, det_vent_producto, det_vent_cantidad, det_vent_precio_unitario, det_vent_subtotal)
    select o.Venta_Nro_Venta, o.Producto_Cod_Producto,
           sum(o.Detalle_Venta_Cantidad_Prod_Venta),
           min(o.Detalle_Venta_Precio_Unitario_Prod_Venta),
           sum(o.Detalle_Venta_Subtotal_Prod_Venta)
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Venta v    on v.vent_nro_venta = o.Venta_Nro_Venta
    join LOS_SIN_GRUPO.Producto p on p.prod_codigo    = o.Producto_Cod_Producto
    where o.Detalle_Venta_Cantidad_Prod_Venta is not null
    group by o.Venta_Nro_Venta, o.Producto_Cod_Producto;
end
go

create or alter procedure LOS_SIN_GRUPO.migrar_compras
as
begin
    set nocount on;

    insert into LOS_SIN_GRUPO.Compra
        (comp_nro_compra, comp_local, comp_proveedor, comp_empleado, comp_fecha, comp_total)
    select x.nro, loc.loc_id, pr.prov_id, emp.empl_id, x.fecha, x.total
    from (
        select Compra_Nro_Compra             as nro,
               min(Compra_Fecha_Compra)      as fecha,
               min(Compra_Total_Compra)      as total,
               min(Proveedor_Cuit_Proveedor) as cuit,
               min(Local_Nombre_Local)       as nombre_local,
               min(Empleado_Dni_Empleado)    as dni_empleado
        from gd_esquema.Maestra
        where Compra_Nro_Compra is not null
        group by Compra_Nro_Compra
    ) x
    join LOS_SIN_GRUPO.Proveedor pr on pr.prov_cuit   = x.cuit
    join LOS_SIN_GRUPO.Local loc    on loc.loc_nombre = x.nombre_local
    join LOS_SIN_GRUPO.Empleado emp on emp.empl_dni   = x.dni_empleado;

    insert into LOS_SIN_GRUPO.Detalle_Compra
        (det_comp_nro_compra, det_comp_producto, det_comp_cantidad, det_comp_precio_costo, det_comp_subtotal)
    select o.Compra_Nro_Compra, o.Producto_Cod_Producto,
           sum(o.Detalle_Compra_Cantidad_Prod_Compra),
           min(o.Detalle_Compra_Precio_Unitario_Prod_Compra),
           sum(o.Detalle_Compra_Cantidad_Prod_Compra * o.Detalle_Compra_Precio_Unitario_Prod_Compra)
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Compra c   on c.comp_nro_compra = o.Compra_Nro_Compra
    join LOS_SIN_GRUPO.Producto p on p.prod_codigo     = o.Producto_Cod_Producto
    where o.Producto_Cod_Producto is not null
      and o.Detalle_Compra_Cantidad_Prod_Compra is not null
    group by o.Compra_Nro_Compra, o.Producto_Cod_Producto;
end
go

create procedure LOS_SIN_GRUPO.migrar_alquileres
as
begin
    set nocount on;

    insert into LOS_SIN_GRUPO.Bicicleta_Alquiler
        (bici_alq_nro_serie, bici_alq_local, bici_alq_modelo, bici_alq_estado, bici_alq_precio_hora, bici_alq_precio_dia)
    select distinct o.Bicicleta_Alquiler_Nro_Serie_Bici_Alquiler, null, null, e.est_bici_id,
           o.Bicicleta_Alquiler_Precio_Bici_Alquiler_Hora, o.Bicicleta_Alquiler_Precio_Bici_Alquiler_Dia
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Estado_Bici_Alquiler e on e.est_bici_descripcion = o.Estado_Bici_Alquiler_Estado_Bici_Alquiler
    where o.Bicicleta_Alquiler_Nro_Serie_Bici_Alquiler is not null;

    insert into LOS_SIN_GRUPO.Alquiler
        (alq_nro_alquiler, alq_cliente, alq_empleado, alq_bici_nro_serie, alq_forma_pago, alq_estado,
         alq_fecha_inicio, alq_fecha_fin_pactada, alq_fecha_devolucion_real, alq_importe_total)
    select distinct o.Alquiler_Nro_Alquiler, null, null, b.bici_alq_nro_serie, f.pago_id, es.est_alq_id,
           o.Alquiler_Fecha_Inicio_Alquiler, o.Alquiler_Fecha_Fin_Pactada_Alquiler,
           o.Alquiler_Fecha_Devolucion_Real_Alquiler, o.Alquiler_Importe_Total_Alquiler
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Bicicleta_Alquiler b on b.bici_alq_nro_serie = o.Bicicleta_Alquiler_Nro_Serie_Bici_Alquiler
    join LOS_SIN_GRUPO.Forma_Pago f on f.pago_descripcion = o.Forma_Pago_Forma_Pago
    join LOS_SIN_GRUPO.Estado_Alquiler es on es.est_alq_descripcion = o.Estado_Alquiler_Estado_Alquiler
    where o.Alquiler_Nro_Alquiler is not null;
end
go

create procedure LOS_SIN_GRUPO.migrar_reparaciones
as
begin
    set nocount on;

    -- Cabecera: una fila por número de reparación TODO: Falta corregir los nulos
    insert into LOS_SIN_GRUPO.Reparacion
        (repa_nro_reparacion, repa_local, repa_cliente, repa_empleado, repa_modelo_bici, repa_estado,
         repa_nro_serie_bici, repa_fecha_ingreso, repa_fecha_entrega_estimada, repa_fecha_entrega_real,
         repa_diagnostico, repa_precio_mano_obra, repa_precio_repuestos, repa_precio_total)
    select x.nro, null, null, null, null, es.est_rep_id,
           x.serie, x.fecha_ingreso, x.fecha_est, x.fecha_real, x.diagnostico,
           x.mano_obra, x.repuestos, x.total
    from (
        select Reparacion_Nro_Reparacion as nro,
               min(Estado_Reparacion_Estado_Reparacion)          as estado,
               min(Reparacion_Numero_Serie_Bici_Reparacion)      as serie,
               min(Reparacion_Fecha_Ingreso_Reparacion)          as fecha_ingreso,
               min(Reparacion_Fecha_Entrega_Estimada_Reparacion) as fecha_est,
               min(Reparacion_Fecha_Entrega_Real_Reparacion)     as fecha_real,
               min(Reparacion_Diagnostico_Reparacion)            as diagnostico,
               min(Reparacion_Precio_Mano_Obra_Reparacion)       as mano_obra,
               min(Reparacion_Precio_Repuestos_Reparacion)       as repuestos,
               min(Reparacion_Precio_Total_Reparacion)           as total
        from gd_esquema.Maestra
        where Reparacion_Nro_Reparacion is not null
        group by Reparacion_Nro_Reparacion
    ) x
    join LOS_SIN_GRUPO.Estado_Reparacion es on es.est_rep_descripcion = x.estado;

    insert into LOS_SIN_GRUPO.Detalle_Reparacion
        (det_repa_nro_reparacion, det_repa_repuesto, det_repa_cantidad,
         det_repa_precio_unitario, det_repa_subtotal)
    select o.Reparacion_Nro_Reparacion, o.Repuesto_Cod_Repuesto,
           sum(o.Detalle_Reparacion_Cantidad_Repuesto),
           min(o.Detalle_Reparacion_Precio_Unitario_Repuesto),
           sum(o.Detalle_Reparacion_Subtotal_Repuesto)
    from gd_esquema.Maestra o
    join LOS_SIN_GRUPO.Reparacion r on r.repa_nro_reparacion = o.Reparacion_Nro_Reparacion
    join LOS_SIN_GRUPO.Repuesto rp on rp.rep_codigo = o.Repuesto_Cod_Repuesto
    where o.Repuesto_Cod_Repuesto is not null
    group by o.Reparacion_Nro_Reparacion, o.Repuesto_Cod_Repuesto;
end
go

create procedure LOS_SIN_GRUPO.migrar_todo
as
begin
    set nocount on;
    begin transaction;
    begin try
        exec LOS_SIN_GRUPO.migrar_ubicaciones;
        exec LOS_SIN_GRUPO.migrar_catalogo;
        exec LOS_SIN_GRUPO.migrar_locales_empleados;
        exec LOS_SIN_GRUPO.migrar_clientes_proveedores;
        exec LOS_SIN_GRUPO.migrar_ventas;
        exec LOS_SIN_GRUPO.migrar_compras;
        exec LOS_SIN_GRUPO.migrar_alquileres;
        exec LOS_SIN_GRUPO.migrar_reparaciones;
        commit transaction;
    end try
    begin catch
        if @@trancount > 0 rollback transaction;
        print 'Error: ' + error_message();
        throw;
    end catch
end
go

exec LOS_SIN_GRUPO.migrar_todo;

-- TODO: CREACIÓN DE INDICES-----------------
