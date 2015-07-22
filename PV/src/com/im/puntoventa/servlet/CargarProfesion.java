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
 * Servlet implementation class CargarProfesion
 */
@WebServlet("/CargarProfesion")
public class CargarProfesion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CargarProfesion() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		response.setContentType("text/html");
		PrintWriter respuesta = response.getWriter();
		respuesta.println("<option value=''>Seleccione Profesion</option>");
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_profesiones}");
			rs = stmt.executeQuery();
			
			while(rs.next()){
				respuesta.println("<option value='"+rs.getString("codigo_profesion")+"'>"+rs.getString("nombre_profesion")+"</option>");
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e){
			System.out.println("Error: " + e.getMessage());
		}
	}

}
