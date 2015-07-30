
  (function($, window, document) {
	  
   $(function() {
	   var codigoP;
	   var subTotal = 0;
	   var Total;
//	   $('#indice').hide();
	   
	   $(document).keydown(function (e){
		   if(e.keyCode==115){
			   $('#buscarDocumentos').modal('toggle');
		   }else if(e.keyCode==17){
			   $('#buscarProductos').modal('toggle');
		   }else if(e.keyCode==121){
			   $('#buscarPagos').modal('toggle');
			   cargarTiposPago();
		   }
	   });
	   /**EVENTOS*/
	   fechaActual();
	   $('#fPago').focus();
	   $('#tDoc').keydown(function(e){
		   if(e.keyCode==13){
			   if($(this).val()==3 || $(this).val()==1){
				   $('#autorizar').modal('toggle');
			   }else if($(this).val()==2){
				   cargarDatosDoc(1,$(this).val());
			   }
			   
		   }
	   });
	   $('#fPago').keydown(function(e){
		   if(e.keyCode==13){
			   cargarDatosPago(3,$(this).val(),$('#lCredito').val());
		   }
	   });
	   
	   $('#nit').keydown(function(e){
		   if(e.keyCode==13){
			   cargarDatosNit($(this).val());
		   }
	   });
	   $(document).on('keydown', '#cantidad',function(e){
		   if(e.keyCode==13){
			   var indiceFila = $(this).parent().parent().index();
	   			$('#indice').text(indiceFila);
	   			codigoP = $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(0).children().val();
	   			$('#codigoProd').text(codigoP);
			   var $td= $(this).closest('tr').children('td').children('input');
			   var $td2= $(this).closest('tr').children('td').children('div').children('input');
			   var canti = parseInt($('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(3).children().val());
			   var disp = parseInt($('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(4).children().val());
			   if(canti > disp){
				   
		   			
		   			
		   			$('#botones').show();
		   			$('#escondido').hide();
		   			$('#buscarProductosBodegas').modal('toggle');
				  
			   }else{
				   var resultado;
				   if($(this).val()==''){
					   resultado = parseFloat(0).toFixed(2);
					   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(8).children().val(resultado);
					   
					   subTotal = parseFloat(subTotal+resultado).toFixed(2);
					   $('#subTotal').text('Subtotal: ' + subTotal);
					   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(6).children().focus();
					   
				   }else{
					   
					   resultado = parseFloat($('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(3).children().val()*
				   				$('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(5).children().children().eq(1).val()
					   ).toFixed(2);
					   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(8).children().val(resultado);
					   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(6).children().focus();
				   }
				   
			   }
		   }
		   
	   });
	   $('#siBodegas').click(function(){
		   $('#botones').hide();
		   $('#escondido').show();
	   });
	   $jq("input[id$='codigoProducto']").live('keydown',function(e){
		   	if(e.keyCode==13){
		   		if($.trim($('#fPago').val()) == ''){
		   			alert('Debe ingresar una forma de pago');
		   			$('#divFormaPago').addClass('has-error');
		   			$('#fPago').focus();
		   		}else{
		   			var indiceFila = $(this).parent().parent().index();
		   			$('#indice').text(indiceFila);
		   			var codigo = $(this).val();
			   		var lista = 1;
			   		var formaPago = separarTexto(0, $('#fPago').val());
			   		var $td= $(this).closest('tr').children('td').children('input');
			   		var $td2= $(this).closest('tr').children('td').children('div').children('input');
			   		$.post('TraerProducto',{codigo :codigo, lista : lista, formaPago : formaPago} ,function(responseJson){
			 		   if(responseJson!=null){
			 			   
			 			   $.each(responseJson, function(key, value) {
			 				   $td.eq(0).val(value['codigoProducto']);
			 				   $td.eq(1).val(value['medida']);
			 				   $td.eq(2).val(value['descripcionProducto']);
			 				   $td.eq(4).val(parseInt(value['disponible']));
			 				   $td2.eq(0).val(value['precioUnitario']);
			 				   $td.eq(10).val(value['descuentoMaximo']);
			 				   $td.eq(6).val(parseFloat(value['descuento']).toFixed(2));
			 				   $td.eq(7).val(parseFloat(value['importe']).toFixed(2));
			 				   $td.eq(8).val(value['codigoBodega']);
			 			    });
			 			  $td.eq(3).focus();
			 		   }
			 				   
			 	   });
		   		}
		   		
	   		}else if(e.keyCode==9){
	   			e.preventDefault();
	   			$('#filtroTextoProductos').val('');
	   			var indiceFila = $(this).parent().parent().index();
	   			$('#indice').text(indiceFila);
	   			
	   			//modificar la primera fila
//	   			$('table#datosVarios tbody tr:first td:first').children().val(indiceFila);
	   			$('#contenedorProductos').empty();
	   			$('#buscarProductos').modal('toggle');
	   		}
	   });
	   $('#autorizacion').click(function (e){
		   autorizarDocumento($('#tDoc').val());
	   });
	   
	   $('#agregarFila').click(function (e){
		   	 var filaNueva = $('<tr>'
		   		 
		   		 +'<td><input type="text" class="form-control input-sm" id="codigoProducto" ></td>'
		   		+'<td><input type="text" class="form-control input-sm" id="unidad" disabled></td>'
        		+'<td><input type="text" class="form-control input-sm" id="descripcion" ></td>'
        		+'<td><input type="text" class="form-control input-sm" id="cantidad"></td>'
        		+'<td><input type="text" class="form-control input-sm" id="disponible" ></td>'
        		+'<td><div class="input-group"><span class="input-group-addon">Q.</span><input type="text" class="form-control input-sm" id="precioUnitario" ></div></td>'
        		+'<td><input type="text" class="form-control input-sm" id="porcentaje"></td>'
        		+'<td><input type="text" class="form-control input-sm" id="descuento" ></td>'
        		+'<td><input type="text" class="form-control input-sm" id="importe" ></td>'
        		+'<td><input type="text" class="form-control input-sm" id="bodega"></td>'
        		+'<td><input type="checkbox"></td>'
        		+'<td><input type="text" class="form-control input-sm" id="descuentoMaximo" disabled></td>'
        		+'<td><input type="text" class="form-control input-sm" id="observaciones"></td>'
		   		 +'</tr>');
		   	 filaNueva.prependTo(('#datosVarios > tbody'));
           });
	   
	   $('#f4').click(function (e){
		   $('#buscarDocumentos').modal('toggle');
	   });
	   $('#f10').click(function (e){
		   $('#buscarPagos').modal('toggle');
		   cargarTiposPago();
	   });
	 //seleccionar el tipo de pago desde tabla en modal
	   $jq("table[id$='tablaPagos'] td:nth-child(1)").live('click',function(event) {  
				//Para evitar que el link actue.  
		   event.preventDefault();  
		   var $td= $(this).closest('tr').children('td');
		   $('#fPago').val($td.eq(0).text());
		   cargarDatosPago(3,$('#fPago').val(),'0.1');
		   $('#buscarPagos').modal('toggle');
	   });
	   //seleccionar producto
	   $jq("table[id$='tablaProductos'] td:nth-child(1)").live('click',function(event) {  
			//Para evitar que el link actue.  
		   event.preventDefault();  
		   var $td= $(this).closest('tr').children('td');
		   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(0).children().val($td.eq(0).text());
		   $('#buscarProductos').modal('toggle');
		   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(0).children().focus();
		   
	   });
	   
	   
	   //cargar productos por filtros
	   $('#filtroTextoProductos').keydown(function (e){
		   if(e.keyCode==13){
			   
			   $('#contenedorProductos').empty();
			   if($(this).val()==''){
				   alert('Debe ingresar algo para buscar');
			   }else{
				   cargarProductosFiltro($('#filtroComboProductos').val(),$('#filtroTextoProductos').val(),  separarTexto(0, $('#fPago').val()));
			   }
		   }
		   
		   
	   });	
	   $('#filtroTextoBodegas').keydown(function (e){
		   $('#contenedorProductosBodegas').empty();
		   if(e.keyCode==13){
			   if($(this).val()=='' || $('#filtroComboBodegas').val() == ''){
				   alert('Las busquedas requieren un filtro y una palabra a buscar.');
			   }else{
				   
				   cargarProductosFiltroBodegas($('#filtroComboBodegas').val(), $(this).val(), separarTexto(0, $('#fPago').val()), codigoP);
			   }
		   }
		   
	   });
	   //Seleccionar producto de Bodega alterna
	   
	   $jq("table[id$='tablaProductosBodega'] td:nth-child(1)").live('click',function(event) {  
			//Para evitar que el link actue.  
		   event.preventDefault();  
		   var $td= $(this).closest('tr').children('td');
		   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(4).children().val($td.eq(4).text());
		   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(9).children().val($td.eq(5).text());
		   
		   $('#buscarProductosBodegas').modal('toggle');
		   //enfocar cantidad
		   
		   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(3).children().val();
		   
		   //hacer la suma
		   var resultado;
		   resultado = parseFloat($('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(3).children().val()*
				   				$('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(5).children().children().eq(1).val()
		   ).toFixed(2);
		   
		   
		   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(8).children().val(resultado);
		   
		   subTotal = parseFloat(separarTexto(1, $('#subTotal').text())) + parseFloat($('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(8).children().val());
		   $('#subTotal').text('SubTotal: ' + parseFloat(subTotal).toFixed(2));
		   $('#datosVarios > tbody > tr').eq($('#indice').text()).children().eq(6).children().focus();
	   });
	   //grabar el Documento
	   $('#grabarDocumento').click(function(){
		   var numFilas = $('#datosVarios >tbody >tr').length;
		   $('#numFilas').text(numFilas);
		   $.post('IngresarEnc',{
			   codigoCliente : $('#codigoCliente').text(), nit : $('#nit').val(), nombreCliente : $('#nombre').val(),
			   direcFactura : $('#direcF').val(), tel : $('#telefono').val(), tarjeta : $('#tarjeta').val(),
			   direcEnvio : $('#direcE').val(), tipoDoc : separarTexto(0, $('#tDoc').val()), fechaVence : $('#fechaVencimiento').val(),
			   tipoPago : separarTexto(0, $('#fPago').val()), tipoCredito : $('#tCredito').val(), autoriza : "S",
			   fechaDoc : $('#fechaEntrega').val(), cargosEnvio : 0, otrosCargos: 0,
			   montoVenta: separarTexto(1, $('#subTotal').text()), montoTotal : separarTexto(1, $('#total').text()), tipoNota : 0,
			   caja : 0 , fechaEntrega : $('#fechaEntrega').val(), noConsigna : 0 , codMovDev : 0,
			   generaSolicitud : 'N', tipoPagoNC : 0 , tipoCliente : $('#tipoCliente').text(),
			   codigoNegocio : "", cantidadDevolver : 0, autorizoDespacho : "", 
			   saldo : $('#saldoCliente').text()
		   } ,function(responseText) {
			   if(responseText!=null){
				   $('#numDocumento').text(responseText);
			   }
					   
		   });
	   });
	   
   });/**fin de document.ready*/
   
   function obtenerImporteSinDescuento(){
	   
   }
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
 //fecha entrega
   function fechaEntrega(){
	   	var d = new Date();
	    var month = d.getMonth()+1;
	    var day = d.getDate()+1;
	    var fecha = 
	    	d.getFullYear() + '-' + 
	        ((''+month).length<2 ? '0' : '') + month + '-' +
	        ((''+day).length<2 ? '0' : '') + day;  
	        
		$('#fechaEntrega').val(fecha);
		
   }
   //FUNCION CARGAR COMBO TIPOS DE PAGO
   function cargarTiposPago(){
	   $.post('CargarCombos',{combo : 1} ,function(responseText) {
		   if(responseText!=null){
			   $('#tCredito').html(responseText);
		   }
				   
	   });
   }
   
   //funcion cargar datos usando Nit
   function cargarDatosNit(nit){
	   $.post('InformacionNit',{nit : nit} ,function(responseJson) {
		   if(responseJson!=null){
			   $.each(responseJson, function(key, value) {
					$('#nit').val(value['nit']);
					$('#nombre').val(value['nombreCliente']);
					$('#direcF').val(value['direccionF']);
					$('#direcE').val(value['direccionE']);
					$('#telefono').val(value['telefono']);
					$('#lCredito').val(value['limiteCredito']);
					$('#codigoCliente').text(value['codigoCliente']);
					$('#tipoCliente').text(value['tipoCliente']);
					$('#saldoCliente').text(value['saldo']);
			    });
			   fechaEntrega();
		   }
				   
	   });
   }
   //funcion cargar datos del tipo documento
   function cargarDatosDoc(opcion, codigoDocumento){
	   $.post('TraeDatos',{opcion : opcion,codigo : codigoDocumento} ,function(responseJson) {
		   
		   if(responseJson!=null){
			   $.each(responseJson, function(key, value) { 
					$('#tDoc').val(value['codigoMovimiento'] + ' ' + value['descripcionMovimiento']);
			    });
			   cargarFechaVencimiento(2, separarTexto(0, $('#tDoc').val()));
		   }
				   
	   });
   }
 //funcion cargar datos del tipo documento
   function cargarDatosPago(opcion, tipoPago, limiteCredito){
	   $.post('TraeDatos',{opcion : opcion,tipoPago : tipoPago,limite : limiteCredito} ,function(responseJson) {
		   if(responseJson!=null){
			   $.each(responseJson, function(key, value) { 
					$('#fPago').val(value['codigoPago'] + ' ' + value['descripcionPago']);
					$('#tCredito').val(value['esCredito']);
			    });
			   $('#codigoProducto').focus();
		   }
				   
	   });
   }
  
   //cargar fecha
   function cargarFechaVencimiento(opcion, noDoc){
	   $.post('TraeDatos',{opcion : opcion , codigo : noDoc} ,function(responseJson) {
		   if(responseJson!=null){
			   $.each(responseJson, function(key, value) {
					$('#fechaVencimiento').val(separarTexto(0,value['fechaVencimiento']));
			    });
		   }
				   
	   });
   }
   
 //Autorizar tipo documento
   function autorizarDocumento(noDoc){
	   $.post('Autorizaciones',{opcion : noDoc} ,function(responseText) {
		   if(responseText!=null){
			   if(parseInt(responseText)==1){
				   cargarDatosDoc(1, noDoc);
				   $('#autorizar').modal('toggle');
			   }else{
				   ('#notificacion').text(responseText);
			   }
		   }
				   
	   });
   }
   function separarTexto(posicion, texto){
	   var cadena = texto;
	   var particiones = cadena.split(' ');
	    
	   return particiones[posicion];
   }
   function obtenerCodigo(codigo){
	   var codigoProducto = codigo;
	   return codigoProducto;
   }
   function cargarTiposPago(){

	   $('#contenedorPagos').empty();
	   $.post('CargaTiposPago', function(responseJson) {
			   if(responseJson!=null){
				   var contenedor = $("#contenedorPagos");
				   var tabla = $("<table id='tablaPagos' class='table table-striped table-bordered table-condensed'></table>");
			       var thead = $("<thead></thead>");
			       var tbody = $("<tbody></tbody>");
			       var encabezado = $("<tr> <th></th> <th></th> </tr>");
			       encabezado.children().eq(0).text("Codigo Pago");
			       encabezado.children().eq(1).text("Descripcion");
			       
			       encabezado.appendTo(thead);
			       tabla.appendTo(contenedor);
			       
			       thead.appendTo(tabla);
			       tbody.appendTo(tabla);
			       $.each(responseJson, function(key,value) {
			            var rowNew = $("<tr> <td><a href='#'></a></td> <td></td> </tr>");
			               rowNew.children().children().eq(0).text(value['codigo']);
			               rowNew.children().eq(1).text(value['descripcion']);
			               rowNew.appendTo($('table#tablaPagos tbody'));
			       });
			       $('#tablaPagos').dataTable( {
			    	   "scrollY" : 200,
			    	   "scrollX" : true,
				        "language": {
				            "url": "//cdn.datatables.net/plug-ins/1.10.7/i18n/Spanish.json"   	
				        }
			       	
				    });
			       }
			   });
   }
   function cargarProductosFiltro(seleccion, texto, codigoPago){
	   $('#contenedorProductos').empty();
	   $.post('FiltrosProducto',{seleccion : seleccion, criterio : texto, codigoPago : codigoPago}, function(responseJson){
		   if(responseJson!=null){
			   var contenedor = $("#contenedorProductos");
			   var tabla = $("<table id='tablaProductos' class='table table-striped table-bordered table-condensed table-hover'></table>");
		       var thead = $("<thead></thead>");
		       var tbody = $("<tbody></tbody>");
		       var encabezado = $("<tr> <th></th> <th></th> <th></th> <th></th> <th></th> <th></th> <th></th>  <th></th> <th></th> <th></th> <th></th> </tr>");
		       encabezado.children().eq(0).text("Código");
		       encabezado.children().eq(1).text("Descripcion");
		       encabezado.children().eq(2).text("Marca");
		       encabezado.children().eq(3).text("Precio U");
		       encabezado.children().eq(4).text("Disponible");
		       encabezado.children().eq(5).text("Bodega");
		       encabezado.children().eq(6).text("Back Order");
		       encabezado.children().eq(7).text("Fecha Espera");
		       encabezado.children().eq(8).text('Tránsito');
		       encabezado.children().eq(9).text("Familia");
		       encabezado.children().eq(10).text("referencia");
		       encabezado.appendTo(thead);
		       tabla.appendTo(contenedor);
		       thead.appendTo(tabla);
		       tbody.appendTo(tabla);
		       $.each(responseJson, function(key,value) {
		            var rowNew = $("<tr> <td><a href='#'></a></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>");
		               rowNew.children().children().eq(0).text(value['codigoProducto']);
		               rowNew.children().eq(1).text(value['descripcionProducto']);
		               rowNew.children().eq(2).text(value['marcaProducto']);
		               rowNew.children().eq(3).text(value['precioProducto']);
		               rowNew.children().eq(4).text(parseInt(value['disponible']));
		               rowNew.children().eq(5).text(value['bodegaProducto']);
		               rowNew.children().eq(6).text(parseInt(value['backOrder']));
		               rowNew.children().eq(7).text(value['fechaespera']);
		               rowNew.children().eq(8).text(value['transito']);
		               rowNew.children().eq(9).text(value['familiaProducto']);
		               rowNew.children().eq(10).text(value['referenciaProducto']);
		               rowNew.appendTo($('table#tablaProductos tbody'));
		       });
		       $("#tablaProductos").dataTable( {
		    	   "columnDefs": [
			                       { "width": "200%", "targets": 1 }
			                     ],
		    	   "scrollY" : 200,
		    	   "scrollX" : true,
			        "language": {
			            "url": "//cdn.datatables.net/plug-ins/1.10.7/i18n/Spanish.json"   	
			        }
			        
			    });
		       }
	   });
   }
   
   function cargarProductosFiltroBodegas(seleccion, texto, codigoPago, codigoProducto){
	   $('#contenedorProductosBodegas').empty();
	   $.post('ProdOtrasBod',{seleccion : seleccion, criterio : texto, codigoPago : codigoPago, codigoProducto : codigoProducto}, function(responseJson){
		   
		   if(responseJson!=null){
			   var contenedor = $("#contenedorProductosBodegas");
			   var tabla = $("<table id='tablaProductosBodega' class='table table-striped table-bordered table-condensed table-hover'></table>");
		       var thead = $("<thead></thead>");
		       var tbody = $("<tbody></tbody>");
		       var encabezado = $("<tr> <th></th> <th></th> <th></th> <th></th> <th></th> <th></th> <th></th>  <th></th> <th></th> <th></th> <th></th> </tr>");
		       encabezado.children().eq(0).text("Codigo");
		       encabezado.children().eq(1).text("Descripcion");
		       encabezado.children().eq(2).text("Marca");
		       encabezado.children().eq(3).text("Precio U");
		       encabezado.children().eq(4).text("Disponible");
		       encabezado.children().eq(5).text("Bodega");
		       encabezado.children().eq(6).text("Back Order");
		       encabezado.children().eq(7).text("Fecha Espera");
		       encabezado.children().eq(8).text('Transito');
		       encabezado.children().eq(9).text("Familia");
		       encabezado.children().eq(10).text("referencia");
		       encabezado.appendTo(thead);
		       tabla.appendTo(contenedor);
		       thead.appendTo(tabla);
		       tbody.appendTo(tabla);
		       $.each(responseJson, function(key,value) {
		            var rowNew = $("<tr> <td><a href='#'></a></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> <td></td> </tr>");
		               rowNew.children().children().eq(0).text(value['codigoProducto']);
		               rowNew.children().eq(1).text(value['descripcionProducto']);
		               rowNew.children().eq(2).text(value['marcaProducto']);
		               rowNew.children().eq(3).text(value['precioProducto']);
		               rowNew.children().eq(4).text(parseInt(value['disponible']));
		               rowNew.children().eq(5).text(value['bodegaProducto']);
		               rowNew.children().eq(6).text(parseInt(value['backOrder']));
		               rowNew.children().eq(7).text(value['fechaespera']);
		               rowNew.children().eq(8).text(value['transito']);
		               rowNew.children().eq(9).text(value['familiaProducto']);
		               rowNew.children().eq(10).text(value['referenciaProducto']);
		               rowNew.appendTo($('table#tablaProductosBodega tbody'));
		       });
		       $("#tablaProductosBodega").dataTable( {
		    	   "columnDefs": [
			                       { "width": "200%", "targets": 1 }
			                     ],
		    	   "scrollY" : 200,
		    	   "scrollX" : true,
			        "language": {
			            "url": "//cdn.datatables.net/plug-ins/1.10.7/i18n/Spanish.json"   	
			        }
			        
			    });
		       }
	   });
   }
   function cargarEncabezado(){}
  }(window.jQuery, window, document));