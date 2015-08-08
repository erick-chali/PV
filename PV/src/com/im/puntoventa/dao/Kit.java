package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosKit;

public class Kit {
	
	public static ArrayList<DatosKit> obtenerDetalles(String codlista, String unidad, String pago, String producto, String bodega, String serie, String numero){
		Connection con = null;
		CallableStatement stmt=null;
		ResultSet rs = null;
		DatosKit datos = null;
		ArrayList<DatosKit> lista = new ArrayList<DatosKit>();
		
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_GetKitsProducto(?,?,?,?,?,?,?)}");
			stmt.setString(1, codlista);
			stmt.setString(2, unidad);
			stmt.setString(3, pago);
			stmt.setString(4, producto);
			stmt.setString(5, bodega);
			stmt.setString(6, null);
			stmt.setString(7, null);
			rs = stmt.executeQuery();
			
			while(rs.next()){
				datos = new DatosKit();
				datos.setCodigoProducto(rs.getString("producto"));
				System.out.println(datos.getCodigoProducto());
				datos.setCodigoDetKit(rs.getString("producto_det"));
				System.out.println(datos.getCodigoDetKit());
				datos.setDescripcion(rs.getString("descP"));
				datos.setUnidad(rs.getString("unidad"));
				datos.setMedida(rs.getString("descU"));
				datos.setCantidad(rs.getString("cantidad"));
				datos.setPrecio(rs.getString("precio"));
				datos.setPorDesc(rs.getString("porDesc"));
				datos.setDescuento(rs.getString("descuento"));
				datos.setFrac(rs.getString("Frac"));
				datos.setDisponible(rs.getString("disponible"));
				lista.add(datos);
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e){
			datos = new DatosKit();
			datos.setMensaje("Error: " + e.getMessage());
			System.out.println(datos.getMensaje());
		}
		return lista;
	}
}
