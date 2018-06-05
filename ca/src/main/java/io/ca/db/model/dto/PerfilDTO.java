package io.ca.db.model.dto;

import java.util.Set;

import org.hibernate.validator.constraints.NotEmpty;

import io.ca.db.model.Usuario;
import lombok.Data;

@Data
public class PerfilDTO {

	private Long id;
	@NotEmpty
	private String nome;
	private Set<GrupoDTO> grupos;
	private Set<Usuario> usuarios;

}
