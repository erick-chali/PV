<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>PUNTO VENTA</title>
        
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css">
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
            <li><a href="pv.jsp">Punto venta</a></li>
            <li class="active"><a href="datoscliente.jsp">Ingreso Datos Cliente</a></li>
            <li><a href="">Cambio Tipo Cliente</a></li>
            <li><a href="">Cambio Vendedor</a></li>
            
          </ul>
          <ul class="nav navbar-nav navbar-right">
          	<li></li>
            <li><a href="Logout"><span class="glyphicon glyphicon-off" aria-hidden="true"></span> Cerrar Sesi&oacute;n</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
    
    <div class="panel panel-default" id="cotizacion">
    	<div class="panel-body">
    	<form>
       		<div class="row">
           		<div class="col-md-6">
               		<h6>Nombre Cliente</h6>
               		<input type="text" class="form-control input-sm" placeholder="Nombre Cliente" id="nombreC">
               		
               		<h6>Direccion Factura</h6>
               		<input type="text" class="form-control input-sm" placeholder="Direccion Factura" id="direcF">
               		
               		<h6>Direccion Envio</h6>
               		<input type="text" class="form-control input-sm" placeholder="Direccion Envio" id="direcE">
                   	
                   	<div class="col-md-6">
                   	<h6>Zona</h6>
               		<input type="text" class="form-control input-sm" placeholder="Zona" id="zona">
                   	</div>
                   	<div class="col-md-6">
                   	<h6>Colonia/Barrio</h6>
               		<input type="text" class="form-control input-sm" placeholder="Colonia/Barrio" id="cob">
                   	</div>
                   	
                   	<h6>Profesi&oacute;n</h6>
               		<select class="form-control input-sm" id="profesion"></select>
               		
               		<h6>Segmento</h6>
               		<select class="form-control input-sm" id="segmento"></select>
               		
               		<h6>Observaciones</h6>
               		<input type="text" class="form-control input-sm" placeholder="Observaciones" id="observaciones">
               		
               		<h6>Pa&iacute;s</h6>
               		<select class="form-control input-sm" id="pais"></select>
               		
               		<h6>Departamento</h6>
               		<select class="form-control input-sm" id="departamento"></select>
               		
               		<h6>Municipio</h6>
               		<select class="form-control input-sm" id="municipio"></select>
               		
               	</div>
                <div class="col-md-6">
					<h6>NIT</h6>
                    <input type="number" class="form-control input-sm" placeholder="NIT" id="nit">
                    
                    <h6>Fecha de Nacimiento</h6>
                    <input type="date" class="form-control input-sm" placeholder="dd/mm/aaaa" id="fechaNac" >
                    
                    <h6>Tel&eacute;fono</h6>
                    <input type="tel" class="form-control input-sm" placeholder="Telefono" id="telefono">
                    
                    <h6>Fax</h6>
                    <input type="tel" class="form-control input-sm" placeholder="Fax" id="fax">
                    
                    <h6>e-mail</h6>
                    <input type="email" class="form-control input-sm" placeholder="sucorreo@dominio.com" id="mail">
                    
                    <h6>M&oacute;vil</h6>
                    <input type="tel" class="form-control input-sm" placeholder="Movil" id="movil">
                    
                    <h6>Regi&oacute;n</h6>
                    <select class="form-control input-sm" id="region"></select>
                    
                    <button type="button" class="btn btn-primary btn-md" id="ingresaDC">
  						<span class="glyphicon glyphicon-save" aria-hidden="true"></span> Guardar
					</button>
              	</div>
           	</div><!--fin de fila-->
           	</form>
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
        
    <script type="text/javascript" src="js/jquery-1.5.min.js"></script>
	<script type="text/javascript">
		var $jq = jQuery.noConflict();
	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/scriptDatosCliente.js"></script>
    </body>
</html>