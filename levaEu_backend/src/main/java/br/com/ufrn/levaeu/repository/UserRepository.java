package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    public User findByPhoneOrEmail(String phone, String email);

    Optional<User> findByEmail(String email);

    Optional<User> findByPhone(String phone);

    Optional<User> findByEnrollment(String enrollment);
}