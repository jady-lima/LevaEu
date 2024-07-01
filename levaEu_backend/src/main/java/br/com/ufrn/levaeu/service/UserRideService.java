package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.UserRide;
import br.com.ufrn.levaeu.repository.UserRideRepository;
import org.springframework.stereotype.Service;

@Service
public class UserRideService {

    private final UserRideRepository userRideRepository;

    public UserRideService(UserRideRepository userRideRepository) {
        this.userRideRepository = userRideRepository;
    }

    public UserRide addUserToRide(UserRide userRide){
       return userRideRepository.save(userRide);
    }
}
