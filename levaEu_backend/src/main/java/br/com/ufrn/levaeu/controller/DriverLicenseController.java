package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.model.DriverLicense;
import br.com.ufrn.levaeu.service.DriverLicenseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cnhs")
public class DriverLicenseController {

    @Autowired
    private DriverLicenseService driverLicenseService;

    @PostMapping
    public ResponseEntity<DriverLicense> criarCNH(@RequestBody DriverLicense driverLicense) {
        DriverLicense novaDriverLicense = driverLicenseService.salvarCNH(driverLicense);
        return ResponseEntity.ok(novaDriverLicense);
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
        DriverLicense atualizada = driverLicenseService.salvarCNH(driverLicense);
        return ResponseEntity.ok(atualizada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarCNH(@PathVariable Long id) {
        driverLicenseService.excluirCNH(id);
        return ResponseEntity.ok().build();
    }
}