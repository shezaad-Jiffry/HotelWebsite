package com.HotelProject;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EmployeeService {
    public String createEmployee(Employee employee) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();

        // sql query
        String insertCustomerQuery = "INSERT INTO employee VALUES (?,?,?,?,?::job,?) ON CONFLICT DO NOTHING;";

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertCustomerQuery);

            // set every ? of statement
            stmt.setInt(1,    employee.getSsn());
            stmt.setString(2,   employee.getFirstName());
            stmt.setString(3, employee.getLastName());
            stmt.setBoolean(4, employee.getEmployed());
            stmt.setString(5, employee.getJobType());
            stmt.setInt(6, employee.getHotelId());

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
