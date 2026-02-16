<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
  String user = (String) session.getAttribute("loggedUser");
  if (user == null) {
    response.sendRedirect("login.jsp?msg=Please+login+first");
    return;
  }

  Reservation r = (Reservation) session.getAttribute("editReservation");

  // If editReservation not found, redirect back
  if (r == null) {
    response.sendRedirect("listReservations?msg=Please+select+a+reservation+to+edit");
    return;
  }

  String err = request.getParameter("err");
  String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Edit Reservation | Ocean View Resort</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <style>
    /* Keep SAME bright background brightness as index */
    :root{
      --p1:#6D28D9;
      --p2:#A78BFA;

      --text:rgba(255,255,255,0.95);
      --muted:rgba(255,255,255,0.75);

      --glass:rgba(255,255,255,0.10);
      --glass2:rgba(255,255,255,0.06);
      --border:rgba(255,255,255,0.18);
      --shadow:0 18px 70px rgba(0,0,0,0.55);

      --good:#22c55e;
      --bad:#ff5a5a;
    }

    *{ box-sizing:border-box; }
    body{
      margin:0;
      font-family:"Segoe UI", Arial, sans-serif;
      min-height:100vh;
      color:var(--text);

      background:
              radial-gradient(1200px 700px at 15% 10%, rgba(196,181,253,0.55), transparent 55%),
              radial-gradient(900px 600px at 85% 20%, rgba(167,139,250,0.45), transparent 55%),
              linear-gradient(120deg, rgba(255,255,255,0.55), rgba(255,255,255,0.25)),
              url("images/resort-bg.jpg") center/cover no-repeat fixed;
    }

    .page{
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:40px 16px;
    }

    .glass{
      width:min(980px, 100%);
      border-radius:22px;
      background:linear-gradient(180deg, var(--glass), var(--glass2));
      border:1px solid var(--border);
      box-shadow:var(--shadow);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      padding:26px;
    }

    .top{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      flex-wrap:wrap;
      margin-bottom:14px;
    }

    h1{
      margin:0;
      font-size:26px;
      font-weight:900;
      letter-spacing:0.2px;
    }

    .sub{
      margin:6px 0 0;
      color:var(--muted);
      font-size:13px;
      line-height:1.5;
    }

    .back{
      display:inline-flex;
      align-items:center;
      justify-content:center;
      width:42px;
      height:42px;
      border-radius:14px;
      text-decoration:none;
      color:white;
      border:1px solid rgba(255,255,255,0.22);
      background:rgba(255,255,255,0.08);
      font-size:22px;
      font-weight:900;
      transition:all .2s ease;
    }
    .back:hover{
      transform:translateY(-2px);
      background:rgba(255,255,255,0.14);
    }

    .msg{
      margin:10px 0 0;
      padding:10px 12px;
      border-radius:14px;
      border:1px solid rgba(34,197,94,0.35);
      background:rgba(34,197,94,0.10);
      color:rgba(255,255,255,0.95);
      font-size:13px;
    }

    .err{
      margin:10px 0 0;
      padding:10px 12px;
      border-radius:14px;
      border:1px solid rgba(255,90,90,0.35);
      background:rgba(255,90,90,0.10);
      color:rgba(255,255,255,0.95);
      font-size:13px;
    }

    form{
      margin-top:18px;
    }

    .grid{
      display:grid;
      grid-template-columns: 1fr 1fr;
      gap:12px;
    }
    @media(max-width: 720px){
      .grid{ grid-template-columns:1fr; }
    }

    label{
      display:block;
      margin:0 0 6px;
      font-size:12px;
      font-weight:800;
      color:rgba(255,255,255,0.85);
    }

    input, select{
      width:100%;
      padding:12px 12px;
      border-radius:14px;
      border:1px solid rgba(255,255,255,0.18);
      outline:none;
      background:rgba(255,255,255,0.10);
      color:rgba(255,255,255,0.92);
      font-size:14px;
    }

    input::placeholder{ color:rgba(255,255,255,0.45); }

    select option{
      color:#111;
    }

    input[readonly]{
      opacity:0.85;
      cursor:not-allowed;
    }

    .actions{
      margin-top:14px;
      display:flex;
      gap:12px;
      flex-wrap:wrap;
      justify-content:center;
    }

    .btn{
      cursor:pointer;
      border:none;
      padding:12px 18px;
      border-radius:14px;
      font-weight:900;
      letter-spacing:0.2px;
      color:white;
      transition:transform .15s ease, filter .15s ease;
    }

    .btn-primary{
      background:linear-gradient(135deg, var(--p1), var(--p2));
      box-shadow:0 14px 34px rgba(109,40,217,0.35);
    }
    .btn-primary:hover{
      transform:translateY(-2px);
      filter:brightness(1.06);
    }

    .btn-ghost{
      text-decoration:none;
      display:inline-flex;
      align-items:center;
      justify-content:center;
      padding:12px 18px;
      border-radius:14px;
      font-weight:900;
      border:1px solid rgba(255,255,255,0.22);
      background:rgba(255,255,255,0.08);
      color:white;
    }
    .btn-ghost:hover{
      transform:translateY(-2px);
      background:rgba(255,255,255,0.14);
    }

    .footer{
      margin-top:18px;
      text-align:center;
      font-size:12px;
      color:rgba(255,255,255,0.65);
    }
  </style>
</head>

<body>
<div class="page">
  <div class="glass">

    <div class="top">
      <div>
        <h1>Edit Reservation</h1>
        <p class="sub">Update customer details and reservation dates in luxury glass style.</p>
      </div>
      <a class="back" href="<%=request.getContextPath()%>/listReservations" title="Back">&lt;</a>
    </div>

    <% if (msg != null) { %>
    <div class="msg"><%= msg %></div>
    <% } %>

    <% if (err != null) { %>
    <div class="err"><%= err %></div>
    <% } %>

    <form action="<%=request.getContextPath()%>/updateReservation" method="post">
      <div class="grid">

        <div>
          <label>Reservation Number</label>
          <input type="text" name="reservationNumber" value="<%= r.getReservationNumber() %>" readonly>
        </div>

        <div>
          <label>Customer ID</label>
          <input type="text" name="customerId" value="<%= r.getCustomerId() %>" required>
        </div>

        <div>
          <label>Customer Mobile</label>
          <input type="text" name="customerMobile" value="<%= r.getCustomerMobile() %>" required>
        </div>

        <div>
          <label>Guest Name</label>
          <input type="text" name="guestName" value="<%= r.getGuestName() %>" required>
        </div>

        <div>
          <label>Address</label>
          <input type="text" name="address" value="<%= r.getAddress() %>" required>
        </div>

        <div>
          <label>Room Type</label>
          <select name="roomType" required>
            <option value="">-- Select --</option>
            <option value="Single" <%= "Single".equals(r.getRoomType()) ? "selected" : "" %>>Single</option>
            <option value="Double" <%= "Double".equals(r.getRoomType()) ? "selected" : "" %>>Double</option>
            <option value="Deluxe" <%= "Deluxe".equals(r.getRoomType()) ? "selected" : "" %>>Deluxe</option>
          </select>
        </div>

        <div>
          <label>Check-In Date</label>
          <input type="date" name="checkIn" value="<%= r.getCheckIn() %>" required>
        </div>

        <div>
          <label>Check-Out Date</label>
          <input type="date" name="checkOut" value="<%= r.getCheckOut() %>" required>
        </div>

      </div>

      <div class="actions">
        <button class="btn btn-primary" type="submit">✅ Update Reservation</button>
        <a class="btn-ghost" href="<%=request.getContextPath()%>/listReservations">Cancel</a>
      </div>
    </form>

    <div class="footer">
      © <%= java.time.Year.now() %> Ocean View Resort | Developed by Manuja Rathnayake
    </div>

  </div>
</div>
</body>
</html>