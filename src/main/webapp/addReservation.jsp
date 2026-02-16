<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String user = (String) session.getAttribute("loggedUser");
  if (user == null) {
    response.sendRedirect("login.jsp?msg=Please+login+first");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Ocean View Resort | Add Reservation</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <style>
    :root{
      --p1:#7C3AED; /* purple */
      --p2:#C4B5FD; /* light purple */
      --white:#ffffff;

      --glass:rgba(255,255,255,0.18);
      --border:rgba(255,255,255,0.35);

      --text:rgba(255,255,255,0.95);
      --muted:rgba(255,255,255,0.75);
    }

    *{box-sizing:border-box;}

    body{
      margin:0;
      font-family:"Segoe UI", Arial, sans-serif;
      min-height:100vh;
      color:var(--text);

      /* BRIGHT VERSION (like index page) */
      background:
              radial-gradient(1200px 700px at 15% 10%, rgba(196,181,253,0.55), transparent 55%),
              radial-gradient(900px 600px at 85% 20%, rgba(167,139,250,0.45), transparent 55%),
              linear-gradient(120deg, rgba(255,255,255,0.60), rgba(255,255,255,0.30)),
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
      width:min(850px, 100%);
      background:var(--glass);
      backdrop-filter:blur(14px);
      -webkit-backdrop-filter:blur(14px);
      border-radius:25px;
      border:1px solid var(--border);
      box-shadow:0 25px 70px rgba(0,0,0,0.35);
      padding:35px;
    }

    .top{
      text-align:center;
      margin-bottom:18px;
    }

    .logo{
      width:64px;
      height:64px;
      border-radius:18px;
      margin:0 auto 10px;
      border:1px solid rgba(255,255,255,0.35);
      background:rgba(255,255,255,0.10);
      display:flex;
      justify-content:center;
      align-items:center;
      overflow:hidden;
    }
    .logo img{width:100%; height:100%; object-fit:cover;}

    h2{
      margin:0;
      font-size:28px;
      letter-spacing:1px;
    }

    .sub{
      margin:6px auto 0;
      max-width:520px;
      color:var(--muted);
      font-size:13px;
      line-height:1.6;
    }

    .msg{
      margin:14px auto 0;
      padding:12px 14px;
      width:min(520px,100%);
      border-radius:14px;
      background:rgba(16,185,129,0.20);
      border:1px solid rgba(16,185,129,0.35);
      color:#E8FFF3;
      font-weight:700;
      text-align:center;
    }

    .err{
      margin:14px auto 0;
      padding:12px 14px;
      width:min(520px,100%);
      border-radius:14px;
      background:rgba(239,68,68,0.18);
      border:1px solid rgba(239,68,68,0.30);
      color:#FFECEC;
      font-weight:700;
      text-align:center;
    }

    form{
      margin-top:22px;
      display:grid;
      grid-template-columns: 1fr 1fr;
      gap:14px;
    }

    @media (max-width: 720px){
      form{grid-template-columns:1fr;}
    }

    .field{
      display:flex;
      flex-direction:column;
      gap:6px;
    }

    label{
      font-size:13px;
      font-weight:700;
      color:rgba(255,255,255,0.90);
      letter-spacing:0.2px;
    }

    input, select{
      padding:12px 14px;
      border-radius:14px;
      border:1px solid rgba(255,255,255,0.35);
      outline:none;
      background:rgba(255,255,255,0.88);
      color:#2b2b2b;
      font-weight:650;
    }

    input:focus, select:focus{
      border-color: rgba(196,181,253,0.9);
      box-shadow: 0 0 0 4px rgba(124,58,237,0.20);
    }

    .full{
      grid-column: 1 / -1;
    }

    .actions{
      grid-column: 1 / -1;
      display:flex;
      justify-content:center;
      margin-top:6px;
    }

    button{
      width:min(360px, 100%);
      padding:13px 18px;
      border:none;
      border-radius:16px;
      cursor:pointer;
      font-weight:900;
      letter-spacing:0.5px;
      color:white;
      background:linear-gradient(135deg, var(--p1), var(--p2));
      box-shadow:0 16px 38px rgba(124,58,237,0.35);
      transition:transform .12s ease, filter .12s ease;
    }

    button:hover{
      transform:translateY(-2px);
      filter:brightness(1.06);
    }

    .back{
      display:block;
      text-align:center;
      margin-top:20px;
      color:white;
      text-decoration:none;
      font-weight:800;
      opacity:0.92;
    }

    .back:hover{
      text-decoration:underline;
    }

    .footer{
      text-align:center;
      margin-top:26px;
      font-size:12px;
      opacity:0.70;
    }
  </style>
</head>

<body>
<div class="page">
  <div class="glass-container">

    <div class="top">
      <div class="logo">
        <img src="images/logo.png" alt="Logo"
             onerror="this.style.display='none'; this.parentNode.innerHTML='OV'; this.parentNode.style.fontWeight='900';" />
      </div>
      <h2>Add New Reservation</h2>
      <p class="sub">
        Enter customer details and reservation information. Customer ID and Customer Mobile must be unique.
      </p>

      <%
        String msg = request.getParameter("msg");
        String err = request.getParameter("err");
        if (msg != null) {
      %>
      <div class="msg"><%= msg %></div>
      <% } %>

      <%
        if (err != null) {
      %>
      <div class="err"><%= err %></div>
      <% } %>
    </div>

    <form action="<%=request.getContextPath()%>/addReservation" method="post">

      <div class="field">
        <label>Reservation Number</label>
        <input type="text" name="reservationNumber" required placeholder="ex: OV1001">
      </div>

      <div class="field">
        <label>Customer ID Number</label>
        <input type="text" name="customerId" required placeholder="ex: 200401701799">
      </div>

      <div class="field">
        <label>Customer Mobile Number</label>
        <input type="text" name="customerMobile" required placeholder="ex: 0771234567">
      </div>

      <div class="field">
        <label>Guest Name</label>
        <input type="text" name="guestName" required placeholder="ex: Manuja Rathnayake">
      </div>

      <div class="field full">
        <label>Address</label>
        <input type="text" name="address" required placeholder="ex: Matara, Sri Lanka">
      </div>

      <div class="field">
        <label>Room Type</label>
        <select name="roomType" required>
          <option value="">-- Select --</option>
          <option value="Single">Single</option>
          <option value="Double">Double</option>
          <option value="Deluxe">Deluxe</option>
        </select>
      </div>

      <div class="field">
        <label>Check-In Date</label>
        <input type="date" name="checkIn" required>
      </div>

      <div class="field">
        <label>Check-Out Date</label>
        <input type="date" name="checkOut" required>
      </div>

      <div class="actions">
        <button type="submit">Save Reservation</button>
      </div>
    </form>

    <a class="back" href="dashboard.jsp">⬅ Back to Dashboard</a>

    <div class="footer">
      © <%= java.time.Year.now() %> Ocean View Resort
    </div>

  </div>
</div>
</body>
</html>