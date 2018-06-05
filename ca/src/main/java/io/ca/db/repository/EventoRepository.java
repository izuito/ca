package io.ca.db.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import io.ca.db.model.Evento;

public interface EventoRepository extends JpaRepository<Evento, Long> {

}
