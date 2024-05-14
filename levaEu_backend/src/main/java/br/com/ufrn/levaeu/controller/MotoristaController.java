package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.model.Motorista;
import br.com.ufrn.levaeu.service.MotoristaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/motoristas")
public class MotoristaController {

    @Autowired
    private MotoristaService motoristaService;

    //Cria um novo motorista no sistema.
    @PostMapping
    public ResponseEntity<Motorista> criarMotorista(@RequestBody Motorista motorista) {
        Motorista novoMotorista = motoristaService.salvarMotorista(motorista);
        return ResponseEntity.ok(novoMotorista);
    }

    //Atualiza as informações de um motorista existente.
    @PutMapping("/{id}")
    public ResponseEntity<Motorista> atualizarMotorista(@PathVariable Long id, @RequestBody Motorista motorista) {
        motorista.setId(id);
        Motorista atualizado = motoristaService.salvarMotorista(motorista);
        return ResponseEntity.ok(atualizado);
    }

    // Retorna informações de um motorista específico.

    @GetMapping("/{id}")
    public ResponseEntity<Motorista> obterMotorista(@PathVariable Long id) {
        return motoristaService.buscarMotoristaPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //Exclui um motorista do sistema.

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarMotorista(@PathVariable Long id) {
        motoristaService.excluirMotorista(id);
        return ResponseEntity.ok().build();
    }
}
