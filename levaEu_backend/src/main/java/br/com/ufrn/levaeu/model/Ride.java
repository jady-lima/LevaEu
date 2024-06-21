package br.com.ufrn.levaeu.model;

import java.util.HashMap;

import jakarta.persistence.OneToMany;

public class Ride {
	private User driver;
    private String arrivalLocal;
    private	String leavingLocal;
    
    @OneToMany 	
    private HashMap< Long, String > requesters = new HashMap< Long, String>();
    
    @OneToMany
    private HashMap< Long, String > confirmeds = new HashMap< Long, String >(); 

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
    	this.leavingLocal = arrivalLocal;
    }
}