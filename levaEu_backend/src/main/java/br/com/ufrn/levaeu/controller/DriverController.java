package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.service.DriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/motoristas")
public class DriverController {

    @Autowired
    private DriverService driverService;

    //Cria um novo motorista no sistema.
    @PostMapping
    public ResponseEntity<Driver> criarMotorista(@RequestBody Driver driver) {
        Driver novoDriver = driverService.salvarMotorista(driver);
        return ResponseEntity.ok(novoDriver);
    }

    //Atualiza as informações de um motorista existente.
    @PutMapping("/{id}")
    public ResponseEntity<Driver> atualizarMotorista(@PathVariable Long id, @RequestBody Driver driver) {
        driver.setId(id);
        Driver atualizado = driverService.salvarMotorista(driver);
        return ResponseEntity.ok(atualizado);
    }

    // Retorna informações de um motorista específico.

    @GetMapping("/{id}")
    public ResponseEntity<Driver> obterMotorista(@PathVariable Long id) {
        return driverService.buscarMotoristaPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //Exclui um motorista do sistema.

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarMotorista(@PathVariable Long id) {
        driverService.excluirMotorista(id);
        return ResponseEntity.ok().build();
    }
}
