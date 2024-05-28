package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.repository.DriverLicenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class DriverLicenseService {

    @Autowired
    private DriverLicenseRepository driverLicenseRepository;

    public DriverLicense validarECriar(DriverLicense driverLicense) {
        // Implementar validação da CNH
        return driverLicense;
    }

    public DriverLicense salvarCNH(DriverLicense driverLicense) {
        return driverLicenseRepository.save(driverLicense);
    }

    public Optional<DriverLicense> buscarCNHPorId(Long id) {
        return driverLicenseRepository.findById(id);
    }

    public void excluirCNH(Long id) {
        driverLicenseRepository.deleteById(id);
    }
}
