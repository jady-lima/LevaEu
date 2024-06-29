package br.com.ufrn.levaeu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import br.com.ufrn.levaeu.model.Ride;
import org.springframework.stereotype.Repository;

@Repository
public interface RideRepository extends JpaRepository<Ride, Long> {
}
