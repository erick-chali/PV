/**
 * 
 */

  (function($, window, document) {
	  
   $(function() {
	   /**EVENTOS*/
	   fechaActual();
	   cargarProfesiones();
	   cargarSegmentos();
	   cargarPaises();
	   
	   
	   
	   $('#pais').change(function(){
			 var opcion = $(this).find('option:selected');
			 var idPais = $(opcion).val();
			 cargarDepartamentos(idPais);
			 cargarRegiones(idPais)
	   });
	   
	   $('#departamento').change(function(){
			 var pais = $('#pais').find('option:selected');
			 var idPais = $(pais).val();
			 var depa = $('#departamento').find('option:selected');
			 var idDepa = $(depa).val();
			 cargarMunicipios(idPais,idDepa);
	   });
	   
	   $('#ingresaDC').click(function (){
		   alert($('#fechaNac').val());
		   ingresarDatosCliente(
				   $('#nit').val(),$('#nombreC').val(),$('#direcF').val(),$('#direcE').val(),$('#telefono').val(),
				   $('#fax').val(),$('#email').val(),$('#profesion').val(),$('#segmento').val(),$('#fechaNac').val(),
				   $('#observaciones').val(),$('#movil').val(),$('#region').val(),$('#departamento').val(),$('#municipio').val(),
				   $('#zona').val(),$('#cob').val()
		   );
	   });

	   
   });/**fin de document.ready*/

   /**FUNCIONES*/
   //fecha actual
   function fechaActual(){
	   	var d = new Date();
	    var month = d.getMonth()+1;
	    var day = d.getDate();
	    var fecha = 
	        ((''+day).length<2 ? '0' : '') + day + '/' +
	        ((''+month).length<2 ? '0' : '') + month + '/' +
	        d.getFullYear();
		$('#fecha').text(fecha);
		 
		
   }
   
   function cargarProfesiones(){
	   $.post('CargarCombos',{combo : 2} ,function(responseText) {
		   if(responseText!=null){
			   $('#profesion').html(responseText);
		   }
				   
	   });
   }
   
   function cargarSegmentos(){
	   $.post('CargarCombos',{combo:3},function(responseText) {
		   if(responseText!=null){
			   $('#segmento').html(responseText);
		   }
				   
	   });
   }
   
   function cargarPaises(){
	   $.post('CargarPais', function(responseText) {
		   if(responseText!=null){
			   $('#pais').html(responseText);
		   }
				   
	   });
   }
   
   function cargarDepartamentos(idP){
	   $.post('CargarDepartamento',{pais : idP} , function(responseText) {
		   if(responseText!=null){
			   $('#departamento').html(responseText);
		   }
				   
	   });
   }
   
   function cargarMunicipios(idP, idD){
	   $.post('CargarMunicipio',{pais : idP,departamento:idD} , function(responseText) {
		   if(responseText!=null){
			   $('#municipio').empty();
			   $('#municipio').html(responseText);
		   }
				   
	   });
   }
   
   function cargarRegiones(idP){
	   $.post('CargarRegion',{pais : idP} , function(responseText) {
		   if(responseText!=null){
			   $('#region').html(responseText);
		   }
				   
	   });
   }
   
   function ingresarDatosCliente(nit,nombre,dFactura,dEnvio,tel,fax,email,codProfesion,codSegmento,
		   						dob,observaciones,movil,codRegion,codDepartamento,codMunicipio,zona,cob
   								)
   {
	   $.post('IngresarDatosCliente',{
		   nit : nit, cliente : nombre, direcF : dFactura, direcE : dEnvio, telefono : tel,
		   fax : fax, email : email, codProf : codProfesion, codSeg : codSegmento, dob : dob, observaciones : observaciones,
		   movil : movil, region : codRegion, departamento : codDepartamento, municipio : codMunicipio, zona : zona,
		   colbar : cob
	   } , function(responseText) {
		   if(responseText!=null){
			   $('#notificacion').html(responseText);
		   }
				   
	   });
   }
  }(window.jQuery, window, document));