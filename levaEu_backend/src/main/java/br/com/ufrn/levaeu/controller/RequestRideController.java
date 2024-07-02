package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.DTO.RequestRideDTO;
import br.com.ufrn.levaeu.DTO.RequesterRideDTO;
import br.com.ufrn.levaeu.DTO.UserDTO;
import br.com.ufrn.levaeu.errors.NotFoundException;
import br.com.ufrn.levaeu.model.Location;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.model.UserRide;
import br.com.ufrn.levaeu.service.LocationService;
import br.com.ufrn.levaeu.service.RideService;
import br.com.ufrn.levaeu.service.UserRideService;
import br.com.ufrn.levaeu.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/request-ride")
public class RequestRideController {


    private final RideService rideService;
    private final UserService userService;
    private final LocationService locationService;
    private final UserRideService userRideService;

    public RequestRideController(RideService rideService, UserService userService, LocationService locationService, UserRideService userRideService) {
        this.rideService = rideService;
        this.userService = userService;
        this.locationService = locationService;
        this.userRideService = userRideService;
    }

    @PostMapping()
    public String addUserToRide(@RequestBody RequestRideDTO requestRideDTO) {
        try {
            Ride ride = rideService.findById(requestRideDTO.idRide());
            User user = userService.findById(requestRideDTO.idUser());

            Location stopPoint = locationService.create(requestRideDTO.stopPoint());

            UserRide userRide = new UserRide(ride, user, stopPoint, requestRideDTO.isDeparture());

            userRideService.addUserToRide(userRide);

            return "Deu certo";
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @PostMapping("/confirm/{idUser}/{idRide}")
    public UserRide confirmUserInRide(@PathVariable Long idUser, @PathVariable Long idRide) {
        try {
            User user = userService.findById(idUser);
            Ride ride = rideService.findById(idRide);
            UserRide userRide = userRideService.findUserRideByRideAndUser(ride, user);
            userRide.setConfirmed(true);

            return userRideService.addUserToRide(userRide);
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @GetMapping("/{idRide}")
    public List<RequesterRideDTO> findAll(@PathVariable Long idRide){
        try {
            Ride ride = rideService.findById(idRide);
            List<UserRide> userRides = userRideService.findAllUserRideByRide(ride);

            userRides = userRideService.filterByTime(userRides);

            List<RequesterRideDTO> requestersRide = new ArrayList<>();

            for(UserRide userRide : userRides){
                UserDTO userDTO = new UserDTO(userRide.getUser());
                requestersRide.add(new RequesterRideDTO(userRide, userDTO));
            }

            return requestersRide;
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @GetMapping("/user/{idUser}")
    public List<RequesterRideDTO> findAllRequestRidesByUser(@PathVariable Long idUser) {
        try {
            User user = userService.findById(idUser);

            List<UserRide> userRides = userRideService.findAllUserRideByUser(user);

            userRides = userRideService.filterByTime(userRides);

            List<RequesterRideDTO> requestersRide = new ArrayList<>();

            for(UserRide userRide : userRides){
                UserDTO userDTO = new UserDTO(userRide.getUser());
                requestersRide.add(new RequesterRideDTO(userRide, userDTO));
            }

            return requestersRide;
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @DeleteMapping("/user/{idUser}/{idRide}")
    public UserRide removeUserRequestFromRide(@PathVariable Long idUser, @PathVariable Long idRide) {
        try {
            User user = userService.findById(idUser);
            Ride ride = rideService.findById(idRide);
            UserRide userRide = userRideService.findUserRideByRideAndUser(ride, user);
            userRideService.removeUserRequestFromRide(userRide);

            return userRide;
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    @DeleteMapping("/confirm/{idUser}/{idRide}")
    public UserRide disconfirmUserInRide(@PathVariable Long idUser, @PathVariable Long idRide) {
        try {
            User user = userService.findById(idUser);
            Ride ride = rideService.findById(idRide);
            UserRide userRide = userRideService.findUserRideByRideAndUser(ride, user);
            userRide.setConfirmed(false);

            return userRideService.addUserToRide(userRide);
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }
}
