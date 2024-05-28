package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.model.Car;
import br.com.ufrn.levaeu.service.CarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/veiculos")
public class CarController {

    @Autowired
    private CarService carService;

    @PostMapping
    public ResponseEntity<Car> criarVeiculo(@RequestBody Car car) {
        Car novoCar = carService.salvarVeiculo(car);
        return ResponseEntity.ok(novoCar);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Car> obterVeiculo(@PathVariable Long id) {
        return carService.buscarVeiculoPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<Car> atualizarVeiculo(@PathVariable Long id, @RequestBody Car car) {
        car.setId(id);
        Car atualizado = carService.salvarVeiculo(car);
        return ResponseEntity.ok(atualizado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarVeiculo(@PathVariable Long id) {
        carService.excluirVeiculo(id);
        return ResponseEntity.ok().build();
    }
}
