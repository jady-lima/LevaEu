package br.com.ufrn.levaeu.model;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

@Entity
public class Ride {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_driver", referencedColumnName = "id")
	@JsonIgnore
    private Driver driver;

    @OneToOne
    @JoinColumn(name = "id_departure_location", referencedColumnName = "id")
    private Location departureLocation;

    @OneToOne
    @JoinColumn(name = "id_destination_location", referencedColumnName = "id")
    private	Location destinationLocation;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime departureTime;

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

    public LocalDateTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalDateTime departureTime) {
        this.departureTime = departureTime;
    }

    public Location getDepartureLocation() {
    	return this.departureLocation;
    }
    public void setDepartureLocation(Location departureLocation) {
    	this.departureLocation = departureLocation;
    }
    public Location getDestinationLocation() {
    	return this.destinationLocation;
    }

    public void setDestinationLocation(Location destinationLocation) {
    	this.destinationLocation = destinationLocation;
    }
}