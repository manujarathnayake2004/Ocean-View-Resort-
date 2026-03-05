<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.dao.ReservationDAO" %>
<%@ page import="com.oceanview.model.Reservation" %>

<%
    // Session check (Manager only)
    String user = (String) session.getAttribute("loggedUser");
    String role = (String) session.getAttribute("loggedRole");

    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+login+first");
        return;
    }
    if (role == null || !role.equalsIgnoreCase("MANAGER")) {
        response.sendRedirect("login.jsp?msg=Access+Denied");
        return;
    }

    // Load reservations directly for manager page
    ReservationDAO dao = new ReservationDAO();
    List<Reservation> list = dao.getAllReservations();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager | All Reservations</title>
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
            width:min(1200px, 100%);
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

        h2{
            margin:0;
            font-size:26px;
            letter-spacing:0.6px;
        }

        .pill{
            font-size:12px;
            padding:8px 12px;
            border-radius:999px;
            border:1px solid rgba(255,255,255,0.25);
            background:rgba(255,255,255,0.10);
        }

        .search-box{
            display:flex;
            justify-content:center;
            margin: 12px 0 18px;
        }

        .search-box input{
            width:min(520px, 100%);
            padding:12px 14px;
            border:none;
            border-radius:14px;
            outline:none;
            background:rgba(255,255,255,0.88);
            color:#333;
            font-weight:600;
        }

        table{
            width:100%;
            border-collapse:collapse;
            border-radius:15px;
            overflow:hidden;
        }

        th{
            background:rgba(255,255,255,0.25);
            padding:14px;
            text-align:left;
            font-size:13px;
        }

        td{
            background:rgba(255,255,255,0.15);
            padding:12px;
            font-size:13px;
        }

        tr:hover td{
            background:rgba(255,255,255,0.25);
        }

        .btn{
            padding:7px 12px;
            border-radius:10px;
            text-decoration:none;
            font-size:12px;
            font-weight:700;
            display:inline-block;
        }

        .bill{
            background:linear-gradient(135deg,#7C3AED,#C4B5FD);
            color:white;
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
            <h2>All Reservations (Manager)</h2>
            <div class="pill">Logged in: <b><%= user %></b> (MANAGER)</div>
        </div>

        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Search by reservation no, guest name, mobile, room type...">
        </div>

        <table id="resTable">
            <tr>
                <th>Reservation No</th>
                <th>Customer ID</th>
                <th>Mobile</th>
                <th>Guest Name</th>
                <th>Room Type</th>
                <th>Check-In</th>
                <th>Check-Out</th>
                <th>Action</th>
            </tr>

            <%
                if (list != null && !list.isEmpty()) {
                    for (Reservation r : list) {
            %>
            <tr>
                <td><%= r.getReservationNumber() %></td>
                <td><%= r.getCustomerId() %></td>
                <td><%= r.getCustomerMobile() %></td>
                <td><%= r.getGuestName() %></td>
                <td><%= r.getRoomType() %></td>
                <td><%= r.getCheckIn() %></td>
                <td><%= r.getCheckOut() %></td>
                <td>
                    <a class="btn bill"
                       href="<%=request.getContextPath()%>/billPrint.jsp?reservationNumber=<%= r.getReservationNumber() %>">
                        🧾 Print Bill
                    </a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8">No reservations found.</td>
            </tr>
            <% } %>
        </table>

        <a class="back" href="managerDashboard.jsp">⬅ Back to Manager Dashboard</a>

        <div class="footer">
            © <%= java.time.Year.now() %> Ocean View Resort
        </div>

    </div>
</div>

<script>
    // Simple table search (no backend change)
    const input = document.getElementById("searchInput");
    const table = document.getElementById("resTable");

    input.addEventListener("keyup", function () {
        const filter = input.value.toLowerCase();
        const rows = table.getElementsByTagName("tr");

        for (let i = 1; i < rows.length; i++) {
            const rowText = rows[i].innerText.toLowerCase();
            rows[i].style.display = rowText.includes(filter) ? "" : "none";
        }
    });
</script>

</body>
</html>