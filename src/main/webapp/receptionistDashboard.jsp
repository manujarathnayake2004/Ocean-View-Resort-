<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String loggedUser = (String) session.getAttribute("loggedUser");
    String loggedRole = (String) session.getAttribute("loggedRole");

    // Protect page
    if (loggedUser == null || loggedRole == null || !loggedRole.equalsIgnoreCase("RECEPTIONIST")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Receptionist Dashboard | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            --p1:#6D28D9;
            --p2:#A78BFA;
            --w:#FFFFFF;
            --text:rgba(255,255,255,0.92);
            --muted:rgba(255,255,255,0.72);

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

            /* ✅ Keep same background + brightness like your index/admin */
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
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border: 1px solid var(--border);
            border-radius: 22px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }

        .wrap{
            width:min(1100px, 100%);
            padding: 22px;
        }

        .topbar{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:16px;
            margin-bottom: 16px;
        }

        .brand{
            display:flex;
            align-items:center;
            gap:12px;
        }

        .logo{
            width:48px;
            height:48px;
            border-radius: 16px;
            border: 1px solid rgba(255,255,255,0.25);
            overflow:hidden;
            background: rgba(255,255,255,0.10);
            display:flex;
            align-items:center;
            justify-content:center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.35);
            font-weight:900;
        }
        .logo img{width:100%; height:100%; object-fit:cover;}

        .brand-text b{
            display:block;
            font-size:16px;
            letter-spacing: 0.3px;
        }
        .brand-text span{
            display:block;
            margin-top:2px;
            font-size:12px;
            color:var(--muted);
        }

        .userbox{
            text-align:right;
        }
        .userbox b{font-size:14px;}
        .pill{
            display:inline-block;
            margin-top:6px;
            font-size:12px;
            padding:7px 10px;
            border-radius: 999px;
            border: 1px solid rgba(255,255,255,0.22);
            background: rgba(255,255,255,0.08);
            color: rgba(255,255,255,0.88);
        }

        h1{
            margin: 10px 0 6px;
            font-size: 34px;
            letter-spacing: 0.4px;
            text-shadow: 0 10px 26px rgba(0,0,0,0.35);
        }
        p.sub{
            margin:0 0 18px;
            color: var(--muted);
            line-height: 1.6;
            font-size: 14px;
        }

        .grid{
            display:grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 14px;
        }
        @media(max-width: 720px){
            .grid{grid-template-columns: 1fr;}
        }

        .card{
            border-radius: 18px;
            border: 1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            padding: 16px;
            position:relative;
            overflow:hidden;
            transition: transform .12s ease, background .12s ease;
        }
        .card:hover{
            transform: translateY(-2px);
            background: rgba(255,255,255,0.10);
        }
        .card::before{
            content:"";
            position:absolute;
            inset:-60px;
            background: radial-gradient(circle at 20% 20%, rgba(167,139,250,0.22), transparent 55%);
            pointer-events:none;
        }
        .card h3{
            position:relative;
            margin:0 0 8px;
            font-size:16px;
        }
        .card p{
            position:relative;
            margin:0 0 12px;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.55;
        }

        .btn{
            position:relative;
            display:inline-flex;
            align-items:center;
            gap:10px;
            padding: 12px 14px;
            border-radius: 14px;
            text-decoration:none;
            font-weight:800;
            color: var(--w);
            border: 1px solid rgba(255,255,255,0.22);
            background: rgba(255,255,255,0.10);
        }
        .btn:hover{ background: rgba(255,255,255,0.14); }

        .btn-primary{
            background: linear-gradient(135deg, var(--p1), var(--p2));
            box-shadow: 0 14px 34px rgba(109,40,217,0.35);
            border: 0;
        }
        .btn-primary:hover{ filter: brightness(1.06); }

        .actions{
            display:flex;
            justify-content:flex-end;
            gap:10px;
            margin-top:16px;
            flex-wrap:wrap;
        }

        .footer{
            margin-top: 16px;
            text-align:center;
            color: rgba(255,255,255,0.60);
            font-size: 12px;
            padding-top: 10px;
        }
    </style>
</head>

<body>
<div class="page">
    <div class="glass wrap">

        <div class="topbar">
            <div class="brand">
                <div class="logo">
                    <img src="images/logo.png" alt="Logo"
                         onerror="this.style.display='none'; this.parentNode.innerHTML='OV';" />
                </div>
                <div class="brand-text">
                    <b>Ocean View Resort</b>
                    <span>Receptionist Dashboard</span>
                </div>
            </div>

            <div class="userbox">
                <b>Welcome, <%= loggedUser %> (Receptionist)</b><br>
                <span class="pill">Limited Access • Front Desk</span>
            </div>
        </div>

        <h1>Receptionist Panel</h1>
        <p class="sub">
            Add reservations, view and search bookings, and calculate/print bills.
        </p>

        <div class="grid">

            <div class="card">
                <h3>➕ Add New Reservation</h3>
                <p>Create a new booking with guest details and check-in/check-out dates.</p>
                <a class="btn btn-primary" href="addReservation.jsp">Open →</a>
            </div>

            <div class="card">
                <h3>📋 View Reservations</h3>
                <p>View all reservations and manage reservation list quickly.</p>
                <a class="btn" href="listReservations.jsp">Open →</a>
            </div>

            <div class="card">
                <h3>🔎 Search Reservation</h3>
                <p>Find a booking using the reservation number (fast lookup).</p>
                <a class="btn" href="searchReservation.jsp">Open →</a>
            </div>

            <div class="card">
                <h3>🧾 Calculate & Print Bill</h3>
                <p>Generate the bill from reservation number and print invoice.</p>
                <a class="btn" href="billPrint.jsp">Open →</a>
            </div>

        </div>

        <div class="actions">
            <a class="btn" href="logout.jsp">🚪 Logout</a>
        </div>

        <div class="footer">
            © <%= java.time.Year.now() %> Ocean View Resort • Receptionist Access
        </div>

    </div>
</div>
</body>
</html>