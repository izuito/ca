package io.ca.db.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import io.ca.db.model.Grupo;

public interface GrupoRepository extends JpaRepository<Grupo, Long> {

	@Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM Grupo u WHERE u.nome = ?1")
	boolean exists(String nome);

	Grupo findByNome(String nome);

	List<Grupo> findByNomeStartingWith(String nome);
	
}
