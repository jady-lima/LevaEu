package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.Car;
import br.com.ufrn.levaeu.repository.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CarService {

    @Autowired
    private CarRepository carRepository;

    public Car validarECriar(Car car) {
        // Implementar validação do veículo
        return car;
    }

    public Car salvarVeiculo(Car car) {
        return carRepository.save(car);
    }

    public Optional<Car> buscarVeiculoPorId(Long id) {
        return carRepository.findById(id);
    }

    public void excluirVeiculo(Long id) {
        carRepository.deleteById(id);
    }
}
