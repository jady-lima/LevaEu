package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.errors.NotFoundException;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.model.UserRide;
import br.com.ufrn.levaeu.repository.UserRideRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserRideService {

    private final UserRideRepository userRideRepository;

    public UserRideService(UserRideRepository userRideRepository) {
        this.userRideRepository = userRideRepository;
    }

    public UserRide addUserToRide(UserRide userRide){
       return userRideRepository.save(userRide);
    }

    public List<UserRide> findAllUserRideByRide(Ride ride) {
        return userRideRepository.findAllUserRideByRide(ride);
    }

    public UserRide findUserRideByRideAndUser(Ride ride, User user) throws NotFoundException {
        Optional<UserRide> userRide = userRideRepository.findByRideAndUser(ride, user);
        if(!userRide.isPresent()){
            throw new NotFoundException("Solicitação de usuário não foi encontrada, atualize a lista de solicitações!");
        }
        return userRide.get();
    }
}
