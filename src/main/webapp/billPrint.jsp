<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
  String reservationNumber = request.getParameter("reservationNumber");

  Reservation reservation = null;
  long nights = 0;
  double ratePerDay = 15000; // You can change room rate here
  double total = 0;

  if (reservationNumber != null && !reservationNumber.trim().isEmpty()) {
    ReservationDAO dao = new ReservationDAO();
    reservation = dao.getReservationByNumber(reservationNumber);

    if (reservation != null) {
      LocalDate checkIn = reservation.getCheckIn().toLocalDate();
      LocalDate checkOut = reservation.getCheckOut().toLocalDate();
      nights = ChronoUnit.DAYS.between(checkIn, checkOut);
      total = nights * ratePerDay;
    }
  }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Ocean View Resort | Bill</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <style>
    body{
      margin:0;
      font-family: "Segoe UI", Arial, sans-serif;
      min-height:100vh;

      /* SAME BRIGHT BACKGROUND */
      background:
              linear-gradient(rgba(255,255,255,0.4), rgba(255,255,255,0.4)),
              url("images/resort-bg.jpg") center/cover no-repeat fixed;
    }

    .container{
      max-width:900px;
      margin:60px auto;
      padding:30px;
      background: rgba(255,255,255,0.15);
      backdrop-filter: blur(15px);
      border-radius:25px;
      border:1px solid rgba(255,255,255,0.4);
      box-shadow:0 20px 60px rgba(0,0,0,0.2);
      color:#222;
    }

    h1{
      margin-top:0;
      font-size:32px;
    }

    .info-grid{
      display:grid;
      grid-template-columns:1fr 1fr;
      gap:20px;
      margin-top:20px;
    }

    .box{
      padding:15px;
      border-radius:15px;
      background:rgba(255,255,255,0.4);
    }

    table{
      width:100%;
      margin-top:30px;
      border-collapse:collapse;
    }

    table th, table td{
      padding:12px;
      text-align:left;
    }

    table th{
      border-bottom:2px solid #ccc;
    }

    .total{
      text-align:right;
      font-size:20px;
      font-weight:bold;
      margin-top:20px;
    }

    .print-btn{
      float:right;
      padding:10px 20px;
      background: linear-gradient(135deg,#6D28D9,#A78BFA);
      border:none;
      border-radius:20px;
      color:white;
      font-weight:bold;
      cursor:pointer;
    }

    .print-btn:hover{
      opacity:0.9;
    }

    @media print{
      .print-btn{
        display:none;
      }
    }

  </style>
</head>

<body>

<div class="container">

  <button class="print-btn" onclick="window.print()">🧾 Print</button>

  <h1>Bill Summary</h1>

  <% if(reservation != null){ %>

  <div class="info-grid">
    <div class="box">
      <strong>Guest Name:</strong><br>
      <%= reservation.getGuestName() %>
    </div>

    <div class="box">
      <strong>Room Type:</strong><br>
      <%= reservation.getRoomType() %>
    </div>

    <div class="box">
      <strong>Check-In:</strong><br>
      <%= reservation.getCheckIn() %>
    </div>

    <div class="box">
      <strong>Check-Out:</strong><br>
      <%= reservation.getCheckOut() %>
    </div>
  </div>

  <table>
    <tr>
      <th>Description</th>
      <th>Amount (LKR)</th>
    </tr>
    <tr>
      <td>Nights (<%= nights %>)</td>
      <td><%= nights * ratePerDay %></td>
    </tr>
    <tr>
      <td>Rate per Day</td>
      <td><%= ratePerDay %></td>
    </tr>
  </table>

  <div class="total">
    Total: LKR <%= total %>
  </div>

  <% } else { %>

  <p style="color:red;">Reservation not found.</p>

  <% } %>

</div>

</body>
</html>