package br.com.ufrn.levaeu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.model.Ride;
import br.com.ufrn.levaeu.repository.RideRepository;

@Service
public class RideService {
	
	@Autowired
	private RideRepository rideRepository;
	
	public Ride validarECriar(Ride ride) {
		return rideRepository.save(ride);
	}
	
	public void validateRide(Ride ride) throws Exception{
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
			throw new DuplicatedEntryException("o local de chegada deve ser diferente do local de partida.");
			}
		}
}
