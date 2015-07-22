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
 * Servlet implementation class Autorizaciones
 */
@WebServlet("/Autorizaciones")
public class Autorizaciones extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Autorizaciones() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		
		request.getSession().setAttribute("opcion", request.getParameter("opcion"));
		response.setContentType("text/html");
		PrintWriter dato = response.getWriter();
		int respuesta = 0;
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_Autorizacion(?,?)}");
			stmt.setInt(1, Integer.parseInt((String) request.getSession().getAttribute("usuarioID")));
			stmt.setInt(2, Integer.parseInt((String)request.getSession().getAttribute("opcion")));
			rs = stmt.executeQuery();
			
			while(rs.next()){
				respuesta = rs.getInt("Autorizado");
			}
		}catch(SQLException e){
			System.out.println("Error: " + e.getMessage());
		}
		if(respuesta==1){
			dato.println(respuesta);
		}else{
			dato.println("Usuario ingresado no tiene autorizacion");
		}
	}

}
