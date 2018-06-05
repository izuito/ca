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
@EqualsAndHashCode(exclude = { "nome", "senha", "ativo", "perfis", "grupos" })
@Entity
@Table(name = "USUARIO", uniqueConstraints = { @UniqueConstraint(columnNames = { "NOME" }) })
public class Usuario implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false)
	private Long id;

	@Column(name = "NOME", nullable = false, length = 50)
	private String nome;

	@Column(name = "SENHA", nullable = false, length = 50)
	private String senha;

	@Column(name = "ATIVO", nullable = false)
	private Boolean ativo;

	@JoinTable(name = "USUARIO_PERFIL", joinColumns = {
			@JoinColumn(name = "ID_USUARIO", referencedColumnName = "ID", nullable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "ID_PERFIL", referencedColumnName = "ID", nullable = false) })
	@ManyToMany(fetch = FetchType.EAGER)
	private Set<Perfil> perfis = new HashSet<>();

	@ManyToMany(mappedBy = "usuarios", fetch = FetchType.EAGER)
	private Set<Grupo> grupos = new HashSet<>();

	public void add(Perfil p) {
		if (getPerfis() == null) {
			setPerfis(new HashSet<>());
		}
		if (getPerfis().stream().noneMatch(n -> n.equals(p))) {
			getPerfis().add(p);
		}
	}

	public void remove(Perfil p) {
		if (getPerfis() != null) {
			getPerfis().removeIf(r -> r.equals(p));
		}
	}

}
