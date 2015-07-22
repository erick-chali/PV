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
import com.im.puntoventa.dao.ImplementaTiposPago;
import com.im.puntoventa.dao.InterfazTiposPago;
import com.im.puntoventa.datos.TiposPago;

/**
 * Servlet implementation class CargaTiposPago
 */
@WebServlet("/CargaTiposPago")
public class CargaTiposPago extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CargaTiposPago() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		TiposPago datos = null;
		InterfazTiposPago interfaz = new ImplementaTiposPago();
		
		datos = new TiposPago();
		datos.setLimiteCredito("0.1");
		
		datos = interfaz.obtenerPagos(datos);
		
		ArrayList<TiposPago> listado = null;
		listado = new ArrayList<TiposPago>();
		listado = ImplementaTiposPago.traerPagos();
		
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(listado, new TypeToken<List<TiposPago>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		datos = null;
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
	}

}
