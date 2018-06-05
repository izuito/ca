package io.ca.db.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import io.ca.db.model.Perfil;

public interface PerfilRepository extends JpaRepository<Perfil, Long> {

	@Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM Perfil u WHERE u.nome = ?1")
	boolean exists(String nome);

	Perfil findByNome(String nome);
	
	List<Perfil> findByNomeStartingWith(String nome);
	
}
