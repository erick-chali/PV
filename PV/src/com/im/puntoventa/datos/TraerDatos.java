package com.im.puntoventa.datos;

public class TraerDatos {
	public TraerDatos(String codigoMovimiento, String descripcionMovimiento, String fechaVencimiento,
					String codigoPago, String descripcionPago, int limiteCredito, String esCredito
			){
		this.setCodigoMovimiento(codigoMovimiento);
		this.setDescripcionMovimiento(descripcionMovimiento);
		this.setFechaVencimiento(fechaVencimiento);
		this.setCodigoPago(codigoPago);
		this.setDescripcionPago(descripcionPago);
		this.setLimiteCredito(limiteCredito);
		this.setEsCredito(esCredito);
	}
	public TraerDatos(){}
	
	private String codigoMovimiento;
	private String descripcionMovimiento;
	private String codigoPago;
	private String descripcionPago;
	private String usuarioID;
	private String fechaVencimiento;
	private String NoOpcion;
	private int limiteCredito;
	private String esCredito;
	
	public String getCodigoMovimiento() {
		return codigoMovimiento;
	}
	public void setCodigoMovimiento(String codigoMovimiento) {
		this.codigoMovimiento = codigoMovimiento;
	}
	public String getDescripcionMovimiento() {
		return descripcionMovimiento;
	}
	public void setDescripcionMovimiento(String descripcionMovimiento) {
		this.descripcionMovimiento = descripcionMovimiento;
	}
	public String getUsuarioID() {
		return usuarioID;
	}
	public void setUsuarioID(String usuarioID) {
		this.usuarioID = usuarioID;
	}
	public String getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(String fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public String getNoOpcion() {
		return NoOpcion;
	}
	public void setNoOpcion(String noOpcion) {
		NoOpcion = noOpcion;
	}
	public String getCodigoPago() {
		return codigoPago;
	}
	public void setCodigoPago(String codigoPago) {
		this.codigoPago = codigoPago;
	}
	public String getDescripcionPago() {
		return descripcionPago;
	}
	public void setDescripcionPago(String descripcionPago) {
		this.descripcionPago = descripcionPago;
	}
	public int getLimiteCredito() {
		return limiteCredito;
	}
	public void setLimiteCredito(int limiteCredito) {
		this.limiteCredito = limiteCredito;
	}
	public String getEsCredito() {
		return esCredito;
	}
	public void setEsCredito(String esCredito) {
		this.esCredito = esCredito;
	}
	
	
}
