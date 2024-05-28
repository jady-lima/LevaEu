package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Driver;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DriverRepository extends JpaRepository<Driver, Long> {
}
