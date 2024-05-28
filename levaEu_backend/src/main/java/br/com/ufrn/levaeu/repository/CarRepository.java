package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Car;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CarRepository extends JpaRepository<Car, Long> {
}
