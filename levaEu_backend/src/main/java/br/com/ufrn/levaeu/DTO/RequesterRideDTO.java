package br.com.ufrn.levaeu.DTO;

import br.com.ufrn.levaeu.model.UserRide;

public class RequesterRideDTO {
    private UserRide userRide;
    private UserDTO user;

    public RequesterRideDTO(UserRide userRide, UserDTO user) {
        this.userRide = userRide;
        this.user = user;
    }

    public UserRide getUserRide() {
        return userRide;
    }

    public void setUserRide(UserRide userRide) {
        this.userRide = userRide;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }
}
