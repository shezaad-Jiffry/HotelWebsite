<%@ page import="com.HotelProject.HotelChainService" %>

<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String message = "";
    try{
        message = request.getParameter("message");
    }
    catch (Exception e){
        message = "what would you like to do this did not work?";
    }
    finally {
        message = "book a room or switch to employee view";
    }
%>
<!DOCTYPE html>
<html lang="en">
    <div class="col-md-4">
        <h1><%=message%></h1>
        <div class="card" id="card-container-layout">
            <div class="card-body" id="card">
                <h4 class="card-title">Book a room now!</h4>
                <a class="btn btn-primary" id="show-btn" href="hotel.jsp">Book a room</a>

            </div>
            <a class="btn btn-primary" id="show-btn-employee" href="employee.jsp">Switch to employee view</a>
        </div>
    </div>
</html>