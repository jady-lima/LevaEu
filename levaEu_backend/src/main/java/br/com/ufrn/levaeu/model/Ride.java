package br.com.ufrn.levaeu.model;

import java.time.LocalDateTime;
import java.util.HashMap;

import jakarta.persistence.*;

@Entity
public class Ride {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_driver", referencedColumnName = "id")
	private Driver driver;
    private String arrivalLocal;
    private	String leavingLocal;
    private LocalDateTime leavingTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Driver getDriver() {
        return driver;
    }

    public void setDriver(Driver driver) {
        this.driver = driver;
    }

    public LocalDateTime getLeavingTime() {
        return leavingTime;
    }

    public void setLeavingTime(LocalDateTime leavingTime) {
        this.leavingTime = leavingTime;
    }

    public String getArrivalLocal() {
    	return this.arrivalLocal;
    }
    public void setArrivalLocal(String arrivalLocal) {
    	this.arrivalLocal = arrivalLocal;
    }
    public String getLeavingLocal() {
    	return this.leavingLocal;
    }

    public void setLeavingLocal(String leavingLocal) {
    	this.leavingLocal = leavingLocal;
    }
}