<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.oceanview.dao.PaymentDAO" %>
<%@ page import="com.oceanview.model.Payment" %>

<%
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

    PaymentDAO dao = new PaymentDAO();

    int paymentCount = dao.getPaymentCount();
    double totalRevenue = dao.getTotalRevenue();

    List<Payment> payments = dao.getAllPayments();
    int maxRows = 8;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Report | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        :root{
            --p1:#7C3AED;
            --p2:#C4B5FD;
            --glass:rgba(255,255,255,0.14);
            --border:rgba(255,255,255,0.22);
        }
        *{box-sizing:border-box;}
        body{
            margin:0;
            font-family:"Segoe UI", Arial, sans-serif;
            min-height:100vh;
            color:#fff;
            background:
                    linear-gradient(rgba(40,0,90,0.55), rgba(120,0,180,0.45)),
                    url("images/resort-bg.jpg") center/cover no-repeat fixed;
        }
        .overlay{
            min-height:100vh;
            padding:60px 18px;
            background:rgba(0,0,0,0.25);
            display:flex;
            justify-content:center;
            align-items:flex-start;
        }
        .card{
            width:min(1200px,100%);
            background:var(--glass);
            border:1px solid var(--border);
            border-radius:26px;
            backdrop-filter:blur(14px);
            -webkit-backdrop-filter:blur(14px);
            box-shadow:0 25px 70px rgba(0,0,0,0.45);
            padding:28px;
        }
        .topbar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:10px;
            flex-wrap:wrap;
        }
        .title{
            margin:0;
            font-size:30px;
            letter-spacing:0.6px;
            font-weight:900;
        }
        .subtitle{
            margin:6px 0 0;
            opacity:0.85;
            font-size:13px;
        }
        .btns{ display:flex; gap:10px; }
        .btn{
            padding:10px 14px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,0.22);
            background:rgba(0,0,0,0.28);
            color:#fff;
            text-decoration:none;
            font-weight:800;
            font-size:13px;
        }
        .btn.primary{
            background:linear-gradient(135deg,var(--p1),var(--p2));
            border:none;
        }
        .stats{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap:14px;
            margin-top:18px;
        }
        .stat{
            background:rgba(0,0,0,0.28);
            border:1px solid rgba(255,255,255,0.16);
            border-radius:18px;
            padding:16px;
        }
        .stat small{ opacity:0.8; font-weight:700; }
        .stat .value{ margin-top:6px; font-size:26px; font-weight:900; }
        h3{ margin:22px 0 10px; font-size:18px; }
        table{
            width:100%;
            border-collapse:collapse;
            border-radius:16px;
            overflow:hidden;
        }
        th{
            background:rgba(255,255,255,0.18);
            padding:12px;
            font-size:13px;
            text-align:left;
            white-space:nowrap;
        }
        td{
            background:rgba(0,0,0,0.22);
            padding:12px;
            font-size:13px;
        }
        tr:hover td{ background:rgba(0,0,0,0.30); }
        .footer{ margin-top:16px; text-align:center; font-size:12px; opacity:0.75; }
        @media(max-width:700px){ .stats{ grid-template-columns:1fr; } }
    </style>
</head>

<body>
<div class="overlay">
    <div class="card">

        <div class="topbar">
            <div>
                <div class="title">Manager Report</div>
                <div class="subtitle">Welcome, <b><%= user %></b> | Role: <b><%= role %></b></div>
            </div>

            <div class="btns">
                <a class="btn" href="managerDashboard.jsp">← Back</a>
                <a class="btn primary" href="LogoutServlet">Logout</a>
            </div>
        </div>

        <div class="stats">
            <div class="stat">
                <small>Total Payments</small>
                <div class="value"><%= paymentCount %></div>
            </div>
            <div class="stat">
                <small>Total Revenue (LKR)</small>
                <div class="value"><%= String.format("%.2f", totalRevenue) %></div>
            </div>
        </div>

        <h3>Recent Payments</h3>

        <table>
            <tr>
                <th>Payment ID</th>
                <th>Reservation No</th>
                <th>Nights</th>
                <th>Rate / Night</th>
                <th>Subtotal</th>
                <th>Total</th>
                <th>Paid At</th>
            </tr>

            <%
                if (payments != null && !payments.isEmpty()) {
                    int c = 0;
                    for (Payment p : payments) {
                        if (c++ >= maxRows) break;
            %>
            <tr>
                <td><%= p.getPaymentId() %></td>
                <td><%= p.getReservationNumber() %></td>
                <td><%= p.getNights() %></td>
                <td><%= String.format("%.2f", p.getRatePerDay()) %></td>
                <td><%= String.format("%.2f", p.getSubtotal()) %></td>
                <td><%= String.format("%.2f", p.getTotal()) %></td>
                <td><%= p.getPaymentDate() != null ? p.getPaymentDate() : "-" %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">No payments found yet. Print a bill and click “Save Payment”.</td>
            </tr>
            <% } %>
        </table>

        <div class="footer">© <%= java.time.Year.now() %> Ocean View Resort</div>

    </div>
</div>
</body>
</html>