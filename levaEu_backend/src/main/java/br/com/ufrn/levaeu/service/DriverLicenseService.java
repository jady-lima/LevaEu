package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.repository.DriverLicenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
public class DriverLicenseService {

    @Autowired
    private DriverLicenseRepository driverLicenseRepository;

    public DriverLicense validarECriar(DriverLicense driverLicense) {
        // Implementar validação da CNH
        return driverLicense;
    }

    public DriverLicense save(DriverLicense driverLicense) {
        return driverLicenseRepository.save(driverLicense);
    }

    public void validateDriverLicense(DriverLicense driverLicense) throws Exception {
        if(driverLicenseRepository.findBycpf(driverLicense.getCPF()).isPresent()){
            throw new DuplicatedEntryException("Já existe uma CNH cadastrada com esse CPF");
        }
        if(driverLicenseRepository.findByRegistrationNumber(driverLicense.getRegistrationNumber()).isPresent()){
            throw new DuplicatedEntryException("Essa CNH já está vinculada a outro usuário");
        }
        if(driverLicense.getExpirationDate().isBefore(LocalDate.now())){
            throw new Exception("A CNH está vencida");
        }
    }

    public Optional<DriverLicense> buscarCNHPorId(Long id) {
        return driverLicenseRepository.findById(id);
    }

    public void excluirCNH(Long id) {
        driverLicenseRepository.deleteById(id);
    }

}
