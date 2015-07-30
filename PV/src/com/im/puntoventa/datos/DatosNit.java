package com.im.puntoventa.datos;

public class DatosNit {
	public DatosNit(String nit, String codigoCliente, String nombreCliente, String direccionF,
			String direccionE, String telefono, String tipoCliente, String tipoCredito, double limiteCredito
			,double saldo
			){
		this.setNit(nit);
		this.setCodigoCliente(codigoCliente);
		this.setNombreCliente(nombreCliente);
		this.setDireccionF(direccionF);
		this.setDireccionE(direccionE);
		this.setTelefono(telefono);
		this.setTipoCliente(tipoCliente);
		this.setTipoCredito(tipoCredito);
		this.setLimiteCredito(limiteCredito);
		this.setSaldo(saldo);
	}
	
	public DatosNit(){}
	
	private String nit;
	private String codigoCliente;
	private String nombreCliente;
	private String direccionF;
	private String direccionE;
	private String telefono;
	private String tipoCliente;
	private String tipoCredito;
	private double limiteCredito;
	private int resultado;
	private double saldo;
	
	public double getSaldo() {
		return saldo;
	}

	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}

	public String getNit() {
		return nit;
	}
	public void setNit(String nit) {
		this.nit = nit;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getDireccionF() {
		return direccionF;
	}
	public void setDireccionF(String direccionF) {
		this.direccionF = direccionF;
	}
	public String getDireccionE() {
		return direccionE;
	}
	public void setDireccionE(String direccionE) {
		this.direccionE = direccionE;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public String getTipoCredito() {
		return tipoCredito;
	}
	public void setTipoCredito(String tipoCredito) {
		this.tipoCredito = tipoCredito;
	}

	public double getLimiteCredito() {
		return limiteCredito;
	}

	public void setLimiteCredito(double limiteCredito) {
		this.limiteCredito = limiteCredito;
	}

	public int getResultado() {
		return resultado;
	}

	public void setResultado(int resultado) {
		this.resultado = resultado;
	}
	
	
}
