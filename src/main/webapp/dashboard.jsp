<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String loggedUser = (String) session.getAttribute("loggedUser");
    String loggedRole = (String) session.getAttribute("loggedRole");
    Integer roleId = (Integer) session.getAttribute("roleId");

    if (loggedUser == null) {
        response.sendRedirect("login.jsp?err=Please%20login%20first");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Ocean View Resort</title>

    <style>
        :root{
            --purple:#512175;
            --purple2:#7a3cff;
            --white:#ffffff;
            --glass: rgba(255,255,255,0.10);
            --glass2: rgba(255,255,255,0.07);
            --line: rgba(255,255,255,0.14);
            --shadow: 0 18px 45px rgba(0,0,0,0.45);
        }

        *{margin:0;padding:0;box-sizing:border-box;font-family:Arial, sans-serif;}
        body{
            min-height:100vh;
            background:url("images/resort-bg.jpg") no-repeat center center/cover;
            color:var(--white);
        }

        .backdrop{
            position:fixed; inset:0;
            background:linear-gradient(120deg, rgba(0,0,0,0.60), rgba(0,0,0,0.30));
            backdrop-filter: blur(2px);
            z-index:-1;
        }

        .glass{
            background: var(--glass);
            border:1px solid var(--line);
            border-radius:22px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(14px);
            overflow:hidden;
        }

        /* Only one panel now */
        .container{
            width:92%;
            max-width:1200px;
            margin:40px auto;
        }

        .main{
            padding:20px;
        }

        .topBar{
            display:flex;
            align-items:flex-start;
            justify-content:space-between;
            gap:14px;
            padding:18px;
            border-radius:22px;
            background: var(--glass2);
            border:1px solid var(--line);
            margin-bottom:16px;
        }

        .topBar h1{
            font-size:34px;
            letter-spacing:0.2px;
            margin-bottom:6px;
        }
        .topBar p{
            opacity:0.85;
            font-size:14px;
            line-height:1.5;
        }

        .statusPill{
            white-space:nowrap;
            padding:10px 14px;
            border-radius:999px;
            background: rgba(0,0,0,0.28);
            border:1px solid rgba(255,255,255,0.14);
            font-size:13px;
        }
        .statusPill b{color:#d8ffd8}

        .cards{
            display:grid;
            grid-template-columns: repeat(3, 1fr);
            gap:14px;
        }

        .card{
            padding:18px;
            border-radius:22px;
            background: rgba(0,0,0,0.22);
            border:1px solid rgba(255,255,255,0.12);
            min-height:150px;
            transition:0.2s;
        }
        .card:hover{
            transform: translateY(-2px);
            border-color: rgba(255,255,255,0.20);
        }

        .card h3{
            font-size:18px;
            margin-bottom:8px;
        }
        .card p{
            font-size:13px;
            opacity:0.85;
            line-height:1.45;
        }

        .btn{
            display:inline-block;
            margin-top:12px;
            padding:10px 14px;
            border-radius:14px;
            text-decoration:none;
            color:#fff;
            background: rgba(81,33,117,0.40);
            border:1px solid rgba(255,255,255,0.15);
            transition:0.2s;
            font-size:13px;
        }
        .btn:hover{
            background: rgba(81,33,117,0.65);
        }

        .btnSolid{
            background: linear-gradient(90deg, var(--purple), var(--purple2));
            border:none;
        }

        .footer{
            margin-top:16px;
            text-align:right;
            font-size:12px;
            opacity:0.7;
            padding-right:6px;
        }

        @media (max-width: 980px){
            .container{margin:20px auto;}
            .cards{grid-template-columns:1fr;}
            .topBar{flex-direction:column;}
        }
    </style>
</head>
<body>
<div class="backdrop"></div>

<div class="container">
    <div class="glass main">

        <div class="topBar">
            <div>
                <h1>Dashboard</h1>
                <p>Welcome to Ocean View Resort hotel reservation & billing system. Manage reservations, billing and users using the menu.</p>
            </div>
            <div class="statusPill">Status: <b>Online</b></div>
        </div>

        <div class="cards">

            <div class="card">
                <h3> ➕ Add Reservation </h3>
                <p>Create a new reservation with guest information, room type and dates.</p>
                <a class="btn btnSolid" href="<%= request.getContextPath() %>/addReservation.jsp">Open</a>
            </div>

            <div class="card">
                <h3> 🔎 Reservation Details</h3>
                <p>Search and view reservation information by reservation number.</p>
                <a class="btn" href="<%= request.getContextPath() %>/searchReservation.jsp">Open</a>
            </div>

            <div class="card">
                <h3>📜 View All Reservations</h3>
                <p>Calculate and print bill for a reservation using reservation number.</p>
                <a class="btn" href="<%= request.getContextPath() %>/listReservations.jsp">Open</a>
            </div>

            <div class="card">
                <h3> 🗓️ Calculate & Print Bill </h3>
                <p>Print bill using reservation number (after calculation).</p>
                <a class="btn" href="<%= request.getContextPath() %>/calculateBill.jsp">Open</a>
            </div>

            <div class="card">
                <h3> ❓ Help</h3>
                <p>Create and manage system users (Admin / Receptionist).</p>
                <% if (loggedRole != null && loggedRole.equalsIgnoreCase("ADMIN")) { %>
                <a class="btn" href="<%= request.getContextPath() %>/help.jsp">Open</a>
                <% } else { %>
                <span style="opacity:0.7;font-size:13px;">Admin only</span>
                <% } %>
            </div>

            <div class="card">
                <h3> ❌ Logout</h3>
                <p>Exit from the system securely.</p>
                <a class="btn btnSolid" href="<%= request.getContextPath() %>/logout.jsp">Logout</a>
            </div>


        </div>

        <div class="footer">© 2026 Ocean View Resort</div>
    </div>
</div>

</body>
</html>