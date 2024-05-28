package br.com.ufrn.levaeu.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "cnhs")
public class DriverLicense {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String registrationNumber;
    private String cpf;
    private Date issuanceDate;
    private Date expirationDate;
    private String category;

    // Getters e Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String numeroRegistro) {
        this.registrationNumber = numeroRegistro;
    }

    public String getNumeroCPF() {
        return cpf;
    }

    public void setNumeroCPF(String numeroCPF) {
        this.cpf = numeroCPF;
    }

    public Date getIssuanceDate() {
        return issuanceDate;
    }

    public void setIssuanceDate(Date issuanceDate) {
        this.issuanceDate = issuanceDate;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String categoria) {
        this.category = categoria;
    }
}