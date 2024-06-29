package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.DriverLicense;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DriverLicenseRepository extends JpaRepository<DriverLicense, Long> {
    Optional<DriverLicense> findBycpf(String numeroCPF);

    Optional<DriverLicense> findByRegistrationNumber(String registrationNumber);
}