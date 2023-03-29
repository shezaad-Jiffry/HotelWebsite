<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.HotelProject.*" %>

<%
  // get values from the request
  String country = request.getParameter("country");
  String region = request.getParameter("region");
  HotelService hotelService = new HotelService();
  List<Hotel> hotels = null;
  int[]roomCounts = null;
  int roomsInArea = 0;
  try {
    hotels = hotelService.getHotel(country,region);
    roomCounts = new int[hotels.size()];
    roomsInArea = hotelService.getAvailableRoomsInAreaCount(country,region);
    for(int i = 0; i < hotels.size(); i++){
      roomCounts[i] = hotelService.getAvailableRoomsCount(hotels.get(i).getHotelID());
    }
  } catch (Exception e) {
    e.printStackTrace();
  }

%>

<html>
<h1>ROOMS</h1>
<h2>there are a total of <%=roomsInArea %>  rooms in <%=country + "," + region %></h2>
<div class="container">
  <div class="row" id="row">
    <div class="col-md-12">
      <div class="card" id="card-container">
        <div class="card-body" id="card">
          <% if (hotels.size() == 0) { %>
          <h1 style="margin-top: 5rem;">No rooms found in the area specified</h1>
          <% } else { %>
          <div class="table-responsive">
            <table class="table">
              <thead >
              <tr>
                <th>Hotel Chain</th>
                <th>Country</th>
                <th>Region</th>
                <th>street_name</th>
                <th>postal code</th>
                <th>rating</th>
                <th>available rooms</th>
              </tr>
              </thead>
              <tbody>
              <% int i = 0;
                for (Hotel hotel : hotels) { %>
              <tr >
                <td><%= hotel.getChainName() %></td>
                <td><%= hotel.getCountry() %></td>
                <td><%= hotel.getRegion() %></td>
                <td><%= hotel.getStreetName() %></td>
                <td><%= hotel.getPostalCode() %></td>
                <td><%= hotel.getRating() %></td>
                <td><%= roomCounts[i] %></td>
                <form method="POST" action="room.jsp">
                  <td>
                    <input type="hidden" value="<%= hotel.getHotelID() %>" name="hotel_id" />
                    <input type="hidden" value="<%= hotel.getChainName() %>" name="hotel_chain_name" />
                    <button type="view rooms" class="btn btn-primary btn-submit-custom">View Rooms</button>
                  </td>
                </form>
              </tr>
              <% i++;} %>
              </tbody>
            </table>
          </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>
</div>

</html>