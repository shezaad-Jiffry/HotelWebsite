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
        <h1>AN ERROR OCCURED PLEASE HIT THE BACK BUTTON AND TRY AGAIN!</h1>
         <h2><%=message%></h2>
        </div>
    </div>
</html>