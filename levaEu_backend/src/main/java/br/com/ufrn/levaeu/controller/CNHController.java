package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.model.CNH;
import br.com.ufrn.levaeu.service.CNHService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cnhs")
public class CNHController {

    @Autowired
    private CNHService cnhService;

    @PostMapping
    public ResponseEntity<CNH> criarCNH(@RequestBody CNH cnh) {
        CNH novaCNH = cnhService.salvarCNH(cnh);
        return ResponseEntity.ok(novaCNH);
    }

    @GetMapping("/{id}")
    public ResponseEntity<CNH> obterCNH(@PathVariable Long id) {
        return cnhService.buscarCNHPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<CNH> atualizarCNH(@PathVariable Long id, @RequestBody CNH cnh) {
        cnh.setId(id);
        CNH atualizada = cnhService.salvarCNH(cnh);
        return ResponseEntity.ok(atualizada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletarCNH(@PathVariable Long id) {
        cnhService.excluirCNH(id);
        return ResponseEntity.ok().build();
    }
}