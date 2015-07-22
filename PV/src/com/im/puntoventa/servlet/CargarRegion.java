package com.im.puntoventa.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class CargarRegion
 */
@WebServlet("/CargarRegion")
public class CargarRegion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CargarRegion() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getSession().setAttribute("codPais", request.getParameter("pais"));
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		response.setContentType("text/html");
		PrintWriter respuesta = response.getWriter();
		
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_proRegiones(?)}");
			stmt.setString(1, (String) request.getSession().getAttribute("codPais"));
			rs = stmt.executeQuery();
			
			while(rs.next()){
				respuesta.println("<option value='"+rs.getString("Codigo")+"'>"+rs.getString("Nombre")+"</option>");
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e){
			System.out.println("Error: " + e.getMessage());
		}
	}

}
