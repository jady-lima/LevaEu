package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.DTO.DriverResponseDTO;
import br.com.ufrn.levaeu.DTO.RideResponseDTO;
import br.com.ufrn.levaeu.errors.InvalidEntryException;
import br.com.ufrn.levaeu.errors.NotFoundException;
import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.repository.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.repository.RideRepository;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class RideService {
	
	@Autowired
	private RideRepository rideRepository;
    @Autowired
    private LocationRepository locationRepository;

	public Ride createRide(Ride ride) {
		ride.setDepartureLocation(locationRepository.save(ride.getDepartureLocation()));
		ride.setDestinationLocation(locationRepository.save(ride.getDestinationLocation()));
		return rideRepository.save(ride);
	}
	
	public void validateRide(Ride ride) throws EmptyEntryException, InvalidEntryException{
		if(ride.getDepartureLocation() == null) {
			throw new EmptyEntryException("Adicione um local de Destino.");
			}
		if(ride.getDestinationLocation() == null) {
			throw new EmptyEntryException("Adicione um local de partida");
			}
		if(ride.getDepartureTime() == null) {
			throw new EmptyEntryException( "Defina um horario de partida");
			}
		if(ride.getDepartureLocation().getName().equalsIgnoreCase(ride.getDestinationLocation().getName())){
			throw new InvalidEntryException("o local de chegada deve ser diferente do local de partida.");
			}
		}

	public List<Ride> findAllRides() {
		return rideRepository.findAll();
	}



	public List<Ride> filterRidesByTime(List<Ride> rides) {
		Iterator<Ride> iterator = rides.iterator();
		while (iterator.hasNext()) {
			Ride ride = iterator.next();
			if (ride.getDepartureTime().isBefore(LocalDateTime.now())) {
				iterator.remove();
			}
		}
		return rides;
	}

	public List<Ride> filterRidesByDrives(User user, List<Ride> rides) {
		Iterator<Ride> iterator = rides.iterator();
		while (iterator.hasNext()) {
			Ride ride = iterator.next();
			if (ride.getDriver().getId() == user.getId()) {
				iterator.remove();
			}
		}
		return rides;
	}

	public List<RideResponseDTO> convertRidesToResponseDTO(List<Ride> rides) {
		List<RideResponseDTO> ridesResponseDTOS = new ArrayList<>();
		for(Ride ride : rides){
			DriverResponseDTO driver = new DriverResponseDTO(ride.getDriver(), ride.getDriver().getDriverLicense(), ride.getDriver().getCar());
			RideResponseDTO rideResponseDTO = new RideResponseDTO(driver, ride);
			ridesResponseDTOS.add(rideResponseDTO);
		}

		ridesResponseDTOS.sort(Comparator.comparing(ride -> Duration.between(LocalDateTime.now(), ride.getRide().getDepartureTime()).toMinutes()));

		return ridesResponseDTOS;
	}

	public Ride findById(Long idRide) throws NotFoundException {
		Optional<Ride> ride = rideRepository.findById(idRide);
		if(!ride.isPresent()){
			throw new NotFoundException("Corrida não encontrada");
		}
		return ride.get();
	}

	public List<Ride> findRidesByDriver(Driver driver) {
		return rideRepository.findByDriver(driver);
	}
}
