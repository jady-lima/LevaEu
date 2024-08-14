package br.com.ufrn.levaeu.model;

public enum TypeUser {
    ADMIN("admin"),
    DRIVER("driver"),
    DEFAULT("default");

    private String name;

    TypeUser(String name){
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
