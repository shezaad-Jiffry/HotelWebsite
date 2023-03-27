package com.HotelProject;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CustomerService {
    public String createCustomer(Customer customer) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();

        // sql query
        String insertCustomerQuery = "INSERT INTO customer VALUES (?,?,?,?,?,?,?,?,?);";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertCustomerQuery);

            // set every ? of statement
            stmt.setInt(1, customer.getSsn());
            stmt.setDate(2, customer.getRegistrationDate());
            stmt.setString(3, customer.getFirstName());
            stmt.setString(4, customer.getLastName());
            stmt.setString(5, customer.getCountry());
            stmt.setString(6, customer.getRegion());
            stmt.setString(7, customer.getStreetName());
            stmt.setInt(8, customer.getStreetNumber());
            stmt.setString(9, customer.getPostalCode());

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
