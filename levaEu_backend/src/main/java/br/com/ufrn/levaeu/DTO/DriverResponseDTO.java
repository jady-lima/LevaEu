package br.com.ufrn.levaeu.DTO;

import br.com.ufrn.levaeu.model.Car;
import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.model.User;

public class DriverResponseDTO extends UserDTO{

    private DriverLicense driverLicense;
    private Car car;

    public DriverResponseDTO(User user, String token, DriverLicense driverLicense, Car car) {
        super(user, token);
        this.driverLicense = driverLicense;
        this.car = car;
    }

    public DriverLicense getDriverLicense() {
        return driverLicense;
    }

    public void setDriverLicense(DriverLicense driverLicense) {
        this.driverLicense = driverLicense;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }
}
