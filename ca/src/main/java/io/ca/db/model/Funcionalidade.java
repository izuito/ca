package io.ca.db.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 *
 * @author izuito
 */
@Data
@EqualsAndHashCode(exclude = { "funcionalidade", "descricao", "ordem", "funcionalidades", "components", "funcionalidadeEventos" })
@Entity
@Table(name = "FUNCIONALIDADE")
public class Funcionalidade implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false)
	private Long id;

	@JoinColumn(name = "ID_FUNCIONALIDADE", referencedColumnName = "ID")
	@ManyToOne(fetch = FetchType.EAGER)
	private Funcionalidade funcionalidade;

	@Column(name = "DESCRICAO", length = 254)
	private String descricao;

	@Column(name = "ORDEM")
	private Integer ordem;

	@OneToMany(mappedBy = "funcionalidade", fetch = FetchType.EAGER)
	private Set<Funcionalidade> funcionalidades = new HashSet<>();

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "funcionalidade", fetch = FetchType.EAGER)
	private Set<Components> components = new HashSet<>();

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "funcionalidade", fetch = FetchType.EAGER)
	private Set<FuncionalidadeEvento> funcionalidadeEventos = new HashSet<>();

}
