<%--
  Created by IntelliJ IDEA.
  User: Shezaads
  Date: 2023-03-13
  Time: 5:00 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>

<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <h2>
                please enter your employee credentials
            </h2>
            <div class="card" id="card-container">
                <form class="form-horizontal" name="room-form" action="insert-renting-controller.jsp" method="POST">
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
                    <h2>
                        please enter the customers info including room renting dates etc
                    </h2>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="rentingStart">start date</label>
                        <input id = "rentingStart" type="date" class="form-control" name="rentingStart" placeholder="123456789"  max="999999999" >
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="rentingEnd">end date</label>
                        <input id = "rentingEnd" type="date" class="form-control" name="rentingEnd" placeholder="rentDateEnd">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="roomNumber">room number</label>
                        <input id = "roomNumber" type="number" class="form-control" name="roomNumber" placeholder="roomNumber">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="hotelID">hotel id</label>
                        <input id = "hotelID" type="number" class="form-control" name="hotelID" placeholder="hotel_id">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="customerSSN">customers ssn</label>
                        <input id = "customerSSN" type="number" class="form-control" name="customerSSN" placeholder="123456789"  max="999999999" >
                    </div>
                    <button type="submit" class="btn btn-primary btn-submit-custom">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>

</html>