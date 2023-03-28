package com.HotelProject;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

public class RentingService {
    public String createRenting(Renting renting) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();

        // sql query
        String insertBookingQuery = "INSERT INTO renting VALUES (?,?,?,?,?,?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertBookingQuery);
            Date rentingStartSQL = Date.valueOf(renting.getDateRentedStart());
            Date rentingEndSQL = Date.valueOf(renting.getDateRentedEnd());
            // set every ? of statement
            stmt.setDate(1, rentingStartSQL);
            stmt.setDate(2, rentingEndSQL);
            stmt.setInt(3, renting.getEmployeeSSN());
            stmt.setInt(4, renting.getCustomerSSN());
            stmt.setInt(5, renting.getRoomNumber());
            stmt.setInt(6, renting.getHotelID());

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting renting: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Booking successfully transfered!";

        }

        // return respective message
        return message;
    }
}
