package com.HotelProject;

public class Hotel {
    private int hotelID;
    private String country;
    private String region;
    private String streetName;
    private int streetNumber;
    private String postalCode;
    private String email;
    private int rating;
    private int numberRooms;
    private String chainName;

    //constructor for hotel (the data is premade for this all that has to be done is the gathering of it so no different constructor)
    public Hotel(int hotelID, String country, String region, String streetName, int streetNumber, String postalCode, String email, int rating, int numberRooms, String chainName) {
        this.hotelID = hotelID;
        this.country = country;
        this.region = region;
        this.streetName = streetName;
        this.streetNumber = streetNumber;
        this.postalCode = postalCode;
        this.email = email;
        this.rating = rating;
        this.numberRooms = numberRooms;
        this.chainName = chainName;
    }

    public int getHotelID() {
        return hotelID;
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

    public String getEmail() {
        return email;
    }

    public int getRating() {
        return rating;
    }

    public int getNumberRooms() {
        return numberRooms;
    }

    public String getChainName() {
        return chainName;
    }
    @Override
    public String toString() {
        return "<ul>"
                + "<li>chain name= " + chainName + "</li>"
                + "<li>hotel id= " + hotelID + "</li>"
                + "<li>number of rooms= " + numberRooms + "</li>"
                + "<li>rating= " + rating + "</li>"
                + "<li>country= " + email + "</li>"
                + "<li>region= " + region + "</li>"
                + "<li>street address= " + streetNumber + "," + streetName + "," + postalCode + "</li>";
    }
}
