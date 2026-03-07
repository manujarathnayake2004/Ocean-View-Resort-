<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="com.oceanview.dao.ReservationDAO" %>

<%
  // ✅ Login check
  String user = (String) session.getAttribute("loggedUser");
  if (user == null) {
    response.sendRedirect("login.jsp?msg=Please+login+first");
    return;
  }

  // ✅ Get list from session (servlet sets this)
  List<Reservation> list = (List<Reservation>) session.getAttribute("reservationList");

  // ✅ If user opened JSP directly, load from DB
  if (list == null) {
    ReservationDAO dao = new ReservationDAO();
    list = dao.getAllReservations();
    session.setAttribute("reservationList", list);
  }

  // Keep UI filter values (optional)
  String roomTypeVal = request.getParameter("roomType");
  if (roomTypeVal == null || roomTypeVal.trim().isEmpty()) roomTypeVal = "All";

  String fromDateVal = request.getParameter("fromDate");
  String toDateVal = request.getParameter("toDate");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>All Reservations</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
    body{
      margin:0;
      font-family:"Segoe UI", Arial, sans-serif;
      min-height:100vh;
      color:#fff;
      background: url("images/resort-bg.jpg") center/cover no-repeat fixed;
    }

    .overlay{
      min-height:100vh;
      display:flex;
      justify-content:center;
      align-items:flex-start;
      padding:60px 20px;
      background:rgba(0,0,0,0.35);
    }

    .glass{
      width:min(1300px,100%);
      background:rgba(255,255,255,0.12);
      border:1px solid rgba(255,255,255,0.22);
      border-radius:28px;
      backdrop-filter:blur(14px);
      -webkit-backdrop-filter:blur(14px);
      box-shadow:0 25px 70px rgba(0,0,0,0.40);
      padding:28px;
    }

    h1{
      text-align:center;
      margin:0 0 20px;
      font-size:32px;
      letter-spacing:0.7px;
    }

    .filters{
      display:flex;
      gap:12px;
      flex-wrap:wrap;
      justify-content:center;
      align-items:center;
      margin-bottom:18px;
    }

    select, input[type="date"]{
      padding:10px 14px;
      border-radius:14px;
      border:none;
      outline:none;
      background:rgba(0,0,0,0.35);
      color:#fff;
      font-weight:700;
    }

    select option{ color:#000; }

    .btn{
      padding:10px 16px;
      border-radius:14px;
      border:none;
      cursor:pointer;
      font-weight:800;
      background:linear-gradient(135deg,#7C3AED,#C4B5FD);
      color:#fff;
    }

    .btn-clear{
      padding:10px 16px;
      border-radius:14px;
      border:1px solid rgba(255,255,255,0.25);
      cursor:pointer;
      font-weight:800;
      background:rgba(0,0,0,0.35);
      color:#C4B5FD;
      text-decoration:none;
      display:inline-block;
    }

    table{
      width:100%;
      border-collapse:collapse;
      border-radius:18px;
      overflow:hidden;
    }

    th{
      background:rgba(255,255,255,0.22);
      padding:14px;
      text-align:left;
      font-size:13px;
      white-space:nowrap;
    }

    td{
      background:rgba(255,255,255,0.10);
      padding:13px;
      font-size:13px;
    }

    tr:hover td{ background:rgba(255,255,255,0.18); }

    .action a{
      display:inline-block;
      padding:8px 12px;
      border-radius:12px;
      background:rgba(124,58,237,0.55);
      color:#fff;
      text-decoration:none;
      font-weight:800;
      font-size:12px;
      white-space:nowrap;
    }

    .action a:hover{ filter:brightness(1.1); }

    .center{
      text-align:center;
      margin-top:18px;
    }

    .back{
      color:#fff;
      text-decoration:none;
      font-weight:800;
    }

    .back:hover{ text-decoration:underline; }

    .footer{
      text-align:center;
      margin-top:18px;
      font-size:12px;
      opacity:0.8;
    }
  </style>
</head>

<body>
<div class="overlay">
  <div class="glass">

    <h1>All Reservations</h1>

    <!-- ✅ FILTERS (go to servlet) -->
    <form class="filters" method="get" action="<%=request.getContextPath()%>/filterReservations">
      <select name="roomType">
        <option value="All" <%= "All".equalsIgnoreCase(roomTypeVal) ? "selected" : "" %>>All</option>
        <option value="Single" <%= "Single".equalsIgnoreCase(roomTypeVal) ? "selected" : "" %>>Single</option>
        <option value="Double" <%= "Double".equalsIgnoreCase(roomTypeVal) ? "selected" : "" %>>Double</option>
        <option value="Deluxe" <%= "Deluxe".equalsIgnoreCase(roomTypeVal) ? "selected" : "" %>>Deluxe</option>
      </select>

      <input type="date" name="fromDate" value="<%= fromDateVal != null ? fromDateVal : "" %>">
      <input type="date" name="toDate" value="<%= toDateVal != null ? toDateVal : "" %>">

      <button class="btn" type="submit">Apply Filters</button>
      <a class="btn-clear" href="<%=request.getContextPath()%>/listReservations">Clear</a>
    </form>

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
        <td class="action">
          <a href="billPrint.jsp?reservationNumber=<%= r.getReservationNumber() %>">🧾 Print Bill</a>
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

    <div class="center">
      <a class="back" href="dashboard.jsp">← Back to Dashboard</a>
    </div>

    <div class="footer">© 2026 Ocean View Resort</div>

  </div>
</div>
</body>
</html>