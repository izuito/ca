package io.ca.db.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import io.ca.db.model.Components;

public interface ComponentsRepository extends JpaRepository<Components, Long> {

}
