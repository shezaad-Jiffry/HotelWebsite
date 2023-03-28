package com.HotelProject;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class RoomService {

    /**
     * Method to get all hotel chains from database
     * @return list of all students found in database
     * @throws Exception when trying to connect to database
     */
    public List<Room> getRoom(int hotelID) throws Exception {

        // sql query
        String sql = "SELECT * FROM available_rooms_no_count WHERE hotel_id = ?";
        // connection object
        ConnectionDB db = new ConnectionDB();

        // data structure to keep all HotelChains retrieved from database
        List<Room> rooms = new ArrayList<Room>();
        // try connect to database, catch any exceptions
        try (Connection con = db.getConnection()) {
            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1,hotelID);
            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();
            // iterate through the result set
            while (rs.next()) {

                // create new HotelChain object
                Array issues = rs.getArray("issues");
                Array amenities = rs.getArray("amenities");

                Room room = new Room(
                        rs.getInt("room_number"),
                        (String[]) (issues.getArray()),
                        rs.getString("scenary"),
                        rs.getBoolean("extendable"),
                        rs.getInt("price"),
                        (String[]) (amenities.getArray()),
                        rs.getInt("capacity"),
                        rs.getInt("hotel_id")
                );
                // append hotel chain in hotel chain list
                rooms.add(room);
            }
            // close result set
            rs.close();
            // close statement
            stmt.close();
            con.close();
            db.close();
            // return result
            return rooms;
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
    }
}
