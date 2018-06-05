package io.ca.db.model.dto;

import java.util.Set;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class UsuarioDTO {

	private Long id;
	@NotEmpty
	private String nome;
	private String senha;
	private Boolean ativo;
	private Set<GrupoDTO> grupos;
	private Set<PerfilDTO> funcoes;

}
