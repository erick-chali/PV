package com.im.puntoventa.servlet;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.dao.Kit;
import com.im.puntoventa.datos.DatosKit;

/**
 * Servlet implementation class CargarKits
 */
@WebServlet("/CargarKits")
public class CargarKits extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CargarKits() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String lista, medida, pago, producto, serie, numero, bodega;
		request.getSession().setAttribute("codigoLista", request.getParameter("lista"));
		request.getSession().setAttribute("codigoPago", request.getParameter("pago"));
		request.getSession().setAttribute("codigoProducto", request.getParameter("codigoProducto"));
		request.getSession().setAttribute("serie", request.getParameter("serie"));
		request.getSession().setAttribute("numero", request.getParameter("numero"));
		request.getSession().setAttribute("bodega", request.getParameter("bodega"));
		lista = (String)request.getSession().getAttribute("codigoLista");
		System.out.println("Lista: " + lista);
		pago = (String)request.getSession().getAttribute("codigoPago");
		System.out.println("Pago: " + pago);
		producto = (String)request.getSession().getAttribute("codigoProducto");
		System.out.println("Producto: " + producto);
		serie = (String)request.getSession().getAttribute("serie");
		System.out.println("Serie: " + serie);
		numero = (String)request.getSession().getAttribute("numero");
		System.out.println("Numero: " + numero);
		bodega = (String)request.getSession().getAttribute("bodega");
		System.out.println("Bodega: " + bodega);
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_LookUp_UnidadesXProductoPago(?,?,?,?,?)}");
			stmt.setInt(1, 0);
			stmt.setString(2, "");
			stmt.setString(3, lista);
			stmt.setString(4, producto);
			stmt.setString(5, pago);
			rs = stmt.executeQuery();
			while(rs.next()){
				request.getSession().setAttribute("medida", rs.getString("unidad_medida"));
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e){}
		medida = (String)request.getSession().getAttribute("medida");
		System.out.println("Medida: " + medida);
		
		ArrayList<DatosKit> listado = null;
		listado = new ArrayList<DatosKit>();
		listado = Kit.obtenerDetalles(lista, medida, pago, producto, bodega, serie, numero);
		
		Gson gson = new Gson();
		JsonElement elemento = gson.toJsonTree(listado, new TypeToken<List<DatosKit>>(){}.getType());
		JsonArray arreglo = elemento.getAsJsonArray();
		response.setContentType("application/json");
		
		response.getWriter().print(arreglo);
	}

}
