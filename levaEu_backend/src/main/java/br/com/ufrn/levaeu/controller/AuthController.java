package br.com.ufrn.levaeu.controller;

import br.com.ufrn.levaeu.DTO.AuthDTO;
import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.service.TokenService;
import br.com.ufrn.levaeu.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final TokenService tokenService;
    private final UserService userService;

    public AuthController(AuthenticationManager authenticationManager, TokenService tokenService, UserService userService) {
        this.authenticationManager = authenticationManager;
        this.tokenService = tokenService;
        this.userService = userService;
    }

    @PostMapping("/login")
    public String login(@RequestBody AuthDTO authDTO){
        String token = "";
        try {
            String emailOrPhone = !authDTO.email().equals("") ? authDTO.email() : authDTO.phone();
            UsernamePasswordAuthenticationToken usernamePassword = new UsernamePasswordAuthenticationToken(emailOrPhone, authDTO.pass());
            Authentication auth = authenticationManager.authenticate(usernamePassword);

            token = tokenService.generateToken((User) auth.getPrincipal());
            return token;
        } catch (Exception err) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/register")
    public User register(@RequestBody User user){
        String encryptedPassword = new BCryptPasswordEncoder().encode(user.getPass());
        user.setPass(encryptedPassword);

        try {
            userService.validateUser(user);
        } catch (DuplicatedEntryException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        }

        if(user.getTypeUser().getName().equalsIgnoreCase("driver")) {
            return user;
        }

        userService.createUser(user);
        return user;
    }

//    @PostMapping("/logout")
//    public ResponseEntity<String> logout(){
//        return ResponseEntity.ok("Logout realizado com sucesso!");
//    }
}
