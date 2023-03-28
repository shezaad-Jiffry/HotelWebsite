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
    String rentingStart = request.getParameter("rentingStart");
    String rentingEnd = request.getParameter("rentingEnd");
    String strCustomerSSN = request.getParameter("customerSSN");
    String strRoomNumber = request.getParameter("roomNumber");
    String strHotelId = request.getParameter("hotelID");
    int customerSSN = Integer.parseInt(strCustomerSSN);
    int roomNumber = Integer.parseInt(strRoomNumber);
    int hotelID = Integer.parseInt(strHotelId);
%>

<html>

<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <h1>
                <%="Please enter your employee credentials to rent out room for " + customerSSN + " for room " + roomNumber + " at hotel " + hotelID  %>
            </h1>
            <div class="card" id="card-container">
                <form class="form-horizontal" name="room-form" action="insert-customer-controller.jsp" method="POST">
                    <div class="form-group col-sm-3 mb-3">
                        <label for="ssn">ssn</label>
                        <input id = "ssn" type="number" class="form-control" name="ssn" placeholder="123456789"  max="999999999" >
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="first_name">first_name</label>
                        <input id = "first_name" type="text" class="form-control" name="first_name" placeholder="Enter first_name">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="last_name">last_name</label>
                        <input id = "last_name" type="text" class="form-control" name="last_name" placeholder="Enter last_name">
                    </div>
                    <input type="hidden" value="<%= rentingStart %>" name="rentingStart" />
                    <input type="hidden" value="<%= RentingEnd() %>" name="rentingEnd" />
                    <input type="hidden" value="<%= CustomerSSN() %>" name="customerSSN" />
                    <input type="hidden" value="<%= RoomNumber() %>" name="roomNumber" />
                    <input type="hidden" value="<%= HotelID() %>" name="hotelID" />
                    <button type="submit" class="btn btn-primary btn-submit-custom">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>

</html>