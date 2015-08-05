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
import com.im.puntoventa.dao.ImplementaFiltroClientes;
import com.im.puntoventa.datos.DatosFiltroClientes;

/**
 * Servlet implementation class FiltroClientes
 */
@WebServlet("/FiltroClientes")
public class FiltroClientes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FiltroClientes() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nit="", nombre="";
		request.getSession().setAttribute("opcion", request.getParameter("opcion"));
		
		int op = Integer.parseInt((String) request.getSession().getAttribute("opcion"));
		
		if(op==1){
			request.getSession().setAttribute("nombre", request.getParameter("criterio"));
			nombre = (String)request.getSession().getAttribute("nombre");
			nit ="";
		}else if(op==2){
			request.getSession().setAttribute("nit", request.getParameter("criterio"));
			nit = (String)request.getSession().getAttribute("nit");
			nombre = "";
		}
		
		ArrayList<DatosFiltroClientes> listado = null;
		listado = new ArrayList<DatosFiltroClientes>();
		listado = ImplementaFiltroClientes.obtenerClientes(nit, nombre, op);
		
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(listado, new TypeToken<List<DatosFiltroClientes>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
	}

}
