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
import com.im.puntoventa.dao.ImplementaDatosNit;
import com.im.puntoventa.dao.InterfazDatosNit;
import com.im.puntoventa.datos.DatosNit;

/**
 * Servlet implementation class InformacionNit
 */
@WebServlet("/InformacionNit")
public class InformacionNit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InformacionNit() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DatosNit datos = null;
		InterfazDatosNit inter = new ImplementaDatosNit();
		request.getSession().setAttribute("nit", (String) request.getParameter("nit"));
		datos = new DatosNit();
		datos.setNit((String)request.getSession().getAttribute("nit"));
		datos = inter.obtenerDatos(datos);
		
		
		
		ArrayList<DatosNit> data = null;
		data = new ArrayList<DatosNit>();
		data = ImplementaDatosNit.obtenerInformacion();
		
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(data, new TypeToken<List<DatosNit>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		
		response.setContentType("application/json");
		
		datos = null;
		response.getWriter().print(arreglo);
		
	}

}
