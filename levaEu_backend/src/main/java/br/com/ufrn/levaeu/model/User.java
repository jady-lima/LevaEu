package br.com.ufrn.levaeu.model;

import java.util.ArrayList;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;
    @Email
    private String email;
    private String phone;
    @NotBlank
    private String pass;
    @NotBlank
    private String enrollment;
    @NotNull
    private TypeUser typeUser;
    private String gender;
    
    // Getters and setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String nome) {
        this.name = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String telefone) {
        this.phone = telefone;
    }

    public TypeUser getTypeUser() {
        return typeUser;
    }

    public String getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(String enrollment) {
        this.enrollment = enrollment;
    }

    public void setTypeUser(TypeUser typeUser) {
        this.typeUser = typeUser;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String senha) {
        this.pass = senha;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String genero) {
        this.gender = genero;
    }
}