package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosProducto;

public class ImplementaDatosProducto implements InterfazDatosProducto{
	
	static String codigoProducto, lista, unidad, codigoBodega, formaPago;
	
	@Override
	public DatosProducto obtenerDatos(DatosProducto datos) {
		// TODO Auto-generated method stub
		codigoProducto = datos.getCodigoProducto();
		lista = datos.getCodigoLista();
		codigoBodega = datos.getCodigoBodega();
		formaPago = datos.getFormaPago();
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_obtenerMedida(?,?)}");
			stmt.setString(1, codigoProducto);
			stmt.setInt(2, 1);
			rs = stmt.executeQuery();
			while(rs.next()){
				unidad = rs.getString("unidad_medida");
			}

			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e){}
		return null;
	}
	
	public static ArrayList<DatosProducto> obtenerInformacion(){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		DatosProducto dato = null;
		ArrayList<DatosProducto> lista = new ArrayList<DatosProducto>();
		
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_Get_Producto(?,?,?,?,?,?,?)}");
			stmt.setInt(1, 1);
			stmt.setString(2, codigoProducto);
			stmt.setString(3, unidad);
			stmt.setString(4, codigoBodega);
			stmt.setInt(5, Integer.parseInt(formaPago));
			stmt.setString(6, null);
			stmt.setString(7, null);
			rs = stmt.executeQuery();
			
			while(rs.next()){
				dato = new DatosProducto();
				dato.setCodigoProducto(rs.getString("Codigo_Producto"));
				dato.setDescripcionProducto(rs.getString("Descripcion"));
				dato.setMedida(rs.getString("Medida"));
				dato.setPrecioUnitario(rs.getDouble("PrecioU"));
				dato.setDescuentoMaximo(rs.getDouble("Descuento"));
				dato.setDisponible(rs.getString("Disponible"));
				dato.setImporte(0);
				dato.setDescuento(0);
				dato.setCodigoBodega(rs.getString("codigo_bodega"));
				dato.setEsKit(rs.getString("es_kit"));
				lista.add(dato);
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e ){}
		
		return lista;
	}
}
