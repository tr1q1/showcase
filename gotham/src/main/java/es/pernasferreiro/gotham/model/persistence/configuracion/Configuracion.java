/**
 * 
 */
package es.pernasferreiro.gotham.model.persistence.configuracion;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author tino
 *
 */
@Entity
@Table(name = "configuracion")
public final class Configuracion
{
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name = "grupo")
	private String grupo;
	
	@Column(name = "parametro")
	private String parametro;
	
	@Column(name = "valor")
	private String valor;
	
	@Column(name = "entorno")
	private String entorno;

	@Column(name = "fecha")
	private Timestamp fecha;
	
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

	/**
	 * @return the fecha
	 */
	public final Timestamp getFecha() {
		return fecha;
	}

	/**
	 * @param fecha the fecha to set
	 */
	public final void setFecha(Timestamp fecha) {
		this.fecha = fecha;
	}
} // class
