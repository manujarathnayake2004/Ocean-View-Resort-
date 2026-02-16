<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
    // Session check
    String user = (String) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+login+first");
        return;
    }

    String reservationNumber = request.getParameter("reservationNumber");
    Reservation reservation = null;

    if (reservationNumber != null && !reservationNumber.trim().isEmpty()) {
        ReservationDAO dao = new ReservationDAO();
        reservation = dao.getReservationByNumber(reservationNumber.trim());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort | View Reservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        :root{
            --p1:#6D28D9;
            --p2:#A78BFA;
            --text: rgba(255,255,255,0.92);
            --muted: rgba(255,255,255,0.72);
            --glass: rgba(255,255,255,0.14);
            --glass2: rgba(255,255,255,0.08);
            --border: rgba(255,255,255,0.24);
            --shadow: 0 18px 70px rgba(0,0,0,0.45);
        }

        *{box-sizing:border-box;}
        body{
            margin:0;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height:100vh;
            color: var(--text);

            /* KEEP SAME BRIGHTNESS / BACKGROUND */
            background:
                    radial-gradient(1200px 700px at 15% 10%, rgba(167,139,250,0.35), transparent 55%),
                    radial-gradient(900px 600px at 85% 20%, rgba(109,40,217,0.30), transparent 55%),
                    linear-gradient(120deg, rgba(8,6,20,0.62), rgba(8,6,20,0.30)),
                    url("images/resort-bg.jpg") center/cover no-repeat fixed;
        }

        .page{
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            padding: 36px 16px;
        }

        .glass{
            width:min(980px, 100%);
            background: linear-gradient(180deg, var(--glass), var(--glass2));
            border: 1px solid var(--border);
            border-radius: 22px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            overflow:hidden;
        }

        .top{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:12px;
            padding:18px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.14);
        }

        .brand{
            display:flex;
            align-items:center;
            gap:10px;
        }

        .logo{
            width:46px;
            height:46px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,0.22);
            background: rgba(255,255,255,0.10);
            display:flex;
            align-items:center;
            justify-content:center;
            font-weight:900;
            overflow:hidden;
        }

        .logo img{width:100%; height:100%; object-fit:cover;}

        .brand b{display:block; font-size:16px;}
        .brand span{display:block; font-size:12px; color:var(--muted); margin-top:2px;}

        .btn{
            text-decoration:none;
            padding:10px 14px;
            border-radius: 14px;
            border:1px solid rgba(255,255,255,0.22);
            background: rgba(255,255,255,0.10);
            color: var(--text);
            font-weight:800;
            display:inline-flex;
            align-items:center;
            gap:8px;
        }
        .btn:hover{background: rgba(255,255,255,0.14);}

        .content{
            padding:22px;
        }

        h1{
            margin:0 0 6px;
            font-size:28px;
            letter-spacing:0.4px;
        }
        .sub{
            margin:0 0 18px;
            color: var(--muted);
            line-height:1.6;
            font-size:13px;
        }

        .search-box{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
            margin-bottom:18px;
        }

        input[type="text"]{
            flex:1;
            min-width:220px;
            padding:12px 14px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,0.22);
            background: rgba(255,255,255,0.10);
            color: var(--text);
            outline:none;
        }
        input::placeholder{color: rgba(255,255,255,0.55);}

        .btn-primary{
            cursor:pointer;
            padding:12px 16px;
            border-radius:14px;
            border:none;
            font-weight:900;
            color:white;
            background: linear-gradient(135deg, var(--p1), var(--p2));
            box-shadow: 0 14px 34px rgba(109,40,217,0.35);
        }
        .btn-primary:hover{filter:brightness(1.06);}

        .grid{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap:12px;
            margin-top: 10px;
        }
        @media(max-width:720px){
            .grid{grid-template-columns:1fr;}
        }

        .card{
            border-radius:18px;
            border:1px solid rgba(255,255,255,0.18);
            background: rgba(255,255,255,0.08);
            padding:14px;
        }

        .label{
            font-size:12px;
            color: var(--muted);
            margin-bottom:6px;
        }
        .value{
            font-size:14px;
            font-weight:800;
        }

        .msg{
            margin-top: 12px;
            padding: 12px 14px;
            border-radius: 14px;
            border: 1px solid rgba(255,255,255,0.20);
            background: rgba(255,255,255,0.10);
            color: rgba(255,255,255,0.92);
        }

        .err{
            border-color: rgba(255,60,60,0.35);
            background: rgba(255,60,60,0.12);
        }

        .footer{
            text-align:center;
            padding:14px;
            border-top:1px solid rgba(255,255,255,0.14);
            color: rgba(255,255,255,0.65);
            font-size:12px;
        }
    </style>
</head>

<body>
<div class="page">
    <div class="glass">

        <div class="top">
            <div class="brand">
                <div class="logo">
                    <img src="images/logo.png" alt="Logo"
                         onerror="this.style.display='none'; this.parentNode.innerHTML='OV';" />
                </div>
                <div>
                    <b>Ocean View Resort</b>
                    <span>Reservation Details</span>
                </div>
            </div>

            <a class="btn" href="dashboard.jsp">⬅ Back</a>
        </div>

        <div class="content">
            <h1>View Reservation</h1>
            <p class="sub">
                Enter the reservation number to display full reservation information.
                (Example: OV1001)
            </p>

            <form class="search-box" method="get" action="viewReservation.jsp">
                <input type="text" name="reservationNumber" placeholder="Enter Reservation Number (ex: OV1001)"
                       value="<%= reservationNumber != null ? reservationNumber : "" %>" required>
                <button class="btn-primary" type="submit">🔎 Search</button>
            </form>

            <% if (reservationNumber != null && (reservation == null)) { %>
            <div class="msg err">❌ No reservation found for: <b><%= reservationNumber %></b></div>
            <% } %>

            <% if (reservation != null) { %>
            <div class="grid">

                <div class="card">
                    <div class="label">Reservation Number</div>
                    <div class="value"><%= reservation.getReservationNumber() %></div>
                </div>

                <div class="card">
                    <div class="label">Guest Name</div>
                    <div class="value"><%= reservation.getGuestName() %></div>
                </div>

                <div class="card">
                    <div class="label">Customer ID</div>
                    <div class="value"><%= reservation.getCustomerId() %></div>
                </div>

                <div class="card">
                    <div class="label">Customer Mobile</div>
                    <div class="value"><%= reservation.getCustomerMobile() %></div>
                </div>

                <div class="card">
                    <div class="label">Address</div>
                    <div class="value"><%= reservation.getAddress() %></div>
                </div>

                <div class="card">
                    <div class="label">Room Type</div>
                    <div class="value"><%= reservation.getRoomType() %></div>
                </div>

                <div class="card">
                    <div class="label">Check-In Date</div>
                    <div class="value"><%= reservation.getCheckIn() %></div>
                </div>

                <div class="card">
                    <div class="label">Check-Out Date</div>
                    <div class="value"><%= reservation.getCheckOut() %></div>
                </div>

            </div>
            <% } %>

        </div>

        <div class="footer">
            © <%= java.time.Year.now() %> Ocean View Resort • Developed by Manuja Rathnayake
        </div>

    </div>
</div>
</body>
</html>