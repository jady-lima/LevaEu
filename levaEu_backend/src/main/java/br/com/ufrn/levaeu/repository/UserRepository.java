package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    public User findByPhoneOrEmail(String phone, String email);

    Optional<User> findByEmail(String email);

    Optional<User> findByPhone(String phone);

    Optional<User> findByEnrollment(String enrollment);
}