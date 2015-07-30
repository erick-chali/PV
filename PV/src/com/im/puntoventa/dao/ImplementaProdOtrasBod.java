package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosProdOtrasBod;

public class ImplementaProdOtrasBod implements InterfazProdOtrasBod{
	public static String referencia, descripcion, marca, familia, codigoProducto, lista, tipoPago;
	
	public static ArrayList<DatosProdOtrasBod> obtenerBodegas(){
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		DatosProdOtrasBod datos = null;
		ArrayList<DatosProdOtrasBod> listado = new ArrayList<DatosProdOtrasBod>();
		if(referencia!=null){
			
			con = new ConectarDB().getConnection();
			try {
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterRef_Prod(?,?,?,?)}");
				stmt.setInt(1, Integer.parseInt(lista));
				stmt.setInt(2, Integer.parseInt(tipoPago));
				stmt.setString(3, codigoProducto);
				stmt.setString(4, referencia);
				rs= stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosProdOtrasBod();
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
					listado.add(datos);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}else if(descripcion!=null){
			con = new ConectarDB().getConnection();
			try {
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterDesc_Prod(?,?,?,?)}");
				stmt.setInt(1, Integer.parseInt(lista));
				stmt.setInt(2, Integer.parseInt(tipoPago));
				stmt.setString(3, codigoProducto);
				stmt.setString(4, descripcion);
				rs= stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosProdOtrasBod();
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
					listado.add(datos);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}else if(marca!=null){
			con = new ConectarDB().getConnection();
			try {
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterMar_Prod(?,?,?,?)}");
				stmt.setInt(1, Integer.parseInt(lista));
				stmt.setInt(2, Integer.parseInt(tipoPago));
				stmt.setString(3, codigoProducto);
				stmt.setString(4, marca);
				rs= stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosProdOtrasBod();
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
					listado.add(datos);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}else if(familia!=null){
			con = new ConectarDB().getConnection();
			try {
				stmt = con.prepareCall("{call stp_UDPV_LookUp_Prods_FilterFam_Prod(?,?,?,?)}");
				stmt.setInt(1, Integer.parseInt(lista));
				stmt.setInt(2, Integer.parseInt(tipoPago));
				stmt.setString(3, codigoProducto);
				stmt.setString(4, familia);
				rs= stmt.executeQuery();
				
				while(rs.next()){
					datos = new DatosProdOtrasBod();
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
					listado.add(datos);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("Error: " + e.getMessage());
			}
		}
		return listado;
	}

	@Override
	public DatosProdOtrasBod parametros(DatosProdOtrasBod datos) {
		// TODO Auto-generated method stub
		lista = datos.getLista();
		tipoPago = datos.getTipoPago();
		codigoProducto = datos.getCodigoProducto();
		referencia = datos.getBuscaReferencia();
		descripcion = datos.getBuscaDescripcion();
		marca = datos.getBuscaMarca();
		familia = datos.getBuscaFamilia();
		
		return null;
	}
}
