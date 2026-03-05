<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String loggedRole = (String) session.getAttribute("loggedRole");
  String backUrl = "index.jsp";
  if ("ADMIN".equalsIgnoreCase(loggedRole)) backUrl = "adminDashboard.jsp";
  else if ("RECEPTIONIST".equalsIgnoreCase(loggedRole)) backUrl = "receptionistDashboard.jsp";
  else if ("MANAGER".equalsIgnoreCase(loggedRole)) backUrl = "managerDashboard.jsp";
%>
<!DOCTYPE html>
<html>
<head>
  <title>Calculate & Print Bill</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    /* Keep SAME background brightness: no extra dark overlay */
    body{
      margin:0;
      min-height:100vh;
      font-family: Arial, Helvetica, sans-serif;
      background: url('images/resort-bg.jpg') center/cover fixed no-repeat;
    }
    .wrap{min-height:100vh; display:flex; align-items:center; justify-content:center; padding:28px;}
    .glass{
      width:min(760px, 96vw);
      border-radius:28px;
      padding:26px 26px 22px;
      background: rgba(255,255,255,0.16);
      backdrop-filter: blur(18px);
      -webkit-backdrop-filter: blur(18px);
      border: 1px solid rgba(255,255,255,0.20);
      box-shadow: 0 18px 55px rgba(0,0,0,0.25);
      color:#eee;
    }
    .top{display:flex; align-items:center; justify-content:space-between; gap:14px; margin-bottom:10px;}
    .brand{display:flex; align-items:center; gap:12px;}
    .logo{width:42px;height:42px;border-radius:14px;background:rgba(0,0,0,.25);display:flex;align-items:center;justify-content:center;font-weight:900;}
    .brand h3{margin:0;font-size:18px;}
    .brand small{display:block;opacity:.85;margin-top:3px;}
    h1{margin:12px 0 6px; font-size:38px; letter-spacing:.2px;}
    p{margin:0 0 18px; opacity:.85;}
    form{display:flex; gap:12px; flex-wrap:wrap; align-items:center;}
    input{
      flex: 1 1 260px;
      padding:14px 16px;
      border-radius:16px;
      border: 1px solid rgba(255,255,255,.22);
      background: rgba(0,0,0,.22);
      color:#fff;
      outline:none;
      font-size:16px;
    }
    input::placeholder{color:rgba(255,255,255,.65);}
    .btn{
      padding:14px 18px;
      border-radius:16px;
      border:none;
      cursor:pointer;
      font-weight:800;
      letter-spacing:.3px;
    }
    .btn-primary{background: linear-gradient(90deg,#4b1fd2,#6a2cff); color:#fff;}
    .btn-ghost{background: rgba(255,255,255,.22); color:#fff; text-decoration:none; display:inline-flex; align-items:center; justify-content:center;}
    .footer{margin-top:18px; display:flex; justify-content:space-between; flex-wrap:wrap; gap:10px; opacity:.85;}
    .footer a{color:#fff; text-decoration:none;}
    .footer a:hover{text-decoration:underline;}
  </style>
</head>
<body>
<div class="wrap">
  <div class="glass">
    <div class="top">
      <div class="brand">
        <div class="logo">OV</div>
        <div>
          <h3>Ocean View Resort</h3>
          <small>Calculate & Print Bill</small>
        </div>
      </div>
      <a class="btn btn-ghost" href="<%= backUrl %>">← Back</a>
    </div>

    <h1>Bill Search</h1>
    <p>Enter the reservation number (example: <b>OV1001</b>). The bill will open on the next page.</p>

    <form method="get" action="billPrint.jsp">
      <input name="reservationNumber" placeholder="Enter reservation number" required />
      <button class="btn btn-primary" type="submit">Open Bill</button>
    </form>

    <div class="footer">
      <span>© 2026 Ocean View Resort</span>
      <span>Tip: If bill is empty, check the reservation exists.</span>
    </div>
  </div>
</div>
</body>
</html>
