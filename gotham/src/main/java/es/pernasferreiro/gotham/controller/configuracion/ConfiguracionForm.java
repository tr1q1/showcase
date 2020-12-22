package es.pernasferreiro.gotham.controller.configuracion;

import org.apache.commons.lang3.StringUtils;

import es.pernasferreiro.gotham.domain.utils.Validation;
import es.pernasferreiro.gotham.model.persistence.configuracion.Configuracion;

/**
 * Representa un formulario de Alta de Parámetro de Configuracion
 */
public class ConfiguracionForm
{
	private Long id;
	private String grupo;
	private String parametro;
	private String valor;
	private String entorno;
	
	/**
	 * Crea una nueva instancia
	 */
	public ConfiguracionForm()
	{
		
	}
	
	/**
	 * Crea una nueva instancia a partir de un parametro de configuracion
	 * @param gasto Linea de gasto
	 */
	public ConfiguracionForm(Configuracion configuracion)
	{
		this.id = configuracion.getId();
		this.grupo = StringUtils.trimToEmpty(configuracion.getGrupo());
		this.parametro = StringUtils.trimToEmpty(configuracion.getParametro());
		this.valor = StringUtils.trimToEmpty(configuracion.getValor());
		this.entorno = StringUtils.trimToEmpty(configuracion.getEntorno());
	}

	/**
	 * Valida el formulario
	 */
	public void validar()
	{
		Validation.validar("grupo", this.grupo);
		Validation.validar("parametro", this.parametro);
		Validation.validar("valor", this.valor);
		Validation.validar("entorno", this.entorno);
	} // validar	

	/**
	 * @return the id
	 */
	public final Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public final void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the grupo
	 */
	public final String getGrupo() {
		return grupo;
	}

	/**
	 * @param grupo the grupo to set
	 */
	public final void setGrupo(String grupo) {
		this.grupo = grupo;
	}

	/**
	 * @return the parametro
	 */
	public final String getParametro() {
		return parametro;
	}

	/**
	 * @param parametro the parametro to set
	 */
	public final void setParametro(String parametro) {
		this.parametro = parametro;
	}

	/**
	 * @return the valor
	 */
	public final String getValor() {
		return valor;
	}

	/**
	 * @param valor the valor to set
	 */
	public final void setValor(String valor) {
		this.valor = valor;
	}

	/**
	 * @return the entorno
	 */
	public final String getEntorno() {
		return entorno;
	}

	/**
	 * @param entorno the entorno to set
	 */
	public final void setEntorno(String entorno) {
		this.entorno = entorno;
	}
}
