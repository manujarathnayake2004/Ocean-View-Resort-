<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
  String user = (String) session.getAttribute("loggedUser");
  String role = (String) session.getAttribute("loggedRole");

  if (user == null) {
    response.sendRedirect("login.jsp?msg=Please+login+first");
    return;
  }
  if (role == null || !role.equalsIgnoreCase("RECEPTIONIST")) {
    response.sendRedirect("login.jsp?msg=Access+Denied");
    return;
  }

  String reservationNumber = request.getParameter("reservationNumber");
  Reservation res = null;
  boolean searched = false;

  if (reservationNumber != null && !reservationNumber.trim().isEmpty()) {
    searched = true;
    ReservationDAO dao = new ReservationDAO();
    res = dao.getReservationByNumber(reservationNumber.trim());
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Receptionist | Search Reservation</title>
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
      background:rgba(0,0,0,0.35);
      display:flex;
      justify-content:center;
      align-items:center;
      padding:30px 16px;
    }
    .glass{
      width:min(900px,100%);
      background:rgba(255,255,255,0.12);
      border:1px solid rgba(255,255,255,0.22);
      border-radius:26px;
      backdrop-filter: blur(14px);
      -webkit-backdrop-filter: blur(14px);
      box-shadow:0 25px 70px rgba(0,0,0,0.40);
      padding:28px;
    }
    h2{
      margin:0 0 18px;
      text-align:center;
      font-size:26px;
      letter-spacing:0.5px;
    }
    .pill{
      text-align:center;
      font-size:12px;
      opacity:0.85;
      margin-bottom:16px;
    }
    form{
      display:flex;
      gap:10px;
      justify-content:center;
      flex-wrap:wrap;
      margin-bottom:18px;
    }
    input{
      width:280px;
      padding:12px 14px;
      border-radius:14px;
      border:none;
      outline:none;
      background:rgba(0,0,0,0.35);
      color:#fff;
      font-weight:700;
    }
    input::placeholder{ color:rgba(255,255,255,0.6); }

    button{
      padding:12px 18px;
      border:none;
      border-radius:14px;
      cursor:pointer;
      font-weight:900;
      color:#fff;
      background:linear-gradient(135deg,#7C3AED,#C4B5FD);
    }
    button:hover{ filter:brightness(1.08); }

    .msg{
      margin-top:8px;
      padding:12px 14px;
      border-radius:14px;
      background:rgba(255,0,0,0.12);
      border:1px solid rgba(255,0,0,0.30);
      text-align:center;
      font-size:13px;
    }

    .result{
      margin-top:16px;
      padding:18px;
      border-radius:16px;
      background:rgba(255,255,255,0.08);
      border:1px solid rgba(255,255,255,0.18);
    }
    .row{
      display:flex;
      justify-content:space-between;
      gap:12px;
      padding:10px 0;
      border-bottom:1px solid rgba(255,255,255,0.12);
    }
    .row:last-child{ border-bottom:none; }
    .label{
      opacity:0.8;
      font-size:12px;
    }
    .val{
      font-weight:800;
      font-size:13px;
      text-align:right;
    }

    .back{
      display:block;
      text-align:center;
      margin-top:18px;
      color:#fff;
      text-decoration:none;
      font-weight:900;
    }
    .back:hover{ text-decoration:underline; }

    .footer{
      text-align:center;
      margin-top:16px;
      font-size:12px;
      opacity:0.75;
    }
  </style>
</head>

<body>
<div class="overlay">
  <div class="glass">
    <h2>🔎 Search Reservation (Receptionist)</h2>
    <div class="pill">Logged in as <b><%= user %></b> (RECEPTIONIST)</div>

    <form method="get" action="receptionistSearchReservation.jsp">
      <input type="text" name="reservationNumber" placeholder="Enter Reservation Number"
             value="<%= reservationNumber != null ? reservationNumber : "" %>" required>
      <button type="submit">Search</button>
    </form>

    <% if (searched && res == null) { %>
    <div class="msg">❌ Reservation not found for: <b><%= reservationNumber %></b></div>
    <% } %>

    <% if (res != null) { %>
    <div class="result">
      <div class="row"><div class="label">Reservation No</div><div class="val"><%= res.getReservationNumber() %></div></div>
      <div class="row"><div class="label">Customer ID</div><div class="val"><%= res.getCustomerId() %></div></div>
      <div class="row"><div class="label">Mobile</div><div class="val"><%= res.getCustomerMobile() %></div></div>
      <div class="row"><div class="label">Guest Name</div><div class="val"><%= res.getGuestName() %></div></div>
      <div class="row"><div class="label">Address</div><div class="val"><%= res.getAddress() %></div></div>
      <div class="row"><div class="label">Room Type</div><div class="val"><%= res.getRoomType() %></div></div>
      <div class="row"><div class="label">Check-In</div><div class="val"><%= res.getCheckIn() %></div></div>
      <div class="row"><div class="label">Check-Out</div><div class="val"><%= res.getCheckOut() %></div></div>
    </div>
    <% } %>

    <a class="back" href="receptionistDashboard.jsp">← Back to Receptionist Dashboard</a>
    <div class="footer">© 2026 Ocean View Resort</div>
  </div>
</div>
</body>
</html>