<%--
  Created by IntelliJ IDEA.
  User: Shezaads
  Date: 2023-03-13
  Time: 5:00 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String hotelId = request.getParameter("hotel_id");
    String roomNumber = request.getParameter("room_number");
    String hotelChainName = request.getParameter("hotel_chain_name");
%>

<html>

<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <h1>
                <%="Please enter your credentials and booking dates to book room " + roomNumber + " at hotel with id " + hotelId  %>
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
                    <div class="form-group col-sm-3 mb-3">
                        <label for="country">country</label>
                        <input id = "country" type="text" class="form-control" name="country" placeholder="Enter country">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="region">Region</label>
                        <input id = "region" type="text" class="form-control" name="region" placeholder="Enter province/state">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="street_name">street_name</label>
                        <input id = "street_name" type="text" class="form-control" name="street_name" placeholder="Enter street_name">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="street_number">street number</label>
                        <input id = "street_number" type="number" class="form-control" name="street_number" placeholder="1234" max="9999">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="postal_code">postal code</label>
                        <input id = "postal_code" type="text" class="form-control" name="postal_code" placeholder="ABCABC">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="renting_start">renting start</label>
                        <input id = "renting_start" type="date" class="form-control" name="renting_start" placeholder="yyyy-mm-dd">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="renting_end">renting end</label>
                        <input id = "renting_end" type="date" class="form-control" name="renting_end" placeholder="yyyy-mm-dd">
                    </div>
                    <input type="hidden" value="<%= hotelId %>" name="hotel_id" />
                    <input type="hidden" value="<%= roomNumber %>" name="room_number" />
                    <input type="hidden" value="<%= hotelChainName %>" name="hotel_chain_name" />
                    <button type="submit" class="btn btn-primary btn-submit-custom">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>

</html>