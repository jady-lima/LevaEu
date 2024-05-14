package br.com.ufrn.levaeu.service;

import aj.org.objectweb.asm.commons.Remapper;
import br.com.ufrn.levaeu.model.Veiculo;
import br.com.ufrn.levaeu.repository.VeiculoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class VeiculoService {

    @Autowired
    private VeiculoRepository veiculoRepository;

    public Veiculo validarECriar(Veiculo veiculo) {
        // Implementar validação do veículo
        return veiculo;
    }

    public Veiculo salvarVeiculo(Veiculo veiculo) {
        return veiculoRepository.save(veiculo);
    }

    public Optional<Veiculo> buscarVeiculoPorId(Long id) {
        return veiculoRepository.findById(id);
    }

    public void excluirVeiculo(Long id) {
        veiculoRepository.deleteById(id);
    }
}
