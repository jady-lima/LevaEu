package br.com.ufrn.levaeu.service;

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

    @Transactional
    public Driver salvarMotorista(Driver driver) {
        // Verificar e processar CNH
        DriverLicense driverLicense = driverLicenseService.validarECriar(driver.getDriverLicense());
        driver.setDriverLicense(driverLicense);

        // Verificar e processar veículo
        Car car = carService.validarECriar(driver.getCar());
        driver.setCar(car);

        // Salvar motorista
        return driverRepository.save(driver);
    }

    public Optional<Driver> buscarMotoristaPorId(Long id) {
        return driverRepository.findById(id);
    }

    public void excluirMotorista(Long id) { driverRepository.deleteById(id);
    }
}