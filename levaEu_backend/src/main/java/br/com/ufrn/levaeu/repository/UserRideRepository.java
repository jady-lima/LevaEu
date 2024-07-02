package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.model.UserRide;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRideRepository extends JpaRepository<UserRide, Long> {
    List<UserRide> findAllUserRideByRide(Ride ride);

    Optional<UserRide> findByRideAndUser(Ride ride, User user);
}
