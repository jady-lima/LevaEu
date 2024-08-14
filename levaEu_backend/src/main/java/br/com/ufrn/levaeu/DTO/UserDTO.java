package br.com.ufrn.levaeu.DTO;

import br.com.ufrn.levaeu.model.TypeUser;
import br.com.ufrn.levaeu.model.User;

public class UserDTO {
    private Long id;
    private String name;
    private String email;
    private String phone;
    private String pass;
    private String enrollment;
    private TypeUser typeUser;
    private String gender;
    private String cep;
    private String street;
    private String number;
    private String district;
    private String city;
    private String state;
    private String country;
    private String token;

    public UserDTO(User user, String token) {
        this.id = user.getId();
        this.name = user.getName();
        this.email = user.getEmail();
        this.phone = user.getPhone();
        this.pass = user.getPass();
        this.enrollment = user.getEnrollment();
        this.gender = user.getGender();
        this.cep = user.getCep();
        this.street = user.getStreet();
        this.number = user.getNumber();
        this.district = user.getDistrict();
        this.city = user.getCity();
        this.state = user.getState();
        this.country = user.getCountry();
        this.token = token;
        this.typeUser = user.getTypeUser();
    }

    public UserDTO(User user) {
        this.id = user.getId();
        this.name = user.getName();
        this.email = user.getEmail();
        this.phone = user.getPhone();
        this.pass = user.getPass();
        this.enrollment = user.getEnrollment();
        this.gender = user.getGender();
        this.cep = user.getCep();
        this.street = user.getStreet();
        this.number = user.getNumber();
        this.district = user.getDistrict();
        this.city = user.getCity();
        this.state = user.getState();
        this.country = user.getCountry();
        this.typeUser = user.getTypeUser();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(String enrollment) {
        this.enrollment = enrollment;
    }

    public TypeUser getTypeUser() {
        return typeUser;
    }

    public void setTypeUser(TypeUser typeUser) {
        this.typeUser = typeUser;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
