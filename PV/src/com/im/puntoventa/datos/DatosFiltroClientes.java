package com.im.puntoventa.datos;

public class DatosFiltroClientes {
	
	public DatosFiltroClientes(String nit, String nombre, String  tarjeta){
		this.setNit(nit);
		this.setNombre(nombre);
		this.setTarjeta(tarjeta);
	}
	
	public DatosFiltroClientes(){}
	
	private String nit;
	private String nombre;
	private String tarjeta;
	private String opcion;
	public String getNit() {
		return nit;
	}
	public void setNit(String nit) {
		this.nit = nit;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getTarjeta() {
		return tarjeta;
	}
	public void setTarjeta(String tarjeta) {
		this.tarjeta = tarjeta;
	}

	public String getOpcion() {
		return opcion;
	}

	public void setOpcion(String opcion) {
		this.opcion = opcion;
	}
	
	
}
