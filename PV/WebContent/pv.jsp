<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="charset=ISO-8859-1" lang="es">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>PUNTO VENTA</title>
        
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="//cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.css">
        <link type="text/css" rel="stylesheet" href="css/style.css">
        
    </head>
    <body>
    <!-- Fixed navbar -->
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="pv.jsp">Punto venta</a></li>
            <li><a href="datoscliente.jsp">Ingreso Datos Cliente</a></li>
            <li><a href="">Cambio Tipo Cliente</a></li>
            <li><a href="">Cambio Vendedor</a></li>
            
          </ul>
          <ul class="nav navbar-nav navbar-right">
          	<li></li>
            <li><a href="Logout"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Cerrar Sesion</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
    
        <div class="panel panel-default">
                <div class="panel-body">
                    
                    <div class="well well-sm">
                    	
                    	<div class="row">
                        <div class="col-md-4">
                                <h6>Forma de Pago</h6>
                            <div class="input-group" id="divFormaPago">
                                <input type="text" class="form-control input-sm" placeholder="Forma Pago" id="fPago">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="f10">F10</button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        <div class="col-md-4">
                            <h6>Tipo Credito</h6>
                            <select class="form-control input-sm" id="tCredito" disabled> 
                            	<option value="">Tipos de cr&eacute;dito</option>
                            	<option value="1">credito</option>
                            	<option value="2">contado</option>
                            </select> 
                        </div>
                        <div class="col-md-4">
                            <h6>Limite Credito</h6>
                            <div class="input-group">
                            	<span class="input-group-addon">Q.</span>
                                <input type="text" class="form-control input-sm" placeholder="Limite de Cr&eacute;dito" id="lCredito" disabled>
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="exp">
                                    	<span class="glyphicon glyphicon-export" aria-hidden="true"></span>
                                    </button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        
                    </div><!--fin de fila-->
                    	
                    	
                    
                    </div>
                    
                    
                    <div class="well well-sm">
                    	<div class="table-responsive" id="contenedorDatosVarios">
                    		<div id="toolbar">
                    			<button type="button" id="agregarFila" class="btn btn-primary btn-sm" style="margin-bottom: 10px;">
                    			<span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>
                    			</button>
                    			<label id="indice"></label>
                    		</div>
                    		
                    	<table id="datosVarios" data-toggle="table" data-url="false" data-toolbar="#toolbar" class="table table-striped table-bordered">
	                    <thead>
	                    	<tr>
	                    		
	                    		<th data-field="producto" class="col-md-1">Producto</th>
	                    		<th data-field="unidad">Unidad Medida</th>
	                    		<th data-field="descripcion" class="col-md-2">Descripcion</th>
	                    		<th data-field="cantidad" class="col-md-2">Cantidad</th>
	                    		<th data-field="disponible" class="col-md-2">Disponible</th>
	                    		<th data-field="precio" class="col-md-3">Precio Unitario</th>
	                    		<th data-field="porcentaje" class="col-md-1">%</th>
	                    		<th data-field="descuento">Descuento</th>
	                    		<th data-field="importe">Importe</th>
	                    		<th data-field="bodega">Bodega</th>
	                    		<th data-field="envio">Env&iacute;o</th>
	                    		<th data-field="dm" class="col-md-1">DM</th>
	                    		<th data-field="observaciones">Observaciones</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
	                    		
	                    		<td><input type="text" class="form-control input-sm" id="codigoProducto" ></td>
	                    		<td><input type="text" class="form-control input-sm" id="unidad" disabled></td>
	                    		<td><input type="text" class="form-control input-sm" id="descripcion" ></td>
	                    		<td><input type="text" class="form-control input-sm" id="cantidad"></td>
	                    		<td><input type="text" class="form-control input-sm" id="disponible" ></td>
	                    		<td><div class="input-group"><span class="input-group-addon">Q.</span><input type="text" class="form-control input-sm" id="precioUnitario" ></div></td>
	                    		<td><input type="text" class="form-control input-sm" id="porcentaje"></td>
	                    		<td><input type="text" class="form-control input-sm" id="descuento" ></td>
	                    		<td><input type="text" class="form-control input-sm" id="importe" ></td>
	                    		<td><input type="text" class="form-control input-sm" id="bodega"></td>
	                    		<td><input type="checkbox"></td>
	                    		<td><input type="text" class="form-control input-sm" id="descuentoMaximo" disabled></td>
	                    		<td><input type="text" class="form-control input-sm" id="observaciones"></td>
	                    	</tr>
	                    </tbody>
                    </table>
                    	</div>
                    	
                    </div>
                    
                    
                    <div class="well well-sm">
                    	
                    	<div class="row">
                        <div class="col-md-4">
                                <h6>Tipo Documento</h6>
                            <div class="input-group">
                                <input type="text" class="form-control input-sm" placeholder="Tipo Documento" id="tDoc">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="f9">F9</button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        <div class="col-md-4">
                            <h6>No. Documento</h6>
                            <div class="input-group">
                                <input type="text" class="form-control input-sm" placeholder="No. Documento" id="nDoc">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="f4">F4</button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        <div class="col-md-4">
                            <h6>Fecha Vencimiento</h6>
                            <input type="text" class="form-control input-sm" id="fechaVencimiento" disabled>
                        </div>
                        
                    </div><!--fin de fila-->
                    
                    
                    	<div class="row">
                        <div class="col-md-3">
                            <h6>Nit</h6>
<!--                            <label for="nit">NIT</label>-->
                            <div class="input-group">
                                <input type="text" class="form-control input-sm" placeholder="NIT" id="nit">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="f3">F3</button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        <div class="col-md-3">
<!--                            <label for="nombre">Nombre Cliente</label>-->
                            <h6>Nombre Cliente</h6>
                            <input type="text" class="form-control input-sm" id="nombre" placeholder="Nombre Cliente" disabled>     
                        </div>
                        <div class="col-md-6">
<!--                            <label for="direcF">Dirección Factura</label>-->
                            <h6>Dirección Factura</h6>
                            <input class="form-control input-sm" type="text" id="direcF" placeholder="Dirección Factura">
                        </div>
                    </div><!--fin de fila-->
                    
                    <div class="row" style="margin-top: 5px">
                        <div class="col-md-2">
<!--                            <label for="telefono">Teléfono</label>-->
                            <h6>Teléfono</h6>
                            <input type="tel" class="form-control input sm" id="telefono" placeholder="Teléfono">
                        </div>
                        <div class="col-md-2">
                            <h6>Tarjeta</h6>
<!--                            <label for="tarjeta">Tarjeta</label>-->
                            <input type="text" class="form-control input-sm" id="tarjeta" placeholder="Tarjeta" >     
                        </div>
                        <div class="col-md-2">
                            <h6>Fecha Entrega</h6>
                            <input type="text" class="form-control inputsm" id="fechaEntrega" disabled>
                        </div>
                        <div class="col-md-6">
                            <h6>Dirección Envío</h6>
<!--                            <label for="direcE">Dirección Envío</label>-->
                            <input class="form-control input-sm" type="text" id="direcE" placeholder="Dirección Envío">
                        </div>
                    </div><!--fin de fila-->
                    </div>
                    
                </div>
        </div><!-- FIN PANEL COTIZACION -->
        
        
        
        	<div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-3 text-center">
                        	<h5 id="fecha"></h5>
                        </div>
                        <div class="col-md-3 text-center">
                            <h5>${sucursal}</h5>
                        </div>
                        <div class="col-md-3 text-center">
                            <h5>${usuario}</h5>  
                        </div>
                        <div class="col-md-3 text-center">
                            <h5>${vendedor}</h5>    
                        </div>
                    </div><!--fin de fila-->
                    
                    
                </div>
        </div><!-- FIN PANEL PIE PAGINA -->
        
        <!-- Modal -->
		<div id="autorizar" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Autorizar Documento</h4>
		      </div>
		      <div class="modal-body">
		      	<label for="popUser">Usuario</label>
		        <input type="text" class="form-control input-sm" id="popUser">
		        <label for="popPass">Contrase&ntilde;a</label>
		        <input type="password" class="form-control input-sm" id="popPass">
		        <button type="button" class="btn btn-primary btn-sm" style="margin-top: 10px;" id="autorizacion">Autorizar</button>
		        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="margin-top: 10px;" id="cancelar">Cancelar</button>
		      </div>
		      <div class="modal-footer">
		      	<p id="notificacion" class="text-danger"></p>
		      </div>
		    </div>
		
		  </div>
		</div><!-- FIN DE MODAL -->
		
		<!-- Modal BUSQUEDA DOCUMENTOS -->
		<div id="buscarDocumentos" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
		  <div class="modal-dialog">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		      	<button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Busqueda de Documentos</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="col-md-6">
		      		<select id="filtroCombo" class="form-control input-sm">
		      		<option value="">Seleccione Filtro</option>
		      		<option value="1">Nombre</option>
		      		<option value="2">NIT</option>
		      		</select>
		      	</div>
		      	<div class="col-md-6">
		      		<input type="text" class="form-control input-sm col-md-6" id="filtroTexto">
		      	</div>
		      	<div id="contenedorTablaFiltro">
		      		<table id="filtroTabla"  data-toggle="table" data-classes="table table-hover table-condensed" data-striped="true" data-row-style="rowStyle" data-search="true" data-pagination="false" data-show-columns="true">
		      			<thead>
		      				<tr>
			      				<th data-sortable="true" >No.</th>
								<th data-sortable="true" >Nombre</th>
								<th data-sortable="true">Nit</th>
								<th data-sortable="true">Fecha</th>
								<th data-sortable="true">Monto</th>
								<th data-sortable="true">Autorizaci&oacute;n</th>
								<th data-sortable="true">Fecha Autorizaci&oacute;n</th>
		      				</tr>
		      			</thead>
		      			<tbody>
		      				
		      			</tbody>
		      		</table>
		      	</div>
		        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="margin-top: 10px;" id="cancelar">Cancelar</button>
		      </div>
		      <div class="modal-footer">
		      	<p id="notificacion" class="text-danger"></p>
		      </div>
		    </div>
		  </div>
		</div><!-- FIN DE MODAL -->
		
		<!-- Modal BUSQUEDA PRODUCTOS -->
		<div id="buscarProductos" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="true" tabindex="-1">
		  <div class="modal-dialog modal-lg">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		      	<button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Busqueda de Productos</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="col-md-6" style="margin-bottom: 10px;">
		      		<select id="filtroComboProductos" class="form-control input-sm">
		      		<option value="">Seleccione Filtro</option>
		      		<option value="1">Referencia</option>
		      		<option value="2">Descripci&oacute;n</option>
		      		<option value="3">Marca</option>
		      		<option value="4">Familia</option>
		      		</select>
		      	</div>
		      	<div class="col-md-6" style="margin-bottom: 10px;">
		      		<input type="text" class="form-control input-sm col-md-6" id="filtroTextoProductos">
		      	</div>
		      	<div id="contenedorProductos">
		      		 
		      	</div>
		        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="margin-top: 10px;" id="cancelar">Cancelar</button>
		      </div>
		      <div class="modal-footer">
		      	<p id="notificacion" class="text-danger"></p>
		      </div>
		    </div>
		  </div>
		</div><!-- FIN DE MODAL -->
		
		<!-- Modal BUSQUEDA PRODUCTOS OTRAS BODEGAS -->
		<div id="buscarProductosBodegas" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="true" tabindex="-1">
		  <div class="modal-dialog modal-lg">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		      	<button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Busqueda de Productos en Otras Bodegas</h4>
		      </div>
		      <div class="modal-body">
		      	<div id="botones">
		      		<label>La cantidad de producto excede al monto disponible, Desea buscar en otra bodega?</label>
		      		<button type="button" class="btn btn-primary btn-sm" style="margin-top: 10px;" id="siBodegas">Si</button>
		      		<button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="margin-top: 10px;" id="noBodegas">No</button>
		      	</div>
		      	<div id="escondido">
		      		<div class="col-md-6" style="margin-bottom: 10px;">
			      		<select id="filtroComboBodegas" class="form-control input-sm">
			      		<option value="">Seleccione Filtro</option>
			      		<option value="1">Referencia</option>
			      		<option value="2">Descripci&oacute;n</option>
			      		<option value="3">Marca</option>
			      		<option value="4">Familia</option>
			      		</select>
		      		</div>
			      	<div class="col-md-6" style="margin-bottom: 10px;">
			      		<input type="text" class="form-control input-sm col-md-6" id="filtroTextoBodegas">
			      	</div>
			      	<div id="contenedorProductosBodegas">
			      		 
			      	</div>
		        	<button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="margin-top: 10px;" id="cancelar">Cancelar</button>
		      	</div>
		      	
		      	
		      </div>
		      <div class="modal-footer">
		      	<p id="notificacion" class="text-danger"></p>
		      </div>
		    </div>
		  </div>
		</div><!-- FIN DE MODAL -->
		
		<!-- Modal BUSQUEDA PAGOS -->
		<div id="buscarPagos" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" tabindex="-1">
		  <div class="modal-dialog modal-lg">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		      	<button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Busqueda de Pagos</h4>
		      </div>
		      <div class="modal-body">
		      	<div id="contenedorPagos">
		      		
		      	</div>
		        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="margin-top: 10px;" id="cancelar">Cancelar</button>
		      </div>
		      <div class="modal-footer">
		      	<p id="notificacion" class="text-danger"></p>
		      </div>
		    </div>
		  </div>
		</div><!-- FIN DE MODAL -->
		
		
    <script type="text/javascript" src="js/jquery-1.5.min.js"></script>
	<script type="text/javascript">
		var $jq = jQuery.noConflict();
	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/script.js"></script>
	<script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
	<script src="//cdn.datatables.net/plug-ins/1.10.7/integration/bootstrap/3/dataTables.bootstrap.js"></script>
	
    
    
    </body>
</html>