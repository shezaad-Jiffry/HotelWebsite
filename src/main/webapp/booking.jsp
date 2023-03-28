<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.HotelProject.*" %>

<%
  BookingService bookingService = new BookingService();
  List<Booking> bookings = null;
  try {
    bookings = bookingService.getBooking();
  } catch (Exception e) {
    e.printStackTrace();
  }

%>

<html>
<h1>Bookings</h1>
<div class="container">
  <div class="row" id="row">
    <div class="col-md-12">
      <div class="card" id="card-container">
        <div class="card-body" id="card">
          <% if (bookings.size() == 0) { %>
          <h1 style="margin-top: 5rem;">No rooms found in the area specified</h1>
          <% } else { %>
          <div class="table-responsive">
            <table class="table">
              <thead >
              <tr>
                <th>Date booked</th>
                <th>Renting start</th>
                <th>Renting end</th>
                <th>Customer SSN</th>
                <th>Room number</th>
                <th>Hotel ID</th>
              </tr>
              </thead>
              <tbody>
              <% int i = 0;
                for (Booking booking : bookings) { %>
              <tr >
                <td><%= booking.getDateBooked() %></td>
                <td><%= booking.getRentingStart() %></td>
                <td><%= booking.getRentingEnd() %></td>
                <td><%= booking.getCustomerSSN() %></td>
                <td><%= booking.getRoomNumber() %></td>
                <td><%= booking.getHotelID() %></td>
                <form method="POST" action="renting.jsp">
                  <td>
                    <input type="hidden" value="<%= booking.getRentingStart() %>" name="rentingStart" />
                    <input type="hidden" value="<%= booking.getRentingEnd() %>" name="rentingEnd" />
                    <input type="hidden" value="<%= booking.getCustomerSSN() %>" name="customerSSN" />
                    <input type="hidden" value="<%= booking.getRoomNumber() %>" name="roomNumber" />
                    <input type="hidden" value="<%= booking.getHotelID() %>" name="hotelID" />
                    <button type="view rooms" class="btn btn-primary btn-submit-custom">transfer to renting</button>
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