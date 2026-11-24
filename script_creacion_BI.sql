use GD2C_2026
go

-- Elimina las vistas del BI para poder re-ejecutar el script
drop view if exists LOS_SIN_GRUPO.BI_Vista_Facturacion_Ventas_Local_Mes
drop view if exists LOS_SIN_GRUPO.BI_Vista_Ticket_Promedio_Mes_Tipo_Rango
drop view if exists LOS_SIN_GRUPO.BI_Vista_Porcentaje_Ventas_Tipo_Local_Trimestre
drop view if exists LOS_SIN_GRUPO.BI_Vista_Promedio_Horas_Alquiler_Local_Mes
drop view if exists LOS_SIN_GRUPO.BI_Vista_Top5_Categorias_Alquiladas_Anio
drop view if exists LOS_SIN_GRUPO.BI_Vista_Desvio_Reparaciones_Local_Trimestre
drop view if exists LOS_SIN_GRUPO.BI_Vista_Ranking_Categorias_Repuestos_Mes
drop view if exists LOS_SIN_GRUPO.BI_Vista_Porcentaje_Facturacion_Reparaciones_Trimestre
drop view if exists LOS_SIN_GRUPO.BI_Vista_Promedio_Unidades_Compradas_Tipo_Trimestre
drop view if exists LOS_SIN_GRUPO.BI_Vista_Importe_Compras_Local_Mes
drop view if exists LOS_SIN_GRUPO.BI_Vista_Facturacion_Total_Local_Mes

-- Elimina las tablas del BI (primero los hechos y después las dimensiones)
drop table if exists LOS_SIN_GRUPO.BI_Hecho_Venta
drop table if exists LOS_SIN_GRUPO.BI_Hecho_Compra
drop table if exists LOS_SIN_GRUPO.BI_Hecho_Alquiler
drop table if exists LOS_SIN_GRUPO.BI_Hecho_Reparacion
drop table if exists LOS_SIN_GRUPO.BI_Hecho_Ingreso_Reparacion
drop table if exists LOS_SIN_GRUPO.BI_Hecho_Repuesto
drop table if exists LOS_SIN_GRUPO.BI_Tiempo
drop table if exists LOS_SIN_GRUPO.BI_Rango_Etario
drop table if exists LOS_SIN_GRUPO.BI_Tipo_Producto
drop table if exists LOS_SIN_GRUPO.BI_Local
drop table if exists LOS_SIN_GRUPO.BI_Categoria_Bicicleta
drop table if exists LOS_SIN_GRUPO.BI_Categoria_Repuesto
drop table if exists LOS_SIN_GRUPO.BI_Tipo_Ingreso_Reparacion

-- Elimina los stored procedures del BI
drop procedure if exists LOS_SIN_GRUPO.migrar_bi_todo
drop procedure if exists LOS_SIN_GRUPO.migrar_bi_hechos
drop procedure if exists LOS_SIN_GRUPO.migrar_bi_dimensiones
go

-- Dimensión tiempo: una fila por año, trimestre y mes
create table LOS_SIN_GRUPO.BI_Tiempo (
    tiempo_id bigint identity(1,1),
    tiempo_anio int not null,
    tiempo_trimestre int not null,
    tiempo_mes int not null,
    constraint pk_bi_tiempo primary key (tiempo_id),
    constraint uq_bi_tiempo unique (tiempo_anio, tiempo_mes)
)

-- Dimensión rango etario de los clientes
create table LOS_SIN_GRUPO.BI_Rango_Etario (
    rango_etario_id bigint identity(1,1),
    rango_etario_descripcion nvarchar(50) not null,
    constraint pk_bi_rango_etario primary key (rango_etario_id)
)

-- Dimensión tipo de producto (bicicleta o accesorio)
create table LOS_SIN_GRUPO.BI_Tipo_Producto (
    tipo_producto_id bigint not null,
    tipo_producto_descripcion nvarchar(50) not null,
    constraint pk_bi_tipo_producto primary key (tipo_producto_id)
)

-- Dimensión local, el id 0 representa "Sin informar" para operaciones sin local
create table LOS_SIN_GRUPO.BI_Local (
    local_id bigint not null,
    local_nombre nvarchar(255) not null,
    local_localidad nvarchar(255),
    local_provincia nvarchar(255),
    constraint pk_bi_local primary key (local_id)
)

-- Dimensión categoría de bicicleta, el id 0 representa "Sin informar"
create table LOS_SIN_GRUPO.BI_Categoria_Bicicleta (
    categoria_bicicleta_id bigint not null,
    categoria_bicicleta_nombre nvarchar(255) not null,
    constraint pk_bi_categoria_bicicleta primary key (categoria_bicicleta_id)
)

-- Dimensión categoría de repuesto
create table LOS_SIN_GRUPO.BI_Categoria_Repuesto (
    categoria_repuesto_id bigint not null,
    categoria_repuesto_nombre nvarchar(255) not null,
    constraint pk_bi_categoria_repuesto primary key (categoria_repuesto_id)
)

-- Dimensión tipo de ingreso de reparación (mano de obra o repuestos)
create table LOS_SIN_GRUPO.BI_Tipo_Ingreso_Reparacion (
    tipo_ingreso_id bigint identity(1,1),
    tipo_ingreso_descripcion nvarchar(50) not null,
    constraint pk_bi_tipo_ingreso_reparacion primary key (tipo_ingreso_id)
)

-- Hechos de ventas: una fila por tiempo, local, tipo de producto y rango etario, con las ventas sumarizadas
create table LOS_SIN_GRUPO.BI_Hecho_Venta (
    hecho_venta_tiempo bigint not null,
    hecho_venta_local bigint not null,
    hecho_venta_tipo_producto bigint not null,
    hecho_venta_rango_etario bigint not null,
    hecho_venta_cantidad_ventas int not null,
    hecho_venta_cantidad_unidades int,
    hecho_venta_monto_total decimal(18,2),
    constraint pk_bi_hecho_venta primary key (hecho_venta_tiempo, hecho_venta_local, hecho_venta_tipo_producto, hecho_venta_rango_etario),
    constraint fk_bi_hecho_venta_tiempo foreign key (hecho_venta_tiempo) references LOS_SIN_GRUPO.BI_Tiempo(tiempo_id),
    constraint fk_bi_hecho_venta_local foreign key (hecho_venta_local) references LOS_SIN_GRUPO.BI_Local(local_id),
    constraint fk_bi_hecho_venta_tipo_producto foreign key (hecho_venta_tipo_producto) references LOS_SIN_GRUPO.BI_Tipo_Producto(tipo_producto_id),
    constraint fk_bi_hecho_venta_rango_etario foreign key (hecho_venta_rango_etario) references LOS_SIN_GRUPO.BI_Rango_Etario(rango_etario_id)
)

-- Hechos de compras: una fila por tiempo, local y tipo de producto, con las compras sumarizadas
create table LOS_SIN_GRUPO.BI_Hecho_Compra (
    hecho_compra_tiempo bigint not null,
    hecho_compra_local bigint not null,
    hecho_compra_tipo_producto bigint not null,
    hecho_compra_cantidad_compras int not null,
    hecho_compra_cantidad_unidades int,
    hecho_compra_monto_total decimal(18,2),
    constraint pk_bi_hecho_compra primary key (hecho_compra_tiempo, hecho_compra_local, hecho_compra_tipo_producto),
    constraint fk_bi_hecho_compra_tiempo foreign key (hecho_compra_tiempo) references LOS_SIN_GRUPO.BI_Tiempo(tiempo_id),
    constraint fk_bi_hecho_compra_local foreign key (hecho_compra_local) references LOS_SIN_GRUPO.BI_Local(local_id),
    constraint fk_bi_hecho_compra_tipo_producto foreign key (hecho_compra_tipo_producto) references LOS_SIN_GRUPO.BI_Tipo_Producto(tipo_producto_id)
)

-- Hechos de alquileres: una fila por tiempo, local y categoría de bicicleta, con los alquileres sumarizados
create table LOS_SIN_GRUPO.BI_Hecho_Alquiler (
    hecho_alquiler_tiempo bigint not null,
    hecho_alquiler_local bigint not null,
    hecho_alquiler_categoria_bicicleta bigint not null,
    hecho_alquiler_cantidad_alquileres int not null,
    hecho_alquiler_cantidad_con_horas int not null,
    hecho_alquiler_total_horas decimal(18,2),
    hecho_alquiler_monto_total decimal(18,2),
    constraint pk_bi_hecho_alquiler primary key (hecho_alquiler_tiempo, hecho_alquiler_local, hecho_alquiler_categoria_bicicleta),
    constraint fk_bi_hecho_alquiler_tiempo foreign key (hecho_alquiler_tiempo) references LOS_SIN_GRUPO.BI_Tiempo(tiempo_id),
    constraint fk_bi_hecho_alquiler_local foreign key (hecho_alquiler_local) references LOS_SIN_GRUPO.BI_Local(local_id),
    constraint fk_bi_hecho_alquiler_categoria_bicicleta foreign key (hecho_alquiler_categoria_bicicleta) references LOS_SIN_GRUPO.BI_Categoria_Bicicleta(categoria_bicicleta_id)
)

-- Hechos de reparaciones: una fila por tiempo y local, con las reparaciones y sus desvíos de entrega sumarizados
create table LOS_SIN_GRUPO.BI_Hecho_Reparacion (
    hecho_reparacion_tiempo bigint not null,
    hecho_reparacion_local bigint not null,
    hecho_reparacion_cantidad_reparaciones int not null,
    hecho_reparacion_cantidad_con_desvio int not null,
    hecho_reparacion_total_desvio_dias int,
    hecho_reparacion_monto_total decimal(18,2),
    constraint pk_bi_hecho_reparacion primary key (hecho_reparacion_tiempo, hecho_reparacion_local),
    constraint fk_bi_hecho_reparacion_tiempo foreign key (hecho_reparacion_tiempo) references LOS_SIN_GRUPO.BI_Tiempo(tiempo_id),
    constraint fk_bi_hecho_reparacion_local foreign key (hecho_reparacion_local) references LOS_SIN_GRUPO.BI_Local(local_id)
)

-- Hechos de ingresos de reparación: una fila por tiempo, local y tipo de ingreso, con el monto sumarizado
create table LOS_SIN_GRUPO.BI_Hecho_Ingreso_Reparacion (
    hecho_ingreso_reparacion_tiempo bigint not null,
    hecho_ingreso_reparacion_local bigint not null,
    hecho_ingreso_reparacion_tipo_ingreso bigint not null,
    hecho_ingreso_reparacion_monto_total decimal(18,2),
    constraint pk_bi_hecho_ingreso_reparacion primary key (hecho_ingreso_reparacion_tiempo, hecho_ingreso_reparacion_local, hecho_ingreso_reparacion_tipo_ingreso),
    constraint fk_bi_hecho_ingreso_reparacion_tiempo foreign key (hecho_ingreso_reparacion_tiempo) references LOS_SIN_GRUPO.BI_Tiempo(tiempo_id),
    constraint fk_bi_hecho_ingreso_reparacion_local foreign key (hecho_ingreso_reparacion_local) references LOS_SIN_GRUPO.BI_Local(local_id),
    constraint fk_bi_hecho_ingreso_reparacion_tipo_ingreso foreign key (hecho_ingreso_reparacion_tipo_ingreso) references LOS_SIN_GRUPO.BI_Tipo_Ingreso_Reparacion(tipo_ingreso_id)
)

-- Hechos de repuestos utilizados: una fila por tiempo, local y categoría de repuesto, con las unidades sumarizadas
create table LOS_SIN_GRUPO.BI_Hecho_Repuesto (
    hecho_repuesto_tiempo bigint not null,
    hecho_repuesto_local bigint not null,
    hecho_repuesto_categoria_repuesto bigint not null,
    hecho_repuesto_cantidad_utilizada int,
    constraint pk_bi_hecho_repuesto primary key (hecho_repuesto_tiempo, hecho_repuesto_local, hecho_repuesto_categoria_repuesto),
    constraint fk_bi_hecho_repuesto_tiempo foreign key (hecho_repuesto_tiempo) references LOS_SIN_GRUPO.BI_Tiempo(tiempo_id),
    constraint fk_bi_hecho_repuesto_local foreign key (hecho_repuesto_local) references LOS_SIN_GRUPO.BI_Local(local_id),
    constraint fk_bi_hecho_repuesto_categoria_repuesto foreign key (hecho_repuesto_categoria_repuesto) references LOS_SIN_GRUPO.BI_Categoria_Repuesto(categoria_repuesto_id)
)
go

-- SP que migra las dimensiones del BI desde el modelo transaccional
create procedure LOS_SIN_GRUPO.migrar_bi_dimensiones
as
begin
    set nocount on

    -- Tiempo: combinaciones de año, trimestre y mes de todas las fechas de operaciones
    insert into LOS_SIN_GRUPO.BI_Tiempo (tiempo_anio, tiempo_trimestre, tiempo_mes)
    select distinct year(x.fecha), datepart(quarter, x.fecha), month(x.fecha)
    from (
        select vent_fecha_hora as fecha from LOS_SIN_GRUPO.Venta
        union select comp_fecha from LOS_SIN_GRUPO.Compra
        union select alq_fecha_inicio from LOS_SIN_GRUPO.Alquiler
        union select repa_fecha_ingreso from LOS_SIN_GRUPO.Reparacion
    ) x
    where x.fecha is not null

    -- Rangos etarios del enunciado, más "Sin informar" para clientes sin fecha de nacimiento
    insert into LOS_SIN_GRUPO.BI_Rango_Etario (rango_etario_descripcion)
    values ('Hasta 25 años'), ('De 26 a 35 años'), ('De 36 a 50 años'), ('Más de 50 años'), ('Sin informar')

    -- Tipos de producto
    insert into LOS_SIN_GRUPO.BI_Tipo_Producto (tipo_producto_id, tipo_producto_descripcion)
    select tipo_prod_id, tipo_prod_descripcion
    from LOS_SIN_GRUPO.Tipo_Producto

    -- Locales con su localidad y provincia
    insert into LOS_SIN_GRUPO.BI_Local (local_id, local_nombre, local_localidad, local_provincia)
    select l.loc_id, l.loc_nombre, lo.loca_nombre, p.pcia_nombre
    from LOS_SIN_GRUPO.Local l
    join LOS_SIN_GRUPO.Localidad lo on lo.loca_id = l.loc_localidad
    join LOS_SIN_GRUPO.Provincia p  on p.pcia_id = lo.loca_provincia

    -- Local "Sin informar" para operaciones cuyo local no se pudo determinar
    insert into LOS_SIN_GRUPO.BI_Local (local_id, local_nombre, local_localidad, local_provincia)
    values (0, 'Sin informar', null, null)

    -- Categorías de bicicleta
    insert into LOS_SIN_GRUPO.BI_Categoria_Bicicleta (categoria_bicicleta_id, categoria_bicicleta_nombre)
    select cat_bici_id, cat_bici_nombre
    from LOS_SIN_GRUPO.Categoria_Bicicleta

    -- Categoría "Sin informar" para alquileres cuya bicicleta no tiene modelo
    insert into LOS_SIN_GRUPO.BI_Categoria_Bicicleta (categoria_bicicleta_id, categoria_bicicleta_nombre)
    values (0, 'Sin informar')

    -- Categorías de repuesto
    insert into LOS_SIN_GRUPO.BI_Categoria_Repuesto (categoria_repuesto_id, categoria_repuesto_nombre)
    select cat_rep_id, cat_rep_nombre
    from LOS_SIN_GRUPO.Categoria_Repuesto

    -- Tipos de ingreso de reparación
    insert into LOS_SIN_GRUPO.BI_Tipo_Ingreso_Reparacion (tipo_ingreso_descripcion)
    values ('Mano de Obra'), ('Repuestos')
end
go

-- SP que migra las tablas de hechos del BI, sumarizando la información por sus dimensiones
create procedure LOS_SIN_GRUPO.migrar_bi_hechos
as
begin
    set nocount on

    -- Ventas: cantidad de ventas, unidades y monto por tiempo, local, tipo de producto y rango etario del cliente
    insert into LOS_SIN_GRUPO.BI_Hecho_Venta
        (hecho_venta_tiempo, hecho_venta_local, hecho_venta_tipo_producto, hecho_venta_rango_etario,
         hecho_venta_cantidad_ventas, hecho_venta_cantidad_unidades, hecho_venta_monto_total)
    select t.tiempo_id, v.vent_local, p.prod_tipo, r.rango_etario_id,
           count(distinct v.vent_nro_venta), sum(d.det_vent_cantidad), sum(d.det_vent_subtotal)
    from LOS_SIN_GRUPO.Venta v
    join LOS_SIN_GRUPO.Detalle_Venta d on d.det_vent_nro_venta = v.vent_nro_venta
    join LOS_SIN_GRUPO.Producto p      on p.prod_codigo = d.det_vent_producto
    join LOS_SIN_GRUPO.BI_Tiempo t     on t.tiempo_anio = year(v.vent_fecha_hora)
                                      and t.tiempo_mes = month(v.vent_fecha_hora)
    left join LOS_SIN_GRUPO.Cliente c  on c.clie_id = v.vent_cliente
    -- Edad cumplida del cliente a la fecha de la venta (NULL si no hay fecha de nacimiento)
    cross apply (
        select datediff(year, c.clie_fecha_nac, v.vent_fecha_hora)
             - case when dateadd(year, datediff(year, c.clie_fecha_nac, v.vent_fecha_hora), c.clie_fecha_nac) > v.vent_fecha_hora
                    then 1 else 0 end as edad
    ) a
    join LOS_SIN_GRUPO.BI_Rango_Etario r
         on r.rango_etario_descripcion = case when a.edad is null then 'Sin informar'
                                              when a.edad <= 25   then 'Hasta 25 años'
                                              when a.edad <= 35   then 'De 26 a 35 años'
                                              when a.edad <= 50   then 'De 36 a 50 años'
                                              else 'Más de 50 años' end
    group by t.tiempo_id, v.vent_local, p.prod_tipo, r.rango_etario_id

    -- Compras: cantidad de compras, unidades y monto por tiempo, local y tipo de producto
    insert into LOS_SIN_GRUPO.BI_Hecho_Compra
        (hecho_compra_tiempo, hecho_compra_local, hecho_compra_tipo_producto,
         hecho_compra_cantidad_compras, hecho_compra_cantidad_unidades, hecho_compra_monto_total)
    select t.tiempo_id, c.comp_local, p.prod_tipo,
           count(distinct c.comp_nro_compra), sum(d.det_comp_cantidad), sum(d.det_comp_subtotal)
    from LOS_SIN_GRUPO.Compra c
    join LOS_SIN_GRUPO.Detalle_Compra d on d.det_comp_nro_compra = c.comp_nro_compra
    join LOS_SIN_GRUPO.Producto p       on p.prod_codigo = d.det_comp_producto
    join LOS_SIN_GRUPO.BI_Tiempo t      on t.tiempo_anio = year(c.comp_fecha)
                                       and t.tiempo_mes = month(c.comp_fecha)
    group by t.tiempo_id, c.comp_local, p.prod_tipo

    -- Alquileres: cantidad, horas y monto por tiempo, local y categoría de bicicleta
    -- (las horas van de inicio a devolución real y quedan NULL si no hubo devolución o las fechas están invertidas)
    insert into LOS_SIN_GRUPO.BI_Hecho_Alquiler
        (hecho_alquiler_tiempo, hecho_alquiler_local, hecho_alquiler_categoria_bicicleta,
         hecho_alquiler_cantidad_alquileres, hecho_alquiler_cantidad_con_horas,
         hecho_alquiler_total_horas, hecho_alquiler_monto_total)
    select t.tiempo_id, isnull(b.bici_alq_local, 0), isnull(m.mod_categoria, 0),
           count(*), count(x.horas), cast(sum(x.horas) as decimal(18,2)), sum(a.alq_importe_total)
    from LOS_SIN_GRUPO.Alquiler a
    join LOS_SIN_GRUPO.Bicicleta_Alquiler b    on b.bici_alq_nro_serie = a.alq_bici_nro_serie
    left join LOS_SIN_GRUPO.Modelo_Bicicleta m on m.mod_id = b.bici_alq_modelo
    join LOS_SIN_GRUPO.BI_Tiempo t             on t.tiempo_anio = year(a.alq_fecha_inicio)
                                              and t.tiempo_mes = month(a.alq_fecha_inicio)
    -- Horas de duración real del alquiler
    cross apply (
        select case when a.alq_fecha_devolucion_real >= a.alq_fecha_inicio
                    then datediff(minute, a.alq_fecha_inicio, a.alq_fecha_devolucion_real) / 60.0 end as horas
    ) x
    group by t.tiempo_id, isnull(b.bici_alq_local, 0), isnull(m.mod_categoria, 0)

    -- Reparaciones: cantidad, desvío de entrega y monto por tiempo y local
    -- (el desvío es NULL si la reparación todavía no fue entregada)
    insert into LOS_SIN_GRUPO.BI_Hecho_Reparacion
        (hecho_reparacion_tiempo, hecho_reparacion_local, hecho_reparacion_cantidad_reparaciones,
         hecho_reparacion_cantidad_con_desvio, hecho_reparacion_total_desvio_dias, hecho_reparacion_monto_total)
    select t.tiempo_id, isnull(r.repa_local, 0),
           count(*), count(x.desvio), sum(x.desvio), sum(r.repa_precio_total)
    from LOS_SIN_GRUPO.Reparacion r
    join LOS_SIN_GRUPO.BI_Tiempo t on t.tiempo_anio = year(r.repa_fecha_ingreso)
                                  and t.tiempo_mes = month(r.repa_fecha_ingreso)
    -- Días de desvío entre la entrega estimada y la real
    cross apply (
        select case when r.repa_fecha_entrega_real is not null and r.repa_fecha_entrega_estimada is not null
                    then datediff(day, r.repa_fecha_entrega_estimada, r.repa_fecha_entrega_real) end as desvio
    ) x
    group by t.tiempo_id, isnull(r.repa_local, 0)

    -- Ingresos de reparación: monto de mano de obra y de repuestos por tiempo y local
    insert into LOS_SIN_GRUPO.BI_Hecho_Ingreso_Reparacion
        (hecho_ingreso_reparacion_tiempo, hecho_ingreso_reparacion_local,
         hecho_ingreso_reparacion_tipo_ingreso, hecho_ingreso_reparacion_monto_total)
    select t.tiempo_id, isnull(r.repa_local, 0), ti.tipo_ingreso_id,
           sum(case when ti.tipo_ingreso_descripcion = 'Mano de Obra' then r.repa_precio_mano_obra
                    else r.repa_precio_repuestos end)
    from LOS_SIN_GRUPO.Reparacion r
    join LOS_SIN_GRUPO.BI_Tiempo t on t.tiempo_anio = year(r.repa_fecha_ingreso)
                                  and t.tiempo_mes = month(r.repa_fecha_ingreso)
    cross join LOS_SIN_GRUPO.BI_Tipo_Ingreso_Reparacion ti
    group by t.tiempo_id, isnull(r.repa_local, 0), ti.tipo_ingreso_id

    -- Repuestos utilizados: unidades por tiempo, local y categoría de repuesto
    insert into LOS_SIN_GRUPO.BI_Hecho_Repuesto
        (hecho_repuesto_tiempo, hecho_repuesto_local, hecho_repuesto_categoria_repuesto,
         hecho_repuesto_cantidad_utilizada)
    select t.tiempo_id, isnull(r.repa_local, 0), rp.rep_categoria, sum(d.det_repa_cantidad)
    from LOS_SIN_GRUPO.Reparacion r
    join LOS_SIN_GRUPO.Detalle_Reparacion d on d.det_repa_nro_reparacion = r.repa_nro_reparacion
    join LOS_SIN_GRUPO.Repuesto rp          on rp.rep_codigo = d.det_repa_repuesto
    join LOS_SIN_GRUPO.BI_Tiempo t          on t.tiempo_anio = year(r.repa_fecha_ingreso)
                                           and t.tiempo_mes = month(r.repa_fecha_ingreso)
    group by t.tiempo_id, isnull(r.repa_local, 0), rp.rep_categoria
end
go

-- SP principal del BI: ejecuta todas las migraciones en orden dentro de una transacción
create procedure LOS_SIN_GRUPO.migrar_bi_todo
as
begin
    set nocount on
    begin transaction
    begin try
        exec LOS_SIN_GRUPO.migrar_bi_dimensiones
        exec LOS_SIN_GRUPO.migrar_bi_hechos
        commit transaction
    end try
    begin catch
        if @@trancount > 0 rollback transaction
        declare @mensaje nvarchar(4000) = 'Error: ' + error_message()
        raiserror(@mensaje, 16, 1)
    end catch
end
go

-- Ejecuta la migración completa del BI
exec LOS_SIN_GRUPO.migrar_bi_todo
go

-- Índices sobre las FKs de las tablas de hechos que no encabezan la clave primaria
-- Venta por local
create index ix_bi_hecho_venta_local on LOS_SIN_GRUPO.BI_Hecho_Venta (hecho_venta_local)
-- Venta por tipo de producto
create index ix_bi_hecho_venta_tipo_producto on LOS_SIN_GRUPO.BI_Hecho_Venta (hecho_venta_tipo_producto)
-- Venta por rango etario
create index ix_bi_hecho_venta_rango_etario on LOS_SIN_GRUPO.BI_Hecho_Venta (hecho_venta_rango_etario)
-- Compra por local
create index ix_bi_hecho_compra_local on LOS_SIN_GRUPO.BI_Hecho_Compra (hecho_compra_local)
-- Compra por tipo de producto
create index ix_bi_hecho_compra_tipo_producto on LOS_SIN_GRUPO.BI_Hecho_Compra (hecho_compra_tipo_producto)
-- Alquiler por local
create index ix_bi_hecho_alquiler_local on LOS_SIN_GRUPO.BI_Hecho_Alquiler (hecho_alquiler_local)
-- Alquiler por categoría de bicicleta
create index ix_bi_hecho_alquiler_categoria_bicicleta on LOS_SIN_GRUPO.BI_Hecho_Alquiler (hecho_alquiler_categoria_bicicleta)
-- Reparación por local
create index ix_bi_hecho_reparacion_local on LOS_SIN_GRUPO.BI_Hecho_Reparacion (hecho_reparacion_local)
-- Ingreso de reparación por local
create index ix_bi_hecho_ingreso_reparacion_local on LOS_SIN_GRUPO.BI_Hecho_Ingreso_Reparacion (hecho_ingreso_reparacion_local)
-- Ingreso de reparación por tipo de ingreso
create index ix_bi_hecho_ingreso_reparacion_tipo_ingreso on LOS_SIN_GRUPO.BI_Hecho_Ingreso_Reparacion (hecho_ingreso_reparacion_tipo_ingreso)
-- Repuesto utilizado por local
create index ix_bi_hecho_repuesto_local on LOS_SIN_GRUPO.BI_Hecho_Repuesto (hecho_repuesto_local)
-- Repuesto utilizado por categoría de repuesto
create index ix_bi_hecho_repuesto_categoria_repuesto on LOS_SIN_GRUPO.BI_Hecho_Repuesto (hecho_repuesto_categoria_repuesto)
go

-- Vista 1: facturación total mensual en ventas de cada local
create view LOS_SIN_GRUPO.BI_Vista_Facturacion_Ventas_Local_Mes
as
select t.tiempo_anio as anio, t.tiempo_mes as mes, l.local_id, l.local_nombre,
       sum(h.hecho_venta_monto_total) as facturacion
from LOS_SIN_GRUPO.BI_Hecho_Venta h
join LOS_SIN_GRUPO.BI_Tiempo t on t.tiempo_id = h.hecho_venta_tiempo
join LOS_SIN_GRUPO.BI_Local l  on l.local_id = h.hecho_venta_local
group by t.tiempo_anio, t.tiempo_mes, l.local_id, l.local_nombre
go

-- Vista 2: ticket promedio de venta mensual por tipo de producto y rango etario del cliente
create view LOS_SIN_GRUPO.BI_Vista_Ticket_Promedio_Mes_Tipo_Rango
as
select t.tiempo_anio as anio, t.tiempo_mes as mes, tp.tipo_producto_descripcion as tipo_producto,
       r.rango_etario_descripcion as rango_etario,
       cast(sum(h.hecho_venta_monto_total) / nullif(sum(h.hecho_venta_cantidad_ventas), 0) as decimal(18,2)) as ticket_promedio
from LOS_SIN_GRUPO.BI_Hecho_Venta h
join LOS_SIN_GRUPO.BI_Tiempo t         on t.tiempo_id = h.hecho_venta_tiempo
join LOS_SIN_GRUPO.BI_Tipo_Producto tp on tp.tipo_producto_id = h.hecho_venta_tipo_producto
join LOS_SIN_GRUPO.BI_Rango_Etario r   on r.rango_etario_id = h.hecho_venta_rango_etario
group by t.tiempo_anio, t.tiempo_mes, tp.tipo_producto_descripcion, r.rango_etario_descripcion
go

-- Vista 3: porcentaje de ventas trimestrales según tipo de producto por local
create view LOS_SIN_GRUPO.BI_Vista_Porcentaje_Ventas_Tipo_Local_Trimestre
as
select t.tiempo_anio as anio, t.tiempo_trimestre as trimestre, l.local_id, l.local_nombre,
       tp.tipo_producto_descripcion as tipo_producto,
       sum(h.hecho_venta_monto_total) as monto,
       cast(sum(h.hecho_venta_monto_total) * 100.0
            / nullif(sum(sum(h.hecho_venta_monto_total)) over (partition by t.tiempo_anio, t.tiempo_trimestre, l.local_id), 0)
            as decimal(18,2)) as porcentaje
from LOS_SIN_GRUPO.BI_Hecho_Venta h
join LOS_SIN_GRUPO.BI_Tiempo t         on t.tiempo_id = h.hecho_venta_tiempo
join LOS_SIN_GRUPO.BI_Local l          on l.local_id = h.hecho_venta_local
join LOS_SIN_GRUPO.BI_Tipo_Producto tp on tp.tipo_producto_id = h.hecho_venta_tipo_producto
group by t.tiempo_anio, t.tiempo_trimestre, l.local_id, l.local_nombre, tp.tipo_producto_descripcion
go

-- Vista 4: promedio de cantidad de horas de alquiler de bicicletas por local y mes
create view LOS_SIN_GRUPO.BI_Vista_Promedio_Horas_Alquiler_Local_Mes
as
select t.tiempo_anio as anio, t.tiempo_mes as mes, l.local_id, l.local_nombre,
       cast(sum(h.hecho_alquiler_total_horas) / nullif(sum(h.hecho_alquiler_cantidad_con_horas), 0) as decimal(18,2)) as promedio_horas
from LOS_SIN_GRUPO.BI_Hecho_Alquiler h
join LOS_SIN_GRUPO.BI_Tiempo t on t.tiempo_id = h.hecho_alquiler_tiempo
join LOS_SIN_GRUPO.BI_Local l  on l.local_id = h.hecho_alquiler_local
group by t.tiempo_anio, t.tiempo_mes, l.local_id, l.local_nombre
go

-- Vista 5: top 5 categorías de bicicleta más alquiladas por año
create view LOS_SIN_GRUPO.BI_Vista_Top5_Categorias_Alquiladas_Anio
as
with ranking as (
    select t.tiempo_anio as anio, c.categoria_bicicleta_id as categoria_id,
           c.categoria_bicicleta_nombre as categoria,
           sum(h.hecho_alquiler_cantidad_alquileres) as cantidad_alquileres,
           row_number() over (partition by t.tiempo_anio
                              order by sum(h.hecho_alquiler_cantidad_alquileres) desc, c.categoria_bicicleta_nombre) as puesto
    from LOS_SIN_GRUPO.BI_Hecho_Alquiler h
    join LOS_SIN_GRUPO.BI_Tiempo t              on t.tiempo_id = h.hecho_alquiler_tiempo
    join LOS_SIN_GRUPO.BI_Categoria_Bicicleta c on c.categoria_bicicleta_id = h.hecho_alquiler_categoria_bicicleta
    where c.categoria_bicicleta_id <> 0
    group by t.tiempo_anio, c.categoria_bicicleta_id, c.categoria_bicicleta_nombre
)
select anio, puesto, categoria_id, categoria, cantidad_alquileres
from ranking
where puesto <= 5
go

-- Vista 6: desvío promedio de reparaciones (en días) entre fecha de entrega estimada y real, por local y trimestre
create view LOS_SIN_GRUPO.BI_Vista_Desvio_Reparaciones_Local_Trimestre
as
select t.tiempo_anio as anio, t.tiempo_trimestre as trimestre, l.local_id, l.local_nombre,
       cast(sum(h.hecho_reparacion_total_desvio_dias) * 1.0 / nullif(sum(h.hecho_reparacion_cantidad_con_desvio), 0) as decimal(18,2)) as desvio_promedio_dias
from LOS_SIN_GRUPO.BI_Hecho_Reparacion h
join LOS_SIN_GRUPO.BI_Tiempo t on t.tiempo_id = h.hecho_reparacion_tiempo
join LOS_SIN_GRUPO.BI_Local l  on l.local_id = h.hecho_reparacion_local
group by t.tiempo_anio, t.tiempo_trimestre, l.local_id, l.local_nombre
go

-- Vista 7: ranking de categorías de repuestos más utilizadas por mes
create view LOS_SIN_GRUPO.BI_Vista_Ranking_Categorias_Repuestos_Mes
as
select t.tiempo_anio as anio, t.tiempo_mes as mes, c.categoria_repuesto_id as categoria_id,
       c.categoria_repuesto_nombre as categoria,
       sum(h.hecho_repuesto_cantidad_utilizada) as cantidad_utilizada,
       rank() over (partition by t.tiempo_anio, t.tiempo_mes order by sum(h.hecho_repuesto_cantidad_utilizada) desc) as ranking
from LOS_SIN_GRUPO.BI_Hecho_Repuesto h
join LOS_SIN_GRUPO.BI_Tiempo t             on t.tiempo_id = h.hecho_repuesto_tiempo
join LOS_SIN_GRUPO.BI_Categoria_Repuesto c on c.categoria_repuesto_id = h.hecho_repuesto_categoria_repuesto
group by t.tiempo_anio, t.tiempo_mes, c.categoria_repuesto_id, c.categoria_repuesto_nombre
go

-- Vista 8: porcentaje de facturación de reparaciones según tipo de ingreso (mano de obra o repuestos) por trimestre
create view LOS_SIN_GRUPO.BI_Vista_Porcentaje_Facturacion_Reparaciones_Trimestre
as
select t.tiempo_anio as anio, t.tiempo_trimestre as trimestre, ti.tipo_ingreso_descripcion as tipo_ingreso,
       sum(h.hecho_ingreso_reparacion_monto_total) as monto,
       cast(sum(h.hecho_ingreso_reparacion_monto_total) * 100.0
            / nullif(sum(sum(h.hecho_ingreso_reparacion_monto_total)) over (partition by t.tiempo_anio, t.tiempo_trimestre), 0)
            as decimal(18,2)) as porcentaje
from LOS_SIN_GRUPO.BI_Hecho_Ingreso_Reparacion h
join LOS_SIN_GRUPO.BI_Tiempo t                   on t.tiempo_id = h.hecho_ingreso_reparacion_tiempo
join LOS_SIN_GRUPO.BI_Tipo_Ingreso_Reparacion ti on ti.tipo_ingreso_id = h.hecho_ingreso_reparacion_tipo_ingreso
group by t.tiempo_anio, t.tiempo_trimestre, ti.tipo_ingreso_descripcion
go

-- Vista 9: promedio de unidades compradas según tipo de producto por trimestre
-- (promedio de unidades por compra, considerando cada compra que incluye ese tipo de producto)
create view LOS_SIN_GRUPO.BI_Vista_Promedio_Unidades_Compradas_Tipo_Trimestre
as
select t.tiempo_anio as anio, t.tiempo_trimestre as trimestre, tp.tipo_producto_descripcion as tipo_producto,
       cast(sum(h.hecho_compra_cantidad_unidades) * 1.0 / nullif(sum(h.hecho_compra_cantidad_compras), 0) as decimal(18,2)) as promedio_unidades
from LOS_SIN_GRUPO.BI_Hecho_Compra h
join LOS_SIN_GRUPO.BI_Tiempo t         on t.tiempo_id = h.hecho_compra_tiempo
join LOS_SIN_GRUPO.BI_Tipo_Producto tp on tp.tipo_producto_id = h.hecho_compra_tipo_producto
group by t.tiempo_anio, t.tiempo_trimestre, tp.tipo_producto_descripcion
go

-- Vista 10: importe total de compras mensuales por local
create view LOS_SIN_GRUPO.BI_Vista_Importe_Compras_Local_Mes
as
select t.tiempo_anio as anio, t.tiempo_mes as mes, l.local_id, l.local_nombre,
       sum(h.hecho_compra_monto_total) as importe_total
from LOS_SIN_GRUPO.BI_Hecho_Compra h
join LOS_SIN_GRUPO.BI_Tiempo t on t.tiempo_id = h.hecho_compra_tiempo
join LOS_SIN_GRUPO.BI_Local l  on l.local_id = h.hecho_compra_local
group by t.tiempo_anio, t.tiempo_mes, l.local_id, l.local_nombre
go

-- Vista 11: facturación mensual del negocio (ventas + alquileres + reparaciones) por local
create view LOS_SIN_GRUPO.BI_Vista_Facturacion_Total_Local_Mes
as
with facturacion as (
    select hecho_venta_tiempo as tiempo_id, hecho_venta_local as local_id,
           hecho_venta_monto_total as ventas, cast(0 as decimal(18,2)) as alquileres, cast(0 as decimal(18,2)) as reparaciones
    from LOS_SIN_GRUPO.BI_Hecho_Venta
    union all
    select hecho_alquiler_tiempo, hecho_alquiler_local, cast(0 as decimal(18,2)), hecho_alquiler_monto_total, cast(0 as decimal(18,2))
    from LOS_SIN_GRUPO.BI_Hecho_Alquiler
    union all
    select hecho_reparacion_tiempo, hecho_reparacion_local, cast(0 as decimal(18,2)), cast(0 as decimal(18,2)), hecho_reparacion_monto_total
    from LOS_SIN_GRUPO.BI_Hecho_Reparacion
)
select t.tiempo_anio as anio, t.tiempo_mes as mes, l.local_id, l.local_nombre,
       sum(f.ventas) as facturacion_ventas,
       sum(f.alquileres) as facturacion_alquileres,
       sum(f.reparaciones) as facturacion_reparaciones,
       sum(f.ventas) + sum(f.alquileres) + sum(f.reparaciones) as facturacion_total
from facturacion f
join LOS_SIN_GRUPO.BI_Tiempo t on t.tiempo_id = f.tiempo_id
join LOS_SIN_GRUPO.BI_Local l  on l.local_id = f.local_id
group by t.tiempo_anio, t.tiempo_mes, l.local_id, l.local_nombre
go
