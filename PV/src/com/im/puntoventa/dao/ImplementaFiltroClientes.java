package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosFiltroClientes;

public class ImplementaFiltroClientes implements InterfazFiltroClientes{
	
	@Override
	public DatosFiltroClientes guardarParametros(DatosFiltroClientes datos) {
		
		// TODO Auto-generated method stub
		return null;
	}
	
	public static ArrayList<DatosFiltroClientes> obtenerClientes(String nit, String nombre, int opcion){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		DatosFiltroClientes datos = null;
		ArrayList<DatosFiltroClientes> lista = new ArrayList<DatosFiltroClientes>();
		
		if(opcion ==1){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Clientes_FilterNomb(?)}");
				stmt.setString(1, nombre);
				rs = stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosFiltroClientes();
					datos.setNit(rs.getString("Nit"));
					datos.setNombre(rs.getString("Nombre"));
					datos.setTarjeta(rs.getString("Tarjeta"));
					lista.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			}catch(SQLException e){
				System.out.println("Error: " + e.getMessage());
			}
		}else if(opcion ==2){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Clientes_FilterNit(?)}");
				stmt.setString(1, nit);
				rs = stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosFiltroClientes();
					datos.setNit(rs.getString("Nit"));
					datos.setNombre(rs.getString("Nombre"));
					datos.setTarjeta(rs.getString("Tarjeta"));
					lista.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			}catch(SQLException e){
				System.out.println("Error: " + e.getMessage());
			}
		}
		
		
		
		return lista;
	}

}
