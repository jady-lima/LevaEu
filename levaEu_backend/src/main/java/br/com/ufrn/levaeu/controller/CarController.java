package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.DTO.DriverDTO;
import br.com.ufrn.levaeu.DTO.DriverResponseDTO;
import br.com.ufrn.levaeu.DTO.UserDTO;
import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.model.Car;
import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
    private AuthenticationManager authenticationManager;
    @Autowired
    private DriverService driverService;
    @Autowired
    private TokenService tokenService;

    @PostMapping
    public UserDTO createCar(@RequestBody DriverDTO driverDTO) {
        String password = driverDTO.driver().getPassword();
        Driver driver = driverDTO.driver();
        String encryptedPassword = new BCryptPasswordEncoder().encode(driver.getPass());
        driver.setPass(encryptedPassword);

        DriverLicense driverLicense = driverDTO.driverLicense();
        Car car = driverDTO.car();

        try {
            carService.validateCar(car);
            carService.save(car);
            // DriveLicense e User já foram validados previamente
            driverLicenseService.save(driverLicense);
            driver = driverService.save(driver, driverLicense, car);

            String emailOrPhone = driver.getEmail() != null ? driver.getEmail() : driver.getPhone();

            UsernamePasswordAuthenticationToken usernamePassword = new UsernamePasswordAuthenticationToken(emailOrPhone, password);
            Authentication auth = authenticationManager.authenticate(usernamePassword);

            String token = tokenService.generateToken((User) auth.getPrincipal());
            return new DriverResponseDTO(driver, token, driver.getDriverLicense(), driver.getCar());
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
