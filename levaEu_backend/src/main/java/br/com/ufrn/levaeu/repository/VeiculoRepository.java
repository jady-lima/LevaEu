package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Veiculo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VeiculoRepository extends JpaRepository<Veiculo, Long> {
}
