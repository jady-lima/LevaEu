package br.com.ufrn.levaeu.model;

import jakarta.persistence.*;

@Entity
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String cep;
    private String street;
    private String number;
    private String district;
    private String city;
    private String state;
    private String country;

    @OneToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id")
    private User user;


    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String rua) {
        this.street = rua;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String numero) {
        this.number = numero;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String bairro) {
        this.district = bairro;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String cidade) {
        this.city = cidade;
    }

    public String getState() {
        return state;
    }

    public void setState(String estado) {
        this.state = estado;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String pais) {
        this.country = pais;
    }
}
