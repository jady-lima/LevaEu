package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Motorista;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MotoristaRepository extends JpaRepository<Motorista, Long> {
}
