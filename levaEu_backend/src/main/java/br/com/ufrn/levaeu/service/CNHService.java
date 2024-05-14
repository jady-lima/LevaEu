package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.CNH;
import br.com.ufrn.levaeu.repository.CNHRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CNHService {

    @Autowired
    private CNHRepository cnhRepository;

    public CNH validarECriar(CNH cnh) {
        // Implementar validação da CNH
        return cnh;
    }

    public CNH salvarCNH(CNH cnh) {
        return cnhRepository.save(cnh);
    }

    public Optional<CNH> buscarCNHPorId(Long id) {
        return cnhRepository.findById(id);
    }

    public void excluirCNH(Long id) {
        cnhRepository.deleteById(id);
    }
}
