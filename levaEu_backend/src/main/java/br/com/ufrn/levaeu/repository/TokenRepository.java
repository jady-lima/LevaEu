package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Token;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TokenRepository extends JpaRepository<Token, Long> {

    @Query("select t from Token t join User u on t.user.id = u.id where u.id = :idUser and (t.expired = false or t.revoked = false)")
    List<Token> findAllValidTokensByUser(Long idUser);

    Optional<Token> findByToken(String token);
}
