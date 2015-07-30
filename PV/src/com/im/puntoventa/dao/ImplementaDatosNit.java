package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosNit;

public class ImplementaDatosNit implements InterfazDatosNit{
	static String nit;
	@Override
	public DatosNit obtenerDatos(DatosNit datos) {
		// TODO Auto-generated method stub
		nit = datos.getNit();
		return null;
	}
	
	public static ArrayList<DatosNit> obtenerInformacion(){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		DatosNit info = null;
		ArrayList<DatosNit> lista = new ArrayList<DatosNit>();
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_Get_CreditoCliente(?)}");
			stmt.setString(1, nit);
			rs = stmt.executeQuery();
			info = new DatosNit();
			info.setResultado(0);
			while(rs.next()){
				info = new DatosNit();
				info.setNit(nit);
				info.setCodigoCliente(rs.getString("Codigo"));
				info.setNombreCliente(rs.getString("Nombre"));
				info.setDireccionF(rs.getString("DireccionFact"));
				info.setDireccionE(rs.getString("DireccionEnv"));
				info.setTelefono(rs.getString("telefono"));
				info.setTipoCliente(rs.getString("tipo_cliente"));
				if(rs.getString("Saldo")!=null){
					info.setSaldo(rs.getDouble("Saldo"));
				}else{
					info.setSaldo(0);
				}
				double limite = rs.getDouble("Limite_Credito") - rs.getDouble("Saldo");
				if(limite!=0){
					info.setLimiteCredito(limite);
				}else{
					info.setLimiteCredito(0.1);
				}
				lista.add(info);
				info.setResultado(1);
			}
		}catch(SQLException e){}
		return lista;
	}
}
