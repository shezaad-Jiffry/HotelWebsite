<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ page import="java.util.ArrayList" %>
<%@ page import="com.HotelProject.CustomerService" %>
<%@ page import="com.HotelProject.Customer" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.HotelProject.Message" %>

<%
    // get values from the request
    String strSSN = request.getParameter("ssn");
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String country = request.getParameter("country");
    String region = request.getParameter("region");
    String streetName = request.getParameter("street_name");
    String strStreetNumber = request.getParameter("street_number");
    String postalCode = request.getParameter("postal_code");
    CustomerService customerService = new CustomerService();
    //gets current day
    java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
    //convert to int
    int ssn = Integer.parseInt(strSSN);
    int streetNumber = Integer.parseInt(strStreetNumber);
    // create customer object
    Customer customer = new Customer(ssn,date,firstName,lastName,country,region,streetName,streetNumber,postalCode);

    Message msg;
    // try to create a new student
    try {
        String value = customerService.createCustomer(customer);
        // if the value contains error/Error then this is an error message
        if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
            // else the student was successfully created
        else msg = new Message("success", value);
    } catch (Exception e) {
        e.printStackTrace();
        msg = new Message("error", "Something went wrong!");
    }

    // create an arraylist of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);
    System.out.println(msg.value);
    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);
    // redirect to index
    if(msg.value.equals("customer successfully inserted!")){
        response.sendRedirect("index.jsp");
    }
    else{
        response.sendRedirect("purchase.jsp");
    }

%>