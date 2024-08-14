package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.errors.DuplicatedEntryException;
import br.com.ufrn.levaeu.errors.EmptyEntryException;
import br.com.ufrn.levaeu.errors.NotFoundException;
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

    public void validateUser(User user) throws DuplicatedEntryException {
        if(userRepository.findByEmail(user.getEmail()).isPresent()){
            throw new DuplicatedEntryException("Já existe um usuário cadastrado com esse email");
        }
        if(userRepository.findByPhone(user.getPhone()).isPresent()){
            throw new DuplicatedEntryException("Já existe um usuário cadastrado com esse telefone");
        }
        if(userRepository.findByEnrollment(user.getEnrollment()).isPresent()){
            throw new DuplicatedEntryException("Já existe um usuário cadastrado com essa matrícula");
        }
    }

    public User findByEmailOrPhone(String emailOrPhone) {
        return userRepository.findByPhoneOrEmail(emailOrPhone, emailOrPhone);
    }

    public User findById(Long idUser) throws NotFoundException {
        Optional<User> user = userRepository.findById(idUser);
        if(!user.isPresent()){
            throw new NotFoundException("Usuário não encontrado");
        }
        return user.get();
    }
}