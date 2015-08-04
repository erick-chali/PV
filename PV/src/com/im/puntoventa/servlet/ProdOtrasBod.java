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
import com.im.puntoventa.dao.ImplementaProdOtrasBod;
import com.im.puntoventa.dao.InterfazProdOtrasBod;
import com.im.puntoventa.datos.DatosProdOtrasBod;

/**
 * Servlet implementation class ProdOtrasBod
 */
@WebServlet("/ProdOtrasBod")
public class ProdOtrasBod extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProdOtrasBod() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DatosProdOtrasBod datos = null;
		InterfazProdOtrasBod interfaz = new ImplementaProdOtrasBod();
		
		request.getSession().setAttribute("seleccion", request.getParameter("seleccion"));
		request.getSession().setAttribute("codigoPago", request.getParameter("codigoPago"));
		request.getSession().setAttribute("criterio", request.getParameter("criterio"));
		request.getSession().setAttribute("codigoProducto", request.getParameter("codigoProducto"));
		request.getSession().setAttribute("codigoLista", request.getParameter("codigoLista"));
		datos = new DatosProdOtrasBod();
		datos.setLista("1");
		datos.setTipoPago((String) request.getSession().getAttribute("codigoPago"));
		datos.setCodigoProducto((String) request.getSession().getAttribute("codigoProducto"));
		datos.setBuscaDescripcion((String) request.getSession().getAttribute("criterio"));
		
		
		datos = interfaz.parametros(datos);
		
		ArrayList<DatosProdOtrasBod> listado = null;
		listado = new ArrayList<DatosProdOtrasBod>();
		listado = ImplementaProdOtrasBod.obtenerBodegas();
		
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(listado, new TypeToken<List<DatosProdOtrasBod>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		datos = null;
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
	}

}
