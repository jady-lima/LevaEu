package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.DTO.DriverResponseDTO;
import br.com.ufrn.levaeu.DTO.RequestRideDTO;
import br.com.ufrn.levaeu.DTO.RideDTO;
import br.com.ufrn.levaeu.DTO.RideResponseDTO;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.errors.InvalidEntryException;
import br.com.ufrn.levaeu.errors.NotFoundException;
import br.com.ufrn.levaeu.model.*;
import br.com.ufrn.levaeu.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/rides")
public class RideController {
		
	@Autowired
	private RideService rideService;
    @Autowired
    private DriverService driverService;
    @Autowired
    private UserService userService;

	@PostMapping
	public RideResponseDTO createRide(@RequestBody RideDTO rideDTO) {
		try {
			rideService.validateRide(rideDTO.ride());
			Driver driver = driverService.findById(rideDTO.idDriver());
			rideDTO.ride().setDriver(driver);
			Ride ride = rideService.createRide(rideDTO.ride());
			DriverResponseDTO driverDTO = new DriverResponseDTO(driver, driver.getDriverLicense(), driver.getCar());
			return new RideResponseDTO(ride);
		} catch (InvalidEntryException | EmptyEntryException err) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, err.getMessage());
		} catch (NotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
		}
    }

	@GetMapping("/{idRide}")
	public RideResponseDTO getRide(@PathVariable Long idRide){
        try {
            Ride ride = rideService.findById(idRide);
			return new RideResponseDTO(ride);
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

	@GetMapping("/list/{idUser}")
	public List<RideResponseDTO> findAllRides(@PathVariable Long idUser){
        try {
            User user = userService.findById(idUser);

			List<Ride> rides = rideService.findAllRides();

			rides = rideService.filterRidesByTime(rides);

			rides = rideService.filterRidesByDrives(user, rides);

			List<RideResponseDTO> ridesResponseDTO = rideService.convertRidesToResponseDTO(rides);

			return ridesResponseDTO;
        } catch (NotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
		}
	}

	@GetMapping("/driver/{idDriver}")
	public List<RideResponseDTO> findRidesByDriver(@PathVariable Long idDriver) {
        try {
            Driver driver = driverService.findById(idDriver);
			List<Ride> rides = rideService.findRidesByDriver(driver);
			rides = rideService.filterRidesByTime(rides);

			return rideService.convertRidesToResponseDTO(rides);
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

}
