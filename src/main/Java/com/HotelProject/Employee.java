package com.HotelProject;

public class Employee {

    private int ssn;
    private String firstName;
    private String lastName;
    private Boolean isEmployed;
    private String jobType;
    private int hotelId;

    public Employee(int ssn, String firstName, String lastName, Boolean isEmployed, String jobType, int hotelId) {
        this.ssn = ssn;
        this.firstName = firstName;
        this.lastName = lastName;
        this.isEmployed = isEmployed;
        this.jobType = jobType;
        this.hotelId = hotelId;
    }

    public int getSsn() {
        return ssn;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public Boolean getEmployed() {
        return isEmployed;
    }

    public String getJobType() {
        return jobType;
    }

    public int getHotelId() {
        return hotelId;
    }
}
