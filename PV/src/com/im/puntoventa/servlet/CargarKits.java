package com.im.puntoventa.servlet;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.im.puntoventa.conexion.ConectarDB;

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
		request.getSession().setAttribute("codigoProducto", request.getParameter("producto"));
		request.getSession().setAttribute("serie", request.getParameter("serie"));
		request.getSession().setAttribute("numero", request.getParameter("numero"));
		
		lista = (String)request.getSession().getAttribute("codigoLista");
		pago = (String)request.getSession().getAttribute("codigoPago");
		producto = (String)request.getSession().getAttribute("codigoProducto");
		serie = (String)request.getSession().getAttribute("serie");
		numero = (String)request.getSession().getAttribute("numero");
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("call stp_UDPV_LookUp_UnidadesXProductoPago(?,?,?,?,?)");
			stmt.setInt(1, 0);
			stmt.setString(2, "");
			stmt.setString(3, lista);
			stmt.setString(4, producto);
			stmt.setString(5, pago);
			rs = stmt.executeQuery();
			while(rs.next()){
				request.getSession().setAttribute("medida", rs.getString("unidad_medida"));
			}
			
		}catch(SQLException e){}
		medida = (String)request.getSession().getAttribute("codigoLista");
	}

}
