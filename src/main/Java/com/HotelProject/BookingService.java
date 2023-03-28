package com.HotelProject;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

public class BookingService {
    public String createBooking(Booking booking) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();

        // sql query
        String insertBookingQuery = "INSERT INTO booking VALUES (?,?,?,?,?,?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertBookingQuery);
            Date rentingStartSQL = Date.valueOf(booking.getRentingStart());
            Date rentingEndSQL = Date.valueOf(booking.getRentingEnd());
            // set every ? of statement
            stmt.setDate(1, booking.getDateBooked());
            stmt.setDate(2, rentingStartSQL);
            stmt.setDate(3, rentingEndSQL);
            stmt.setInt(4, booking.getCustomerSSN());
            stmt.setInt(5, booking.getRoomNumber());
            stmt.setInt(6, booking.getHotelID());

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();
            // close the connection
            db.close();
        } catch (Exception e) {
            message = "Error while inserting customer: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "customer successfully inserted!";

        }

        // return respective message
        return message;
    }
}
