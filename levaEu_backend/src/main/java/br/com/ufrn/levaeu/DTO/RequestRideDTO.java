package br.com.ufrn.levaeu.DTO;

import br.com.ufrn.levaeu.model.Location;

public record RequestRideDTO(Long idUser, Long idRide, Location stopPoint, Boolean isDeparture) {

}
