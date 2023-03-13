<%--
  Created by IntelliJ IDEA.
  User: Shezaads
  Date: 2023-03-13
  Time: 5:00 p.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.HotelProject.HotelChainService" %>
<%@ page import="com.HotelProject.HotelChain" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  // retrieve hotelchain from database
  HotelChainService hotelChainService = new HotelChainService();
  List<HotelChain> hotelChains = null;
  try {
    hotelChains = hotelChainService.getHotelChain();
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<html>
<div class="container">
  <div class="row" id="row">
    <div class="col-md-12">
      <div class="card" id="card-container">
        <div class="card-body" id="card">
          <% if (hotelChains.size() == 0) { %>
          <h1 style="margin-top: 5rem;">No Hotels found</h1>
          <% } else { %>
          <div class="table-responsive">
            <table class="table">
              <thead>
              <tr>
                <th>Chain name</th>
                <th>email</th>
                <th>phone number</th>
                <th></th>
              </tr>
              </thead>
              <tbody>
              <%
                for (HotelChain hotelChain : hotelChains) { %>
              <tr>
                <td><%= hotelChain.getChainName() %></td>
                <td><%= hotelChain.getEmail() %></td>
                <td><%= hotelChain.getPhoneNumber() %></td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>
</div>
</html>
