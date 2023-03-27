<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.HotelProject.*" %>
<h1>ROOMS</h1>
<%
  // get values from the request
  String country = request.getParameter("country");
  String region = request.getParameter("region");
  HotelService hotelService = new HotelService();
  List<Hotel> hotels = null;
  try {
    hotels = hotelService.getHotel(country,region);
  } catch (Exception e) {
    e.printStackTrace();
  }

%>

<html>

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
              </tr>
              </thead>
              <tbody>
              <%
                for (Hotel hotel : hotels) { %>
              <tr >
                <td><%= hotel.getChainName() %></td>
                <td><%= hotel.getCountry() %></td>
                <td><%= hotel.getRegion() %></td>
                <td><%= hotel.getStreetName() %></td>
                <td><%= hotel.getPostalCode() %></td>
                <td><%= hotel.getRating() %></td>
                <form method="POST" action="room.jsp">
                  <td>
                    <input type="hidden" value="<%= hotel.getHotelID() %>" name="hotel_id" />
                    <button type="view rooms" class="btn btn-primary btn-submit-custom">View Rooms</button>
                  </td>
                </form>
              </tr>
              <% } %>
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