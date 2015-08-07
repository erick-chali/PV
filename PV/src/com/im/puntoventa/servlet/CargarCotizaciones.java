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
import com.im.puntoventa.dao.BuscaCotizaciones;
import com.im.puntoventa.datos.DatosCotizaciones;

/**
 * Servlet implementation class CargarCotizaciones
 */
@WebServlet("/CargarCotizaciones")
public class CargarCotizaciones extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CargarCotizaciones() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int sucursal = 0;
		int op=0;
		String criterio = null;
		request.getSession().setAttribute("opcion", request.getParameter("opcion"));
		request.getSession().setAttribute("criterio", request.getParameter("criterio"));
		sucursal = Integer.parseInt((String) request.getSession().getAttribute("codSucursal"));
		criterio = (String) request.getSession().getAttribute("criterio");
		if((String)request.getSession().getAttribute("opcion")!=null){
			op = Integer.parseInt((String)request.getSession().getAttribute("opcion"));
		}
		
		ArrayList<DatosCotizaciones> listado = null;
		listado = new ArrayList<DatosCotizaciones>();
		listado = BuscaCotizaciones.obtenerCotizaciones(sucursal,criterio, op);
		
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(listado, new TypeToken<List<DatosCotizaciones>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
	}

}
