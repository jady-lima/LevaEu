package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.DTO.DriverDTO;
import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.model.Car;
import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.service.CarService;
import br.com.ufrn.levaeu.service.DriverLicenseService;
import br.com.ufrn.levaeu.service.DriverService;
import br.com.ufrn.levaeu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/veiculos")
public class CarController {

    @Autowired
    private CarService carService;
    @Autowired
    private DriverLicenseService driverLicenseService;
    @Autowired
    private UserService userService;
    @Autowired
    private DriverService driverService;

    @PostMapping
    public Car createCar(@RequestBody DriverDTO driverDTO) {
        Driver driver = driverDTO.driver();
        DriverLicense driverLicense = driverDTO.driverLicense();
        Car car = driverDTO.car();
        try {
            carService.validateCar(car);
            Car newCar = carService.save(car);
            // DriveLicense e User já foram validados previamente
            driverLicenseService.save(driverLicense);
            driverService.save(driver, driverLicense, car);
            return newCar;
        } catch (DuplicatedEntryException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Car> obterVeiculo(@PathVariable Long id) {
        return carService.buscarVeiculoPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Car> atualizarVeiculo(@PathVariable Long id, @RequestBody Car car) {
        car.setId(id);
        Car atualizado = carService.save(car);
        return ResponseEntity.ok(atualizado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarVeiculo(@PathVariable Long id) {
        carService.excluirVeiculo(id);
        return ResponseEntity.ok().build();
    }
}
