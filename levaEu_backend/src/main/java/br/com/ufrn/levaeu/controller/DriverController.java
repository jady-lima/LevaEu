package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.model.Driver;
import br.com.ufrn.levaeu.service.DriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/api/motoristas")
public class DriverController {

    @Autowired
    private DriverService driverService;

    //Cria um novo motorista no sistema.
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Driver criarMotorista(@RequestBody Driver driver) {
        try {
            Driver newDriver = driverService.save(driver);
            return newDriver;
        } catch (DuplicatedEntryException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        }

    }

    //Atualiza as informações de um motorista existente.
    @PutMapping("/{id}")
    public Driver atualizarMotorista(@PathVariable Long id, @RequestBody Driver driver) {
        driver.setId(id);
        try {
            return driverService.save(driver);
        } catch (DuplicatedEntryException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        }
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
