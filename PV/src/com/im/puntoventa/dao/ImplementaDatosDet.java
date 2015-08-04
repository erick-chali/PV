package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosDet;

public class ImplementaDatosDet implements InterfazDatosDet{
	
	public static String unidad;
	@Override
	public DatosDet obtenerDatos(DatosDet datos) {
		// TODO Auto-generated method stub
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_obtenerMedida(?,?)}");
			stmt.setString(1, datos.getCodigoProducto());
			stmt.setInt(2, Integer.parseInt(datos.getLista()));
			rs = stmt.executeQuery();
			while(rs.next()){
				unidad = rs.getString("unidad_medida");
			}
			con.close();
			stmt.close();
			rs.close();
			
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_InUp_Mov_Det(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setString(1, datos.getTipoDoc());
			stmt.setString(2, datos.getSerieDoc());
			stmt.setString(3, datos.getNoDoc());
			stmt.setString(4, datos.getCorrelativo());
			stmt.setString(5, datos.getCodigoProducto());
			stmt.setString(6, unidad);
			stmt.setString(7, datos.getCantidad());
			stmt.setString(8, datos.getPrecio());
			stmt.setString(9, datos.getPorDescuento());
			stmt.setString(10, datos.getDescuento());
			stmt.setString(11, datos.getTotal());
			stmt.setString(12, datos.getCodigoCliente());
			stmt.setString(13, datos.getPromo());
			stmt.setString(14, datos.getBodega());
			stmt.setString(15, datos.getEnvia());
			stmt.setString(16, datos.getObservaciones());
			stmt.setString(17, datos.getLista());
			stmt.setString(18, datos.getPago());
			stmt.setString(19, datos.getKit());
			stmt.setString(20, datos.getCorrKit());
			stmt.setString(21, datos.getCodPromo());
			stmt.setString(22, datos.getSerieDevProy());
			stmt.setString(23, datos.getNumeroDevProy());
			stmt.setString(24, datos.getOrdenCompra());
			
			rs = stmt.executeQuery();
			
			while(rs.next()){
				System.out.println("Detalle de producto guardado " + datos.getCodigoProducto());
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e ){
			datos.setMensaje("Error: " + e.getMessage());
		}
		return datos;
	}
	
}
