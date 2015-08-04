package com.im.puntoventa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.im.puntoventa.dao.ImplementaDatosDet;
import com.im.puntoventa.dao.InterfazDatosDet;
import com.im.puntoventa.datos.DatosDet;

/**
 * Servlet implementation class IngresarDet
 */
@WebServlet("/IngresarDet")
public class IngresarDet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IngresarDet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DatosDet datos = null;
		InterfazDatosDet interfaz = new ImplementaDatosDet();
		
		request.getSession().setAttribute("tipoDoc", request.getParameter("tipoDocumento"));
		request.getSession().setAttribute("serieDoc", request.getParameter("serieDocumento"));
		request.getSession().setAttribute("numeroDocumento", request.getParameter("numeroDocumento"));
		request.getSession().setAttribute("numCorrelativo", request.getParameter("numCorrelativo"));
		request.getSession().setAttribute("codigoProducto", request.getParameter("codigoProducto"));
		request.getSession().setAttribute("UMedida", request.getParameter("UMedida"));
		request.getSession().setAttribute("cantidad", request.getParameter("cantidad"));
		request.getSession().setAttribute("precio", request.getParameter("precio"));
		request.getSession().setAttribute("porDescuento", request.getParameter("porDescuento"));
		request.getSession().setAttribute("descuento", request.getParameter("descuento"));
		request.getSession().setAttribute("total", request.getParameter("total"));
		request.getSession().setAttribute("codigoCliente", request.getParameter("codigoCliente"));
		request.getSession().setAttribute("promo", request.getParameter("promo"));
		request.getSession().setAttribute("bodega", request.getParameter("bodega"));
		request.getSession().setAttribute("envio", request.getParameter("envio"));
		request.getSession().setAttribute("observaciones", request.getParameter("observaciones"));
		request.getSession().setAttribute("lista", request.getParameter("lista"));
		request.getSession().setAttribute("pago", request.getParameter("pago"));
		request.getSession().setAttribute("kit", request.getParameter("kit"));
		request.getSession().setAttribute("corrKit", request.getParameter("corrKit"));
		request.getSession().setAttribute("codPromo", request.getParameter("codPromo"));
		request.getSession().setAttribute("serieDevProy", request.getParameter("serieDevProy"));
		request.getSession().setAttribute("numDevProy", request.getParameter("numDevProy"));
		request.getSession().setAttribute("ordenCompra", request.getParameter("ordenCompra"));
		
		datos = new DatosDet();
		datos.setTipoDoc((String)request.getSession().getAttribute("tipoDoc"));
		datos.setSerieDoc((String)request.getSession().getAttribute("serieDoc"));
		datos.setNoDoc((String)request.getSession().getAttribute("numeroDocumento"));
		datos.setCorrelativo((String)request.getSession().getAttribute("numCorrelativo"));
		datos.setCodigoProducto((String)request.getSession().getAttribute("codigoProducto"));
		datos.setuMedida((String)request.getSession().getAttribute("UMedida"));
		datos.setCantidad((String)request.getSession().getAttribute("cantidad"));
		datos.setPrecio((String)request.getSession().getAttribute("precio"));
		datos.setPorDescuento((String)request.getSession().getAttribute("porDescuento"));
		datos.setDescuento((String)request.getSession().getAttribute("descuento"));
		datos.setTotal((String)request.getSession().getAttribute("total"));
		datos.setCodigoCliente((String)request.getSession().getAttribute("codigoCliente"));
		datos.setPromo((String)request.getSession().getAttribute("promo"));
		datos.setBodega((String)request.getSession().getAttribute("bodega"));
		datos.setEnvia((String)request.getSession().getAttribute("envio"));
		datos.setObservaciones((String)request.getSession().getAttribute("observaciones"));
		datos.setLista((String)request.getSession().getAttribute("lista"));
		datos.setPago((String)request.getSession().getAttribute("pago"));
		datos.setKit((String)request.getSession().getAttribute("kit"));
		datos.setCorrKit((String)request.getSession().getAttribute("corrKit"));
		datos.setCodPromo((String)request.getSession().getAttribute("codPromo"));
		datos.setSerieDevProy((String)request.getSession().getAttribute("serieDevProy"));
		datos.setNumeroDevProy((String)request.getSession().getAttribute("numDevProy"));
		datos.setOrdenCompra((String)request.getSession().getAttribute("ordenCompra"));
		
		datos  = interfaz.obtenerDatos(datos);
		
		if(datos.getMensaje()!=null){
			response.setContentType("text/html");
			PrintWriter resp = response.getWriter();
			resp.println(datos.getMensaje());
		}
	}

}
