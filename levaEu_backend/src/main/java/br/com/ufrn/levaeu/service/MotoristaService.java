package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.CNH;
import br.com.ufrn.levaeu.model.Motorista;
import br.com.ufrn.levaeu.model.Usuario;
import br.com.ufrn.levaeu.model.Veiculo;
import br.com.ufrn.levaeu.repository.MotoristaRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MotoristaService {

    @Autowired
    private MotoristaRepository motoristaRepository;

    @Autowired
    private CNHService cnhService;

    @Autowired
    private VeiculoService veiculoService;

    @Transactional
    public Motorista salvarMotorista(Motorista motorista) {
        // Verificar e processar CNH
        CNH cnh = cnhService.validarECriar(motorista.getCnh());
        motorista.setCnh(cnh);

        // Verificar e processar veículo
        Veiculo veiculo = veiculoService.validarECriar(motorista.getVeiculo());
        motorista.setVeiculo(veiculo);

        // Salvar motorista
        return motoristaRepository.save(motorista);
    }

    public Optional<Motorista> buscarMotoristaPorId(Long id) {
        return motoristaRepository.findById(id);
    }

    public void excluirMotorista(Long id) { motoristaRepository.deleteById(id);
    }
}