package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.errors.InvalidEntryException;
import br.com.ufrn.levaeu.repository.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.repository.RideRepository;

import java.util.List;

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
}
