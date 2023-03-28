package com.HotelProject;


import java.text.SimpleDateFormat;
import java.util.Date;

public class Booking {
    private java.sql.Date dateBooked;
    private String rentingStart;
    private String rentingEnd;
    private int customerSSN;
    private int roomNumber;
    private int hotelID;

    public Booking(java.sql.Date dateBooked, String rentingStart, String rentingEnd, int customerSSN, int roomNumber, int hotelID) {
        this.dateBooked = dateBooked;
        this.rentingStart = rentingStart;
        this.rentingEnd = rentingEnd;
        this.customerSSN = customerSSN;
        this.roomNumber = roomNumber;
        this.hotelID = hotelID;
    }

    public java.sql.Date getDateBooked() {
        return dateBooked;
    }

    public String getRentingStart() {
        return rentingStart;
    }

    public String getRentingEnd() {
        return rentingEnd;
    }

    public int getCustomerSSN() {
        return customerSSN;
    }

    public int getRoomNumber() {
        return roomNumber;
    }

    public int getHotelID() {
        return hotelID;
    }
}
