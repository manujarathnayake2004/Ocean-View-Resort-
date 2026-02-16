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
    <title>Dashboard | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Same theme background brightness (DON'T change) -->
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
        .page{min-height:100vh; display:flex; justify-content:center; padding:30px 16px;}
        .glass{
            width:min(780px,100%);
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border:1px solid var(--border);
            border-radius:24px;
            box-shadow:var(--shadow);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            padding:22px;
        }
        h1{margin:0 0 6px; font-size:34px;}
        h2{margin:0 0 18px; font-size:18px; color:rgba(255,255,255,.82); font-weight:700;}
        .menu{display:grid; gap:12px;}
        .item{
            display:flex; align-items:center; justify-content:space-between;
            padding:16px 16px;
            border-radius:18px;
            border:1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            text-decoration:none;
            color:var(--w);
            font-weight:800;
            transition: transform .12s ease, background .12s ease;
        }
        .item:hover{transform: translateY(-1px); background: rgba(255,255,255,0.12);}
        .left{display:flex; align-items:center; gap:12px;}
        .icon{
            width:38px; height:38px; border-radius:14px;
            border:1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.10);
            display:flex; align-items:center; justify-content:center;
        }
        .arrow{opacity:.7; font-size:18px;}
        .footer{margin-top:18px; text-align:center; font-size:12px; color:rgba(255,255,255,.55);}
    </style>
</head>
<body>
<div class="page">
    <div class="glass">

        <h1>Welcome, <%= user %> 👋</h1>
        <h2>Ocean View Resort - Reservation System</h2>

        <div class="menu">

            <a class="item" href="addReservation.jsp">
                <div class="left"><div class="icon">➕</div> Add New Reservation</div>
                <div class="arrow">›</div>
            </a>

            <a class="item" href="searchReservation.jsp">
                <div class="left"><div class="icon">🔎</div> Display Reservation Details</div>
                <div class="arrow">›</div>
            </a>

            <a class="item" href="<%=request.getContextPath()%>/listReservations">
                <div class="left"><div class="icon">📋</div> View All Reservations</div>
                <div class="arrow">›</div>
            </a>

            <!-- ✅ CALCULATE & PRINT BILL (THIS IS THE FEATURE YOU ASKED) -->
            <a class="item" href="searchBill.jsp">
                <div class="left"><div class="icon">🧾</div> Calculate & Print Bill</div>
                <div class="arrow">›</div>
            </a>

            <a class="item" href="help.jsp">
                <div class="left"><div class="icon">❓</div> Help</div>
                <div class="arrow">›</div>
            </a>

            <a class="item" href="exit.jsp">
                <div class="left"><div class="icon">❌</div> Exit System</div>
                <div class="arrow">›</div>
            </a>

            <a class="item" href="logout">
                <div class="left"><div class="icon">🚪</div> Logout</div>
                <div class="arrow">›</div>
            </a>

        </div>

        <div class="footer">© <%= java.time.Year.now() %> Ocean View Resort</div>
    </div>
</div>
</body>
</html>