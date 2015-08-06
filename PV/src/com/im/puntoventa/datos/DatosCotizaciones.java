package com.im.puntoventa.datos;

public class DatosCotizaciones {
	
	
	public DatosCotizaciones(String noCotizacion, String nombre, String nit, String monto, String autorizacion,
			String fAutorizacion, String sucursal, String mensaje, String fecha) {
		this.setNombre(nombre);
		this.setNoCotizacion(noCotizacion);
		this.setNit(nit);
		this.setMonto(monto);
		this.setAutorizacion(autorizacion);
		this.setfAutorizacion(fAutorizacion);
		this.setSucursal(sucursal);
		this.setMensaje(mensaje);
		this.setFecha(fecha);
	}
	public DatosCotizaciones(){}
	
	private String noCotizacion;
	private String nombre;
	private String nit;
	private String fecha;
	private String monto;
	private String autorizacion;
	private String fAutorizacion;
	private String sucursal;
	private String mensaje;
	
	
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getNoCotizacion() {
		return noCotizacion;
	}
	public void setNoCotizacion(String noCotizacion) {
		this.noCotizacion = noCotizacion;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getNit() {
		return nit;
	}
	public void setNit(String nit) {
		this.nit = nit;
	}
	public String getMonto() {
		return monto;
	}
	public void setMonto(String monto) {
		this.monto = monto;
	}
	public String getAutorizacion() {
		return autorizacion;
	}
	public void setAutorizacion(String autorizacion) {
		this.autorizacion = autorizacion;
	}
	public String getfAutorizacion() {
		return fAutorizacion;
	}
	public void setfAutorizacion(String fAutorizacion) {
		this.fAutorizacion = fAutorizacion;
	}
	public String getSucursal() {
		return sucursal;
	}
	public void setSucursal(String sucursal) {
		this.sucursal = sucursal;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	
}
