/*****PROCEDIMIENTO DE LOGIN*******/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_Get_LoginParams'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_Get_LoginParams]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE      Procedure [dbo].[stp_UDPV_Get_LoginParams]--stp_UDPV_Get_LoginParams 'cbobadilla','debb','factura'
	@Usr varchar(50), @Pass varchar(50), @Objeto varchar(50)
/* *********
Devuelve, 
	si el usuario y password son los correctos y el grupo asignado tiene privilegio de lectura,
Los parametros globales
********* */
As
Set nocount on
Declare @Sucursal  integer
	Declare @BodegasNegativos char(1)

	Select @sucursal=Codigo_Sucursal, @BodegasNegativos = Bodegas_Negativo
               From pv_Generales

	if exists (Select p.ReadOK, s.Codigo_Sucursal, s.Descripcion as Sucursal,
		s.Codigo_Lista, s.Codigo_Cliente, s.Codigo_Bodega, s.Prefijo, 
		getdate() as Fecha, v.Codigo_Vendedor, v.Nombre_Vendedor as Vendedor, u.UserID, @bodegasNegativos BodegasNegativos,
		u.caduca_clave, u.dias_expira, u.fecha_exprira, u.fecha_ultima_expiro
	from _Privileges p
	left join _UserGroups g 
		left join _Users u on g.UserID = u.UserID
	on p.UserGroupID = g.UserGroupID
	left join Gn_Sucursales s on s.Codigo_Sucursal = @Sucursal
	left join Gn_Vendedores v on g.UserID = v.UserID
	Where u.UserName = @Usr And u.Password = @Pass And p.ObjectName = @Objeto
	)


	Begin 
	Select p.ReadOK, s.Codigo_Sucursal, s.Descripcion as Sucursal,
		s.Codigo_Lista, s.Codigo_Cliente, s.Codigo_Bodega, s.Prefijo, 
		getdate() as Fecha, v.Codigo_Vendedor, v.Nombre_Vendedor as Vendedor, u.UserID, @bodegasNegativos BodegasNegativos,
		u.caduca_clave, u.dias_expira, u.fecha_exprira, u.fecha_ultima_expiro
	from _Privileges p
	left join _UserGroups g 
		left join _Users u on g.UserID = u.UserID
	on p.UserGroupID = g.UserGroupID
	left join Gn_Sucursales s on s.Codigo_Sucursal = @Sucursal
	left join Gn_Vendedores v on g.UserID = v.UserID
	Where u.UserName = @Usr And u.Password = @Pass And p.ObjectName = @Objeto

	end
	
	else

	begin
	Select  '0' as ReadOK
	

	end
GO

/*****procedimiento que trae todas las cotizaciones de la sucursal*****/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Cotizaciones'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Cotizaciones]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE   PRocedure [dbo].[stp_UDPV_LookUp_Cotizaciones]
	@Sucursal integer
AS

set nocount on

Declare @dias_vencimiento int
Declare @fecha_inicial datetime
Declare @fecha_final datetime

Select @dias_vencimiento = dias_vencimiento
   from pv_generales

Set @fecha_final = getdate()
Set @fecha_inicial = dateadd(dd,-1*@dias_vencimiento,@fecha_final)

--	Declare @Sucursal integer
--	Select @Sucursal =Codigo_Sucursal From pv_Generales
-- Agregado por Mario Rodriguez 29112011 "and estado_cotizacion<>3"

	Select no_cotizacion, nombre_factura as Nombre, numero_nit as Nit, 
		fecha_cotizacion as Fecha, total_Factura as Monto,
		necesita_aut Autorizacion, fecha_autorizo FAutorizo
	From pv_cotizaciones_enc
	Where Codigo_Sucursal = @Sucursal
	      and fecha_cotizacion between @fecha_inicial and @fecha_final and estado_cotizacion<>3 




GO

/*******PROCEDIMIENTO QUE BUSCA COTIZACIONES POR NOMBRE DE CLIENTE********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Cotis_FilterNomb'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Cotis_FilterNomb]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE   Procedure [dbo].[stp_UDPV_LookUp_Cotis_FilterNomb]
	@Sucursal integer,
	@Nombre varchar(60)
AS

set nocount on

Declare @dias_vencimiento int
Declare @fecha_inicial datetime
Declare @fecha_final datetime

Select @dias_vencimiento = dias_vencimiento
   from pv_generales

Set @fecha_final = getdate()
Set @fecha_inicial = dateadd(dd,-1*@dias_vencimiento,@fecha_final)

	Select no_cotizacion, nombre_factura as Nombre, numero_nit as Nit, 
		fecha_cotizacion as Fecha, total_Factura as Monto,
		necesita_aut Autorizacion, fecha_autorizo FAutorizo
	From pv_cotizaciones_enc
	Where Nombre_Factura like '%' + @Nombre + '%'
	And Codigo_Sucursal = @Sucursal
	and fecha_cotizacion between @fecha_inicial and @fecha_final

GO

/*******PROCEDIMIENTO QUE BUSCA COTIZACIONES POR NIT DE CLIENTE********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Cotis_FilterNIT'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Cotis_FilterNIT]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE    Procedure [dbo].[stp_UDPV_LookUp_Cotis_FilterNIT]
	@Sucursal integer,
	@NIT varchar(20)
AS

Set nocount on
Declare @dias_vencimiento int
Declare @fecha_inicial datetime
Declare @fecha_final datetime

Select @dias_vencimiento = dias_vencimiento
   from pv_generales

Set @fecha_final = getdate()
Set @fecha_inicial = dateadd(dd,-1*@dias_vencimiento,@fecha_final)

	Select no_cotizacion, nombre_factura as Nombre, numero_nit as Nit, 
		fecha_cotizacion as Fecha, total_Factura as Monto,
		necesita_aut Autorizacion, fecha_autorizo FAutorizo
	From pv_cotizaciones_enc
	Where numero_nit like '%' + @NIT + '%'
	And Codigo_Sucursal = @Sucursal
	and fecha_cotizacion between @fecha_inicial and @fecha_final
GO

/*******PROCEDIMIENTO QUE BUSCA CODIGO UNIDAD DE MEDIDA********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_obtenerMedida'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_obtenerMedida]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--Fecha Creacion: 17/07/2015
--Autor: Erick Chali
CREATE PROCEDURE [dbo].[stp_obtenerMedida]
@codigoP varchar(10),
@lista int

AS 
set nocount on

DECLARE @codigoC varchar(10)
select @codigoC =  isnull(dbo.replicacionCero_productos(@codigoP),@codigoP)

select * from pv_precios_productos where codigo_producto = @codigoC and codigo_lista = @lista


GO
/*******PROCEDIMIENTO QUE INGRESA EL DETALLE DEL DOCUMENTO********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_InUp_Mov_Det'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P')

DROP PROCEDURE [dbo].[stp_UDPV_InUp_Mov_Det]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE       Procedure [dbo].[stp_UDPV_InUp_Mov_Det]
	@Tipo_Doc integer,	@Serie_Doc char(2),	@No_Doc integer,	@Correlativo smallint,
	@Cod_Prod char(10),	@UMedida char(2),	@Cantidad money, 	@Precio money,
	@Por_Desc money,	@Desc money,		@Total money,		@Cod_Clie integer,
	@Promo integer,		@Bodega char(2),	@Envia smallint,	@Obs varchar(100),
	@Lista smallint,	@Pago smallint, @kit char(1), @corrKit smallint, @CodProm int,
	@serieDevProy char(2)=null, @numeroDevProy int=null, @orden_compra smallint = 0

As
set nocount on
-- V 1.2.7 Cotizaciones
-- Fecha Modifico: 01/06/2007
-- Usuario Modifico: Ocoroy
-- Para que se guarde el precio en los productos kits de las cotizaciones

-- V 1.2.5
-- Fecha Modifico: 02-03-2007
-- Usuario Modifico: Ocoroy
-- Para que maneje los return de errores

-- Fecha Modifico: 07-03-2006
-- Usuario Modifico: Ocoroy
-- Para que calcule el precio distribuido de los componentes de los kits

-- fecha Modifico: 09-03-2006
-- Usuario Modifico: Ocoroy
-- Para el trabajo de las Nc

-- Fecha Modifico: 30-09-2006
-- Usuario Modifico: Ocoroy
-- Cambio para que inserte los productos asociados del detalle
-- en facturas y consignacion

-- Detalle de PV
Declare @Sucursal integer, @Impto money, @Tipomov char(1), @EsKit char(1),
	@KProd char(10), @KCanti money, @KPrecio money, @KMedida char(2),
	@corr int, @corrdet int
	
declare @seriefact char(2), @numerofact int,
	@corrdetf smallint, @cantdetf decimal (18,6)

declare @codigo_producto_kit char(10),
	@precio_kit money,
	@por_desc_kit decimal(10,6),
	@porcentaje decimal(10,6),
	@bod_sucursal char(2),
	@necesita_aut char(1)

	Set @Sucursal = (Select Codigo_Sucursal from pv_generales)
	Set @tipomov = (Select tipo_movimiento from pv_tipos_movimiento Where codigo_movimiento = @Tipo_Doc)
	Set @EsKit = (Select Es_Kit From in_Productos Where codigo_producto = @Cod_Prod)

	select @seriefact = serie_factura, @numerofact = numero_factura from pv_ncredito_enc
	where serie = @serie_doc and
		numero = @no_doc

	-- Verifica La bodega
	If (Select count(*) from in_bodegas where codigo_bodega = @bodega) = 0
	Begin
	   Select @bodega = codigo_bodega from gn_sucursales where codigo_sucursal = @sucursal
	end

	select @bod_sucursal = codigo_bodega from gn_sucursales where codigo_sucursal = @sucursal
	if @bod_sucursal = @bodega 
	Begin
		set @necesita_aut = 'N'
	end
	else
	Begin
		set @necesita_aut = 'S'
	end
	-- El impuesto que aplica

    declare @mensaje varchar(60)

	if exists(Select * From cc_clientes where Codigo_Cliente = @Cod_Clie)
    Begin
   

		Set @Impto = (@Total - Round(@Total/(1+((Select i.tasa From gn_impuestos i, cc_clientes c
			Where i.codigo_impuesto = c.impuesto_ventas And c.codigo_cliente = @Cod_clie)/100)),2))
	End 
    Else
		Set @Impto = (@Total - Round(@Total/(1+((Select i.tasa From gn_impuestos i, cc_clientes c
			Where i.codigo_impuesto = c.impuesto_ventas And c.codigo_cliente = (Select Codigo_Cliente From gn_sucursales Where Codigo_Sucursal = @Sucursal))/100)),2))
	

   	-- Detalle de Documentos
	If @Tipomov = '1' --Coti
	Begin
	
	Begin tran
		if @kit = 'C'
		begin

		-- ObtieneCorrelativo

			Select @corr = isnull( max(correlativo),1) 
			from pv_cotizaciones_det
			where  no_cotizacion = @no_doc 
			-- Se traen los datos del producto kit para calcular los del componente
			Select 	@codigo_producto_kit  = codigo_producto,
				@precio_kit = precio,
				@por_desc_kit = por_descuento
			from pv_cotizaciones_det
			where  no_cotizacion = @no_doc and correlativo = @corr


			-- Se trae el porcentaje del componenete para calcular su precio distribuido
			Select @porcentaje = round((isnull(porcentaje,0)/isnull(cantidad,1)),6) 
			from in_productos_kit
			where codigo_producto = @codigo_producto_kit and codigo_producto_det = @cod_prod

			-- Se calcula el precio del componente del kits
			if isnull(@por_desc_kit,0) > 0 
				Set @precio = @precio_kit - ((@precio_kit * @por_desc_kit)/100)
			else
				set @precio = @precio_kit
			
			set @precio = @precio * (@porcentaje / 100)

			Select @corr = isnull( max(correlativo),1) 
			from pv_cotizaciones_det
			where codigo_sucursal = @sucursal and
				no_cotizacion = @no_doc 

			Select @corrdet = isnull( max(correlativo_kit),0) +1 
			from pv_cotizaciones_kits
			where codigo_sucursal = @sucursal and 
				no_cotizacion = @no_doc and
				correlativo = @corr

			Insert into pv_cotizaciones_Kits
			(codigo_sucursal, no_cotizacion, correlativo, codigo_producto, unidad_medida, cantidad, precio, correlativo_kit, codigo_bodega, envia)
			values (@Sucursal, @No_Doc, @Corr, @Cod_prod, @UMedida, @cantidad, @precio ,@corrdet, @bodega, @envia)
			if @@error <> 0
			Begin
				raiserror('Error al insertar los kits de la cotización',16,1,5000)
				rollback work
				select 1 error
				return 
			end

		end
		else
		begin
			Select @corr = isnull( max(correlativo),0) + 1
			from pv_cotizaciones_det
			where 	codigo_sucursal = @Sucursal and 
				no_cotizacion = @no_doc

			Insert into pv_cotizaciones_det (Codigo_Sucursal, No_Cotizacion, Correlativo, 
				Codigo_Producto, Unidad_Medida, Cantidad, Precio, Por_Descuento, Descuento, Des_Global,
				total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, Observaciones,
				kit, correlativo_kit, envia)
			Values (@Sucursal, @No_Doc, @Corr,
				@Cod_Prod, @UMedida, @Cantidad, @Precio, @Por_Desc, @Desc, 0, 
				@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Obs,
				@kit, @corrKit, @envia)
			if @@error <> 0
			Begin
				raiserror('Error al insertar el detalle de la cotización',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end
		

	  commit tran
	End
	If @Tipomov = '2' --Fact
	Begin
	  Begin tran
		if @kit = 'C'
		begin


			Select @corr = isnull( max(correlativo),1) 
                  		from pv_facturas_det
                  		where serie = @Serie_doc and 
				numero = @no_doc 
			-- Se traen los datos del producto kit para calcular los del componente
			Select 	@codigo_producto_kit  = codigo_producto,
				@precio_kit = precio,
				@por_desc_kit = por_descuento
			from pv_facturas_det
			where serie = @serie_doc and numero = @no_doc and correlativo = @corr
			
			-- Se trae el porcentaje del componenete para calcular su precio distribuido
			Select @porcentaje = round((isnull(porcentaje,0)/isnull(cantidad,1)),6) 
			from in_productos_kit
			where codigo_producto = @codigo_producto_kit and codigo_producto_det = @cod_prod

			-- Se calcula el precio del componente del kits
			if @por_desc_kit > 0 
				Set @precio = @precio_kit - ((@precio_kit * @por_desc_kit)/100)
			else
				set @precio = @precio_kit

			set @precio = @precio * (@porcentaje / 100)

			Select @corrdet = isnull( max(correlativo_kit),0) +1 
			from pv_facturas_kits
			where 	serie = @Serie_doc and 
				numero = @no_doc and
				correlativo = @corr

			Insert into pv_facturas_Kits(serie, numero, correlativo, 
					codigo_producto, unidad_medida, cantidad, precio, correlativo_kit, codigo_bodega, envia)
			values (@Serie_Doc, @No_Doc, @Corr, 
					@Cod_prod, @UMedida, @cantidad, @Precio, @corrdet, @bodega, @envia)
			if @@error <> 0
			Begin
				raiserror('Error al insertar los kits de la factura',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end
		else
		begin
			Select @corr = isnull( max(correlativo),0) + 1
          		from pv_facturas_det
          		where serie = @Serie_doc and 
			numero = @no_doc

			Insert into pv_facturas_det (Serie, Numero, Correlativo, 
				Codigo_Producto, Unidad_Medida, Cantidad, Precio, Por_Descuento, Descuento, Des_Global,
				Total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, envia, Observaciones,
				kit, correlativo_kit, solicitud_orden)
			Values (@Serie_Doc, @No_Doc, @Corr, 
				@Cod_Prod, @UMedida, @Cantidad, @Precio, @Por_Desc, @Desc, 0, 
				@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Envia, @Obs,
				@kit, @corrKit, @orden_compra)
			if @@error <> 0
			Begin
				raiserror('Error al insertar los detalles de la factura',16,1,5000)
				rollback work
				select 1 error
				return 
			end

			-- Inserta los productos asociados
			insert into pv_facturas_asociados 
			(Serie,Numero,Correlativo,codigo_producto,codigo_asociado,cantidad)
			Select @Serie_Doc,@No_Doc,@Corr,@Cod_prod,b.producto_permitido,@cantidad * isnull(b.cantidad,1)
			from in_producto_asociado b
			where codigo_producto = @Cod_prod
			if @@error <> 0
			Begin
				raiserror('Error al insertar los asociados de la factura',16,1,5000)
				rollback work
				select 1 error
				return 
			end
			
			
			--solicitud de orden de compra
			if @orden_compra = -1 
			begin
				insert into pv_facturas_ordenes
				(serie, numero, correlativo)
				values
				(@serie_doc, @no_doc, @corr)
				if @@error <> 0
				Begin
					raiserror('Error al insertar las ordenes',16,1,5000)
					rollback work
					select 1 error
					return 
				end
			end

		end

	   commit tran
	End
	If @Tipomov = '3' --NC
	Begin
	   Begin tran
		if (@kit = 'C') 
		begin
			Select @corr = isnull( max(correlativo),1) 
          		from pv_ncredito_det
          		where serie = @Serie_doc and 
			numero = @no_doc 

			Select @corrdet = isnull( max(correlativo_kit),0) +1 
          		from pv_ncredito_kits
          		where serie = @Serie_doc and 
			numero = @no_doc and
			correlativo = @corr

			Insert into pv_ncredito_Kits(serie, numero, correlativo, 
						codigo_producto, unidad_medida, cantidad, precio, correlativo_kit, codigo_bodega, envia,necesita_aut)
			values (@Serie_Doc, @No_Doc, @Corr, 
				@Cod_Prod, @UMedida, @cantidad, @Precio, @corrdet, @bodega, @envia,@necesita_aut)
			if @@error<>0
			Begin
				raiserror('No se puedo ingresar los productos kits de la nota de crédito',16,1,5000)
				rollback work
				select 1 error
				return 
			end


			update pv_facturas_kits
			set devolucion = isnull(devolucion,0) + @cantidad
			where  serie = @seriefact and
				numero = @numerofact and
				codigo_producto = @Cod_prod
			if @@error<>0
			Begin	
				raiserror('No se pudo actualizar la cantidad devolucion de los componentes kits',16,1,5000)
				rollback work
				select 1 error
				return 
			end

		end
		else
		begin
			Select @corr = isnull( max(correlativo),0) + 1
          		from pv_ncredito_det
          		where serie = @Serie_doc and numero = @no_doc
			if isnull(@seriedevProy,'')=''  and isnull(@numerodevProy,0)=0
			begin
				Insert into pv_ncredito_det (Serie, Numero, Correlativo, 
					Codigo_Producto, Unidad_Medida, Precio, Por_Descuento, Descuento, 
					Total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, envia, Observaciones, cantidad,
					kit, correlativo_kit,necesita_aut)
				Values (@Serie_Doc, @No_Doc, @Correlativo, 
					@Cod_Prod, @UMedida, @Precio, @Por_Desc, @Desc,
					@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Envia, @Obs, @cantidad,
					@kit, @corrkit,@necesita_aut)
				if @@error<>0
				Begin
					raiserror('No se pudo insertar el detalle de las notas de credito',16,1,5000)
					rollback work
					select 1 error
					return 
				end
				
				if @corrkit > 0 and @kit = 'N'
				Begin
					update pv_facturas_kits
					set devolucion = isnull(devolucion,0) + @cantidad
					where  serie = @seriefact and
						numero = @numerofact and
						codigo_producto = @Cod_prod and
						correlativo = @corrkit
					if @@error<>0
					Begin	
						raiserror('No se pudo actualizar la cantidad devolucion de los componentes kits',16,1,5000)
						rollback work
						select 1 error
						return 
					end

					update pv_facturas_det
					set devolucion = isnull(devolucion,0) + @cantidad
					where serie = @seriefact and
						numero = @numerofact and
						correlativo = @corrkit
					if @@error<>0
					Begin
						raiserror('No se puedo actualizar la cantidad devolucion de los kits',16,5000)
						rollback work
						select 1 error
						return 
					end

				end
				else
				Begin
					-- se trae el correlativo que debe afectar segun las opciones
					-- 1 cuando la cantidad devolver es igual a la facturada
					-- 2 cuando la cantidad es menor o igual a la facturada
					-- 3 cuando la cantidad es la suma de 2 lineas
					-- OPCION 1
					Select @corrdetf= correlativo
					from pv_facturas_det 
					where serie = @seriefact and numero = @numerofact and
					codigo_producto = @cod_prod and (cantidad=@cantidad)
					order by correlativo desc
					if ((@corrdetf is null) or (@corrdetf = 0))
					Begin
						-- OPCION 2
						Select @corrdetf= correlativo
						from pv_facturas_det 
						where serie = @seriefact and numero = @numerofact and
						codigo_producto = @cod_prod and (cantidad<=@cantidad)
						order by correlativo desc
					end
					if (@corrdetf>0)
					Begin
						update pv_facturas_det 
						set devolucion = isnull(devolucion,0) + @cantidad
						where serie = @seriefact and
						numero = @numerofact and
						codigo_producto = @cod_prod and correlativo = @corrdetf
					end
					else
					Begin
						-- OPCION 3
						update pv_facturas_det 
						set devolucion = isnull(devolucion,0) + @cantidad
						where serie = @seriefact and
						numero = @numerofact and
						codigo_producto = @cod_prod
					end
					if @@error<>0
					Begin
						raiserror('No se pudo actualizar la cantidad devolucion de los productos',16,1,5000)
						rollback work
						select 1 error
						return 
					end

					if exists(Select 1 from pv_facturas_asociados where serie = @seriefact and numero = @numerofact and codigo_asociado = @cod_prod)
					Begin
						declare @corr_asoc smallint
						Select @corr_asoc = correlativo
						from pv_facturas_asociados
						where 	serie = @seriefact and 
							numero = @numerofact and
							codigo_asociado = @cod_prod
							and (cantidad - isnull(devolucion,0))>0
						order by correlativo desc

						update pv_facturas_asociados
						set devolucion = isnull(devolucion,0) + @cantidad
						where 	serie = @seriefact and
							numero = @numerofact and
							codigo_asociado = @cod_prod and
							correlativo = @corr_asoc
						if @@error<>0
						Begin
							raiserror('Error al actualizar el producto asociado',16,1,5000)
							rollback work
							select 1 error
							return 
						end
					end
				end

			end
			else
			begin
				Insert into pv_ncredito_det (Serie, Numero, Correlativo, 
					Codigo_Producto, Unidad_Medida, Precio, Por_Descuento, Descuento, 
					Total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, envia,  cantidad,
					kit, correlativo_kit, Observaciones,necesita_aut)
				Values (@Serie_Doc, @No_Doc, @Correlativo, 

					@Cod_Prod, @UMedida, @Precio, @Por_Desc, @Desc,
					@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Envia,  @cantidad,
					@kit, @corrkit, 'Devolucion de Proyectos Factura: '+ @seriedevProy + ' ' + convert(varchar(8),@numeroDevProy),@necesita_aut )
				if @@error<>0
				Begin	
					raiserror('No se pudo insertar los detalles de la nota de credito',16,1,5000)
					rollback work
					select 1 error
					return 
				end

				update pv_facturas_det 
					set devolucion = isnull(devolucion,0) + @cantidad
				where serie = @seriedevproy and
					numero = @numerodevproy and
					codigo_producto = @cod_prod
				if @@error<>0
				Begin
					raiserror('No se pudo actualizar la cantidad de devolución',16,1,5000)
					rollback work
					select 1 error
					return 
				end

			end

		end

	  commit tran
	End
	If @Tipomov = '4' --ND
	Begin
	   Begin tran
		if @kit = 'C'
		begin
			Select @corr = isnull( max(correlativo),1) 
          		from pv_ndebito_det
          		where serie = @Serie_doc and 
			numero = @no_doc 

			Select @corrdet = isnull( max(correlativo_kit),0) +1 
          		from pv_ndebito_kits
          		where serie = @Serie_doc and 
			numero = @no_doc and
			correlativo = @corr

			Insert into pv_ndebito_Kits(serie, numero, correlativo, 
							codigo_producto, unidad_medida, cantidad, precio, correlativo_kit, codigo_bodega, envia)
			values (@Serie_Doc, @No_Doc, @Corr, 
				@Cod_Prod, @UMedida, @cantidad, @Precio,@corrdet, @bodega, @envia)
			if @@error<>0
			Begin
				raiserror('No se pude insertar los kits de las notas de debito',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end
		else
		begin	
			Select @corr = isnull( max(correlativo),0) + 1
          		from pv_ndebito_det
          		where serie = @Serie_doc and 
			numero = @no_doc

			Insert into pv_ndebito_det (Serie, Numero, Correlativo, 
				Codigo_Producto, Unidad_Medida, Precio, Por_Descuento, Descuento, 
				Total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, envia, Observaciones, cantidad,
				kit, correlativo_kit)
			Values (@Serie_Doc, @No_Doc, @Correlativo, 
				@Cod_Prod, @UMedida, @Precio, @Por_Desc, @Desc,
				@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Envia, @Obs, @cantidad,
				@kit, @corrKit)
			if @@error <>0 
			Begin
				raiserror('No se puedo insertar los detalles de las notas de debito',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end

	  commit tran
	End

	-- Detalle de Documentos
	If @Tipomov = '5' --Solicitudes de Muestra
	Begin
	    Begin tran
		if @kit = 'C'
		begin
			-- ObtieneCorrelativo
			Select @corr = isnull( max(correlativo),1) 
    			from pv_muestras_det
	          	where codigo_sucursal = @sucursal and
			no_muestra = @no_doc 

			Select @corrdet = isnull( max(correlativo_kit),0) +1 
	      			from pv_muestras_kits
  			where codigo_sucursal = @sucursal and 
			no_muestra = @no_doc and
			correlativo = @corr

			Insert into pv_muestras_Kits(codigo_sucursal, no_muestra, correlativo, 
						codigo_producto, unidad_medida, cantidad, precio, correlativo_kit, codigo_bodega, envia)
			values (@Sucursal, @No_Doc, @Corr, 
					@Cod_prod, @UMedida, @cantidad, @precio ,@corrdet, @bodega, @envia)
			if @@error<>0 
			Begin
				raiserror('No se puedo insertar los kits de las muestras',16,1,5000)
				rollback work
				select 1 error
				return 

			end
		end
		else
		begin
			Select @corr = isnull( max(correlativo),0) + 1
			from pv_muestras_det
			where codigo_sucursal = @Sucursal and 
				no_muestra = @no_doc

			Insert into pv_muestras_det (Codigo_Sucursal, No_muestra, Correlativo, 
				Codigo_Producto, Unidad_Medida, Cantidad, Precio, Por_Descuento, Descuento, Des_Global,
				total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, Observaciones,
				kit, correlativo_kit)
			Values (@Sucursal, @No_Doc, @Corr,
				@Cod_Prod, @UMedida, @Cantidad, @Precio, @Por_Desc, @Desc, 0, 
				@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Obs,
				@kit, @corrKit)
			if @@error<>0
			Begin
				raiserror('No se pudo insertar los detalles de las muestras',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end
		

	  commit tran
	End

	If @Tipomov = '6' --Devoluciones de Proyectos
	Begin
	    Begin tran
		if @kit = 'C'
		begin
			-- ObtieneCorrelativo
			Select @corr = isnull( max(correlativo),1) 
   			from pv_devolucion_det
	                  	where codigo_sucursal = @sucursal and
				no_devolucion = @no_doc 
	
			Select @corrdet = isnull( max(correlativo_kit),0) +1 
      			from pv_devolucion_kits
  			where codigo_sucursal = @sucursal and 
			no_devolucion = @no_doc and
			correlativo = @corr
	
			Insert into pv_devolucion_Kits(codigo_sucursal, no_devolucion, correlativo, 
						codigo_producto, unidad_medida, cantidad, precio, correlativo_kit, codigo_bodega, envia)
			values (@Sucursal, @No_Doc, @Corr, 
					@Cod_prod, @UMedida, @cantidad, @precio ,@corrdet, @bodega, @envia)
			if @@error<>0
			Begin
				raiserror('No se pudo insertar los kits de la devolucion',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end
		else
		begin
			Select @corr = isnull( max(correlativo),0) + 1
			from pv_devolucion_det
			where codigo_sucursal = @Sucursal and no_devolucion = @no_doc

			Insert into pv_devolucion_det (Codigo_Sucursal, No_devolucion, Correlativo, 
				Codigo_Producto, Unidad_Medida, Cantidad, Precio, Por_Descuento, Descuento, Des_Global,
				total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, Observaciones,
				kit, correlativo_kit, serie, numero_factura)
			Values (@Sucursal, @No_Doc, @Corr,
				@Cod_Prod, @UMedida, @Cantidad, @Precio, @Por_Desc, @Desc, 0, 
				@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Obs,
				@kit, @corrKit, @serieDevProy, @numerodevProy)
			if @@error<>0
			Begin
				raiserror('No se puedo insertar los detalles de la devolucion',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end

	  commit tran
	End


	If @Tipomov = '7' --Mercaderia en Consignacion
	Begin
	   Begin tran
		if @kit = 'C'
		begin
			-- ObtieneCorrelativo	
			Select @corr = isnull( max(correlativo),1) 
  			from pv_consigna_det
	                  	where codigo_sucursal = @sucursal and
			no_consignacion = @no_doc 
	
			Select @corrdet = isnull( max(correlativo_kit),0) +1 
      			from pv_consigna_kits
  			where codigo_sucursal = @sucursal and 
			no_consignacion = @no_doc and
			correlativo = @corr

			Insert into pv_consigna_Kits(codigo_sucursal, no_consignacion, correlativo, 
						codigo_producto, unidad_medida, cantidad, precio, correlativo_kit, codigo_bodega, envia)
			values (@Sucursal, @No_Doc, @Corr, 
					@Cod_prod, @UMedida, @cantidad, @precio ,@corrdet, @bodega, @envia)
			if @@error<>0
			Begin
				raiserror('No se pudo insertar los kits de la mercaderia en consignación',16,1,5000)
				rollback work
				select 1 error
				return 
			end
		end
		else
		begin
			Select @corr = isnull( max(correlativo),0) + 1
			from pv_consigna_det
			where 	codigo_sucursal = @Sucursal and 
				no_consignacion = @no_doc

			Insert into pv_consigna_det (Codigo_Sucursal, No_consignacion, Correlativo, 
				Codigo_Producto, Unidad_Medida, Cantidad, Precio, Por_Descuento, Descuento, Des_Global,
				total_Linea, impuesto_ventas, costo_ventas, codigo_promocion, codigo_bodega, Observaciones,
				kit, correlativo_kit)
			Values (@Sucursal, @No_Doc, @Corr,
				@Cod_Prod, @UMedida, @Cantidad, @Precio, @Por_Desc, @Desc, 0, 
				@Total, @Impto, (@Total - @Impto), @codProm, @Bodega, @Obs,
				@kit, @corrKit)
			if @@error<>0
			Begin
				raiserror('No se pudo insertar la mercaderia en consignación',16,1,5000)
				rollback work
				select 1 error
				return 
			end

			insert into pv_consigna_asociado 

			(codigo_sucursal,no_consignacion,Correlativo,codigo_producto,codigo_asociado,cantidad)
			Select @sucursal,@No_Doc,@Corr,@Cod_prod,b.producto_permitido,@cantidad * isnull(b.cantidad,1)
			from in_producto_asociado b
			where codigo_producto = @Cod_prod
			if @@error <> 0
			Begin
				raiserror('Error al insertar los asociados de la consignacion',16,1,5000)
				rollback work
				select 1 error
				return 
			end
			

		end
		
	   commit tran
	End

select 0 error

GO

/*******PROCEDIMIENTO QUE INGRESA EL ENCABEZADO DEL DOCUMENTO********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_InUp_Mov_Enc'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_InUp_Mov_Enc]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  Procedure [dbo].[stp_UDPV_InUp_Mov_Enc]
	@Cod_Clie integer,	@Nit varchar(20),	@Nom_Clie varchar(200),
	@Dir_Fact varchar(200),	@Tel varchar(20),	@Tarj varchar(20),
	@Dir_Env varchar(200),	@cod_vendedor integer,	@User varchar(35),
	@tipodoc integer,	@No_doc integer = Null,	@Fecha_Vence datetime,
	@tipo_pago integer,	@tipo_cred integer,	@autoriza char(1),
	@fecha_doc datetime,	@cargos_envio money,	@otros_cargos money,	
	@monto_venta money,	@monto_total money,
	@Serie_Dev char(5) = Null,	@No_Doc_Dev integer = Null, @Observaciones varchar(100) = Null,
	@Tipo_Nota smallint,	@Caja char(3), @fecha_entrega datetime,
	@codDept smallint = null, @codGen smallint = null, @no_consigna int = null,
	@CodMovDev smallint, @Genera_Solicitud char(1), @TipoPagoNC smallint,
	@tipo_cliente smallint,@codigo_negocio char(5), @cantidad_devolver money,
	@autorizo_despacho varchar(50), @saldo money
As
Set NOCOUNT On

-- 1.4
-- Fecha Modifico: 18-07-2014
-- Usuario Mario Rodriguez
-- segmento de linea 338, que permita que Melvin pueda facturar cotizaciones antes facturadas


-- 1.4
-- Fecha Modifico: 29-04-2014
-- Usuario Mario Rodriguez
-- Se agregaron las validaciones para no permitir facturar cotizaciones sin autorizacion


-- 1.4
-- Fecha Modifico: 11-11-2011
-- Usuario Rsao
-- Validacion de NIT, no deja grabar si el nit es invalido

-- 1.3
-- Fecha Modifico: 07-05-2008
-- Usuario Ocoroy
-- las nc en los abonos no estaban asignando el codigo_sucursal

-- 1.2.9
-- Fecha Modifico: 29-07-2007
-- Usuario Modifico: Ocoroy
-- Cambio: Se agrego el tipo_cliente y el codigo_negocio

-- 1.2.7
-- Fecha Modifico: 25-04-2007
-- Usuario Modifico: Ocoroy
-- la autorizacion para las NC, tambien para la generacion de la solicitud de cheque

-- 1.2.6
-- Fecha Modifico: 10-04-2007
-- Usuario Modifico: Ocoroy
-- Cambio para que maneje el activa_credito, para las formas de pago 

-- 1.2.5
-- Fecha modifico: 01-02-2006
-- Usuario Modifico: Ocoroy

-- Fecha Modifico: 22/03/2005
-- Usuario Modifico: Ocoroy

-- Fecha Modifico: 03/05/2006
-- Usuario Modifico: Ocoroy

-- Fecha Modifico: 01-10-2006
-- Usuario Modifico: Ocoroy

-- Fecha Modifico: 11-12-2006
-- Usuario Modifico: Ocoroy


/*0*/ 
Declare @Serie char(2), 
	@Correlat integer, 
	@Impto money, 
	@Sucursal integer, 
	@Tipomov char(1)

Declare @Cartera char(3), @Moneda smallint, @Mov char(2),
	@codigo_cobrador smallint,
	@TipoAbono char(2),
	@activa_credito char(1),
	@nombre_cliente varchar(60),
	@nit_cliente varchar(20),
	@no_solicitud int,
	@nombre_vendedor varchar(100),
	@codigo_centro varchar(20),
	@monto_aplicacxc money

Set @Sucursal = (	Select codigo_sucursal 
			from pv_generales)

Set @tipomov = (	Select tipo_movimiento 
			from pv_tipos_movimiento 
			Where codigo_movimiento = @tipodoc)

-- Se trae si el tipo de pago activa credito
Select @activa_credito = isnull(activa_credito,'N')
from pv_tipos_pago
where codigo_pago = @tipo_pago

Select @nombre_vendedor = nombre_vendedor
from gn_vendedores
where codigo_vendedor = @cod_vendedor

Set @Moneda = (Select Codigo_Moneda from gn_generales)

--Verifica que el NIT sea Valido
set @nit=Upper(@nit)
Declare @resNit varchar(20) 
select @resNit = rtrim(dbo.fn_nitvalido(@nit))

If  @resNit = 'NIT Invalido'
   begin
		raiserror('NO SE PUEDE GRABAR LA FACTURA, NIT DEL CLIENTE ES INVALIDO, VERIFIQUE',16,1,5000);
		return
   end

-- para solicitudes de muestras comenzar aca
Begin tran		
	--Correlativo
	update pv_cajascorrelat
	set correlativo = correlativo
	where 	codigo_sucursal = @Sucursal 
		and codigo_caja = @caja 
		and codigo_movimiento = @tipodoc
	if @@error<>0
	begin
		raiserror('Otro usuario esta ulizan esta opción, intentelo nuevamente ',16,1,5000);
		rollback work
		return
	end

	If ((@tipomov = '1') And (Isnull(@No_doc, 0) = 0)) Or (@tipomov in('2', '3', '4','5','6','7'))
		Set @Correlat = dbo.fn_PV_CorrelativoDoc(@Sucursal, @Caja, @tipodoc)
	Else
		Set @Correlat = @No_doc

	If @Correlat < 1
	Begin
		Raiserror('No Existe Correlativo asignado para este documento o el rango permitido ha sido sobrepasado- stp_UDPV_InUp_Mov_Enc', 16, 1, 5000)
		rollback work
        Return		
	End

	-- Actualizacion de Correlativos
	--si no es cotizacion
	if @tipomov <> '1' 
	Begin
		Update pv_cajascorrelat
		Set correlativo = correlativo + 1
		Where codigo_Sucursal = @Sucursal And Codigo_Caja = @Caja and codigo_movimiento = @tipodoc
		If @@error > 0
		Begin
			Raiserror('No se pudo actualizar Correlativos de Punto de Venta - stp_UDPV_InUp_Mov', 16, 1, 5000)
			rollback work
			Return
		End
	end

	If @tipomov in ('2', '3', '4')
		Set @Serie = (	Select Serie 
				from pv_cajascorrelat 
				Where 	Codigo_Sucursal = @Sucursal 
					And Codigo_Caja = @Caja 
					And Codigo_Movimiento = @tipodoc)

/*1*/

	--Actualizar Cliente
	If (Select count(*) From pv_clientes_frecuentes Where numero_nit = @Nit) = 0
	Begin
		Insert Into pv_clientes_frecuentes 
		(numero_nit, nombre_Factura, direccion_facturar, direccion_envio,
		notarjeta, telefono, fecha_creacion, codigo_cliente)
		Values 
		(@Nit, @Nom_Clie, @Dir_Fact, @Dir_Env, @Tarj, @Tel, getdate(), @Cod_Clie)
		if @@error<>0
		Begin
			raiserror('No se pudo insertar el cliente a pv_clientes_frecuentes',16,1,5000)
			rollback work
			return
		end
		
	End
	Else
	Begin
		Update pv_clientes_frecuentes
		Set 	nombre_factura = @Nom_Clie,
			direccion_facturar = @Dir_Fact,
			direccion_envio = @DIr_Env,
			notarjeta = @Tarj,
			telefono = @Tel
		Where numero_nit = @Nit
		if @@error<>0
		Begin
			raiserror('No se pudo actualizar el cliente en pv_clientes_frecuentes',16,1,5000)
			rollback work
			return
		end
	End
	if exists(Select * From cc_clientes where nit = @Nit)
	Begin
		Set @Impto = (@monto_total - Round((@monto_total/(1+((Select i.tasa From gn_impuestos i, cc_clientes c
		Where i.codigo_impuesto = c.impuesto_ventas And c.codigo_cliente = @Cod_clie)/100))),2))

	end
	Else
	Begin
		Set @Impto = (@monto_total - Round((@monto_total/(1+((Select i.tasa From gn_impuestos i, cc_clientes c
			Where i.codigo_impuesto = c.impuesto_ventas And c.codigo_cliente = (Select Codigo_Cliente From gn_sucursales Where Codigo_Sucursal = @Sucursal))/100))),2))

	end

	
/*2*/
	--Segun Tipo de Documento Grabar Movimiento
	If @tipomov = '1' --Coti
	Begin	
		If (Isnull(@No_doc, 0) <> 0) And Exists(Select no_cotizacion from pv_cotizaciones_enc Where no_cotizacion = @No_Doc)
		Begin
			Update pv_cotizaciones_enc
			Set codigo_pago = @tipo_pago,		codigo_vendedor = @cod_vendedor,
			tipo_credito = @tipo_cred,		direccion_factura = @Dir_Fact,
			total_ventas = @monto_total-@impto,	necesita_aut = @autoriza,
			total_impuesto = @Impto,		total_factura = @monto_total,
			cargos_envios = @cargos_envio,		otros_cargos = @otros_cargos,
			fecha_emision = getdate(),		usuario_emision = @User,
			Observaciones = @Observaciones,		monto_Des_Global = 0,
			direccion_envio = @DIr_Env,		notarjeta = @Tarj,
			nombre_factura = @nom_clie,
			tipo_cliente = @tipo_cliente,
			codigo_negocio = @codigo_negocio
			,FECHA_ULTIMA_ACT=getdate() --Agregado por Mario Rodriguez 28112011
			Where codigo_Sucursal = @Sucursal And no_cotizacion = @Correlat and codigo_movimiento=@tipodoc
			if @@error<>0
			Begin
				raiserror('No se pudo actualizar la cotización',16,1,5000)
				rollback work
				return
			end

		End
		Else
		Begin
			Insert Into pv_cotizaciones_enc (codigo_sucursal,
			no_cotizacion,		codigo_pago,
			codigo_vendedor,	tipo_credito,	fecha_cotizacion,
			fecha_vencimiento,	numero_nit,	nombre_factura,
			direccion_factura,	codigo_Cliente,
			total_ventas,		total_impuesto,
			cargos_envios,		otros_cargos,	total_factura,
			estado_cotizacion,	fecha_emision,	usuario_emision,
			necesita_aut,		Observaciones,	monto_Des_Global, codigo_movimiento,
			direccion_envio,	notarjeta,tipo_cliente,codigo_negocio, FECHA_ULTIMA_ACT) --Agregado por Mario Rodriguez 28112011

			values (@Sucursal, @Correlat, 

				@tipo_pago, @Cod_vendedor, @tipo_cred, @fecha_doc, @fecha_vence, @nit, @Nom_clie,
				@Dir_fact, @Cod_Clie, @monto_total-@Impto, @Impto,
				@cargos_envio, @otros_cargos, @monto_total, 1, getdate(), @User, @autoriza, @Observaciones, 0, @tipodoc,
				@dir_env,@tarj,@tipo_cliente,@codigo_negocio,getdate())
			if @@error<>0
			Begin
				raiserror('No se pudo inserta la cotización',16,1,5000)
				rollback work
				return
			end
			-- se actualiza el correlativo
			Update pv_cajascorrelat
			Set correlativo = correlativo + 1
			Where codigo_Sucursal = @Sucursal And Codigo_Caja = @Caja and codigo_movimiento = @tipodoc
			If @@error > 0
			Begin
				Raiserror('No se pudo actualizar Correlativos de Punto de Venta - stp_UDPV_InUp_Mov', 16, 1, 5000)
				rollback work
				Return
			End


		End
	End
	
	
	If @tipomov = '2' --Fact
	Begin	
		Insert Into pv_facturas_enc (serie, numero, codigo_sucursal,
		codigo_pago,
		codigo_vendedor,	tipo_credito,	fecha_factura,
		fecha_pago,		numero_nit,	nombre_factura,
		direccion_facturar,	codigo_Cliente,
		total_ventas,		total_impuesto,
		cargos_envios,		otros_cargos,	total_factura,
		Serie_Factura_Dev, 	Numero_Factura_Dev, 
		estado_factura,		fecha_emision,	usuario_emision,
		monto_Des_global,pagado, codigo_movimiento,
	 	direccion_envio,	notarjeta, no_consignacion, observaciones,fecha_est_entrega, no_cotizacion,
		tipo_cliente,codigo_negocio,telefono)
		values (@Serie, @Correlat, @Sucursal,
			@tipo_pago, @Cod_vendedor,  @tipo_cred, @fecha_doc, @fecha_vence, @nit, @Nom_clie,
			@Dir_fact, @Cod_Clie, @monto_total-@Impto, @Impto,
			@cargos_envio, @otros_cargos, @monto_total, 
			@Serie_Dev, @No_Doc_Dev, 'I', getdate(), @User,
			0,0,@tipodoc,
			@dir_env,@tarj,@no_consigna, @observaciones,@fecha_entrega,@No_doc,
			@tipo_cliente,@codigo_negocio,@Tel)
		if @@error<>0 
		Begin
			raiserror('No se pudo insertar la factura',16,1,5000)
			rollback work
			return
		end

        if @tipo_cred = 1
		Begin
			insert into cj_facturasCredito
			(serie, numero, codigo_caja, codigo_sucursal)
			values
			(@serie, @correlat,@caja,@sucursal)
			if @@error<>0
			Begin
				raiserror('No se pudo inserta los datos de la factura credito',16,1,5000)
				rollback work
				return

			end
		end
        
        --Veficacion de la Cotizacion 29042014
		Declare @v_necesitaaut char(1)
		Declare @v_estadocotizacion char(1)
		Declare @v_usuarioidautorizo varchar(30)
		select 
			@v_necesitaaut=necesita_aut,@v_estadocotizacion=estado_cotizacion,@v_usuarioidautorizo=usuarioid_autorizo
		from 
			pv_cotizaciones_enc
		where
			codigo_sucursal=@sucursal and no_cotizacion = @no_doc
			
		if (@v_necesitaaut='S' and @v_estadocotizacion='3' and @cod_vendedor<>145)
			Begin
				raiserror('No se puede generar el documento, Cotizacion Cerrada',16,1,5000)
				rollback work
				return
		end
		
		if (@v_necesitaaut='S' and @v_estadocotizacion<>'3' and @v_usuarioidautorizo is null and @cod_vendedor<>145)
			Begin
				raiserror('No se puede generar el documento, Cotizacion Pendiente de autorizar, Verifique!!!',16,1,5000)
				rollback work
				return
		end

        --Agregado por Mario Rodriguez 28112011
    	if @no_doc>0
        Begin
			update pv_cotizaciones_enc
				set FECHA_ULTIMA_ACT=getdate(), estado_cotizacion=3
            where codigo_sucursal=@sucursal and no_cotizacion = @no_doc
        End
        
		-- Aqui termila Agregado
	End


	If @tipomov = '3' --NC
	Begin	
		Insert Into pv_ncredito_enc 
		(serie, numero, codigo_sucursal,
		codigo_vendedor,	fecha_nota,	concepto,
		fecha_pago,		numero_nit,	nombre,
		direccion,		codigo_Cliente,
		total_ventas,		total_impuesto,	total_nota,
		Serie_Factura, 		Numero_Factura, 
		estado_nota,		fecha_emision,	usuario_emision, 
	          codigo_motivo,		codigo_movimiento, tipo_credito,codigo_pago,
		direccion_envio,	notarjeta,necesita_autorizacion,
		tipo_devolucion_monto,tipo_cliente,codigo_negocio,monto_devolver,autorizo_despacho)
		values (@Serie, @Correlat, @Sucursal,
			@Cod_vendedor,  @fecha_doc, @Observaciones, 
			@fecha_vence, @nit, @Nom_clie,
			@Dir_fact, @Cod_Clie, 
			@monto_total-@Impto, @Impto,@monto_total, 
			@Serie_Dev, @No_Doc_Dev, 
			1, getdate(), @User, 
			@Tipo_Nota, @tipodoc, @tipo_cred,@tipo_pago,
			@dir_env,@tarj,@autoriza,
		@TipoPagoNC,@tipo_cliente,@codigo_negocio,@cantidad_devolver,@autorizo_despacho)
		if @@error<> 0 
		Begin
			raiserror('No se pudo insertar la nota de credito',16,1,5000)
			rollback work
			return
		end

		Insert into cj_notasCredito 
		(serie, numero,codigo_caja,codigo_sucursal)
		values
		(@serie,@correlat,@caja,@sucursal)
		if @@error<>0
		Begin
			raiserror('No se pudo insertar los datos de la nota a caja',16,1,5000)
			rollback work
			return
		end
		-- (1) Si la nc > saldo se permite cualquier tipo de devolucion quedando asi
		--		- Tipo Pago 1 es Aplicada en el dia por lo tanto se toma el monto total
		--		- Tipo Pago >1 es Sol. Cheque, Efectivo Vta,Efectivo Caja Chica se cancela es saldo y solo se paga el restante
		
		If (@tipomov = '3' and @tipo_cred = 1)
		Begin
			if (@monto_total >= @saldo)
			Begin
				if (@TipoPagoNC=1)
					set @monto_aplicacxc = @monto_total
				if (@TipoPagoNC>1)
				Begin
					if (@monto_total=@cantidad_devolver)
					Begin
						set @cantidad_devolver = @saldo - @cantidad_devolver
						set @monto_aplicacxc = @saldo
					end
					if (@monto_total<@cantidad_devolver) and (@cantidad_devolver>@saldo)
					Begin
						set @cantidad_devolver = @saldo - @cantidad_devolver
						set @monto_aplicacxc = @saldo
					end					
				end
			end
			if (@monto_total < @saldo)	
			Begin
				if (@TipoPagoNC=1)
				Begin
					set @monto_aplicacxc = @monto_total
					set @Genera_Solicitud= 'N'
				end
				if (@TipoPagoNC>1)
				Begin
					set @TipoPagoNC = 1
					set @monto_aplicacxc = @monto_total
					set @Genera_Solicitud= 'N'
				end
			end
			if (@TipoPagoNC = 5)
			Begin
				set @monto_aplicacxc = @monto_total
				set @Genera_Solicitud= 'N'
			end
		end

		if @Genera_Solicitud = 'S' 
		Begin
			update bn_generales
			set no_solicitud = isnull(no_solicitud,0) + 1
			if @@error<> 0
			Begin
				raiserror('Error al actualizar el No. Solicitud',16,1,5000)
				rollback work
				return
			end
			
			Select @no_solicitud = no_solicitud
			from bn_generales
			
			Select @codigo_centro = codigo_centro
			from gn_sucursales
			where codigo_sucursal = @sucursal

			if @codigo_centro is null
			Begin
				raiserror('Es necesario que asigne un centro a la sucursal',16,1,5000)
				rollback work
				return			
			end

			insert into bn_solicitud_cheque
			(no_solicitud,nombre_beneficiario,codigo_cliente,codigo_empleado,observaciones,
			fecha_solicitud,codigo_moneda,monto_solicitud,serie,numero,estado,id_cuenta,
			codigo_tipo,numero_cheque,centro_solicitante,modulo_origen)
			values
			(@no_solicitud,@nom_clie,@cod_clie,null,
			'Devolucion de Nota de Credito '+@serie+' '+str(@correlat)+' '+@nombre_vendedor+' '+str(@sucursal),
			getdate(),@Moneda,@cantidad_devolver,@serie,@correlat,'1',null,null,null,@codigo_centro,'PV' )

			if @@error<>0
			begin
				raiserror('Error al insertar la solicitud del cheque',16,1,5000)
				rollback work	
				return
			end
			
		end

	End

	If @tipomov = '4' --ND
	Begin	
		Insert Into pv_ndebito_enc (serie, numero, codigo_sucursal,
		codigo_pago,		tipo_credito,	fecha_factura,
		fecha_pago,		numero_nit,	nombre,
		direccion,		codigo_Cliente, concepto,
		total_cargo,		total_impuesto,
		cargos_envios,		otros_cargos,	total_nota,
		Serie_nd_Dev, 		Numero_nd_Dev, 
		estado_nota,		fecha_emision,	usuario_emision, codigo_motivo, codigo_movimiento,
		direccion_envio,	notarjeta, tipo_cliente,codigo_negocio)
		values (@Serie, @Correlat, @Sucursal,
			@tipo_pago, @tipo_cred, @fecha_doc, @fecha_vence, @nit, @Nom_clie,
			@Dir_fact, @Cod_Clie, @Observaciones, @monto_total-@Impto, @Impto,
			@cargos_envio, @otros_cargos, @monto_total, 
			@Serie_Dev, @No_Doc_Dev, 1, getdate(), @User, @Tipo_Nota, @tipodoc,
			@dir_env,@tarj,@tipo_cliente,@codigo_negocio)
		if @@error<>0
		Begin
			raiserror('No se pudo insertar la nota de debito',16,1,5000)
			rollback work
			return
		end	
		Insert into cj_notasDebito
		(serie, numero,codigo_caja,codigo_sucursal)
		values
		(@serie,@correlat,@caja,@sucursal)
		if @@error<>0
		Begin
			raiserror('No se pudo insertar los datos de la nota en la caja',16,1,5000)
			rollback work
			return
		end
	
	End

	--Solicitudes de muestra
	if @tipomov = '5'
	begin
		insert into pv_muestras_enc
		(codigo_sucursal,no_muestra,codigo_pago,codigo_vendedor,tipo_credito,
		fecha_muestra,fecha_vencimiento,numero_nit,nombre_muestra,direccion_factura,
		codigo_cliente,monto_des_global,total_ventas,total_impuesto,cargos_envios,otros_cargos,
		total_muestra,estado_muestra,fecha_emision,usuario_emision,necesita_aut,Observaciones,
		codigo_movimiento,direccion_envio,notarjeta )
		values
		(@Sucursal,@Correlat,@tipo_pago,@Cod_vendedor,@tipo_cred, 
		 @fecha_doc,@fecha_vence,@nit,@Nom_clie,@Dir_fact,
		 @Cod_Clie,@monto_total-@Impto,@monto_total,@Impto,@cargos_envio, @otros_cargos, 
		 @monto_total, 'P', getdate(), @User, 'S', @Observaciones, 
		 @tipodoc,@dir_env,@tarj)
		if @@error<>0
		Begin
			raiserror('No se pudo insertar la muestra',16,1,5000)
			rollback work
			return
		end
	end

	--Devoluciones de Proyetos
	if @tipomov = '6'
	begin
		insert into pv_devolucion_enc
		(codigo_sucursal,no_devolucion,codigo_pago,codigo_vendedor,tipo_credito,
		fecha_devolucion,fecha_vencimiento,numero_nit,nombre_devolucion,direccion_devolucion,
		codigo_cliente,monto_des_global,total_ventas,total_impuesto,cargos_envios,otros_cargos,
		total_devolucion,estado_devolucion,fecha_emision,usuario_emision,necesita_aut,Observaciones,
		codigo_movimiento,direccion_envio,notarjeta, codigo_departamento, codigo_generador )
		values
		(@Sucursal,@Correlat,@tipo_pago,@Cod_vendedor,@tipo_cred, 
		 @fecha_doc,@fecha_vence,@nit,@Nom_clie,@Dir_fact,
		 @Cod_Clie,@monto_total-@Impto,@monto_total,@Impto,@cargos_envio, @otros_cargos, 
		 @monto_total, 'P', getdate(), @User, 'N', @Observaciones, 
		 @tipodoc,@dir_env,@tarj, @codDept, @codGen)
		if @@error<>0
		Begin
			raiserror('No se pudo insertar la devolucion de proyectos',16,1,5000)
			rollback work
			return
		end
	end

	--mercaderia en consignacion
	if @tipomov = '7'
	begin
		insert into pv_consigna_enc
		(codigo_sucursal,no_consignacion,codigo_pago,codigo_vendedor,tipo_credito,
		fecha_consignacion,fecha_vencimiento,numero_nit,nombre_consignacion,direccion_consignacion,
		codigo_cliente,monto_des_global,total_ventas,total_impuesto,cargos_envios,otros_cargos,
		total_consignacion,estado_consignacion,fecha_emision,usuario_emision,necesita_aut,Observaciones,
		codigo_movimiento,direccion_envio,notarjeta,fecha_est_entrega,tipo_cliente,codigo_negocio )
		values
		(@Sucursal,@Correlat,@tipo_pago,@Cod_vendedor,@tipo_cred, 
		 @fecha_doc,@fecha_vence,@nit,@Nom_clie,@Dir_fact,
		 @Cod_Clie,@monto_total-@Impto,@monto_total,@Impto,@cargos_envio, @otros_cargos, 
		 @monto_total, 'P', getdate(), @User, 'S', @Observaciones, 
		 @tipodoc,@dir_env,@tarj,@fecha_entrega,@tipo_cliente,@codigo_negocio)
		if @@error<>0
		Begin
			raiserror('No se pudo insertar la mercaderia en consignacion',16,1,5000)
			rollback work
			return
		end
	end

	
/*4*/
-- Actualizacion de Cuentas x Cobrar
If Not Exists(Select Codigo_Cliente From cc_Clientes Where Codigo_Cliente = @Cod_Clie) and @cod_clie <> 0 and @cod_clie is not null
Begin
delete from cc_campos_clientes where codigo_cliente = @cod_clie
if @@error<>0
Begin
	raiserror('No se pudo eliminar el dato del cliente',16,1,5000)
	rollback work
	return
end

-- Actualiza el codigo de cliente en cuentas por Cobrar
Insert Into cc_clientes
(codigo_cliente, nombre_cliente,direccion_correspondencia, nombre_fiscal, 
direccion_fiscal,nit, telefono_usual,impuesto_ventas)
values 
(@cod_clie,@nom_clie,@dir_fact,@nom_clie,@dir_fact,@nit,@tel,1)
if @@error<>0
Begin
	raiserror('No se pudo insertar los datos del cliente',16,1,5000)
	rollback work
	return
end
End

if ((@activa_credito='S') and (@tipo_cred = 1))
Begin
	if ((@cod_clie = 0) or (@cod_clie is null))
	Begin
		Select @cod_clie = codigo_cliente
		from gn_sucursales
		where codigo_sucursal = @sucursal

		set @nombre_cliente = @Nom_clie
		set @nit_cliente = @cod_clie
	end
	else
	Begin
		set @nombre_cliente = null
		set @nit_cliente = null
	end
end
If (@cod_clie <> 0 and @cod_clie is not null)
Begin
	Set @Cartera = (Select Codigo_Cartera from pv_generales)
	Set @Mov = (Select tipo_movimiento_Cc From pv_tipos_movimiento Where codigo_movimiento = @Tipodoc)
	Set @TipoAbono = (Select tipo_movimiento_Cc From pv_tipos_movimiento Where codigo_movimiento = @CodMovDev ) -- Facturas del Sistema

	-- Busqueda del Codigo de Cobrador
	Select @codigo_cobrador = codigo_cobrador from cc_clientes where codigo_cliente = @cod_clie

	If (@tipomov = '3' and @tipo_cred = 1) --and (@TipoPagoNC='1') --NC
	Begin
		-- Inserta encabezado nota de debito
		Insert Into cc_abonos_enc
		(codigo_cartera, codigo_cliente, tipo_movimiento, serie_movimiento, numero_movimiento,
		codigo_cobrador, fecha_documento, monto, saldo, observaciones,
		fecha_ingreso, usuario_ingreso, codigo_moneda,codigo_sucursal)
		Values
		(@Cartera, @Cod_Clie, @Mov, @Serie, @Correlat, 
		isnull(@Codigo_cobrador,1), @fecha_doc, @monto_aplicacxc, 0, 'Ref '+@Serie_Dev+ convert(char(10),@No_Doc_Dev),
		getdate(), @User, @Moneda,@sucursal)
		If @@error< > 0
		Begin
			Raiserror('No se pudo actualizar abonos de Cuentas por Cobrar - stp_UDPV_InUp_Mov', 16, 1, 5000)
			rollback work
			Return
		End

		-- Inserta detalle de nota de debito
		Insert Into cc_abonos_det
		(codigo_cartera,tipo_movimiento,serie_movimiento,numero_movimiento,
		correlativo,tipo_mov_det,serie_mov_det,numero_mov_det,monto_abono,fecha_aplicacion,documento_id)
		values (@cartera,@mov,@serie,@correlat,


		1, @TipoAbono,@Serie_Dev,@No_Doc_Dev,@monto_aplicacxc,@fecha_doc,@cartera +@tipoAbono + @Serie_Dev+ CONVERT(CHAR(8),@No_Doc_Dev) )
                         
		If @@error > 0
		Begin
			Raiserror('No se pudo actualizar Detalle Abonos de Cuentas por Cobrar - stp_UDPV_InUp_Mov', 16, 1, 5000)
			rollback work
			Return
		End
	    
	End

	If (@tipomov = '4') Or ((@tipomov = '2') And (@tipo_cred = 1))-- Facturas Credito y ND
	Begin
		Insert Into cc_cargos_enc
		(codigo_cartera, codigo_cliente, tipo_movimiento, serie_movimiento, numero_movimiento,
		fecha_documento, fecha_pago, impuesto_ventas, monto, total, saldo, observaciones, 
		fecha_ingreso, usuario_ingreso, codigo_moneda, codigo_vendedor,nombre_cliente,nit_cliente,
		codigo_sucursal,modulo_origen,codigo_negocio)
		Values
		(@Cartera, @Cod_Clie, @Mov, @Serie, @Correlat, 
		@Fecha_doc, @Fecha_Vence, @Impto, @monto_total-@Impto, @monto_total, @monto_total,
		 'Ref '+@Serie_Dev+ convert(char(10),@No_Doc_Dev),
		getdate(), @User, @Moneda, @cod_vendedor,@nombre_cliente,@nit_cliente,@sucursal,'PV',@codigo_negocio)
		
		If @@error > 0
		Begin
			Raiserror('No se pudo actualizar cargos de Cuentas por Cobrar - stp_UDPV_InUp_Mov', 16, 1, 5000)
			rollback work
			Return
		End
	end
End
/*5*/
-- Bitacoras
If @tipomov in ('2','3','4')
Begin
	Insert Into pv_bitacora 
	(codigo_movimiento, serie, numero, accion, monto_anterior, monto_actual, usuario, fecha)
	values 
	(@tipodoc, @Serie, @Correlat, 'I', 0, @monto_total, @User, getdate())
	If @@error > 0
	Begin
		Raiserror('No se pudo actualizar Bitacora - stp_UDPV_InUp_Mov', 16, 1, 5000)
		rollback work
		Return
	End
End
	Select @Serie, @Correlat
/*6*/
commit tran


GO

/*******PROCEDIMIENTO QUE BUSCA EL CREDITO DEL CLIENTE********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_Get_CreditoCliente'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
/****** Object:  StoredProcedure [dbo].[stp_UDPV_Get_CreditoCliente]    Script Date: 8/4/2015 8:30:07 PM ******/
DROP PROCEDURE [dbo].[stp_UDPV_Get_CreditoCliente]
GO

/****** Object:  StoredProcedure [dbo].[stp_UDPV_Get_CreditoCliente]    Script Date: 8/4/2015 8:30:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE Procedure [dbo].[stp_UDPV_Get_CreditoCliente]
	@nit varchar(10)
As

Set NoCount On

-- Fecha Modificación: 08-05-2009
-- Usuario Modifico: Estuardo Arévalo
-- Cambio de tipos para NombreCliente, DireccionFact y DireccionEnv
-- tenian limite de 50,100,100 respectivamente se cambio a 100,200,200


-- Fecha Modifico: 29-07-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9	
Declare 	@Codigo integer, @Nombre varchar(200), 
		@DireccionFact varchar(200), @DireccionEnv varchar(200),
		@Tarjeta varchar(20), @Telefono varchar(20), 
		@Tipo_Limite integer, @Codigo_Grupo integer,
		@Limite_Credito money, @Saldo money, @CC char(1),
        	@dias_credito smallint, @Corte_Credito char(1),
		@codigo_prof smallint, @descProf varchar(50)
	
Declare 	@Cartera integer,
		@codigo_dias smallint,
		@tipo_cliente smallint

If exists(Select * from cc_clientes where nit = @nit)
   Begin
	Select 	@Codigo = cc.Codigo_cliente, @Nombre = cc.nombre_cliente, 
			@DireccionFact = cc.Direccion_Correspondencia, @DireccionEnv = cc.Direccion_Correspondencia, 
			@Telefono = cc.telefono_usual, 
			@Tipo_Limite = cc.Tipo_Limite, @Codigo_Grupo = cc.Codigo_Grupo,
			@Limite_Credito = cc.Limite_Credito, @CC = 'S',
			@codigo_dias = dias_limite,
	        	@corte_credito = corte_credito,
			@tipo_cliente = tipo_cliente
	From cc_Clientes cc Where cc.nit = @nit

	-- Obtiene los dias de credito para el cliente
	Select @dias_credito = dias
	from cc_dias_credito
	where dias_limite =@codigo_dias
   end
Else
Begin
	Select @tipo_cliente = 1
	Select 	@Codigo = cf.Codigo_Cliente, @Nombre = cf.Nombre_Factura, 
			@DIreccionFact = cf.Direccion_Facturar, @DireccionEnv = cf.Direccion_Envio, 
			@Tarjeta = cf.notarjeta, @Telefono = cf.Telefono, @CC = 'N'
	From pv_Clientes_Frecuentes cf
	Where cf.numero_nit = @nit

	Select @Tipo_Limite = Tipo_Limite, @Codigo_Grupo = Codigo_Grupo, @Limite_Credito = Limite_Credito
	From cc_Clientes Where codigo_cliente =(Select Codigo_Cliente 
									From gn_Sucursales 
									where Codigo_Sucursal = (Select Codigo_Sucursal From pv_generales))

	Set @dias_credito = 0
End

If exists(Select * from pv_clientes_frecuentes where numero_nit = @nit)
	 (Select @Tarjeta =notarjeta, @codigo_prof= codigo_profesion from pv_clientes_frecuentes where numero_nit = @nit)

if @codigo_prof is null 
Begin
	Select @codigo_prof = codigo_profesion
	from pv_tarjetas_preferenciales
	where notarjeta = @Tarjeta
end

--Descripcion de profesion
select @descProf = nombre_profesion from gn_profesiones where codigo_profesion = @codigo_prof

Set @Saldo = 0

If @Tipo_Limite = 1 --Del cliente
	Set @Saldo = (Select Saldo From cc_saldos_Cliente Where Codigo_Cliente = @Codigo)
If @Tipo_Limite = 2 --Del Grupo
Begin

	Select @Limite_Credito = Limite_Credito, @corte_credito = corte_credito 
	From cc_Grupo_Cliente Where Codigo_Grupo = @Codigo_Grupo
	Set @Saldo = (Select isnull(sum(saldo),0) From cc_saldos_Cliente Where Codigo_Cliente in(Select Codigo_Cliente From cc_Clientes Where codigo_grupo = @Codigo_Grupo))
--	select @Limite_Credito,@corte_credito
End
If @Tipo_Limite = 3 --De la cartera
Begin
	Set @Cartera = (Select Codigo_Cartera From pv_Generales)
	Set @Limite_Credito =(Select Limite_Credito From cc_carteras Where Codigo_Cartera = @Cartera)
	Set @Saldo = (Select sum(saldo_final) From cc_saldos_cltecartera Where Codigo_Cliente = @Codigo And Codigo_Cartera = @Cartera)
End
if @Tipo_Limite = 5 --Del negocio
Begin
	Select 	@limite_credito = limite_credito,
			@corte_credito = corte_credito
	from cc_negocios
	where codigo_cliente = @codigo 

	select 	@saldo = sum(saldo_negocio)
	from cc_saldo_negocio
	where 	codigo_cliente = @codigo
end
--5 por negocio
--Final
if isnull(@limite_credito,0) - isnull(@saldo,0) <= 0
	set @cc = 'N'

-- Corte de Serv icio
If @corte_credito = 'S'
Begin
	Set @cc = 'N'
	Set @Limite_credito = 0
	Set @saldo = 0
End
	

Select @Codigo as Codigo, @Nombre as Nombre, @DireccionFact as DireccionFact, @DireccionEnv as DireccionEnv,
@Tarjeta as Tarjeta, @Telefono as Telefono, @Tipo_Limite as Tipo_Limite, @Codigo_Grupo as Codigo_Grupo,
@Limite_Credito as Limite_Credito, @Saldo as Saldo, @CC as CC, @dias_credito Dias_Credito, 

@codigo_prof as Prof, @descProf as DescProfesion, @tipo_cliente tipo_cliente
GO

/*******PROCEDIMIENTO QUE OBTIENE INFORMACION DEL PRODUCTO********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_Get_Producto'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_Get_Producto]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[stp_UDPV_Get_Producto]
	@Lista integer,
	@prod char(10),
	@UMedida char(2),
	@Bode char(2),
	@Pago integer,
	@Serie char(2) = Null,
	@Numero integer = Null
As
set nocount on
-- Fecha modifico: 17/10/2013
-- Usuario: Ocoroy
-- disponible - transito

--1.2.5
-- Fecha Modifico: 05-02-2006
-- Usuario Modifico: Ocoroy

-- Fecha Modificacion: 28-02-2006
-- Usuario Modifico: Ocoroy

-- Fecha Modifico: 03-03-2006
-- Usuario Modifico: Ocoroy

-- Fecha Modifico: 08-03-2006
-- Usuario Modifico: Ocoroy
-- Cambio para que reste la cantidad devolucion a los kits

-- Fecha Modifico: 19-03-2006
-- Usuario Modifico: Ocoroy

-- Fecha Modifico: 13/06/2006
-- Fecha Modifico: Ocoroy

-- Fecha Modifico: 30-09-2006
-- usuario Modifico: Ocoroy

--Fecha Modifico: 20/07/2015
-- usuario Modifico: Erick Chali
DECLARE @codigoC varchar(10)
select @codigoC =  isnull(dbo.replicacionCero_productos(@prod),@prod)

Declare @SerieNoIngresada char(2),
	@NumeroNoingresado integer,
	@Es_Kit char(1),
	@Disponible float

declare @por_devolucion decimal(8,4),
	@por_dev_asoc decimal(8,4),
	@por_descuentopago decimal(8,4)

if @serie is not null and @numero is not null
Begin
	Select @NumeroNoIngresado = Numero
	from pv_facturasOut
	where serie = @serie

If @numero<=Isnull(@numeroNoingresado,0)
   	Set @numero = 0
end

Select  @por_descuentopago = isnull(por_descuento,0)
from pv_tipos_pago
where codigo_pago = @pago


If ISnull(@Numero,0) = 0
   Begin
	
	Select @es_kit = es_kit 
	from in_productos
	where codigo_producto = @codigoC

	If @es_kit = 'S'
            Begin
		-- Trae las Existencias del Kit
		Select 	
				@disponible=min(isnull(e.disponible,0))
		from 	in_existencias e, in_productos_kit k
		where 	k.codigo_producto_det = e.codigo_producto  
			and k.codigo_producto = @codigoC
			and e.codigo_bodega = @Bode

		-- Trae los datos del producto		
		 Select ip.Codigo_Producto, ip.Descripcion, pp.unidad_medida as Unidad_Medida, u.descripcion as Medida,
			ip.Acepta_Fracciones, pp.precio as PrecioU, pp.por_descuento as Descuento,
			isnull(@disponible,0) as Disponible, @Bode codigo_bodega, 
			case when (pp.por_descuento - @por_descuentopago)<0 then 0 
			else (pp.por_descuento - @por_descuentopago) end por_descmin, ip.es_kit
		From pv_precios_productos pp
			Left Join in_Productos ip on pp.codigo_producto = ip.codigo_producto 
			Left Join in_unidades_medida um on um.unidad_medida = pp.unidad_medida  
                                                           And um.Codigo_producto = pp.codigo_producto
			Left Join in_unidades u on um.unidad_medida = u.unidad_medida
		Where   pp.codigo_lista = @Lista
			and pp.codigo_pago = '1'
			And pp.codigo_producto = @codigoC
			And pp.Unidad_Medida = @UMedida
            End
        Else

		Select ip.Codigo_Producto, ip.Descripcion, pp.unidad_medida as Unidad_Medida, u.descripcion as Medida,
			ip.Acepta_Fracciones, pp.precio as PrecioU, pp.por_descuento as Descuento,
			case when isnull(ex.cantidad_transito,0) < 0 
			then isnull(ex.disponible,0) + isnull(ex.cantidad_transito,0)
			else isnull(ex.disponible,0) end Disponible, isnull(ex.Codigo_Bodega,@Bode) codigo_bodega, 
			case when (pp.por_descuento - @por_descuentopago)<0 then 0 
			else (pp.por_descuento - @por_descuentopago) end por_descmin, ip.es_kit
		From pv_precios_productos pp
			Left Join in_Productos ip on pp.codigo_producto = ip.codigo_producto 
			Left Join in_unidades_medida um on um.unidad_medida = pp.unidad_medida  And um.Codigo_producto = pp.codigo_producto
			Left Join in_unidades u on um.unidad_medida = u.unidad_medida
			Left Join in_existencias ex on pp.codigo_producto = ex.codigo_producto 
			and ex.codigo_bodega = @bode
		Where pp.codigo_lista = @Lista
			And pp.codigo_producto = @codigoC
			and pp.codigo_pago = '1'
			And pp.Unidad_Medida = @UMedida

   End
	
Else
begin
	-- Se trae el porcentaje de descuento de devolucion de los productos asociados
	Select 	@por_dev_asoc = por_dev_Asociados
	from pv_generales

	Select @pago = codigo_pago
	from pv_facturas_enc
	where serie = @serie and numero = @numero

	Select @por_devolucion = por_devolucion 
	from pv_tipos_pago where codigo_pago = @pago	
	
	Select 	ip.codigo_producto, ip.descripcion, d.unidad_medida Unidad_Medida, u.descripcion Medida,
		ip.acepta_fracciones, d.precio PrecioU, isnull(d.por_descuento,0) + isnull(@por_devolucion,0) Descuento,
		isnull(d.cantidad,0)-isnull(d.devolucion,0) Disponible, d.codigo_bodega, isnull(d.por_descuento,0) + isnull(@por_devolucion,0) por_descmin, ip.es_kit, 
		case
		when ip.es_kit = 'S' then d.correlativo
		else 0
		end correlativo_kit,
		d.correlativo
	into #tmpDetalleFac
	from 	in_productos ip, pv_facturas_det d, pv_facturas_enc e,
               	in_unidades_medida um,  in_unidades u
	where  	ip.codigo_producto = d.codigo_producto
		and d.serie = e.serie and d.numero = e.numero
		and um.unidad_medida = d.unidad_medida  And um.Codigo_producto = d.codigo_producto
		and um.unidad_medida = u.unidad_medida
		and e.serie = @serie and e.numero = @numero
		and e.estado_factura <> 'A'
		and d.codigo_producto = @codigoC
		

	insert into #tmpDetalleFac
	(codigo_producto, descripcion, Unidad_Medida, Medida, acepta_fracciones, PrecioU, Descuento, Disponible,
	codigo_bodega, por_descmin, es_kit, correlativo_kit,correlativo)
	
	(Select ip.codigo_producto, ip.descripcion, d.unidad_medida Unidad_Medida, u.descripcion Medida,
	           ip.acepta_fracciones, d.precio PrecioU, 0,
                        isnull(d.cantidad,0) - isnull(d.devolucion,0) Disponible, d.codigo_bodega, 0, ip.es_kit, d.correlativo,0
	from in_productos ip, pv_facturas_kits d, pv_facturas_enc e,
               in_unidades_medida um,  in_unidades u
	where  ip.codigo_producto = d.codigo_producto
		and d.serie = e.serie and d.numero = e.numero
		and um.unidad_medida = d.unidad_medida  And um.Codigo_producto = d.codigo_producto
		and um.unidad_medida = u.unidad_medida
		and e.serie = @serie and e.numero = @numero
		and e.estado_factura <> 'A'
		and d.codigo_producto = @codigoC		
	)

	insert into #tmpDetalleFac
	(codigo_producto, descripcion, Unidad_Medida, Medida, acepta_fracciones, PrecioU, Descuento, Disponible,
	codigo_bodega, por_descmin, es_kit,correlativo_kit,correlativo)
	select 	ip.codigo_producto, ip.descripcion, d.unidad_medida Unidad_Medida, u.descripcion Medida,
		ip.acepta_fracciones, (pp.precio  * (1- @por_dev_asoc/100)) PrecioU, 0,
                isnull(d.cantidad,0) Disponible, d.codigo_bodega, 0, ip.es_kit, 0 correlativo_kit,ia.correlativo
	from 	in_productos ip, pv_facturas_asociados ia, pv_facturas_det d,
		in_unidades_medida um,in_unidades u,pv_precios_productos pp
	where 	d.serie = @serie and
		d.numero = @numero and
		d.serie = ia.serie and
		d.numero = ia.numero and		
		d.correlativo = ia.correlativo and
		d.codigo_producto = ia.codigo_producto and
		ia.codigo_asociado = ip.codigo_producto and
		ia.codigo_asociado = um.codigo_producto and
		ia.codigo_asociado = @codigoC and
		um.unidad_medida = u.unidad_medida and
		pp.codigo_producto = @codigoC and
		pp.codigo_lista = @lista and
		pp.unidad_medida = @umedida and
--		pp.codigo_pago = @pago and
		(ia.cantidad - isnull(ia.devolucion,0)) > 0

	select * from #tmpDetalleFac where Disponible > 0 order by correlativo_kit
end


GO


/*******PROCEDIMIENTO QUE BUSCA CLIENTES POR NOMBRE********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Clientes_FilterNomb'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Clientes_FilterNomb]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[stp_UDPV_LookUp_Clientes_FilterNomb]
  @valor varchar(60)
As
	Select numero_nit as Nit, nombre_factura as Nombre, notarjeta Tarjeta
	From pv_Clientes_Frecuentes
	where nombre_factura like '%'+ @valor + '%'

GO

/*******PROCEDIMIENTO QUE BUSCA CLIENTES POR NIT********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Clientes_FilterNit'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Clientes_FilterNit]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[stp_UDPV_LookUp_Clientes_FilterNit]
  @valor varchar(20)
As
	Select numero_nit as Nit, nombre_factura as Nombre, notarjeta Tarjeta
	From pv_Clientes_Frecuentes
	where numero_nit like '%'+ @valor + '%'
GO

/*******PROCEDIMIENTO QUE BUSCA PRODUCTOS POR MARCA********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Prods_FilterMar_Bod'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
/****** Object:  StoredProcedure [dbo].[stp_UDPV_LookUp_Prods_FilterMar_Bod]    Script Date: 8/4/2015 8:40:22 PM ******/
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Prods_FilterMar_Bod]
GO

/****** Object:  StoredProcedure [dbo].[stp_UDPV_LookUp_Prods_FilterMar_Bod]    Script Date: 8/4/2015 8:40:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  Procedure [dbo].[stp_UDPV_LookUp_Prods_FilterMar_Bod]--stp_UDPV_LookUp_Prods_FilterMar_Bod 1,2,'11','incesa'
 @Lista integer,
 @Cod_Pago integer,
 @Cod_Bodega char(2),
 @Mar varchar(60)
As
set nocount on
-- Fecha Modifico: 29-07-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro por bodega factura = 'S' y se quito el de pago 

-- Fecha Modifico: 17-10-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro que apareciera si es defectuoso o alterno

-- Fecha Modifico: 24-07-2015
-- Usuario Modifico: Erick Chali
-- se modifico sintaxis *= por compatibilidad sql server 2012
 Select ip.codigo_producto as Codigo, ip.codigo_referencia as Referencia, ip.descripcion as Descripcion, 
  m.descripcion as Marca, f.descripcion as Familia,
  pp.precio as PrecioU, isnull(ex.disponible,0) as Disponible, isnull(ex.codigo_bodega,'') as Bodega,
  sum (cantidad_autorizada) as backorder, min(fecha_esperado) fecha_esp, isnull(ex.cantidad_transito,0) as Transito 
 into #tmp_productos
 From pv_precios_productos pp
 inner Join in_Productos ip on pp.codigo_producto = ip.codigo_producto 
 inner Join in_marcas m on ip.codigo_marca = m.codigo_marca
 inner Join in_familias f on ip.codigo_familia = f.codigo_familia
 Left Join in_existencias ex on pp.codigo_producto = ex.codigo_producto and ex.codigo_bodega = @Cod_Bodega
 left join co_ordenesi_det cod on pp.codigo_producto = cod.codigo_producto
 
 Where pp.codigo_lista = @Lista
           And m.descripcion like '%' + @Mar + '%'
   and ex.codigo_bodega in (Select codigo_bodega from in_bodegas where factura = 'S')
 group by ip.codigo_producto , ip.codigo_referencia , ip.descripcion , 
  m.descripcion , f.descripcion ,
  pp.precio , ex.disponible, ex.codigo_bodega, ex.cantidad_transito

-- MODIFICADO: MARIO RODRIGUEZ 30/01/2013
-- se incluyeron los productos que no hala el escript anterior por carecer de algún parámetro.
insert #tmp_productos
 (Codigo,Descripcion,Marca,PrecioU,Disponible,Bodega,backorder,fecha_esp,Transito,Familia)
Select 
 ip.codigo_producto, ip.descripcion, m.descripcion, isnull(pp.precio,0), 0,
 @cod_bodega, 0, getdate(), 0, f.descripcion as Familia

 From 
  pv_precios_productos pp left join in_Productos ip on 
   ip.codigo_producto = pp.codigo_producto and
   ip.codigo_producto not in (select codigo from #tmp_productos)
      inner join in_marcas m on 
      ip.codigo_marca = m.codigo_marca 
      inner join in_familias f on 
   ip.codigo_familia = f.codigo_familia

 Where pp.codigo_lista = @lista
       And m.descripcion like '%' + @Mar + '%'


 Select  a.Codigo, isnull(b.defectuoso,'A') defectuoso
 into #tmp_alterno
 from  #tmp_productos a,
   in_productos b,
   in_productos_alternos al,
   in_existencias ex
 where  a.codigo = b.codigo_producto and
   a.codigo = al.codigo_producto and
   al.codigo_alterno = ex.codigo_producto and
   ex.disponible > 0

 Select  distinct 
  a.Codigo, a.Descripcion, a.Marca,a.PrecioU,a.Disponible , a.Bodega, 
  a.BackOrder,convert(varchar(10),a.fecha_esp,103) [Fecha Esp], a.Transito, a.Familia,a.Referencia,     
  isnull(defectuoso,'N') Df
 from #tmp_productos a left join #tmp_alterno b on
      a.codigo = b.codigo
 order by a.codigo
GO

/*******PROCEDIMIENTO QUE BUSCA PRODUCTOS POR DESCRIPCION********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Prods_FilterDesc_Bod'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Prods_FilterDesc_Bod]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  Procedure [dbo].[stp_UDPV_LookUp_Prods_FilterDesc_Bod]
	@Lista integer,
	@Cod_Pago integer,
	@Cod_Bodega char(2),
	@Desc varchar(60)
As
set nocount on
-- Fecha Modifico: 17-10-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro que apareciera si es defectuoso o alterno

-- Fecha Modifico: 29-07-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro por bodega factura = 'S' y se quito el de pago

-- Fecha Modifico: 24-07-2015
-- Usuario Modifico: Erick Chali
-- se modifico la sintaxis *= para que sea compatible con sql server 2012
	Select ip.codigo_producto as Codigo, ip.codigo_referencia as Referencia, ip.descripcion as Descripcion, 
		m.descripcion as Marca, f.descripcion as Familia,
		pp.precio as PrecioU, isnull(ex.disponible,0) as Disponible, isnull(ex.codigo_bodega,'') as Bodega,
		sum (cantidad_autorizada) as backorder, min(fecha_esperado) fecha_esp, isnull(ex.cantidad_transito,0) as Transito	
	into #tmp_productos
	From pv_precios_productos pp
	inner Join in_Productos ip on pp.codigo_producto = ip.codigo_producto 
	inner Join in_marcas m on ip.codigo_marca = m.codigo_marca
	inner Join in_familias f on ip.codigo_familia = f.codigo_familia
	Left Join in_existencias ex on pp.codigo_producto = ex.codigo_producto and ex.codigo_bodega = @Cod_Bodega
	left join co_ordenesi_det cod on pp.codigo_producto = cod.codigo_producto

	Where pp.codigo_lista = @Lista
	And ip.descripcion like '%' + @Desc + '%'
	group by ip.codigo_producto , ip.codigo_referencia , ip.descripcion , 
		m.descripcion , f.descripcion ,
		pp.precio , ex.disponible, ex.codigo_bodega, ex.cantidad_transito

	Select 	a.Codigo, isnull(b.defectuoso,'A') defectuoso
	into #tmp_alterno
	from 	#tmp_productos a,
			in_productos b,
			in_productos_alternos al,
			in_existencias ex
	where 	a.codigo = b.codigo_producto and
			a.codigo = al.codigo_producto and
			al.codigo_alterno = ex.codigo_producto and
			ex.disponible > 0


	Select 	distinct 
		a.Codigo, a.Descripcion, a.Marca,a.PrecioU,a.Disponible , a.Bodega, 
		a.BackOrder,convert(varchar(10),a.fecha_esp,103) [Fecha Esp], a.Transito, a.Familia,a.Referencia,			  
		isnull(defectuoso,'N') Df
	from #tmp_productos a left join 
		#tmp_alterno b on
		a.codigo = b.codigo

	order by a.codigo

GO

/*******PROCEDIMIENTO QUE BUSCA PRODUCTOS POR FAMILIA********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Prods_FilterFam_Bod'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
/****** Object:  StoredProcedure [dbo].[stp_UDPV_LookUp_Prods_FilterFam_Bod]    Script Date: 8/4/2015 8:43:21 PM ******/
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Prods_FilterFam_Bod]
GO

/****** Object:  StoredProcedure [dbo].[stp_UDPV_LookUp_Prods_FilterFam_Bod]    Script Date: 8/4/2015 8:43:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   Procedure [dbo].[stp_UDPV_LookUp_Prods_FilterFam_Bod]
	@Lista integer,
	@Cod_Pago integer,
	@Cod_Bodega char(2),
	@Fam varchar(60)
As
set nocount on
-- Fecha Modifico: 17-10-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro que apareciera si es defectuoso o alterno

-- Fecha Modifico: 29-07-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro por bodega factura = 'S' y se quito el de pago	

-- Fecha Modifico: 24-07-2015
-- Usuario Modifico: Erick Chali
-- se modifico sintaxis *= por compatibilidad sql server 2012
	Select ip.codigo_producto as Codigo, ip.codigo_referencia as Referencia, ip.descripcion as Descripcion, 
		m.descripcion as Marca, f.descripcion as Familia,
		pp.precio as PrecioU, isnull(ex.disponible,0) as Disponible, isnull(ex.codigo_bodega,'') as Bodega,
		sum (cantidad_autorizada) as backorder, min(fecha_esperado) fecha_esp, isnull(ex.cantidad_transito,0) as Transito	
	into #tmp_productos
	From pv_precios_productos pp
	inner Join in_Productos ip on pp.codigo_producto = ip.codigo_producto 
	inner Join in_marcas m on ip.codigo_marca = m.codigo_marca
	inner Join in_familias f on ip.codigo_familia = f.codigo_familia
	Left Join in_existencias ex on pp.codigo_producto = ex.codigo_producto and ex.codigo_bodega = @Cod_Bodega
	left join co_ordenesi_det cod on pp.codigo_producto = cod.codigo_producto
	

	Where pp.codigo_lista = @Lista
	      And f.descripcion like '%' + @Fam + '%'
		 and ex.codigo_bodega in (Select codigo_bodega from in_bodegas where factura = 'S')
	group by ip.codigo_producto , ip.codigo_referencia , ip.descripcion , 
		m.descripcion , f.descripcion ,
		pp.precio , ex.disponible, ex.codigo_bodega, ex.cantidad_transito

-- MODIFICADO: MARIO RODRIGUEZ 3001/2013
-- se incluyeron los productos que no hala el escript anterior por carecer de algún parámetro.
insert #tmp_productos
	(Codigo,Descripcion,Marca,PrecioU,Disponible,Bodega,backorder,fecha_esp,Transito,Familia)

Select 
	ip.codigo_producto, ip.descripcion, m.descripcion, isnull(pp.precio,0), 0,
	@cod_bodega, 0, getdate(), 0, f.descripcion as Familia

	From 
		pv_precios_productos pp left join in_Productos ip on ip.codigo_producto = pp.codigo_producto and
		ip.codigo_producto not in (select codigo from #tmp_productos)
			inner join in_marcas m on  
			ip.codigo_marca = m.codigo_marca
			inner join in_familias f on 
			ip.codigo_familia = f.codigo_familia
	Where pp.codigo_lista = @lista
	      And ip.codigo_marca=m.codigo_marca 
		  and f.descripcion like '%' + @fam + '%' 
--ENDLINE

	Select 	a.Codigo, isnull(b.defectuoso,'A') defectuoso
	into #tmp_alterno
	from 	#tmp_productos a,
			in_productos b,
			in_productos_alternos al,
			in_existencias ex
	where 	a.codigo = b.codigo_producto and
			a.codigo = al.codigo_producto and
			al.codigo_alterno = ex.codigo_producto and
			ex.disponible > 0


	Select 	distinct 
		a.Codigo, a.Descripcion, a.Marca,a.PrecioU,a.Disponible , a.Bodega, 
		a.BackOrder,convert(varchar(10),a.fecha_esp,103) [Fecha Esp], a.Transito, a.Familia,a.Referencia,			  
		isnull(defectuoso,'N') Df
	from #tmp_productos a left join 
		#tmp_alterno b on a.codigo = b.codigo
	

	order by a.codigo




GO

/*******PROCEDIMIENTO QUE BUSCA PRODUCTOS POR REFERENCIA********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Prods_FilterRef_Bod'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
/****** Object:  StoredProcedure [dbo].[stp_UDPV_LookUp_Prods_FilterRef_Bod]    Script Date: 8/4/2015 8:45:53 PM ******/
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Prods_FilterRef_Bod]
GO

/****** Object:  StoredProcedure [dbo].[stp_UDPV_LookUp_Prods_FilterRef_Bod]    Script Date: 8/4/2015 8:45:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[stp_UDPV_LookUp_Prods_FilterRef_Bod]
	@Lista integer,
	@Cod_Pago integer,
	@Cod_Bodega char(2),
	@Ref varchar(35)
As
set nocount on
-- Fecha Modifico: 17-10-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro que apareciera si es defectuoso o alterno

-- Fecha Modifico: 29-07-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro por bodega factura = 'S' y se quito el de pago
	
-- Fecha Modifico: 24-07-2015
-- Usuario Modifico: Erick Chali
-- se modifico sintaxis *= por compatibilidad sql server 2012
Select ip.codigo_producto as Codigo, ip.codigo_referencia as Referencia, ip.descripcion as Descripcion, 
		m.descripcion as Marca, f.descripcion as Familia,
		pp.precio as PrecioU, isnull(ex.disponible,0) as Disponible, isnull(ex.codigo_bodega,'') as Bodega,
		sum (cantidad_autorizada) as backorder, min(fecha_esperado) fecha_esp, isnull(ex.cantidad_transito,0) as Transito	
	into #tmp_productos
	From pv_precios_productos pp
	inner Join in_Productos ip on pp.codigo_producto = ip.codigo_producto 
	inner Join in_marcas m on ip.codigo_marca = m.codigo_marca
	inner Join in_familias f on ip.codigo_familia = f.codigo_familia
	Left Join in_existencias ex on pp.codigo_producto = ex.codigo_producto and ex.codigo_bodega = @Cod_Bodega
	left join co_ordenesi_det cod on pp.codigo_producto = cod.codigo_producto
	
	Where pp.codigo_lista = @Lista
	And ip.Codigo_Referencia like '%' + @Ref + '%'

	group by ip.codigo_producto , ip.codigo_referencia , ip.descripcion , 
		m.descripcion , f.descripcion ,
		pp.precio , ex.disponible, ex.codigo_bodega, ex.cantidad_transito

	Select 	a.Codigo, isnull(b.defectuoso,'A') defectuoso
	into #tmp_alterno
	from 	#tmp_productos a,
			in_productos b,
			in_productos_alternos al,
			in_existencias ex
	where 	a.codigo = b.codigo_producto and
			a.codigo = al.codigo_producto and
			al.codigo_alterno = ex.codigo_producto and
			ex.disponible > 0


	Select 	distinct 
		a.Codigo, a.Descripcion, a.Marca,a.PrecioU,a.Disponible , a.Bodega, 
		a.BackOrder,convert(varchar(10),a.fecha_esp,103) [Fecha Esp], a.Transito, a.Familia,a.Referencia,			  
		isnull(defectuoso,'N') Df
	from #tmp_productos a left join 
		#tmp_alterno b on
		a.codigo = b.codigo

	order by a.codigo



GO

/*******PROCEDIMIENTO QUE BUSCA PRODUCTOS EN OTRAS BODEGAS POR DESCRIPCION********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_LookUp_Prods_FilterDesc_Prod'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_LookUp_Prods_FilterDesc_Prod]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[stp_UDPV_LookUp_Prods_FilterDesc_Prod]
	@Lista integer,
	@Cod_Pago integer,
	@Cod_Prod char(25),
	@Desc varchar(60)
AS
set nocount on
-- Fecha Modifico: 17-10-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro que apareciera si es defectuoso o alterno

-- Fecha Modifico: 29-07-2007
-- Usuario Modifico: Ocoroy
-- ver 1.2.9
-- se agrego el filtro por bodega factura = 'S' y se quito el de pago
	declare @backorder decimal (18,6),
	@fecha_esp datetime
	--consulta de backorder
	select @backorder= sum(isnull(cantidad_autorizada,0))  ,@fecha_esp=min(fecha_esperado) 
	from co_ordenesi_det
	where codigo_producto = @cod_prod and
		fecha_esperado > getdate()
	group by codigo_producto


	Select ip.codigo_producto as Codigo, ip.codigo_referencia as Referencia, ip.descripcion as Descripcion, 
		m.descripcion as Marca, f.descripcion as Familia,
		pp.precio as PrecioU, isnull(ex.disponible,0) as Disponible, isnull(ex.codigo_bodega,'') as Bodega,
		@backorder backorder,@fecha_esp fecha_esp, isnull(ex.cantidad_transito,0) as Transito	
	into #tmp_productos
	From pv_precios_productos pp
	inner Join in_Productos ip on pp.codigo_producto = ip.codigo_producto 
	inner Join in_marcas m on ip.codigo_marca = m.codigo_marca 
	inner  Join in_familias f on ip.codigo_familia = f.codigo_familia
	Left Join in_existencias ex on pp.codigo_producto = ex.codigo_producto
	
	Where pp.codigo_lista = @Lista
	And pp.codigo_producto = @Cod_Prod
	And ip.descripcion like '%' + @Desc + '%'
	and ex.codigo_bodega in (Select codigo_bodega from in_bodegas where factura = 'S')
	group by ip.codigo_producto , ip.codigo_referencia , ip.descripcion , 
		m.descripcion , f.descripcion ,
		pp.precio , ex.disponible, ex.codigo_bodega, ex.cantidad_transito

	Select 	a.Codigo, isnull(b.defectuoso,'A') defectuoso
	into #tmp_alterno
	from 	#tmp_productos a,
			in_productos b,
			in_productos_alternos al,
			in_existencias ex
	where 	a.codigo = b.codigo_producto and
			a.codigo = al.codigo_producto and
			al.codigo_alterno = ex.codigo_producto and
			ex.disponible > 0


	Select 	distinct 
		a.Codigo, a.Descripcion, a.Marca,a.PrecioU,a.Disponible , a.Bodega, 
		a.BackOrder,convert(varchar(10),a.fecha_esp,103) [Fecha Esp], a.Transito, a.Familia,a.Referencia,			  
		isnull(defectuoso,'N') Df
	from #tmp_productos a
		left join #tmp_alterno b on a.codigo = b.codigo

	order by a.codigo
GO

/*******PROCEDIMIENTO QUE BUSCA TODOS LOS TIPOS DE PAGO********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_Lookup_TiposPago'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P')
/****** Object:  StoredProcedure [dbo].[stp_UDPV_Lookup_TiposPago]    Script Date: 8/4/2015 8:54:14 PM ******/
DROP PROCEDURE [dbo].[stp_UDPV_Lookup_TiposPago]
GO

/****** Object:  StoredProcedure [dbo].[stp_UDPV_Lookup_TiposPago]    Script Date: 8/4/2015 8:54:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  Procedure [dbo].[stp_UDPV_Lookup_TiposPago]

	@CodigoPago int,
	@Filtro smallint,
	@Valor varchar(100),
	@LimiteCredito money
As

If @limiteCredito > 0
    Begin
	If @Filtro = 0
		Select codigo_pago, descripcion, es_credito
		From pv_tipos_pago

	If @Filtro = 1
		Select codigo_pago, descripcion, es_credito
		From pv_tipos_pago
		Where descripcion like '%' + ltrim(rtrim(@Valor)) + '%' and codigo_pago = @CodigoPago
     End
Else
    Begin
	If @Filtro = 0
		Select codigo_pago, descripcion, es_credito
		From pv_tipos_pago
	              where es_credito = 'N'
	If @Filtro = 1
		Select codigo_pago, descripcion, es_credito
		From pv_tipos_pago
		Where descripcion like '%' + ltrim(rtrim(@Valor)) + '%' 
                                       and es_credito = 'N' and codigo_pago = @CodigoPago
     End

GO

/*******PROCEDIMIENTO QUE BUSCA EL TIPO DE MOVIMIENTO QUE SE EJECUTARA********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_Get_TipoMovimiento'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P')
DROP PROCEDURE [dbo].[stp_UDPV_Get_TipoMovimiento]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE     Procedure [dbo].[stp_UDPV_Get_TipoMovimiento]
@Doc integer,
@usr integer

As

Select Descripcion, Tipo_Movimiento, Formato, Codigo_Tipo, Imprime, codigo_movimiento
	from pv_tipos_movimiento Where codigo_movimiento = @Doc and codigo_movimiento in (Select u.tipo_movimiento From pv_usuarios_tipos u Where UserID = @Usr)

GO

/*******PROCEDIMIENTO QUE BUSCA FECHA DE VENCIMIENTO DEL DOCUMENTO********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_Get_FechaVence'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P')
DROP PROCEDURE [dbo].[stp_UDPV_Get_FechaVence]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[stp_UDPV_Get_FechaVence]
	@tipo_doc smallint
As
Set NoCount On
-- Fecha Modifico: 26-09-2006
-- Usuario Modifico: Ocoroy

	If @tipo_doc = '1'
		Select dateadd(dd, (Select Dias_vencimiento From pv_generales), getdate()) as FechaVence
	Else
		Select getdate() as FechaVence


GO

/*******PROCEDIMIENTO QUE BUSCA UN TIPO DE PAGO********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_tipoPago'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_tipoPago]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--fecha creacion: 16/07/2015
--Autor: Erick Chali

  CREATE PROCEDURE [dbo].[stp_tipoPago]
  @codigoPago smallint = null,
  @descripcionPago varchar(50) = null
  
  AS

  if exists (Select codigo_pago, descripcion, es_credito FROM pv_tipos_pago where codigo_pago = @codigoPago and estado = 'A')
	  begin
	  Select codigo_pago, descripcion, es_credito FROM pv_tipos_pago where codigo_pago = @codigoPago and
																			estado = 'A'
	  end

  if exists (Select codigo_pago, descripcion, es_credito FROM pv_tipos_pago where descripcion = @descripcionPago and estado = 'A')
	  begin
		Select codigo_pago, descripcion, es_credito FROM pv_tipos_pago where descripcion = @descripcionPago and estado = 'A'
	  end


GO

/*******PROCEDIMIENTO QUE AUTORIZA DOCUMENTOS********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_Autorizacion'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_Autorizacion]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stp_Autorizacion]
@usuarioID int,
@opcion int

AS 
SET NOCOUNT ON

IF EXISTS(SELECT * FROM pv_usuarios_tipos where tipo_movimiento = @opcion and UserID = @usuarioID)
	BEGIN
	SELECT 1 AS Autorizado
	END
ELSE IF NOT EXISTS(SELECT * FROM pv_usuarios_tipos where tipo_movimiento = @opcion and UserID = @usuarioID)
	 BEGIN
	 SELECT 0 AS Autorizado
	 END
GO

/*******PROCEDIMIENTO QUE BUSCA LOS TIPOS DE PAGO PARA EL COMBO DE TIPO CREDITO********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_tiposPago'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_tiposPago]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****
fecha creacion: 14/07/2015
auto: Erick Chali

****/
CREATE PROCEDURE [dbo].[stp_tiposPago]

AS

SELECT * FROM cc_tipos_pago 
GO

/*******PROCEDIMIENTO QUE BUSCA LAS PROFESIONES********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_profesiones'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_profesiones]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--fecha de creacion: 11/07/2015
--Usuario: Erick Chali
CREATE PROCEDURE [dbo].[stp_profesiones]

AS

select * from gn_profesiones
GO

/*******PROCEDIMIENTO QUE BUSCA SEGMENTOS********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_segmentos'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
/****** Object:  StoredProcedure [dbo].[stp_segmentos]    Script Date: 8/4/2015 9:13:27 PM ******/
DROP PROCEDURE [dbo].[stp_segmentos]
GO

/****** Object:  StoredProcedure [dbo].[stp_segmentos]    Script Date: 8/4/2015 9:13:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Fecha Creacion: 11/07/2015
-- Usuario: Erick Chali

CREATE PROCEDURE [dbo].[stp_segmentos]

AS

select * from ve_segmentos_clientes
GO

/*******PROCEDIMIENTO QUE BUSCA DEPARTAMENTOS********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_proDepartamentos'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_proDepartamentos]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[stp_UDPV_proDepartamentos]
	@codigo_pais smallint
AS
Set nocount on
-- Fecha Creacion: 20-10-2007 Se quito el filtro por region
-- Fecha Creacion: 30-07-2007
-- Usuario: Ocoroy
-- ver 1.2.9
Select depto_id Codigo,descripcion Nombre
from gn_deptos_pais
where codigo_pais = @codigo_pais 
order by descripcion

GO

/*******PROCEDIMIENTO QUE BUSCA MUNICIPIOS********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_proMunicipios'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
/****** Object:  StoredProcedure [dbo].[stp_UDPV_proMunicipios]    Script Date: 8/4/2015 9:19:51 PM ******/
DROP PROCEDURE [dbo].[stp_UDPV_proMunicipios]
GO

/****** Object:  StoredProcedure [dbo].[stp_UDPV_proMunicipios]    Script Date: 8/4/2015 9:19:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stp_UDPV_proMunicipios]
	@codigo_pais smallint,
	--@codigo_region smallint,
	@codigo_depto smallint
AS
Set nocount on
-- Fecha Creacion: 30-07-2007
-- Usuario: Ocoroy
-- Fecha Modificacion: 12-07-2015
-- ver 1.2.9
Select muni_id Codigo,descripcion Nombre
from gn_municipios_pais
where codigo_pais = @codigo_pais and
	 codigo_depto = @codigo_depto


GO

/*******PROCEDIMIENTO QUE BUSCA PAISES********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_paises'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_paises]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[stp_paises]

AS

select * from gn_paises 
GO

/*******PROCEDIMIENTO QUE BUSCA REGIONES********/
IF EXISTS (SELECT sys.objects.name FROM sys.objects INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id WHERE sys.objects.name = 'stp_UDPV_proRegiones'  and sys.schemas.name = 'dbo'  and sys.objects.type = 'P') 
DROP PROCEDURE [dbo].[stp_UDPV_proRegiones]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[stp_UDPV_proRegiones]
	@codigo_pais smallint
AS
Set nocount on
-- Fecha Creacion: 30-07-2007
-- Usuario: Ocoroy
-- ver 1.2.9
Select region_id Codigo,descripcion Nombre
from gn_regiones
where codigo_pais = @codigo_pais

GO

