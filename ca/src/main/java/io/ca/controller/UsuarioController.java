package io.ca.controller;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.ca.db.model.Usuario;
import io.ca.db.model.dto.UsuarioDTO;
import io.ca.db.repository.UsuarioRepository;

@RestController
@RequestMapping("/v1/usuarios")
public class UsuarioController {
	
	private final UsuarioRepository ur;

	public UsuarioController(UsuarioRepository fr) {
		this.ur = fr;
	}
	
	@PostMapping
	public ResponseEntity<Object> post(@Validated @RequestBody UsuarioDTO dto) {
		if (ur.exists(dto.getNome())) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		dto.setId(null);

		Usuario entity = mapper(dto);

		ur.save(entity);

		return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@PutMapping(value = "/{id}")
	public ResponseEntity<Object> put(@PathVariable Long id, @Validated @RequestBody UsuarioDTO dto) {
		if (!ur.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		dto.setId(id);

		Usuario entity = mapper(dto);

		Usuario current = ur.findByNome(entity.getNome());

		if (!current.equals(entity)) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		ur.save(entity);

		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Object> delete(@PathVariable Long id) {
		if (!ur.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		ur.delete(id);

		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(value = "/{id}")
	public ResponseEntity<Object> get(@PathVariable Long id) {
		if (!ur.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		Usuario entity = ur.findOne(id);

		UsuarioDTO dto = mapper(entity);

		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	@GetMapping
	public ResponseEntity<List<UsuarioDTO>> get() {
		List<Usuario> entities = ur.findAll();

		List<UsuarioDTO> dtos = mapper(entities);

		return new ResponseEntity<>(dtos, HttpStatus.OK);
	}
	
	@GetMapping(value="/{nome}/nome")
	public ResponseEntity<List<UsuarioDTO>> get(@PathVariable String nome) {
		if (!StringUtils.hasText(nome)) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		List<Usuario> entities = ur.findByNomeStartingWith(nome);

		List<UsuarioDTO> dtos = mapper(entities);

		return new ResponseEntity<>(dtos, HttpStatus.OK);
	}

	private List<UsuarioDTO> mapper(List<Usuario> entities) {
		return entities.stream()
						.map(entity -> mapper(entity))
						.collect(Collectors.toList());
	}

	private UsuarioDTO mapper(Usuario entity) {
		UsuarioDTO dto = new UsuarioDTO();
		dto.setAtivo(entity.getAtivo());
		dto.setId(entity.getId());
		dto.setNome(entity.getNome());
		dto.setSenha(entity.getSenha());
		return dto;
	}

	private Usuario mapper(UsuarioDTO dto) {
		Usuario entity = new Usuario();
		entity.setAtivo(Optional.ofNullable(dto.getAtivo()).orElse(Boolean.TRUE));
		entity.setId(dto.getId());
		entity.setNome(dto.getNome());
		entity.setSenha(dto.getSenha());
		return entity;
	}

}
