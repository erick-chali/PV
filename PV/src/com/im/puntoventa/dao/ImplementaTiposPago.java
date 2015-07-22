package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.TiposPago;

public class ImplementaTiposPago implements InterfazTiposPago{
	static String limiteCredito;
	@Override
	public TiposPago obtenerPagos(TiposPago obj) {
		// TODO Auto-generated method stub
		limiteCredito = obj.getLimiteCredito();
		return null;
	}
	
	public static ArrayList<TiposPago> traerPagos(){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		ArrayList<TiposPago> lista = new ArrayList<TiposPago>();
		TiposPago datos = null;
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_LookUp_TiposPago(?,?,?,?)}");
			stmt.setInt(1, 0);
			stmt.setInt(2, 0);
			stmt.setString(3, "");
			stmt.setString(4, limiteCredito);
			
			rs = stmt.executeQuery();
			
			while (rs.next()){
				datos = new TiposPago();
				datos.setCodigo(rs.getString("codigo_pago"));
				datos.setDescripcion(rs.getString("descripcion"));
				lista.add(datos);
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e){
			System.out.println("Error: " + e.getMessage());
		}
		return lista;
	}
}
