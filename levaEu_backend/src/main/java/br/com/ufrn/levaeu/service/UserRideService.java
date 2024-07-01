package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.model.UserRide;
import br.com.ufrn.levaeu.repository.UserRideRepository;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
