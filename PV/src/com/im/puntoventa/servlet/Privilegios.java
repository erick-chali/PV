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
 * Servlet implementation class Privilegios
 */
@WebServlet("/Privilegios")
public class Privilegios extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Privilegios() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String user,pass,op,mensaje="";
		int permiso = 0;
		request.getSession().setAttribute("usuario", request.getParameter("usuario"));
		request.getSession().setAttribute("pass", request.getParameter("pass"));
		request.getSession().setAttribute("operacion", request.getParameter("operacion"));
		user = (String) request.getSession().getAttribute("usuario");
		pass = (String) request.getSession().getAttribute("pass");
		op = (String) request.getSession().getAttribute("operacion");
		
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		response.setContentType("text/html");
		PrintWriter dato = response.getWriter();
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call Stp_UdPv_ValClaves(?,?,?)}");
			stmt.setString(1, user);
			stmt.setString(2, pass);
			stmt.setString(3, op);
			
			rs = stmt.executeQuery();
			
			while (rs.next()){
				permiso = rs.getInt(1);
			}
			con.close();
			stmt.close();
			rs.close();
			
		}catch(SQLException	e){
			mensaje = "Error: " + e.getMessage();
		}
		if(permiso==1 || permiso  ==0){
			dato.println(permiso);
		}else{
			dato.println(mensaje);
		}
	}

}
