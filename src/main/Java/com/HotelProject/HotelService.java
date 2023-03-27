package com.HotelProject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class HotelService {

    /**
     * Method to get all hotel chains from database
     * @return list of all students found in database
     * @throws Exception when trying to connect to database
     */
    public List<Hotel> getHotel(String country, String region) throws Exception {

        // sql query
        String sql = "SELECT * FROM hotel WHERE country = ? and region = ?";
        // connection object
        ConnectionDB db = new ConnectionDB();
        // data structure to keep all HotelChains retrieved from database
        List<Hotel> hotels = new ArrayList<Hotel>();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1,country);
            stmt.setString(2,region);
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                // create new HotelChain object
                Hotel hotel = new Hotel(
                        rs.getInt("hotel_id"),
                        rs.getString("country"),
                        rs.getString("region"),
                        rs.getString("street_name"),
                        rs.getInt("street_number"),
                        rs.getString("postal_code"),
                        rs.getString("email"),
                        rs.getString("phonenumber"),
                        rs.getInt("rating"),
                        rs.getInt("number_rooms"),
                        rs.getString("chainname")
                );
                // append hotel chain in hotel chain list
                hotels.add(hotel);
            }
            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            // return result
            return hotels;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public int getAvailableRoomsCount(int hotelID) throws Exception {
        int count = 0;
        // sql query
        String sql = "SELECT count FROM available_rooms WHERE hotel_id = ?";

        // connection object
        ConnectionDB db = new ConnectionDB();
        // data structure to keep all HotelChains retrieved from database
        List<Hotel> hotels = new ArrayList<Hotel>();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1,hotelID);
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                count = rs.getInt("count");
            }
            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            // return result
            return count;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }

    public int getAvailableRoomsInAreaCount(String country, String region) throws Exception {
        int count = 0;
        // sql query
        String sql = "SELECT count FROM room_area WHERE country = ? and region = ?";

        // connection object
        ConnectionDB db = new ConnectionDB();
        // data structure to keep all HotelChains retrieved from database
        List<Hotel> hotels = new ArrayList<Hotel>();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1,country);
            stmt.setString(2,region);
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {
                count = rs.getInt("count");
            }
            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            // return result
            return count;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
}
