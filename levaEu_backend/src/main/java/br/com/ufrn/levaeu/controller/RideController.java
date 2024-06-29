package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.service.DriverLicenseService;
import br.com.ufrn.levaeu.service.RideService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/rides")
public class RideController {
		
		@Autowired
	    private RideService rideService;
		
		@PostMapping 
		public Ride createRide(@RequestBody Ride ride) {
			try {
				rideService.validateRide(ride);
				return rideService.createRide(ride);
			} catch (DuplicatedEntryException | EmptyEntryException err) {
				throw new ResponseStatusException(HttpStatus.BAD_REQUEST, err.getMessage());
			}
        }

}
