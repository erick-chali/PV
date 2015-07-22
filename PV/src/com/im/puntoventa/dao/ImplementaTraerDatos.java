package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.TraerDatos;

public class ImplementaTraerDatos implements InterfazTraerDatos{
	static String codMov, usuarioID, codPago;
	static int op, limite;
	@Override
	public TraerDatos traerDatos(TraerDatos datos) {
		// TODO Auto-generated method stub
		codMov = datos.getCodigoMovimiento();
		usuarioID = datos.getUsuarioID();
		op = Integer.parseInt(datos.getNoOpcion());
		codPago = datos.getCodigoPago();
		limite = datos.getLimiteCredito();
		
		return null;
	}
	
	public static ArrayList<TraerDatos> obtenerDatos(){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		ArrayList<TraerDatos> lista = new ArrayList<TraerDatos>();
		TraerDatos datos = null;
		
		if(op==1){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_Get_TipoMovimiento(?,?)}");
				stmt.setString(1, codMov);
				stmt.setString(2, usuarioID);
				
				rs = stmt.executeQuery();
				
				while (rs.next()){
					datos = new TraerDatos();
					datos.setCodigoMovimiento(rs.getString("codigo_movimiento"));
					datos.setDescripcionMovimiento(rs.getString("Descripcion"));
					lista.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			}catch(SQLException e){
				System.out.println("Error: " + e.getMessage());
			}
		}else if(op==2){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_Get_FechaVence(?)}");
				stmt.setString(1, codMov);
				
				rs = stmt.executeQuery();
				
				while (rs.next()){
					datos = new TraerDatos();
					datos.setFechaVencimiento(rs.getString("FechaVence"));
					lista.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			}catch(SQLException e){
				System.out.println("Error: " + e.getMessage());
			}
		}else if(op==3){
			try{
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_tipoPago(?)}");
				stmt.setString(1, codPago);
				
				rs = stmt.executeQuery();
				
				while (rs.next()){
					datos = new TraerDatos();
					datos.setCodigoPago(rs.getString("codigo_pago"));
					datos.setDescripcionPago(rs.getString("descripcion"));
					if(rs.getString("es_credito").equals("S")){
						datos.setEsCredito("1");
					}else{
						datos.setEsCredito("2");
					}
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
