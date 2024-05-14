package br.com.ufrn.levaeu.repository;

import br.com.ufrn.levaeu.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
}