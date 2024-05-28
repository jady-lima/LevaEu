package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.service.DriverService;
import br.com.ufrn.levaeu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private DriverService driverService;

    @GetMapping
    public ResponseEntity<List<User>> listarTodos() {
        System.out.println("Listando todos os usuários");
        List<User> users = userService.listarTodos();
        return ResponseEntity.ok(users);
    }

    @PostMapping
    public ResponseEntity<User> adicionarUsuario(@RequestBody User user) {
        System.out.println("Recebendo usuário: " + user);
        User novoUser = userService.createUser(user);
        if (novoUser != null && novoUser.getId() != null) {
            return ResponseEntity.ok(novoUser);
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> buscarPorId(@PathVariable Long id) {
        return userService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        userService.excluir(id);
        return ResponseEntity.ok().build();
    }
}