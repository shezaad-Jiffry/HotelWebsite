package com.HotelProject;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
    public List<Booking> getBooking() throws Exception {

        // sql query
        String sql = "SELECT * FROM Booking";
        // connection object
        ConnectionDB db = new ConnectionDB();
        // data structure to keep all HotelChains retrieved from database
        List<Booking> bookings = new ArrayList<Booking>();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                // create new HotelChain object
                Booking booking = new Booking(
                        rs.getDate("date_booked"),
                        rs.getString("renting_start"),
                        rs.getString("renting_end"),
                        rs.getInt("customer_ssn"),
                        rs.getInt("room_number"),
                        rs.getInt("hotel_id")
                );
                // append hotel chain in hotel chain list
                bookings.add(booking);
            }
            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            // return result
            return bookings;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
    public String updateArchive(Booking booking, String hotelChain) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();

        // sql query
        String updateArchiveQuery = "UPDATE archive SET hotel_chain = ? WHERE hotel_id = ? and room_number = ? and customer = ?";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(updateArchiveQuery);
            // set every ? of statement
            stmt.setString(1, hotelChain);
            stmt.setInt(2, booking.getHotelID());
            stmt.setInt(3, booking.getRoomNumber());
            stmt.setInt(4, booking.getCustomerSSN());


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
