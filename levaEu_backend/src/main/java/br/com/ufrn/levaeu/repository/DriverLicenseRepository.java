package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.DriverLicense;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DriverLicenseRepository extends JpaRepository<DriverLicense, Long> {
}