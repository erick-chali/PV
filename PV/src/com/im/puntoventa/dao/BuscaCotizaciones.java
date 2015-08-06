package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosCotizaciones;

public class BuscaCotizaciones {
	
	public static ArrayList<DatosCotizaciones> obtenerCotizaciones(int sucursal, String criterio, int op){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		DatosCotizaciones datos = null;
		ArrayList<DatosCotizaciones> lista = new ArrayList<>();
		if(op==0){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Cotizaciones(?)}");
				stmt.setInt(1, sucursal);
				rs = stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosCotizaciones();
					datos.setNoCotizacion(rs.getString("no_cotizacion"));
					datos.setNombre(rs.getString("Nombre"));
					datos.setNit(rs.getString("Nit"));
					datos.setFecha(rs.getString("Fecha"));
					datos.setMonto(rs.getString("Monto"));
					datos.setAutorizacion(rs.getString("Autorizacion"));
					datos.setfAutorizacion(rs.getString("FAutorizo"));
					lista.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			}catch(SQLException e){
				datos = new DatosCotizaciones();
				datos.setMensaje("Error: " + e.getMessage());
				System.out.println(datos.getMensaje());
			}
		}else if(op==1){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Cotis_FilterNomb(?,?)}");
				stmt.setInt(1, sucursal);
				stmt.setString(2, criterio);
				rs = stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosCotizaciones();
					datos.setNoCotizacion(rs.getString("no_cotizacion"));
					datos.setNombre(rs.getString("Nombre"));
					datos.setNit(rs.getString("Nit"));
					datos.setfAutorizacion(rs.getString("Fecha"));
					datos.setMonto(rs.getString("Monto"));
					datos.setAutorizacion(rs.getString("Autorizacion"));
					datos.setfAutorizacion(rs.getString("FAutorizo"));
					lista.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			}catch(SQLException e){
				datos = new DatosCotizaciones();
				datos.setMensaje("Error: " + e.getMessage());
				System.out.println(datos.getMensaje());
			}
		}else if(op==2){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Cotis_FilterNIT(?,?)}");
				stmt.setInt(1, sucursal);
				stmt.setString(2, criterio);
				rs = stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosCotizaciones();
					datos.setNoCotizacion(rs.getString("no_cotizacion"));
					datos.setNombre(rs.getString("Nombre"));
					datos.setNit(rs.getString("Nit"));
					datos.setfAutorizacion(rs.getString("Fecha"));
					datos.setMonto(rs.getString("Monto"));
					datos.setAutorizacion(rs.getString("Autorizacion"));
					datos.setfAutorizacion(rs.getString("FAutorizo"));
					lista.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			}catch(SQLException e){
				datos = new DatosCotizaciones();
				datos.setMensaje("Error: " + e.getMessage());
				System.out.println(datos.getMensaje());
			}
		}
		
		
		return lista;
	}
}
