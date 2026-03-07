<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

  String msg = request.getParameter("msg");
  if (msg == null) msg = "";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Receptionist | Add Reservation</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <style>
    :root{
      --p1:#7C3AED;
      --p2:#C4B5FD;
      --glass:rgba(255,255,255,0.18);
      --border:rgba(255,255,255,0.35);
    }
    *{box-sizing:border-box;}
    body{
      margin:0;
      font-family:"Segoe UI", Arial, sans-serif;
      min-height:100vh;
      color:white;
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
      width:min(1100px, 100%);
      background:var(--glass);
      backdrop-filter:blur(14px);
      -webkit-backdrop-filter:blur(14px);
      border-radius:25px;
      border:1px solid var(--border);
      box-shadow:0 25px 70px rgba(0,0,0,0.35);
      padding:30px;
    }
    .topbar{
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:10px;
      margin-bottom:18px;
    }
    h2{margin:0;font-size:28px;letter-spacing:0.6px;}
    .pill{
      font-size:12px;
      padding:8px 12px;
      border-radius:999px;
      border:1px solid rgba(255,255,255,0.25);
      background:rgba(255,255,255,0.10);
    }
    .msg{
      margin:12px 0 16px;
      padding:12px 14px;
      border-radius:14px;
      background:rgba(0,0,0,0.25);
      border:1px solid rgba(255,255,255,0.15);
      font-size:13px;
    }
    form{
      display:grid;
      grid-template-columns:1fr 1fr;
      gap:14px;
    }
    label{
      display:block;
      font-size:12px;
      opacity:0.9;
      margin-bottom:6px;
      font-weight:700;
    }
    input, select{
      width:100%;
      padding:12px 12px;
      border:none;
      border-radius:14px;
      outline:none;
      background:rgba(0,0,0,0.35);
      color:#fff;
      font-weight:700;
    }
    input::placeholder{ color:rgba(255,255,255,0.6); }
    .full{ grid-column: 1 / span 2; }

    .btn-row{
      display:flex;
      gap:10px;
      justify-content:flex-end;
      margin-top:8px;
    }
    .btn{
      padding:11px 16px;
      border-radius:14px;
      border:none;
      cursor:pointer;
      font-weight:800;
      font-size:13px;
    }
    .save{
      background:linear-gradient(135deg,#7C3AED,#C4B5FD);
      color:white;
    }
    .clear{
      background:rgba(255,255,255,0.20);
      color:white;
      border:1px solid rgba(255,255,255,0.25);
    }
    .back{
      display:block;
      text-align:center;
      margin-top:18px;
      color:white;
      text-decoration:none;
      font-weight:700;
    }
    .back:hover{ text-decoration:underline; }
    .footer{
      text-align:center;
      margin-top:20px;
      font-size:12px;
      opacity:0.8;
    }
  </style>
</head>

<body>
<div class="page">
  <div class="glass-container">

    <div class="topbar">
      <h2>Add New Reservation (Receptionist)</h2>
      <div class="pill">Logged in: <b><%= user %></b> (RECEPTIONIST)</div>
    </div>

    <% if (!msg.trim().isEmpty()) { %>
    <div class="msg"><%= msg %></div>
    <% } %>

    <form method="post" action="<%=request.getContextPath()%>/addReservation">

      <!-- ✅ IMPORTANT: tells servlet to redirect back to receptionist page -->
      <input type="hidden" name="returnPage" value="receptionistAddReservation.jsp">

      <div>
        <label>Reservation Number</label>
        <input type="text" name="reservationNumber" placeholder="ex: OV001" required>
      </div>

      <div>
        <label>Customer ID (Optional)</label>
        <input type="text" name="customerId" placeholder="ex: C001">
      </div>

      <div>
        <label>Guest Name</label>
        <input type="text" name="guestName" placeholder="ex: Manuja Rathnayake" required>
      </div>

      <div>
        <label>Mobile Number</label>
        <input type="text" name="customerMobile" placeholder="07XXXXXXXX" required>
      </div>

      <div class="full">
        <label>Address</label>
        <input type="text" name="address" placeholder="Guest address" required>
      </div>

      <div>
        <label>Room Type</label>
        <select name="roomType" required>
          <option value="">-- Select --</option>
          <option value="Single">Single</option>
          <option value="Double">Double</option>
          <option value="Deluxe">Deluxe</option>
        </select>
      </div>

      <div>
        <label>Room Count (Optional)</label>
        <input type="number" name="roomCount" min="1" value="1">
      </div>

      <div>
        <label>Check-In Date</label>
        <input type="date" name="checkIn" required>
      </div>

      <div>
        <label>Check-Out Date</label>
        <input type="date" name="checkOut" required>
      </div>

      <div class="btn-row full">
        <button type="reset" class="btn clear">Clear</button>
        <button type="submit" class="btn save">Save Reservation</button>
      </div>
    </form>

    <a class="back" href="receptionistDashboard.jsp">⬅ Back to Receptionist Dashboard</a>

    <div class="footer">
      © <%= java.time.Year.now() %> Ocean View Resort
    </div>

  </div>
</div>
</body>
</html>