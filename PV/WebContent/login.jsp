
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" lang="es">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inicio de Sesi&oacute;n</title>
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    </head>
    
    <body>
    <script type="text/javascript">
    (function($, window, document) {
     $(function() {
    	 $('.notificacion').hide();
    	 $('#usuario').focus();
    	 if($('.notificacion').text()!=''){
    		 $('.notificacion').show();
     	}
     });

    }(window.jQuery, window, document));
    </script>
    <center><img alt="Instalaciones Modernas" src="img/s.jpg" align="middle" id="logo"></center>
    
    
    <div class="container">
    	
      <form action="Login" class="form-signin" method="post" id="formLogin" onsubmit="validarFormulario">
      	
        <h2 class="form-signin-heading text-center">Inicio de sesi&oacute;n</h2>
        <label for="ingresaUsuario" class="sr-only">Usuario</label>
        <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Usuario" required>
        <label for="inputPassword" class="sr-only">Clave</label>
        <input type="password" id="clave" name="clave" class="form-control" placeholder="Clave" required>
        
        <div class="alert alert-danger notificacion" role="alert">${msjSesion}</div>
        <input class="btn btn-lg btn-primary btn-block" id="btnInicia" name="btnInicia" type="submit" value="Iniciar Sesi&oacute;n">
<!--        <button class="btn btn-lg btn-primary btn-block" type="submit">Iniciar Sesi�n</button>-->
      </form>
      
    </div>
   
  </body>
</html>