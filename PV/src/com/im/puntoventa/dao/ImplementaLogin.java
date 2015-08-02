package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosLogin;

public class ImplementaLogin implements InterLogin{

	@Override
	public DatosLogin validaUsuario(DatosLogin datos) {
		// TODO Auto-generated method stub
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		DatosLogin datosUsuario = null;
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_Get_LoginParams(?,?,?)}");
			stmt.setString(1, datos.getUsuario());
			stmt.setString(2, datos.getClave());
			stmt.setString(3, "factura");
			rs = stmt.executeQuery();
			
			
				while(rs.next()){
					if(rs.getString("ReadOK").equals("1")){
					datosUsuario = new DatosLogin();
					datosUsuario.setCodSucursal(rs.getString("Codigo_Sucursal"));
					datosUsuario.setSucursal(rs.getString("Sucursal"));
					datosUsuario.setUsuarioID(rs.getString("UserID"));
					datosUsuario.setNombre(rs.getString("Vendedor"));
					datosUsuario.setCodigoVendedor(rs.getString("Codigo_Vendedor"));
					datosUsuario.setRespuesta(1);
					}
					else{
						datosUsuario = new DatosLogin();
						datosUsuario.setRespuesta(0);
						datosUsuario.setNotificacion("Usuario o clave incorrectos");
					}
					
				}
				con.close();
				stmt.close();
				rs.close();
			
			
			
		}catch(SQLException e){
			System.out.println("Error: " + e.getMessage());
		}
		return datosUsuario;
	}
	
	
}
