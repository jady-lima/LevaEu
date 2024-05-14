package br.com.ufrn.levaeu.model;

import jakarta.persistence.*;

@Entity
@Table(name = "motoristas")
public class Motorista extends Usuario {

    @OneToOne(cascade = CascadeType.ALL, optional = true)
    @JoinColumn(name = "cnh_id", referencedColumnName = "id")
    private CNH cnh;

    @OneToOne(cascade = CascadeType.ALL, optional = true)
    @JoinColumn(name = "veiculo_id", referencedColumnName = "id")
    private Veiculo veiculo;

    // Métodos específicos para motoristas, como criar corridas

    public CNH getCnh() {
        return cnh;
    }

    public void setCnh(CNH cnh) {
        this.cnh = cnh;
    }

    public Veiculo getVeiculo() {
        return veiculo;
    }

    public void setVeiculo(Veiculo veiculo) {
        this.veiculo = veiculo;
    }
}
