package br.com.ufrn.levaeu.model;

import jakarta.persistence.*;

@Entity
@Table(name = "motoristas")
public class Driver extends User {
    @OneToOne(cascade = CascadeType.ALL, optional = true)
    @JoinColumn(name = "id_cnh", referencedColumnName = "id")
    private DriverLicense driverLicense;

    @OneToOne(cascade = CascadeType.ALL, optional = true)
    @JoinColumn(name = "id_veiculo", referencedColumnName = "id")
    private Car car;

    // Métodos específicos para motoristas, como criar corridas

    public DriverLicense getDriverLicense() {
        return driverLicense;
    }

    public void setDriverLicense(DriverLicense driverLicense) {
        this.driverLicense = driverLicense;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }
}
