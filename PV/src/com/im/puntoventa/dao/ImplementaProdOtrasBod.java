package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosProdOtrasBod;

public class ImplementaProdOtrasBod implements InterfazProdOtrasBod{
	public static String descripcion, codigoProducto, lista, tipoPago;
	
	public static ArrayList<DatosProdOtrasBod> obtenerBodegas(){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		DatosProdOtrasBod datos = null;
		ArrayList<DatosProdOtrasBod> listado = new ArrayList<DatosProdOtrasBod>();
		
		con = new ConectarDB().getConnection();
		try {
			stmt = con.prepareCall("{call stp_UDPV_Lookup_ProductosXBodega(?,?,?)}");
			stmt.setInt(1, Integer.parseInt(lista));
			stmt.setInt(2, Integer.parseInt(tipoPago));
			stmt.setString(3, codigoProducto);
			rs= stmt.executeQuery();
			
			while(rs.next()){
				datos = new DatosProdOtrasBod();
				datos.setCodigoProducto(rs.getString("Codigo"));
				datos.setDescripcionProducto(rs.getString("Descripcion"));
				datos.setMarcaProducto(rs.getString("Marca"));
				datos.setPrecioProducto(rs.getDouble("PrecioU"));
				datos.setDisponible(rs.getString("Disponible"));
				datos.setBodegaProducto(rs.getString("Bodega"));
				datos.setFamiliaProducto(rs.getString("Familia"));
				datos.setReferenciaProducto(rs.getString("Referencia"));
				listado.add(datos);
			}
			con.close();
			stmt.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Error: " + e.getMessage());
		}
		
		return listado;
	}

	@Override
	public DatosProdOtrasBod parametros(DatosProdOtrasBod datos) {
		// TODO Auto-generated method stub
		lista = datos.getLista();
		tipoPago = datos.getTipoPago();
		codigoProducto = datos.getCodigoProducto();
		descripcion = datos.getBuscaDescripcion();
		
		return null;
	}
}
