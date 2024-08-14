package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.errors.NotFoundException;
import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.model.Car;
import br.com.ufrn.levaeu.repository.DriverRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class DriverService {

    @Autowired
    private DriverRepository driverRepository;

    @Autowired
    private DriverLicenseService driverLicenseService;

    @Autowired
    private CarService carService;
    @Autowired
    private UserService userService;

    @Transactional
    public Driver save(Driver driver, DriverLicense driverLicense, Car car) {
        driver.setDriverLicense(driverLicense);
        driver.setCar(car);

        // Salvar motorista
        return driverRepository.save(driver);
    }

    public Driver save(Driver driver) throws DuplicatedEntryException {
        userService.validateUser(driver);
        return driverRepository.save(driver);
    }

    public Optional<Driver> buscarMotoristaPorId(Long id) {
        return driverRepository.findById(id);
    }

    public void excluirMotorista(Long id) { driverRepository.deleteById(id);
    }

    public Driver findById(Long idDriver) throws NotFoundException {
        Optional<Driver> driver = driverRepository.findById(idDriver);
        if(!driver.isPresent()){
            throw new NotFoundException("Motorista não encontrado");
        }
        return driver.get();
    }
}