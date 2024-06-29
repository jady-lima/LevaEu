package br.com.ufrn.levaeu.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "users")
public class User implements UserDetails {

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
    private String cep;
    private String street;
    private String number;
    private String district;
    private String city;
    private String state;
    private String country;

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

    @Override
    public Collection<GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authorities;
        if(this.getTypeUser().getName().equals("admin")){
            authorities = List.of(new SimpleGrantedAuthority("ROLE_ADMIN"), new SimpleGrantedAuthority("ROLE_DRIVER"), new SimpleGrantedAuthority("ROLE_DEFAULT"));
        } else if (this.getTypeUser().getName().equals("driver")) {
            authorities = List.of(new SimpleGrantedAuthority("ROLE_DRIVER"), new SimpleGrantedAuthority("ROLE_DEFAULT"));
        } else {
            authorities = List.of(new SimpleGrantedAuthority("ROLE_DEFAULT"));
        }
        return authorities;
    }

    @Override
    public String getPassword() {
        return this.pass;
    }

    @Override
    public String getUsername() {
        return this.email.equals("") ? this.phone : this.email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}