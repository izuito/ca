package io.ca.db.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import io.ca.db.model.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

	@Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM Usuario u WHERE u.nome = ?1")
	boolean exists(String nome);

	Usuario findByNome(String nome);

	List<Usuario> findByNomeStartingWith(String nome);
	
}
