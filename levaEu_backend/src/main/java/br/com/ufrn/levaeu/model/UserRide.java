package br.com.ufrn.levaeu.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

@Entity
public class UserRide {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "id_stop_point", referencedColumnName = "id")
    private Location stopPoint;

    private Boolean isConfirmed;

    private Boolean isPickup;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id")
    @JsonIgnore
    private User user;

    @ManyToOne
    @JoinColumn(name = "id_ride", referencedColumnName = "id")
    private Ride ride;

    public UserRide(Ride ride, User user, Location location, Boolean departure) {
        this.ride = ride;
        this.user = user;
        this.stopPoint = location;
        this.isPickup = departure;
        this.isConfirmed = false;
    }

    public UserRide() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Location getStopPoint() {
        return stopPoint;
    }

    public void setStopPoint(Location stopPoint) {
        this.stopPoint = stopPoint;
    }

    public Boolean getConfirmed() {
        return isConfirmed;
    }

    public void setConfirmed(Boolean confirmed) {
        isConfirmed = confirmed;
    }

    public Boolean getDeparture() {
        return isPickup;
    }

    public void setDeparture(Boolean departure) {
        isPickup = departure;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Ride getRide() {
        return ride;
    }

    public void setRide(Ride ride) {
        this.ride = ride;
    }
}
