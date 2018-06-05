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
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 *
 * @author izuito
 */
@Data
@EqualsAndHashCode(exclude = { "nome", "usuarios", "perfis" })
@Entity
@Table(name = "GRUPO")
public class Grupo implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false)
	private Long id;

	@Column(name = "NOME", nullable = false, length = 50)
	private String nome;

	@JoinTable(name = "GRUPO_USUARIO", joinColumns = {
			@JoinColumn(name = "ID_GRUPO", referencedColumnName = "ID", nullable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "ID_USUARIO", referencedColumnName = "ID", nullable = false) })
	@ManyToMany(fetch = FetchType.EAGER)
	private Set<Usuario> usuarios = new HashSet<>();

	@JoinTable(name = "GRUPO_PERFIL", joinColumns = {
			@JoinColumn(name = "ID_GRUPO", referencedColumnName = "ID", nullable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "ID_PERFIL", referencedColumnName = "ID", nullable = false) })
	@ManyToMany(fetch = FetchType.EAGER)
	private Set<Perfil> perfis = new HashSet<>();

	/**
	 * Adiciona relacionamento entre um Usuario e um Grupo
	 * @param Usuario
	 */
	public void add(Usuario u) {
		if (getUsuarios() == null) {
			setPerfis(new HashSet<>());
		}
		if (getUsuarios().stream().noneMatch(n -> n.equals(u))) {
			getUsuarios().add(u);
		}
	}

	/**
	 * Remove relacionamento entre um Usuario e um Grupo
	 * @param Usuario
	 */
	public void remove(Usuario u) {
		if (getUsuarios() != null) {
			getUsuarios().removeIf(r -> r.equals(u));
		}
	}

	/**
	 * Adiciona relacionamento entre um Perfil e um Grupo
	 * @param Perfil
	 */
	public void add(Perfil p) {
		if (getPerfis() == null) {
			setPerfis(new HashSet<>());
		}
		if (getPerfis().stream().noneMatch(n -> n.equals(p))) {
			getPerfis().add(p);
		}
	}

	/**
	 * Remove relacionamento entre um Perfil e um Grupo
	 * @param Perfil
	 */
	public void remove(Perfil p) {
		if (getPerfis() != null) {
			getPerfis().removeIf(r -> r.equals(p));
		}
	}

}
