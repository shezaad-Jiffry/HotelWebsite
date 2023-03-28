<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.HotelProject.*" %>

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
    String rentingStart = request.getParameter("renting_start");
    String rentingEnd = request.getParameter("renting_end");
    CustomerService customerService = new CustomerService();
    BookingService bookingService = new BookingService();
    String strHotelId = request.getParameter("hotel_id");
    String strRoomNumber = request.getParameter("room_number");
    //gets current day
    java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
    //convert to int
    int ssn = Integer.parseInt(strSSN);
    int streetNumber = Integer.parseInt(strStreetNumber);
    int hotelID = Integer.parseInt(strHotelId);
    int roomNumber = Integer.parseInt(strRoomNumber);
    // create customer object
    Customer customer = new Customer(ssn,date,firstName,lastName,country,region,streetName,streetNumber,postalCode);
    Booking booking = new Booking(date,rentingStart,rentingEnd,ssn,roomNumber,hotelID);
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

    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);
    // redirect to index
    if(msg.value.contains("success")){
        try {
            String value = bookingService.createBooking(booking);
            // if the value contains error/Error then this is an error message
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
                // else the student was successfully created
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Something went wrong!");
        }
        System.out.println(msg.value);
        if(msg.value.contains("success")){
            response.sendRedirect("index.jsp");
        }
        else {
            response.sendRedirect("purchase.jsp");
        }
    }
    else{
        response.sendRedirect("purchase.jsp");

    }

%>