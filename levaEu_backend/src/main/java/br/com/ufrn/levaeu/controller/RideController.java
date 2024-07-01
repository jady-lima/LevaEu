package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.DTO.DriverDTO;
import br.com.ufrn.levaeu.DTO.DriverResponseDTO;
import br.com.ufrn.levaeu.DTO.RideDTO;
import br.com.ufrn.levaeu.DTO.RideResponseDTO;
import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.errors.InvalidEntryException;
import br.com.ufrn.levaeu.errors.NotFoundException;
import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.service.DriverLicenseService;
import br.com.ufrn.levaeu.service.DriverService;
import br.com.ufrn.levaeu.service.RideService;
import br.com.ufrn.levaeu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
			return new RideResponseDTO(driverDTO, ride);
		} catch (InvalidEntryException | EmptyEntryException err) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, err.getMessage());
		} catch (NotFoundException e) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
		}
    }

	@GetMapping("/{idUser}")
	public List<Ride> findAllRides(@PathVariable Long idUser){
        try {
            userService.findById(idUser);
        } catch (NotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
        return rideService.findAllRides();
	}

}
