package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> listarTodos() {
        return userRepository.findAll();
    }

    public Optional<User> buscarPorId(Long id) {
        return userRepository.findById(id);
    }

    public void excluir(Long id) {
        userRepository.deleteById(id);
    }

    public User createUser(User user) {
        return userRepository.save(user);
    }
}