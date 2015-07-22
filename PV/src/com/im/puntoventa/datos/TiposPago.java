package com.im.puntoventa.datos;

public class TiposPago {
	public TiposPago(String codigo, String descripcion){
		this.setCodigo(codigo);
		this.setDescripcion(descripcion);
	}
	
	public TiposPago(){}
	private String codigo;
	private String descripcion;
	private String limiteCredito;
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getLimiteCredito() {
		return limiteCredito;
	}

	public void setLimiteCredito(String limiteCredito) {
		this.limiteCredito = limiteCredito;
	}
	
	
}
