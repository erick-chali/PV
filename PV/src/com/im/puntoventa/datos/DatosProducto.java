package com.im.puntoventa.datos;

public class DatosProducto {
	public DatosProducto(String codigoProducto, String descripcionProducto, String medida, String disponible,
			double precioUnitario, double importe, double descuentoMaximo, String codigoBodega, String codigoLista,
			double descuento, String esKit
			){
		this.setCodigoProducto(codigoProducto);
		this.setDescripcionProducto(descripcionProducto);
		this.setMedida(medida);
		this.setDisponible(disponible);
		this.setPrecioUnitario(precioUnitario);
		this.setImporte(importe);
		this.setDescuentoMaximo(descuentoMaximo);
		this.setCodigoBodega(codigoBodega);
		this.setCodigoLista(codigoLista);
		this.setDescuento(descuento);
		this.setEsKit(esKit);
	}
	
	
	public DatosProducto(){}
	
	private String codigoProducto;
	private String descripcionProducto;
	private String medida;
	private String disponible;
	private double precioUnitario;
	private double importe;
	private double descuentoMaximo;
	private String codigoBodega;
	private String codigoLista;
	private String formaPago;
	private double descuento;
	private String esKit;
	
	
	public String getEsKit() {
		return esKit;
	}


	public void setEsKit(String esKit) {
		this.esKit = esKit;
	}


	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getDescripcionProducto() {
		return descripcionProducto;
	}
	public void setDescripcionProducto(String descripcionProducto) {
		this.descripcionProducto = descripcionProducto;
	}
	public String getMedida() {
		return medida;
	}
	public void setMedida(String medida) {
		this.medida = medida;
	}
	public double getPrecioUnitario() {
		return precioUnitario;
	}
	public void setPrecioUnitario(double precioUnitario) {
		this.precioUnitario = precioUnitario;
	}
	public double getImporte() {
		return importe;
	}
	public void setImporte(double importe) {
		this.importe = importe;
	}
	public double getDescuentoMaximo() {
		return descuentoMaximo;
	}
	public void setDescuentoMaximo(double descuentoMaximo) {
		this.descuentoMaximo = descuentoMaximo;
	}
	public String getCodigoBodega() {
		return codigoBodega;
	}
	public void setCodigoBodega(String codigoBodega) {
		this.codigoBodega = codigoBodega;
	}
	public String getCodigoLista() {
		return codigoLista;
	}
	public void setCodigoLista(String codigoLista) {
		this.codigoLista = codigoLista;
	}
	public String getDisponible() {
		return disponible;
	}
	public void setDisponible(String disponible) {
		this.disponible = disponible;
	}
	public String getFormaPago() {
		return formaPago;
	}
	public void setFormaPago(String formaPago) {
		this.formaPago = formaPago;
	}


	public double getDescuento() {
		return descuento;
	}


	public void setDescuento(double descuento) {
		this.descuento = descuento;
	}
	
	
	
}
