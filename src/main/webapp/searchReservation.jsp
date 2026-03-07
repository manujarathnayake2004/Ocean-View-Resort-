<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
    String user = (String) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+login+first");
        return;
    }

    String reservationNumber = request.getParameter("reservationNumber");
    Reservation r = null;
    boolean searched = false;

    if (reservationNumber != null && !reservationNumber.trim().isEmpty()) {
        searched = true;
        ReservationDAO dao = new ReservationDAO();
        r = dao.getReservationByNumber(reservationNumber.trim());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Reservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body{
            margin:0; font-family:Segoe UI, Arial;
            min-height:100vh; color:#fff;
            background: url("images/resort-bg.jpg") center/cover no-repeat fixed;
        }
        .wrap{
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            padding:30px;
            background:rgba(0,0,0,0.35);
        }
        .card{
            width:min(800px, 100%);
            background:rgba(255,255,255,0.12);
            border:1px solid rgba(255,255,255,0.25);
            border-radius:22px;
            backdrop-filter: blur(12px);
            padding:26px;
        }
        h2{ text-align:center; margin:0 0 20px; }
        form{ display:flex; justify-content:center; gap:10px; flex-wrap:wrap; }
        input{
            padding:12px; border-radius:12px; border:none;
            width:260px; outline:none;
        }
        button{
            padding:12px 18px; border-radius:12px; border:none;
            background:#6D28D9; color:#fff; font-weight:700; cursor:pointer;
        }
        .msg{
            margin-top:16px;
            padding:12px; border-radius:12px;
            background:rgba(255,0,0,0.15);
            border:1px solid rgba(255,0,0,0.35);
            text-align:center;
        }
        .result{
            margin-top:18px;
            padding:18px; border-radius:14px;
            background:rgba(255,255,255,0.08);
            border:1px solid rgba(255,255,255,0.2);
        }
        .row{ margin-bottom:10px; }
        .label{ opacity:0.75; font-size:12px; }
        .val{ font-weight:700; }
        a{ color:#fff; display:inline-block; margin-top:16px; text-decoration:none; font-weight:700; }
    </style>
</head>
<body>
<div class="wrap">
    <div class="card">
        <h2>🔎 Search Reservation</h2>

        <form action="searchReservation.jsp" method="get">
            <input type="text" name="reservationNumber" placeholder="Enter Reservation Number"
                   value="<%= reservationNumber != null ? reservationNumber : "" %>" required>
            <button type="submit">Search</button>
        </form>

        <% if (searched && r == null) { %>
        <div class="msg">Reservation not found: <b><%= reservationNumber %></b></div>
        <% } %>

        <% if (r != null) { %>
        <div class="result">
            <div class="row"><div class="label">Reservation No</div><div class="val"><%= r.getReservationNumber() %></div></div>
            <div class="row"><div class="label">Mobile</div><div class="val"><%= r.getCustomerMobile() %></div></div>
            <div class="row"><div class="label">Guest Name</div><div class="val"><%= r.getGuestName() %></div></div>
            <div class="row"><div class="label">Address</div><div class="val"><%= r.getAddress() %></div></div>
            <div class="row"><div class="label">Room Type</div><div class="val"><%= r.getRoomType() %></div></div>
            <div class="row"><div class="label">Check-In</div><div class="val"><%= r.getCheckIn() %></div></div>
            <div class="row"><div class="label">Check-Out</div><div class="val"><%= r.getCheckOut() %></div></div>
        </div>
        <% } %>

        <a href="dashboard.jsp">← Back to Dashboard</a>
    </div>
</div>
</body>
</html>