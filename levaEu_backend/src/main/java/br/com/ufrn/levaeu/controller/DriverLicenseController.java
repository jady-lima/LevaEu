package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.service.DriverLicenseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/cnhs")
public class DriverLicenseController {

    @Autowired
    private DriverLicenseService driverLicenseService;

    @PostMapping
    public DriverLicense createDriverLicense(@RequestBody DriverLicense driverLicense) {
        try {
            driverLicenseService.validateDriverLicense(driverLicense);
            return driverLicense;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<DriverLicense> obterCNH(@PathVariable Long id) {
        return driverLicenseService.buscarCNHPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<DriverLicense> atualizarCNH(@PathVariable Long id, @RequestBody DriverLicense driverLicense) {
        driverLicense.setId(id);
        DriverLicense atualizada = driverLicenseService.save(driverLicense);
        return ResponseEntity.ok(atualizada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarCNH(@PathVariable Long id) {
        driverLicenseService.excluirCNH(id);
        return ResponseEntity.ok().build();
    }
}