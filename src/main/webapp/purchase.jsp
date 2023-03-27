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

%>

<html>

<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <h1>
                Please enter your credentials to book a room
            </h1>
            <div class="card" id="card-container">
                <form class="form-horizontal" name="room-form" action="insert-customer-controller.jsp" method="POST">
                    <div class="form-group col-sm-3 mb-3">
                        <label for="ssn">ssn</label>
                        <input id = "ssn" type="text" class="form-control" name="ssn" placeholder="Enter ssn">
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
                        <input id = "street_number" type="text" class="form-control" name="street_number" placeholder="Enter street_number">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="postal_code">postal code</label>
                        <input id = "postal_code" type="text" class="form-control" name="postal_code" placeholder="Enter postal_code">
                    </div>
                    <button type="submit" class="btn btn-primary btn-submit-custom">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>

</html>