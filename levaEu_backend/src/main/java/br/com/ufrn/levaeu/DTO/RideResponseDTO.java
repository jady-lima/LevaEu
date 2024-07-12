package br.com.ufrn.levaeu.DTO;

import br.com.ufrn.levaeu.model.Ride;

public class RideResponseDTO {

    private DriverResponseDTO driver;
    private Ride ride;

    public RideResponseDTO(DriverResponseDTO driver, Ride ride) {
        this.driver = driver;
        this.ride = ride;
    }

    public RideResponseDTO(Ride ride) {
        this.ride = ride;
    }

    public DriverResponseDTO getDriver() {
        return driver;
    }

    public void setDriver(DriverResponseDTO driver) {
        this.driver = driver;
    }

    public Ride getRide() {
        return ride;
    }

    public void setRide(Ride ride) {
        this.ride = ride;
    }
}
