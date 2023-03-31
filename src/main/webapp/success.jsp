<%@ page import="com.HotelProject.HotelChainService" %>

<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String message = "";
    try{
        message = (String)request.getSession().getAttribute("message");
    }
    catch (Exception e){
        message = "N/A1";
    }

%>
<!DOCTYPE html>
<html lang="en">
    <div class="col-md-4">
        <h1>YOUR REQUEST WAS A SUCCESS! go back to landing page below</h1>
         <h2><%=message%></h2>
                     <div class="card-body" id="card">
                         <h4 class="card-title">Book a room now!</h4>
                         <a class="btn btn-primary" id="show-btn" href="hotel.jsp">Book a room</a>

        </div>
        </div>
    </div>
</html>