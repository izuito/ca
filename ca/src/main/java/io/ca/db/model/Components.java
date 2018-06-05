package io.ca.db.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 *
 * @author izuito
 */
@Data
@EqualsAndHashCode(exclude = { "path", "name", "component", "icon", "sidebar", "collapsed", "funcionalidadeEventos", "funcionalidade" })
@Entity
@Table(name = "COMPONENTS")
public class Components implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false)
	private Long id;

	@Column(name = "PATH", length = 254)
	private String path;

	@Column(name = "NAME", length = 100)
	private String name;

	@Column(name = "COMPONENT", length = 100)
	private String component;

	@Column(name = "ICON", length = 50)
	private String icon;

	@Column(name = "SIDEBAR")
	private Boolean sidebar;

	@Column(name = "COLLAPSED")
	private Boolean collapsed;

	@JoinTable(name = "COMPONENTS_FUNCIONALIDADE_EVENTO", joinColumns = {
			@JoinColumn(name = "ID_COMPONENTS", referencedColumnName = "ID", nullable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "ID_FUNCIONALIDADE", referencedColumnName = "ID_FUNCIONALIDADE", nullable = false),
					@JoinColumn(name = "ID_EVENTO", referencedColumnName = "ID_EVENTO", nullable = false) })
	@ManyToMany(fetch = FetchType.EAGER)
	private Set<FuncionalidadeEvento> funcionalidadeEventos = new HashSet<>();

	@JoinColumn(name = "ID_FUNCIONALIDADE", referencedColumnName = "ID", nullable = false)
	@ManyToOne(optional = false, fetch = FetchType.EAGER)
	private Funcionalidade funcionalidade;

	public void add(FuncionalidadeEvento p) {
		if (getFuncionalidadeEventos() == null) {
			setFuncionalidadeEventos(new HashSet<>());
		}
		if (getFuncionalidadeEventos().stream().noneMatch(n -> n.equals(p))) {
			getFuncionalidadeEventos().add(p);
		}
	}

	public void remove(FuncionalidadeEvento p) {
		if (getFuncionalidadeEventos() != null) {
			getFuncionalidadeEventos().removeIf(r -> r.equals(p));
		}
	}
	
}
