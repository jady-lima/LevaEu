package br.com.ufrn.levaeu.repository;


import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.model.User;
import org.springframework.stereotype.Repository;

@Repository
public interface RideRepository extends JpaRepository<Ride, Long> {
	Optional<Ride> findByUser(User user);
	// Optional<Ride> findByArrival(String arrivalLocal);
	// Optional<Ride> findByLeaving(String leavingLocal);
}
