package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.Location;
import br.com.ufrn.levaeu.repository.LocationRepository;
import org.springframework.stereotype.Service;

@Service
public class LocationService {

    private final LocationRepository locationRepository;

    public LocationService(LocationRepository locationRepository) {
        this.locationRepository = locationRepository;
    }

    public Location create(Location location) {
        return locationRepository.save(location);
    }
}
