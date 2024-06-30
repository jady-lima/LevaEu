package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.errors.InvalidEntryException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.repository.RideRepository;

import java.util.List;

@Service
public class RideService {
	
	@Autowired
	private RideRepository rideRepository;
	
	public Ride createRide(Ride ride) {
		return rideRepository.save(ride);
	}
	
	public void validateRide(Ride ride) throws EmptyEntryException, InvalidEntryException{
		if(ride.getArrivalLocal() == null) {
			throw new EmptyEntryException("Adicione um local de Destino.");
			}
		if(ride.getLeavingLocal() == null) {
			throw new EmptyEntryException("Adicione um local de partida");
			}
		if(ride.getLeavingTime() == null) {
			throw new EmptyEntryException( "Defina um horario de partida");
			}
		if(ride.getArrivalLocal().equalsIgnoreCase(ride.getLeavingLocal())){
			throw new InvalidEntryException("o local de chegada deve ser diferente do local de partida.");
			}
		}

	public List<Ride> findAllRides() {
		return rideRepository.findAll();
	}
}
