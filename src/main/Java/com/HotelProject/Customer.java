package com.HotelProject;

import java.sql.Date;

public class Customer {
    private int ssn;
    private Date registrationDate;
    private String firstName;
    private String lastName;
    private String Country;
    private String region;
    private String streetName;
    private int streetNumber;
    private String postalCode;

    public Customer(int ssn, Date registrationDate, String firstName, String lastName, String country, String region, String streetName, int streetNumber, String postalCode) {
        this.ssn = ssn;
        this.registrationDate = registrationDate;
        this.firstName = firstName;
        this.lastName = lastName;
        Country = country;
        this.region = region;
        this.streetName = streetName;
        this.streetNumber = streetNumber;
        this.postalCode = postalCode;
    }

    public int getSsn() {
        return ssn;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getCountry() {
        return Country;
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
}
