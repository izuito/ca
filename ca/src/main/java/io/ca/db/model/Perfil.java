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
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 *
 * @author izuito
 */
@Data
@EqualsAndHashCode(exclude = { "nome", "funcionalidadeEventos", "usuarios", "grupos" })
@Entity
@Table(name = "PERFIL", uniqueConstraints = { @UniqueConstraint(columnNames = { "NOME" }) })
public class Perfil implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false)
	private Long id;

	@Column(name = "NOME", nullable = false, length = 50)
	private String nome;

	@JoinTable(name = "PERMISSAO", joinColumns = {
			@JoinColumn(name = "ID_PERFIL", referencedColumnName = "ID", nullable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "ID_FUNCIONALIDADE", referencedColumnName = "ID_FUNCIONALIDADE", nullable = false),
					@JoinColumn(name = "ID_EVENTO", referencedColumnName = "ID_EVENTO", nullable = false) })
	@ManyToMany(fetch = FetchType.EAGER)
	private Set<FuncionalidadeEvento> funcionalidadeEventos = new HashSet<>();

	@ManyToMany(mappedBy = "perfis", fetch = FetchType.EAGER)
	private Set<Usuario> usuarios = new HashSet<>();

	@ManyToMany(mappedBy = "perfis", fetch = FetchType.EAGER)
	private Set<Grupo> grupos = new HashSet<>();

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
