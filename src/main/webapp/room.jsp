<%--
  Created by IntelliJ IDEA.
  User: Shezaads
  Date: 2023-03-13
  Time: 5:00 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.HotelProject.RoomService" %>
<%@ page import="com.HotelProject.Room" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  // retrieve room from database
  RoomService roomService = new RoomService();
  List<Room> rooms = null;
  try {
    rooms = roomService.getRoom();
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
          <% if (rooms.size() == 0) { %>
          <h1 style="margin-top: 5rem;">No Hotels found</h1>
          <% } else { %>
          <div class="table-responsive">
            <table class="table">
              <thead>
              <tr>
                <th>Room number</th>
                <th>issues</th>
                <th>amenities</th>
                <th></th>
              </tr>
              </thead>
              <tbody>
              <%
                for (Room room : rooms) { %>
              <tr>
                <td><%= room.getRoomNumber() %></td>
                <td><%= room.getIssues() %></td>
                <td><%= room.getAmenities() %></td>
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
