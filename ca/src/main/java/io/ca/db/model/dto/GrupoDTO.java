package io.ca.db.model.dto;

import java.util.Set;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class GrupoDTO {

	private Long id;
	@NotEmpty
	private String nome;
	private Set<PerfilDTO> funcoes;
	private Set<UsuarioDTO> usuarios;
	
}
