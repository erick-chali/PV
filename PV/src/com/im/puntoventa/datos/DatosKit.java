package com.im.puntoventa.datos;

public class DatosKit {
	
	public DatosKit(String codigoProducto, String codigoDetKit, String descripcion, String unidad, String medida,
			String cantidad, String precio, String porDesc, String descuento, String frac, String disponible,
			String mensaje) {
		this.setCodigoProducto(codigoProducto);
		this.setCodigoDetKit(codigoDetKit);
		this.setDescripcion(descripcion);
		this.setUnidad(unidad);
		this.setMedida(medida);
		this.setCantidad(cantidad);
		this.setPrecio(precio);
		this.setPorDesc(porDesc);
		this.setDescuento(descuento);
		this.setFrac(frac);
		this.setDisponible(disponible);
		this.setMensaje(mensaje);
	}
	public DatosKit(){}
	private String codigoProducto;
	private String codigoDetKit;
	private String descripcion;
	private String unidad;
	private String medida;
	private String cantidad;
	private String precio;
	private String porDesc;
	private String descuento;
	private String frac;
	private String disponible;
	private String mensaje;
	
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoDetKit() {
		return codigoDetKit;
	}
	public void setCodigoDetKit(String codigoDetKit) {
		this.codigoDetKit = codigoDetKit;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getUnidad() {
		return unidad;
	}
	public void setUnidad(String unidad) {
		this.unidad = unidad;
	}
	public String getMedida() {
		return medida;
	}
	public void setMedida(String medida) {
		this.medida = medida;
	}
	public String getCantidad() {
		return cantidad;
	}
	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	public String getPrecio() {
		return precio;
	}
	public void setPrecio(String precio) {
		this.precio = precio;
	}
	public String getPorDesc() {
		return porDesc;
	}
	public void setPorDesc(String porDesc) {
		this.porDesc = porDesc;
	}
	public String getDescuento() {
		return descuento;
	}
	public void setDescuento(String descuento) {
		this.descuento = descuento;
	}
	public String getFrac() {
		return frac;
	}
	public void setFrac(String frac) {
		this.frac = frac;
	}
	public String getDisponible() {
		return disponible;
	}
	public void setDisponible(String disponible) {
		this.disponible = disponible;
	}
	
	
}
