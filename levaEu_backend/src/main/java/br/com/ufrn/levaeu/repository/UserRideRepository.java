package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.UserRide;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRideRepository extends JpaRepository<UserRide, Long> {
}
