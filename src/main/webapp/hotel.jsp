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
        Please enter the country and state/province you wish to visit (state and province can be left blank)
      </h1>
      <div class="card" id="card-container">
        <form class="form-horizontal" name="room-form" action="hotel-handler.jsp" method="POST">
          <div class="form-group col-sm-3 mb-3">
            <label for="country">Country</label>
            <input id = "country" type="text" class="form-control" name="country" placeholder="Enter country">
          </div>
          <div class="form-group col-sm-3 mb-3">
            <label for="region">Region</label>
            <input id = "region" type="text" class="form-control" name="region" placeholder="Enter province/state">
          </div>
          <button type="submit" class="btn btn-primary btn-submit-custom">Submit</button>
        </form>
      </div>
    </div>
  </div>
</div>

</html>