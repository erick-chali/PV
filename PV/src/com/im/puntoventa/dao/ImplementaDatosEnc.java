package com.im.puntoventa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.im.puntoventa.conexion.ConectarDB;
import com.im.puntoventa.datos.DatosEnc;

public class ImplementaDatosEnc implements InterfazDatosEnc{
	
	public static String codigoCliente,nit,nombreCliente,direcFactura,tel,tarjeta,direcEnvio,codigoVendedor;
	public static String username,tipoDocumento,noDocumento,fechaVence,tipoPago,tipoCredito,autoriza;
	public static String fechaDocumento,cargosEnvio,otrosCargos,montoVenta,montoTotal,serieDev,noDocDev;
	public static String observaciones,tipoNota,caja,fechaEntrega,codigoDept,codGen,noConsigna,codMovDev;
	public static String generaSolicitud,tipoPagoNC,tipoCliente,codigoNegocio,cantidadDevolver,autorizoDespacho;
	public static String saldo;
	
	@Override
	public DatosEnc obtenerDatos(DatosEnc datos) {
		// TODO Auto-generated method stub
		Connection con = null;
		CallableStatement stmt = null;
		ResultSet rs = null;
		
		try{
			con = new ConectarDB().getConnection();
			stmt = con.prepareCall("{call stp_UDPV_InUp_Mov_Enc(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setString(1, datos.getCodigoCliente());
			stmt.setString(2, datos.getNit());
			stmt.setString(3, datos.getNombreCliente());
			stmt.setString(4, datos.getDirecFactura());
			stmt.setString(5, datos.getTel());
			stmt.setString(6, datos.getTarjeta());
			stmt.setString(7, datos.getDirecEnvio());
			stmt.setString(8, datos.getCodigoVendedor());
			stmt.setString(9, datos.getUsername());
			stmt.setString(10, datos.getTipoDocumento());
			stmt.setString(11, datos.getNoDocumento());
			stmt.setString(12, datos.getFechaVence());
			stmt.setString(13, datos.getTipoPago());
			stmt.setString(14, datos.getTipoCredito());
			stmt.setString(15, datos.getAutoriza());
			stmt.setString(16, datos.getFechaDocumento());
			stmt.setString(17, datos.getCargosEnvio());
			stmt.setString(18, datos.getOtrosCargos());
			stmt.setString(19, datos.getMontoVenta());
			stmt.setString(20, datos.getMontoTotal());
			stmt.setString(21, datos.getSerieDev());
			stmt.setString(22, datos.getNoDocDev());
			stmt.setString(23, datos.getObservaciones());
			stmt.setString(24, datos.getTipoNota());
			stmt.setString(25, datos.getCaja());
			stmt.setString(26, datos.getFechaEntrega());
			stmt.setString(27, datos.getCodigoDept());
			stmt.setString(28, datos.getCodGen());
			stmt.setString(29, datos.getNoConsigna());
			stmt.setString(30, datos.getCodMovDev());
			stmt.setString(31, datos.getGeneraSolicitud());
			stmt.setString(32, datos.getTipoPagoNC());
			stmt.setString(33, datos.getTipoCliente());
			stmt.setString(34, datos.getCodigoNegocio());
			stmt.setString(35, datos.getCantidadDevolver());
			stmt.setString(36, datos.getAutorizoDespacho());
			stmt.setString(37, datos.getSaldo());
			rs = stmt.executeQuery();
			
			while(rs.next()){
				datos.setNoEnc(rs.getString(2));
				
			}
			con.close();
			stmt.close();
			rs.close();
		}catch(SQLException e ){
			System.out.println("Error: " + e.getMessage());
		}
		return datos;
	}
	
	public static ArrayList<DatosEnc> obtenerDocumento(){
		
		
		
		return null;
	}
}
