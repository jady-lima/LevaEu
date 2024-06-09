package br.com.ufrn.levaeu.DTO;

import br.com.ufrn.levaeu.model.Car;
import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.model.DriverLicense;

public record DriverDTO(Driver driver, DriverLicense driverLicense, Car car) {
}
