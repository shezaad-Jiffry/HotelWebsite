package com.HotelProject;

import java.util.Objects;

public class HotelChain {
    private String chainName;
    private String country;
    private String region;
    private String streetName;
    private int streetNumber;
    private String postalCode;
    private String phoneNumber;
    private String email;

    //constructor for hotelchain (the data is premade for this all that has to be done is the gathering of it so no different constructor)
    public HotelChain(String chainName, String country, String region, String streetName, int streetNumber, String postalCode, String phoneNumber, String email) {
        this.chainName = chainName;
        this.country = country;
        this.region = region;
        this.streetName = streetName;
        this.streetNumber = streetNumber;
        this.postalCode = postalCode;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }
    //getters don't need setters as all the data is premade


    public String getChainName() {
        return chainName;
    }

    public String getCountry() {
        return country;
    }

    public String getRegion() {
        return region;
    }

    public String getStreetName() {
        return streetName;
    }

    public int getStreetNumber() {
        return streetNumber;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    @Override
    public String toString() {
        return "<ul>"
                + "<li>chain name= " + chainName + "</li>"
                + "<li>email= " + email + "</li>"
                + "<li>phone number= " + phoneNumber + "</li>";
    }


}
