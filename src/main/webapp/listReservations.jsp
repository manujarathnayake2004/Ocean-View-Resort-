<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
  String user = (String) session.getAttribute("loggedUser");
  if (user == null) {
    response.sendRedirect("login.jsp?msg=Please+login+first");
    return;
  }

  List<Reservation> list = (List<Reservation>) session.getAttribute("reservationList");

  String filterRoomType = (String) session.getAttribute("filterRoomType");
  String filterFrom = (String) session.getAttribute("filterFrom");
  String filterTo = (String) session.getAttribute("filterTo");

  if (filterRoomType == null) filterRoomType = "";
  if (filterFrom == null) filterFrom = "";
  if (filterTo == null) filterTo = "";
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Ocean View Resort | Reservations</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <style>
    :root{
      --p1:#7C3AED;
      --p2:#C4B5FD;
      --white:#ffffff;
      --glass:rgba(255,255,255,0.18);
      --border:rgba(255,255,255,0.35);
    }

    *{box-sizing:border-box;}

    body{
      margin:0;
      font-family:"Segoe UI", Arial, sans-serif;
      min-height:100vh;
      color:white;

      /* SAME BRIGHT BACKGROUND LIKE INDEX */
      background:
              linear-gradient(rgba(80,0,140,0.55), rgba(120,0,180,0.55)),
              url("images/resort-bg.jpg") center/cover no-repeat fixed;
    }

    .page{
      min-height:100vh;
      display:flex;
      justify-content:center;
      align-items:flex-start;
      padding:60px 20px;
    }

    .glass-container{
      width:min(1200px, 100%);
      background:var(--glass);
      backdrop-filter:blur(14px);
      -webkit-backdrop-filter:blur(14px);
      border-radius:25px;
      border:1px solid var(--border);
      box-shadow:0 25px 70px rgba(0,0,0,0.35);
      padding:35px;
    }

    h2{
      text-align:center;
      margin:0 0 25px;
      font-size:28px;
      letter-spacing:1px;
    }

    .filter-box{
      text-align:center;
      margin-bottom:25px;
    }

    select,input,button,a.clear{
      padding:10px 14px;
      border-radius:12px;
      border:none;
      margin:5px;
      font-weight:600;
    }

    select,input{
      background:rgba(255,255,255,0.85);
      color:#333;
    }

    button{
      background:linear-gradient(135deg,var(--p1),var(--p2));
      color:white;
      cursor:pointer;
    }

    button:hover{
      transform:translateY(-2px);
    }

    a.clear{
      background:white;
      color:#6D28D9;
      text-decoration:none;
    }

    table{
      width:100%;
      border-collapse:collapse;
      border-radius:15px;
      overflow:hidden;
    }

    th{
      background:rgba(255,255,255,0.25);
      padding:14px;
      text-align:left;
      font-size:14px;
    }

    td{
      background:rgba(255,255,255,0.15);
      padding:12px;
      font-size:13px;
    }

    tr:hover td{
      background:rgba(255,255,255,0.25);
    }

    .btn{
      padding:7px 12px;
      border-radius:8px;
      text-decoration:none;
      font-size:12px;
      font-weight:700;
      margin-right:5px;
    }

    .edit{
      background:white;
      color:#7C3AED;
    }

    .delete{
      background:#ff4d6d;
      color:white;
    }

    .bill{
      background:linear-gradient(135deg,#7C3AED,#C4B5FD);
      color:white;
    }

    .footer{
      text-align:center;
      margin-top:30px;
      font-size:13px;
      opacity:0.8;
    }

    .back{
      display:block;
      text-align:center;
      margin-top:20px;
      color:white;
      text-decoration:none;
      font-weight:700;
    }

    .back:hover{
      text-decoration:underline;
    }
  </style>
</head>

<body>

<div class="page">
  <div class="glass-container">

    <h2>All Reservations</h2>

    <!-- FILTER FORM -->
    <div class="filter-box">
      <form action="<%=request.getContextPath()%>/filterReservations" method="get">
        <select name="roomType">
          <option value="All">All</option>
          <option value="Single" <%= "Single".equals(filterRoomType) ? "selected" : "" %>>Single</option>
          <option value="Double" <%= "Double".equals(filterRoomType) ? "selected" : "" %>>Double</option>
          <option value="Deluxe" <%= "Deluxe".equals(filterRoomType) ? "selected" : "" %>>Deluxe</option>
        </select>

        <input type="date" name="fromDate" value="<%= filterFrom %>">
        <input type="date" name="toDate" value="<%= filterTo %>">

        <button type="submit">Apply Filters</button>
        <a class="clear" href="<%=request.getContextPath()%>/listReservations">Clear</a>
      </form>
    </div>

    <!-- TABLE -->
    <table>
      <tr>
        <th>Reservation No</th>
        <th>Customer ID</th>
        <th>Customer Mobile</th>
        <th>Guest Name</th>
        <th>Room Type</th>
        <th>Check-In</th>
        <th>Check-Out</th>
        <th>Action</th>
      </tr>

      <%
        if (list != null && !list.isEmpty()) {
          for (Reservation r : list) {
      %>
      <tr>
        <td><%= r.getReservationNumber() %></td>
        <td><%= r.getCustomerId() %></td>
        <td><%= r.getCustomerMobile() %></td>
        <td><%= r.getGuestName() %></td>
        <td><%= r.getRoomType() %></td>
        <td><%= r.getCheckIn() %></td>
        <td><%= r.getCheckOut() %></td>
        <td>
          <a class="btn edit"
             href="<%=request.getContextPath()%>/editReservation?reservationNumber=<%= r.getReservationNumber() %>">Edit</a>

          <a class="btn delete"
             href="<%=request.getContextPath()%>/deleteReservation?reservationNumber=<%= r.getReservationNumber() %>"
             onclick="return confirm('Are you sure?');">Delete</a>

          <a class="btn bill"
             href="<%=request.getContextPath()%>/billPrint.jsp?reservationNumber=<%= r.getReservationNumber() %>">
            🧾 Print to Bill
          </a>

        </td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="8">No reservations found.</td>
      </tr>
      <% } %>
    </table>

    <a class="back" href="dashboard.jsp">⬅ Back to Dashboard</a>

    <div class="footer">
      © <%= java.time.Year.now() %> Ocean View Resort
    </div>

  </div>
</div>

</body>
</html>