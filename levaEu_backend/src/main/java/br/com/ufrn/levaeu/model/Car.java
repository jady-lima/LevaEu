package br.com.ufrn.levaeu.model;

import jakarta.persistence.*;

@Entity
@Table(name = "veiculos")
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String brand;
    private String model;
    private Integer year;
    private String plate;
    private String color;

    // Getters e Setters


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer ano) {
        this.year = ano;
    }

    public String getPlate() {
        return plate;
    }

    public void setPlate(String placa) {
        this.plate = placa;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String cor) {
        this.color = cor;
    }
}