<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@ page import="java.util.ArrayList" %>
<%@ page import="com.HotelProject.*" %>

<%

    // get values from the request
    String strSSN = request.getParameter("ssn");
    String firstName = request.getParameter("first_name");
    String lastName = request.getParameter("last_name");
    String rentingStart = request.getParameter("rentingStart");
    String rentingEnd = request.getParameter("rentingEnd");
    String strCustomerSSN = request.getParameter("customerSSN");
    String strRoomNumber = request.getParameter("roomNumber");
    String strHotelID = request.getParameter("hotelID");

    //convert to int
    int ssn = Integer.parseInt(strSSN);
    int customerSSN = Integer.parseInt(strCustomerSSN);
    int hotelID = Integer.parseInt(strHotelID);
    int roomNumber = Integer.parseInt(strRoomNumber);
    // create customer object
    Employee employee = new Employee(ssn,firstName,lastName,true,"concierge",hotelID);
    Renting renting = new Renting(rentingStart,rentingEnd,ssn,customerSSN,roomNumber,hotelID);
    Message msg;
    EmployeeService employeeService = new EmployeeService();
    RentingService rentingService = new RentingService();
    // try to create a new student
    try {
        String value = employeeService.createEmployee(employee);
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

            String value = rentingService.createRenting(renting);
            // if the value contains error/Error then this is an error message
            if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
                // else the student was successfully created
            else msg = new Message("success", value);
        } catch (Exception e) {
            e.printStackTrace();
            msg = new Message("error", "Something went wrong!");

        }

        if(msg.value.contains("success")){
            request.setAttribute("message", "successfully turned booking into renting");
            response.sendRedirect("index.jsp");
        }
        else {
            System.out.println(msg.value);
            request.setAttribute("message", "unsuccessfully turned booking into renting ");
            response.sendRedirect("error.jsp");
        }
    }
    else{
        System.out.println(msg.value);
        request.setAttribute("message", "unsuccessfully inserted the employee");
        response.sendRedirect("error.jsp");

    }

%>