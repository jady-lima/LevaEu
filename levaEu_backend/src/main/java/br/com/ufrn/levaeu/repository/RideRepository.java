package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Driver;
import org.springframework.data.jpa.repository.JpaRepository;
import br.com.ufrn.levaeu.model.Ride;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RideRepository extends JpaRepository<Ride, Long> {
    List<Ride> findByDriver(Driver driver);
}
