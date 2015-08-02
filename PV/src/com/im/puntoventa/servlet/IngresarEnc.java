package com.im.puntoventa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.im.puntoventa.dao.ImplementaDatosEnc;
import com.im.puntoventa.dao.InterfazDatosEnc;
import com.im.puntoventa.datos.DatosEnc;

/**
 * Servlet implementation class IngresarEnc
 */
@WebServlet("/IngresarEnc")
public class IngresarEnc extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IngresarEnc() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DatosEnc datos = null;
		InterfazDatosEnc interfaz = new ImplementaDatosEnc();
		
		datos = new DatosEnc();
		datos.setCodigoCliente(request.getParameter("codigoCliente"));
		datos.setNit(request.getParameter("nit"));
		datos.setNombreCliente(request.getParameter("nombreCliente"));
		datos.setDirecFactura(request.getParameter("direcFactura"));
		datos.setTel(request.getParameter("tel"));
		datos.setTarjeta(request.getParameter("tarjeta"));
		datos.setDirecEnvio(request.getParameter("direcEnvio"));
		datos.setCodigoVendedor((String) request.getSession().getAttribute("codigoVendedor"));
		datos.setUsername((String) request.getSession().getAttribute("usuario"));
		datos.setTipoDocumento(request.getParameter("tipoDoc"));
		datos.setFechaVence(request.getParameter("fechaVence"));
		datos.setTipoPago(request.getParameter("tipoPago"));
		datos.setTipoCredito(request.getParameter("tipoCredito"));
		datos.setAutoriza(request.getParameter("autoriza"));
		datos.setFechaDocumento(request.getParameter("fechaEntrega"));
		datos.setCargosEnvio(request.getParameter("cargosEnvio"));
		datos.setOtrosCargos(request.getParameter("otrosCargos"));
		datos.setMontoVenta(request.getParameter("montoVenta"));
		datos.setMontoTotal(request.getParameter("montoTotal"));
		datos.setObservaciones(request.getParameter("observaciones"));
		datos.setTipoNota(request.getParameter("tipoNota"));
		datos.setCaja(request.getParameter("caja"));
		datos.setFechaEntrega(request.getParameter("fechaEntrega"));
		datos.setNoConsigna(request.getParameter("noConsigna"));
		datos.setCodMovDev(request.getParameter("codMovDev"));
		datos.setGeneraSolicitud(request.getParameter("generaSolicitud"));
		datos.setTipoPagoNC(request.getParameter("tipoPagoNC"));
		datos.setTipoCliente(request.getParameter("tipoCliente"));
		datos.setCodigoNegocio(request.getParameter("codigoNegocio"));
		datos.setCantidadDevolver(request.getParameter("cantidadDevolver"));
		datos.setAutorizoDespacho(request.getParameter("autorizaDespacho"));
		datos.setSaldo(request.getParameter("saldo"));
		
		datos = interfaz.obtenerDatos(datos);
		
		if(datos.getNoEnc()!=null){
			response.setContentType("text/html");
			PrintWriter resp = response.getWriter();
			resp.println(datos.getNoEnc());
		}
	}

}
