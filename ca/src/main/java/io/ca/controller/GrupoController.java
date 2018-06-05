package io.ca.controller;

import java.util.List;
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

import io.ca.db.model.Grupo;
import io.ca.db.model.dto.GrupoDTO;
import io.ca.db.repository.GrupoRepository;

@RestController
@RequestMapping("/v1/grupos")
public class GrupoController {
	
	private final GrupoRepository gr;

	public GrupoController(GrupoRepository fr) {
		this.gr = fr;
	}
	
	@PostMapping
	public ResponseEntity<Object> post(@Validated @RequestBody GrupoDTO dto) {
		if (gr.exists(dto.getNome())) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		dto.setId(null);

		Grupo entity = mapper(dto);

		gr.save(entity);

		return new ResponseEntity<>(HttpStatus.CREATED);
	}
	
	@PutMapping(value = "/{id}")
	public ResponseEntity<Object> put(@PathVariable Long id, @Validated @RequestBody GrupoDTO dto) {
		if (!gr.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		dto.setId(id);

		Grupo entity = mapper(dto);

		Grupo current = gr.findByNome(entity.getNome());

		if (!current.equals(entity)) {
			return new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		gr.save(entity);

		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Object> delete(@PathVariable Long id) {
		if (!gr.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		gr.delete(id);

		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@GetMapping(value = "/{id}")
	public ResponseEntity<Object> get(@PathVariable Long id) {
		if (!gr.exists(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		Grupo entity = gr.findOne(id);

		GrupoDTO dto = mapper(entity);

		return new ResponseEntity<>(dto, HttpStatus.OK);
	}
	
	@GetMapping
	public ResponseEntity<List<GrupoDTO>> get() {
		List<Grupo> entities = gr.findAll();

		List<GrupoDTO> dtos = mapper(entities);

		return new ResponseEntity<>(dtos, HttpStatus.OK);
	}
	
	@GetMapping(value="/{nome}/nome")
	public ResponseEntity<List<GrupoDTO>> get(@PathVariable String nome) {
		if (!StringUtils.hasText(nome)) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		List<Grupo> entities = gr.findByNomeStartingWith(nome);

		List<GrupoDTO> dtos = mapper(entities);

		return new ResponseEntity<>(dtos, HttpStatus.OK);
	}

	private List<GrupoDTO> mapper(List<Grupo> entities) {
		return entities.stream().map(entity -> mapper(entity)).collect(Collectors.toList());
	}

	private GrupoDTO mapper(Grupo entity) {
		GrupoDTO dto = new GrupoDTO();
		dto.setId(entity.getId());
		dto.setNome(entity.getNome());
		return dto;
	}

	private Grupo mapper(GrupoDTO dto) {
		Grupo grupo = new Grupo();
		grupo.setId(dto.getId());
		grupo.setNome(dto.getNome());
		return grupo;
	}

}
