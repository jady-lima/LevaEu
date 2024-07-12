package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Car;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CarRepository extends JpaRepository<Car, Long> {
    Optional<Car> findByPlate(String plate);
}
