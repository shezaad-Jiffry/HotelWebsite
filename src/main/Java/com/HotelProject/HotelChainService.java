package com.HotelProject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class HotelChainService {

    /**
     * Method to get all hotel chains from database
     * @return list of all students found in database
     * @throws Exception when trying to connect to database
     */
    public List<HotelChain> getHotelChain() throws Exception {

        // sql query
        String sql = "SELECT * FROM Hotel_Chain";
        // connection object
        ConnectionDB db = new ConnectionDB();
        // data structure to keep all HotelChains retrieved from database
        List<HotelChain> hotelChains = new ArrayList<HotelChain>();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                // create new HotelChain object
                HotelChain hotelChain = new HotelChain(
                        rs.getString("chainname"),
                        rs.getString("country"),
                        rs.getString("region"),
                        rs.getString("street_name"),
                        rs.getInt("street_number"),
                        rs.getString("postal_code"),
                        rs.getString("phonenumber"),
                        rs.getString("email")
                );
                // append hotel chain in hotel chain list
                hotelChains.add(hotelChain);
            }
            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            // return result
            return hotelChains;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
}
