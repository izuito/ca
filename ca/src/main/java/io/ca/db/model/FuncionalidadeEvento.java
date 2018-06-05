package io.ca.db.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 *
 * @author izuito
 */
@Data
@EqualsAndHashCode(exclude = { "perfis", "components", "evento", "funcionalidade" })
@Entity
@Table(name = "FUNCIONALIDADE_EVENTO")
public class FuncionalidadeEvento implements Serializable {

	private static final long serialVersionUID = 1L;

	@EmbeddedId
	protected FuncionalidadeEventoPK pk;

	@ManyToMany(mappedBy = "funcionalidadeEventos", fetch = FetchType.EAGER)
	private Set<Perfil> perfis = new HashSet<>();

	@ManyToMany(mappedBy = "funcionalidadeEventos", fetch = FetchType.EAGER)
	private Set<Components> components = new HashSet<>();

	@JoinColumn(name = "ID_FUNCIONALIDADE", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
	@ManyToOne(optional = false, fetch = FetchType.EAGER)
	private Funcionalidade funcionalidade;

	@JoinColumn(name = "ID_EVENTO", referencedColumnName = "ID", nullable = false, insertable = false, updatable = false)
	@ManyToOne(optional = false, fetch = FetchType.EAGER)
	private Evento evento;

	public FuncionalidadeEvento() {
		if (funcionalidade != null && evento != null) {
			throw new IllegalArgumentException("Objetos Funcionalidade e Evento nulos.");
		}
		if (funcionalidade.getId() != null && evento.getId() != null) {
			throw new IllegalArgumentException("Identificadores Funcionalidade e Evento nulos.");
		}
		setPk(new FuncionalidadeEventoPK(funcionalidade.getId(), evento.getId()));
	}

	@Data
	@AllArgsConstructor
	@EqualsAndHashCode
	@Embeddable
	public static class FuncionalidadeEventoPK implements Serializable {

		private static final long serialVersionUID = 1L;

		@Column(name = "ID_FUNCIONALIDADE", nullable = false)
		private long idFuncionalidade;

		@Column(name = "ID_EVENTO", nullable = false)
		private long idEvento;

	}

}
