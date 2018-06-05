package io.ca.controller;

import java.util.List;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.ca.db.model.Perfil;
import io.ca.db.model.dto.PerfilDTO;
import io.ca.db.repository.PerfilRepository;

@RestController
@RequestMapping("/v1/perfis")
public class PerfilController {

	private final PerfilRepository fr;

	public PerfilController(PerfilRepository fr) {
		this.fr = fr;
	}

	@PostMapping
	public ResponseEntity<Object> post(@Validated @RequestBody PerfilDTO dto) {
		if (fr.exists(dto.getNome())) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		dto.setId(null);

		Perfil entity = mapper(dto);

		fr.save(entity);

		return new ResponseEntity<>(HttpStatus.CREATED);
	}

	@PutMapping(value = "/{id}")
	public ResponseEntity<Object> put(@PathVariable Long id, @Validated @RequestBody PerfilDTO dto) {
		if (!fr.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		dto.setId(id);

		Perfil entity = mapper(dto);

		Perfil current = fr.findByNome(entity.getNome());

		if (!current.equals(entity)) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		fr.save(entity);

		return new ResponseEntity<>(HttpStatus.OK);
	}

	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Object> delete(@PathVariable Long id) {
		if (!fr.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		fr.delete(id);

		return new ResponseEntity<>(HttpStatus.OK);
	}

	@GetMapping(value = "/{id}")
	public ResponseEntity<Object> get(@PathVariable Long id) {
		if (!fr.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		Perfil entity = fr.findOne(id);

		PerfilDTO dto = mapper(entity);

		return new ResponseEntity<>(dto, HttpStatus.OK);
	}

	@GetMapping
	public ResponseEntity<List<PerfilDTO>> get() {
		List<Perfil> entities = fr.findAll();

		List<PerfilDTO> dtos = mapper(entities);

		return new ResponseEntity<>(dtos, HttpStatus.OK);
	}

	@GetMapping(value="/{nome}/nome")
	public ResponseEntity<List<PerfilDTO>> get(@PathVariable String nome) {
		if (nome == null) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		List<Perfil> entities = fr.findByNomeStartingWith(nome);

		List<PerfilDTO> dtos = mapper(entities);

		return new ResponseEntity<>(dtos, HttpStatus.OK);
	}

	private List<PerfilDTO> mapper(List<Perfil> entities) {
		return entities.stream().map(entity -> mapper(entity)).collect(Collectors.toList());
	}

	private Perfil mapper(PerfilDTO dto) {
		Perfil entity = new Perfil();
		entity.setId(dto.getId());
		entity.setNome(dto.getNome());
		return entity;
	}

	private PerfilDTO mapper(Perfil entity) {
		PerfilDTO dto = new PerfilDTO();
		dto.setId(entity.getId());
		dto.setNome(entity.getNome());
		return dto;
	}

}
