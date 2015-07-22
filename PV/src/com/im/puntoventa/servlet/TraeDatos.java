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
import com.im.puntoventa.dao.ImplementaTraerDatos;
import com.im.puntoventa.dao.InterfazTraerDatos;
import com.im.puntoventa.datos.TraerDatos;

/**
 * Servlet implementation class TraeDatos
 */
@WebServlet("/TraeDatos")
public class TraeDatos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TraeDatos() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.getSession().setAttribute("opcion", request.getParameter("opcion"));
		TraerDatos datos = null;
		InterfazTraerDatos inter = new ImplementaTraerDatos();
		datos = new TraerDatos();
		datos.setUsuarioID((String)request.getSession().getAttribute("usuarioID"));
		datos.setCodigoMovimiento((String)request.getParameter("codigo"));
		datos.setNoOpcion((String)request.getSession().getAttribute("opcion"));
		datos.setCodigoPago((String) request.getParameter("tipoPago"));
		
		if(request.getParameter("limite")==null || request.getParameter("limite").equals("")){
			datos.setLimiteCredito(0);
		}else if(request.getParameter("limite")!=null){
			datos.setLimiteCredito( (int)Double.parseDouble(((String) request.getParameter("limite"))));
		}
			
		
		datos = inter.traerDatos(datos);
		
		ArrayList<TraerDatos> data = null;
		data = new ArrayList<TraerDatos>();
		data = ImplementaTraerDatos.obtenerDatos();
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(data, new TypeToken<List<TraerDatos>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		datos = null;
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
	}

}
