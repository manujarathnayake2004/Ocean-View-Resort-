<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String user = (String) session.getAttribute("loggedUser");
  if (user == null) { response.sendRedirect("login.jsp?msg=Please+login+first"); return; }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Calculate & Print Bill</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

  <!-- Keep your SAME background brightness/styles from index theme -->
  <style>
    :root{
      --p1:#6D28D9;
      --p2:#A78BFA;
      --w:#FFFFFF;
      --text:rgba(255,255,255,0.92);
      --muted:rgba(255,255,255,0.74);
      --glass:rgba(255,255,255,0.12);
      --glass2:rgba(255,255,255,0.08);
      --border:rgba(255,255,255,0.22);
      --shadow: 0 18px 70px rgba(0,0,0,0.55);
    }

    *{box-sizing:border-box;}
    body{
      margin:0;
      font-family:"Segoe UI", Arial, sans-serif;
      min-height:100vh;
      color:var(--text);
      background:
              radial-gradient(1200px 700px at 15% 10%, rgba(167,139,250,0.35), transparent 55%),
              radial-gradient(900px 600px at 85% 20%, rgba(109,40,217,0.30), transparent 55%),
              linear-gradient(120deg, rgba(8,6,20,0.72), rgba(8,6,20,0.35)),
              url("images/resort-bg.jpg") center/cover no-repeat fixed;
    }

    .page{
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding: 28px 16px;
    }

    .glass{
      width:min(720px, 100%);
      background: linear-gradient(180deg, var(--glass), var(--glass2));
      border:1px solid var(--border);
      border-radius:24px;
      box-shadow:var(--shadow);
      backdrop-filter: blur(14px);
      -webkit-backdrop-filter: blur(14px);
      padding: 22px;
    }

    .top{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
    }

    h1{margin:14px 0 4px; font-size:32px;}
    p{margin:0 0 18px; color:var(--muted); line-height:1.6;}

    .form{
      display:grid;
      gap: 12px;
      margin-top: 10px;
    }

    label{font-weight:700; font-size:13px; color:rgba(255,255,255,0.85);}
    input{
      width:100%;
      padding: 12px 14px;
      border-radius: 14px;
      border:1px solid rgba(255,255,255,0.22);
      background: rgba(255,255,255,0.10);
      color: var(--w);
      outline:none;
    }
    input::placeholder{color: rgba(255,255,255,0.55);}

    .btn{
      padding: 12px 16px;
      border-radius: 14px;
      border:1px solid rgba(255,255,255,0.22);
      background: linear-gradient(135deg, var(--p1), var(--p2));
      color: var(--w);
      font-weight: 900;
      cursor:pointer;
      width: fit-content;
    }

    .note{
      margin-top: 10px;
      font-size:12px;
      color: rgba(255,255,255,0.65);
    }
  </style>
</head>
<body>
<div class="page">
  <div class="glass">
    <div class="top">
      <div>
        <div style="font-weight:900; letter-spacing:.3px;">Ocean View Resort</div>
        <div style="color:rgba(255,255,255,.65); font-size:12px;">Calculate & Print Bill</div>
      </div>
    </div>

    <h1>Search Reservation</h1>
    <p>Enter the reservation number (example: <b>OV001</b>) to generate the bill.</p>

    <form class="form" method="get" action="<%=request.getContextPath()%>/bill">
      <div>
        <label>Reservation Number</label>
        <input type="text" name="reservationNumber" placeholder="OV..." required />
      </div>

      <button class="btn" type="submit">🧾 Generate Bill</button>
    </form>

    <div class="note">Tip: You can also open bills from the reservation list using “Print to Bill”.</div>
  </div>
</div>
</body>
</html>