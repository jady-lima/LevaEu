package br.com.ufrn.levaeu.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class UserRide {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String stopPoint;

    private Boolean confirmed;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "id")
    private User requester;

    @ManyToOne
    @JoinColumn(name = "id_ride", referencedColumnName = "id")
    private Ride ride;
}
