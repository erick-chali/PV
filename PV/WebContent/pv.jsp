<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" lang="es">
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
                        <div class="col-sm-4 col-md-4">
                                <h6>Forma de Pago</h6>
                            <div class="input-group" id="divFormaPago">
                                <input type="text" class="form-control input-sm" placeholder="Forma Pago" id="fPago">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="f1">F1</button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <h6>Tipo Credito</h6>
                            <select class="form-control input-sm" id="tCredito" disabled> 
                            	<option value="">Tipos de cr&eacute;dito</option>
                            	<option value="1">credito</option>
                            	<option value="2">contado</option>
                            </select> 
                        </div>
                        <div class="col-sm-4 col-md-4">
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
                    		<div id="toolbar">
                    			<button type="button" id="agregarFila" class="btn btn-primary btn-sm" style="margin-bottom: 10px;">
                    			<span class="glyphicon glyphicon-plus" aria-hidden="true" ></span>
                    			</button>
                    			<label id="indice"></label>
                    			<label id="codigoCliente"></label>
                    			<label id="codigoProd"></label>
                    			<label id="numFilas"></label>
                    			<label id="numDocumento"></label>
                    			<label id="saldoCliente"></label>
                    			<label id="tipoCliente"></label>
                    			<label id="mensaje"></label>
                    			<label id="codigoLista">1</label>
                    			<label id="fechaPrueba"></label>
                    		</div>
                    	<div class="table-responsive" id="contenedorDatosVarios">
                    		
                    		
                    	<table id="datosVarios" class="table table-striped table-bordered table-hover">
	                    <thead>
	                    	<tr style="background-color: #0088CC; color: #ffffff;">
	                    		
	                    		<th style="width: 100px;">Producto</th>
	                    		<th style="width: 75px;">U M</th>
	                    		<th style="width: 150px;">Descripcion</th>
	                    		<th style="width: 50px;">Cantidad</th>
	                    		<th style="width: 50px;">Disponible</th>
	                    		<th style="width: 75px;">Precio Unitario</th>
	                    		<th style="width: 75px;">%</th>
	                    		<th style="width: 75px;">Descuento</th>
	                    		<th style="width: 75px;">Importe</th>
	                    		<th style="width: 75px;">Bodega</th>
	                    		<th style="width: 50px;">Env&iacute;o</th>
	                    		<th style="width: 75px;">DM</th>
	                    		<th style="width: 100px;">Observaciones</th>
	                    		<th class="datosOcultos">Es Kit</th>
	                    		
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
	                    		<td id="1"><input type="text" class="form-control input-sm" id="codigoProducto" ></td>
	                    		<td id="2"><input type="text" class="form-control input-sm" id="unidad" disabled></td>
	                    		<td id="3"><input type="text" class="form-control input-sm" id="descripcion" ></td>
	                    		<td id="4"><input type="text" class="form-control input-sm" id="cantidad"></td>
	                    		<td id="5"><input type="text" class="form-control input-sm" id="disponible" ></td>
	                    		<td id="6"><input type="text" class="form-control input-sm" id="precioUnitario" ></td>
	                    		<td id="7"><input type="text" class="form-control input-sm" id="porcentaje"></td>
	                    		<td id="8"><input type="text" class="form-control input-sm" id="descuento" disabled></td>
	                    		<td id="9"><input type="text" class="form-control input-sm" id="importe" disabled></td>
	                    		<td id="10"><input type="text" class="form-control input-sm" id="bodega"></td>
	                    		<td id="11"><input type="checkbox" id="envia"></td>
	                    		<td id="12"><input type="text" class="form-control input-sm" id="descuentoMaximo" disabled></td>
	                    		<td id="13"><input type="text" class="form-control input-sm" id="observaciones"></td>
	                    		<td id="esKit" class="datosOcultos"></td>
	                    	</tr>
	                    </tbody>
                    </table>
                    	</div>
                    	<h5 class="text-right" id="subTotal">SubTotal: 0.00</h5>
                    	<h5 class="text-right" id="total">Total: 0.00</h5>
                    	<button type="button" class="btn btn-primary btn-sm" id="grabarDocumento">
  							<span class="glyphicon glyphicon-save" aria-hidden="true" ></span> Grabar
						</button>
						
                    </div>
                    
                    
                    <div class="well well-sm">
                    	
                    	<div class="row">
                        <div class="col-sm-3 col-md-3">
                        		
	                    	<h6>Tipo Documento</h6>
		                    	<div class="input-group">
		                        	<input type="text" class="form-control input-sm" placeholder="Tipo Documento" id="tDoc">
		                           	<span class="input-group-btn">
		                            	<button class="btn btn-primary btn-sm" type="button" id="f2">F2</button>
		                           	</span>
		                        </div><!-- /input-group -->
                        </div>
                        <div class="col-sm-3 col-md-3">
                            <h6>No. Documento</h6>
                            <div class="input-group">
                                <input type="text" class="form-control input-sm" placeholder="No. Documento" id="nDoc">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="f3">F3</button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        <div class="col-sm-3 col-md-3">
                        	<h6>Fecha Vencimiento</h6>
                           	<input type="text" class="form-control input-sm" id="fechaVencimiento" disabled>
                        </div>
                        
                    </div><!--fin de fila-->
                    
                    
                    	<div class="row">
                        <div class="col-sm-3 col-md-3">
                            <h6>Nit</h6>
<!--                            <label for="nit">NIT</label>-->
                            <div class="input-group">
                                <input type="text" class="form-control input-sm" placeholder="NIT" id="nit">
                                <span class="input-group-btn">
                                    <button class="btn btn-primary btn-sm" type="button" id="f4">F4</button>
                                </span>
                            </div><!-- /input-group -->
                        </div>
                        <div class="col-sm-3 col-md-3">
<!--                            <label for="nombre">Nombre Cliente</label>-->
                            <h6>Nombre Cliente</h6>
                            <input type="text" class="form-control input-sm" id="nombre" placeholder="Nombre Cliente" disabled>     
                        </div>
                        <div class="col-sm-6 col-md-6">
<!--                            <label for="direcF">Dirección Factura</label>-->
                            <h6>Dirección Factura</h6>
                            <input class="form-control input-sm" type="text" id="direcF" placeholder="Dirección Factura">
                        </div>
                    </div><!--fin de fila-->
                    
                    <div class="row" style="margin-top: 5px">
                        <div class="col-sm-2 col-md-2">
<!--                            <label for="telefono">Teléfono</label>-->
                            <h6>Teléfono</h6>
                            <input type="tel" class="form-control input sm" id="telefono" placeholder="Teléfono">
                        </div>
                        <div class="col-sm-2 col-md-2">
                            <h6>Tarjeta</h6>
<!--                            <label for="tarjeta">Tarjeta</label>-->
                            <input type="text" class="form-control input-sm" id="tarjeta" placeholder="Tarjeta" >     
                        </div>
                        <div class="col-sm-2 col-md-2">
                            <h6>Fecha Entrega</h6>
                            <input type="text" class="form-control input-sm" id="fechaEntrega" disabled>
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <h6>Dirección Envío</h6>
<!--                            <label for="direcE">Dirección Envío</label>-->
                            <input class="form-control input-sm" type="text" id="direcE" placeholder="Dirección Envío">
                        </div>
                    </div><!--fin de fila-->
                    </div>
                    
                    <div class="row">
                        <div class="col-sm-3 col-md-3 text-center">
                        	<h5 id="fecha"></h5>
                        </div>
                        <div class="col-sm-3 col-md-3 text-center">
                            <h5>${sucursal}</h5>
                        </div>
                        <div class="col-sm-3 col-md-3 text-center">
                            <h5>${usuario}</h5>  
                        </div>
                        <div class="col-sm-3 col-md-3 text-center">
                            <h5>${vendedor}</h5>    
                        </div>
                    </div><!--fin de fila-->
                </div>
        </div><!-- FIN PANEL COTIZACION -->
        
        
        
        	
        
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
		<div id="buscarDocumentos" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="true" tabindex="-1">
		  <div class="modal-dialog modal-lg">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		      	<button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Busqueda de Documentos</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="col-md-6" style="margin-bottom: 10px;">
		      		<select id="filtroComboDocumentos" class="form-control input-sm">
		      		<option value="">Seleccione Filtro</option>
		      		<option value="1">Nombre</option>
		      		<option value="2">NIT</option>
		      		</select>
		      	</div>
		      	<div class="col-md-6" style="margin-bottom: 10px;">
		      		<input type="text" class="form-control input-sm col-md-6" id="filtroTextoDocumentos">
		      	</div>
		      	<div id="contenedorCotizaciones">
		      		
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
		
		
		<!-- Modal BUSQUEDA Clientes -->
		<div id="buscarClientes" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="true" tabindex="-1">
		  <div class="modal-dialog modal-lg">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		      	<button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">Busqueda de Clientes</h4>
		      </div>
		      <div class="modal-body">
		      	<div class="col-md-6" style="margin-bottom: 10px;">
		      		<select id="filtroComboClientes" class="form-control input-sm">
		      		<option value="">Seleccione Filtro</option>
		      		<option value="1">Nombre</option>
		      		<option value="2">Nit</option>
		      		<option value="3">Tarjeta</option>
		      		</select>
		      	</div>
		      	<div class="col-md-6" style="margin-bottom: 10px;">
		      		<input type="text" class="form-control input-sm col-md-6" id="filtroTextoClientes">
		      	</div>
		      	<div id="contenedorClientes">
		      		 
		      	</div>
		        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="margin-top: 10px;" id="cancelar">Cancelar</button>
		      </div>
		      <div class="modal-footer">
		      	<p id="notificacion" class="text-danger"></p>
		      </div>
		    </div>
		  </div>
		</div><!-- FIN DE MODAL -->
		
		
		<!-- Modal BUSQUEDA Clientes -->
		<div id="detallesKit" class="modal" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="true" tabindex="-1">
		  <div class="modal-dialog modal-lg">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		      	<button type="button" class="close visible-sm visible-xs" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title" id="tituloModalKit"></h4>
		      </div>
		      <div class="modal-body">
		      	
		      	<div id="contenedorKits">
		      		 
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