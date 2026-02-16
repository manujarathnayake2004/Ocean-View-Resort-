<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
    String user = (String) session.getAttribute("loggedUser");
    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+login+first");
        return;
    }

    Reservation r = (Reservation) request.getAttribute("reservation");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Reservation | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

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

            /* SAME BRIGHT BACKGROUND AS INDEX */
            background:
                    radial-gradient(1200px 700px at 15% 10%, rgba(196,181,253,0.55), transparent 55%),
                    radial-gradient(900px 600px at 85% 20%, rgba(167,139,250,0.45), transparent 55%),
                    linear-gradient(120deg, rgba(255,255,255,0.60), rgba(255,255,255,0.30)),
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
            width:min(800px,100%);
            background: linear-gradient(180deg,var(--glass),var(--glass2));
            border:1px solid var(--border);
            border-radius:22px;
            box-shadow:var(--shadow);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            padding:30px;
        }

        h2{
            text-align:center;
            margin-bottom:25px;
            font-size:22px;
        }

        form{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
            justify-content:center;
            margin-bottom:20px;
        }

        input[type=text]{
            padding:12px;
            border-radius:12px;
            border:1px solid rgba(255,255,255,0.3);
            background:rgba(255,255,255,0.15);
            color:#fff;
            width:250px;
            outline:none;
        }

        input::placeholder{
            color:rgba(255,255,255,0.6);
        }

        button{
            padding:12px 20px;
            border-radius:14px;
            border:none;
            font-weight:bold;
            background:linear-gradient(135deg,var(--p1),var(--p2));
            color:white;
            cursor:pointer;
            box-shadow:0 14px 34px rgba(109,40,217,0.35);
        }

        button:hover{
            filter:brightness(1.08);
        }

        .result{
            margin-top:20px;
            border-radius:16px;
            border:1px solid rgba(255,255,255,0.2);
            background:rgba(255,255,255,0.08);
            padding:20px;
        }

        .row{
            margin-bottom:12px;
        }

        .label{
            font-size:12px;
            color:var(--muted);
        }

        .value{
            font-weight:bold;
            font-size:14px;
        }

        .footer{
            margin-top:20px;
            text-align:center;
            font-size:12px;
            color:rgba(255,255,255,0.6);
        }
    </style>
</head>

<body>
<div class="page">
    <div class="glass">

        <h2>🔎 Search Reservation</h2>

        <form action="<%=request.getContextPath()%>/searchReservation" method="get">
            <input type="text" name="reservationNumber" placeholder="Enter Reservation Number" required>
            <button type="submit">Search</button>
        </form>

        <% if(r != null){ %>
        <div class="result">
            <div class="row">
                <div class="label">Reservation Number</div>
                <div class="value"><%= r.getReservationNumber() %></div>
            </div>

            <div class="row">
                <div class="label">Customer ID</div>
                <div class="value"><%= r.getCustomerId() %></div>
            </div>

            <div class="row">
                <div class="label">Customer Mobile</div>
                <div class="value"><%= r.getCustomerMobile() %></div>
            </div>

            <div class="row">
                <div class="label">Guest Name</div>
                <div class="value"><%= r.getGuestName() %></div>
            </div>

            <div class="row">
                <div class="label">Room Type</div>
                <div class="value"><%= r.getRoomType() %></div>
            </div>

            <div class="row">
                <div class="label">Check-In</div>
                <div class="value"><%= r.getCheckIn() %></div>
            </div>

            <div class="row">
                <div class="label">Check-Out</div>
                <div class="value"><%= r.getCheckOut() %></div>
            </div>
        </div>
        <% } %>

        <div class="footer">
            © <%= java.time.Year.now() %> Ocean View Resort
        </div>

    </div>
</div>
</body>
</html>