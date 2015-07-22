package com.im.puntoventa.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;
import com.im.puntoventa.dao.ImplementaDatosProducto;
import com.im.puntoventa.dao.InterfazDatosProducto;
import com.im.puntoventa.datos.DatosProducto;

/**
 * Servlet implementation class TreaerProucto
 */
@WebServlet("/TraerProducto")
public class TraerProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TraerProducto() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DatosProducto datos = null;
		InterfazDatosProducto interfaz = new ImplementaDatosProducto();
		
		request.getSession().setAttribute("codigoProducto", request.getParameter("codigo"));
		request.getSession().setAttribute("lista", request.getParameter("lista"));
		request.getSession().setAttribute("formaPago", request.getParameter("formaPago"));
		
		datos = new DatosProducto();
		datos.setCodigoProducto((String)request.getSession().getAttribute("codigoProducto"));
		datos.setCodigoLista((String)request.getSession().getAttribute("lista") );
		datos.setCodigoBodega((String)request.getSession().getAttribute("codigoBodegaLocal"));
		datos.setFormaPago((String)request.getSession().getAttribute("formaPago"));
		
		datos = interfaz.obtenerDatos(datos);
		ArrayList<DatosProducto> listado = null;
		listado = new ArrayList<DatosProducto>();
		listado = ImplementaDatosProducto.obtenerInformacion();
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(listado, new TypeToken<List<DatosProducto>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		datos = null;
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
		
		
	}

}
