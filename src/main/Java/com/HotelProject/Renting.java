package com.HotelProject;

public class Renting {
    private String dateRentedStart;
    private String dateRentedEnd;
    private int employeeSSN;
    private int customerSSN;
    private int roomNumber;
    private int hotelID;

    public Renting(String dateRentedStart, String dateRentedEnd, int employeeSSN, int customerSSN, int roomNumber, int hotelID) {
        this.dateRentedStart = dateRentedStart;
        this.dateRentedEnd = dateRentedEnd;
        this.employeeSSN = employeeSSN;
        this.customerSSN = customerSSN;
        this.roomNumber = roomNumber;
        this.hotelID = hotelID;
    }

    public String getDateRentedStart() {
        return dateRentedStart;
    }

    public String getDateRentedEnd() {
        return dateRentedEnd;
    }

    public int getEmployeeSSN() {
        return employeeSSN;
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
