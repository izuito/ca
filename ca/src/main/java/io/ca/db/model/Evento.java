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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 *
 * @author izuito
 */
@Data
@EqualsAndHashCode(exclude= {"nome", "funcionalidadeEventos"})
@Entity
@Table(name = "EVENTO", uniqueConstraints = { @UniqueConstraint(columnNames = { "NOME" }) })
public class Evento implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID", nullable = false)
	private Long id;
	
	@Column(name = "NOME", nullable = false, length = 50)
	private String nome;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "evento", fetch = FetchType.EAGER)
	private Set<FuncionalidadeEvento> funcionalidadeEventos = new HashSet<>();

}
