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
import com.im.puntoventa.dao.ImplementaFiltrosProductos;
import com.im.puntoventa.dao.InterfazFiltrosProductos;
import com.im.puntoventa.datos.DatosFiltroProductos;

/**
 * Servlet implementation class FiltrosProducto
 */
@WebServlet("/FiltrosProducto")
public class FiltrosProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FiltrosProducto() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DatosFiltroProductos datos = null;
		InterfazFiltrosProductos interfaz = new ImplementaFiltrosProductos();
		
		request.getSession().setAttribute("seleccion", request.getParameter("seleccion"));
		request.getSession().setAttribute("codigoPago", request.getParameter("codigoPago"));
		request.getSession().setAttribute("criterio", request.getParameter("criterio"));
		
		datos = new DatosFiltroProductos();
		datos.setLista("1");
		datos.setCodigoBodegaLocal((String) request.getSession().getAttribute("codigoBodegaLocal"));
		datos.setCodigoPago((String) request.getSession().getAttribute("codigoPago"));
		if(Integer.parseInt( (String)request.getSession().getAttribute("seleccion"))==1){
			datos.setBuscaReferencia((String) request.getSession().getAttribute("criterio"));
		}else if(Integer.parseInt( (String)request.getSession().getAttribute("seleccion"))==2){
			datos.setBuscaDescripcion((String) request.getSession().getAttribute("criterio"));
		}else if(Integer.parseInt( (String)request.getSession().getAttribute("seleccion"))==3){
			datos.setBuscaMarca((String) request.getSession().getAttribute("criterio"));
		}else if(Integer.parseInt( (String)request.getSession().getAttribute("seleccion"))==4){
			datos.setBuscaFamilia((String) request.getSession().getAttribute("criterio"));
		}
		datos = interfaz.obtenerParametros(datos);
		
		ArrayList<DatosFiltroProductos> listado = null;
		listado = new ArrayList<DatosFiltroProductos>();
		listado = ImplementaFiltrosProductos.obtenerProductos();
		
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(listado, new TypeToken<List<DatosFiltroProductos>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		datos = null;
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
		
		
	}

}
