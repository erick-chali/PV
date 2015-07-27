package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosFiltroProductos;

public class ImplementaFiltrosProductos implements InterfazFiltrosProductos{
	static String lista, codigoPago, codigoBodegaLocal, marca, descripcion, familia, referencia;
	@Override
	public DatosFiltroProductos obtenerParametros(DatosFiltroProductos datos) {
		// TODO Auto-generated method stub
		lista = datos.getLista();
		codigoPago = datos.getCodigoPago();
		codigoBodegaLocal = datos.getCodigoBodegaLocal();
		marca = datos.getBuscaMarca();
		descripcion = datos.getBuscaDescripcion();
		familia = datos.getBuscaFamilia();
		referencia = datos.getBuscaReferencia();
		
		return null;
	}
	public static ArrayList<DatosFiltroProductos> obtenerProductos(){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		ArrayList<DatosFiltroProductos> productos = new ArrayList<DatosFiltroProductos>();
		DatosFiltroProductos datos = null;
		if(marca!=null){
			
			try {
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterMar_Bod(?,?,?,?)}");
				stmt.setInt(1, 1);
				stmt.setInt(2, Integer.parseInt(codigoPago));
				stmt.setString(3, codigoBodegaLocal);
				stmt.setString(4, marca);
				rs = stmt.executeQuery();
				while(rs.next()){
					datos = new DatosFiltroProductos();
					datos.setCodigoProducto(rs.getString("Codigo"));
					datos.setDescripcionProducto(rs.getString("Descripcion"));
					datos.setMarcaProducto(rs.getString("Marca"));
					datos.setPrecioProducto(rs.getDouble("PrecioU"));
					datos.setDisponible(rs.getString("Disponible"));
					datos.setBodegaProducto(rs.getString("Bodega"));
					datos.setBackOrder(rs.getString("BackOrder"));
					datos.setFechaespera(rs.getString("Fecha Esp"));
					datos.setTransito(rs.getString("Transito"));
					datos.setFamiliaProducto(rs.getString("Familia"));
					datos.setReferenciaProducto(rs.getString("Referencia"));
					productos.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}else if(descripcion!=null){
			try {
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterDesc_Bod(?,?,?,?)}");
				stmt.setInt(1, 1);
				stmt.setInt(2, Integer.parseInt(codigoPago));
				stmt.setString(3, codigoBodegaLocal);
				stmt.setString(4, descripcion);
				rs = stmt.executeQuery();
				while(rs.next()){
					datos = new DatosFiltroProductos();
					datos.setCodigoProducto(rs.getString("Codigo"));
					datos.setDescripcionProducto(rs.getString("Descripcion"));
					datos.setMarcaProducto(rs.getString("Marca"));
					datos.setPrecioProducto(rs.getDouble("PrecioU"));
					datos.setDisponible(rs.getString("Disponible"));
					datos.setBodegaProducto(rs.getString("Bodega"));
					datos.setBackOrder(rs.getString("BackOrder"));
					datos.setFechaespera(rs.getString("Fecha Esp"));
					datos.setTransito(rs.getString("Transito"));
					datos.setFamiliaProducto(rs.getString("Familia"));
					datos.setReferenciaProducto(rs.getString("Referencia"));
					productos.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}else if(familia!=null){
			try {
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterFam_Bod(?,?,?,?)}");
				stmt.setInt(1, 1);
				stmt.setInt(2, Integer.parseInt(codigoPago));
				stmt.setString(3, codigoBodegaLocal);
				stmt.setString(4, familia);
				rs = stmt.executeQuery();
				while(rs.next()){
					datos = new DatosFiltroProductos();
					datos.setCodigoProducto(rs.getString("Codigo"));
					datos.setDescripcionProducto(rs.getString("Descripcion"));
					datos.setMarcaProducto(rs.getString("Marca"));
					datos.setPrecioProducto(rs.getDouble("PrecioU"));
					datos.setDisponible(rs.getString("Disponible"));
					datos.setBodegaProducto(rs.getString("Bodega"));
					datos.setBackOrder(rs.getString("BackOrder"));
					datos.setFechaespera(rs.getString("Fecha Esp"));
					datos.setTransito(rs.getString("Transito"));
					datos.setFamiliaProducto(rs.getString("Familia"));
					datos.setReferenciaProducto(rs.getString("Referencia"));
					productos.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}else if(referencia!=null){
			try {
				con = new ConectarDB().getConnection();
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterRef_Bod(?,?,?,?)}");
				stmt.setInt(1, 1);
				stmt.setInt(2, Integer.parseInt(codigoPago));
				stmt.setString(3, codigoBodegaLocal);
				stmt.setString(4, referencia);
				rs = stmt.executeQuery();
				while(rs.next()){
					datos = new DatosFiltroProductos();
					datos.setCodigoProducto(rs.getString("Codigo"));
					datos.setDescripcionProducto(rs.getString("Descripcion"));
					datos.setMarcaProducto(rs.getString("Marca"));
					datos.setPrecioProducto(rs.getDouble("PrecioU"));
					datos.setDisponible(rs.getString("Disponible"));
					datos.setBodegaProducto(rs.getString("Bodega"));
					datos.setBackOrder(rs.getString("BackOrder"));
					datos.setFechaespera(rs.getString("Fecha Esp"));
					datos.setTransito(rs.getString("Transito"));
					datos.setFamiliaProducto(rs.getString("Familia"));
					datos.setReferenciaProducto(rs.getString("Referencia"));
					productos.add(datos);
				}
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}
		
		return productos;
		
	}
}
