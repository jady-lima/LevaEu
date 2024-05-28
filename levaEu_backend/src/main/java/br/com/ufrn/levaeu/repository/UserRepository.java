package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    public User findByPhoneOrEmail(String phone, String email);

}