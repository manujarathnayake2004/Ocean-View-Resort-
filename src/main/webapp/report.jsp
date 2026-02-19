<%@ page import="com.oceanview.dao.PaymentDAO" %>
<%@ page import="com.oceanview.model.Payment" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String user = (String) session.getAttribute("loggedUser");
    String role = (String) session.getAttribute("loggedRole");

    if (user == null) {
        response.sendRedirect("login.jsp?msg=Please+login+first");
        return;
    }
    if (role == null || !("MANAGER".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role))) {
        response.sendRedirect("login.jsp?err=Access+Denied");
        return;
    }

    PaymentDAO dao = new PaymentDAO();
    double revenue = dao.getTotalRevenue();
    int count = dao.getPaymentCount();
    List<Payment> payments = dao.getAllPayments();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Report | Ocean View Resort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        body{
            margin:0;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height:100vh;
            background:
                    radial-gradient(1200px 700px at 15% 10%, rgba(167,139,250,0.35), transparent 55%),
                    radial-gradient(900px 600px at 85% 20%, rgba(109,40,217,0.30), transparent 55%),
                    linear-gradient(120deg, rgba(8,6,20,0.72), rgba(8,6,20,0.35)),
                    url("images/resort-bg.jpg") center/cover no-repeat fixed;
            color: rgba(255,255,255,0.92);
        }

        .wrap{
            max-width: 1100px;
            margin: 40px auto;
            padding: 18px;
        }

        .card{
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.22);
            border-radius: 22px;
            padding: 18px;
            backdrop-filter: blur(14px);
            box-shadow: 0 18px 70px rgba(0,0,0,0.55);
        }

        .top{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap: 12px;
            flex-wrap:wrap;
        }

        h1{ margin: 0; font-size: 30px; }
        .muted{ color: rgba(255,255,255,0.74); margin-top: 6px; }

        .stats{ display:flex; gap:12px; flex-wrap:wrap; margin-top: 12px; }
        .stat{
            padding: 12px 14px;
            border-radius: 18px;
            background: rgba(255,255,255,0.10);
            border: 1px solid rgba(255,255,255,0.18);
            min-width: 200px;
        }

        table{ width:100%; border-collapse: collapse; margin-top: 16px; overflow:hidden; }
        th, td{ padding: 10px; text-align:left; border-bottom: 1px solid rgba(255,255,255,0.15); }
        th{ color: rgba(255,255,255,0.88); }
        td{ color: rgba(255,255,255,0.80); }

        a.btn{
            text-decoration:none;
            padding: 10px 16px;
            border-radius: 14px;
            border: 1px solid rgba(255,255,255,0.22);
            background: rgba(255,255,255,0.10);
            color: rgba(255,255,255,0.92);
            font-weight: 800;
        }
        a.btn:hover{ background: rgba(255,255,255,0.14); }

        .empty{ padding: 12px; color: rgba(255,255,255,0.74); }
    </style>
</head>
<body>

<div class="wrap">
    <div class="card">
        <div class="top">
            <div>
                <h1>Manager Report</h1>
                <div class="muted">Welcome, <b><%= user %></b> | Role: <b><%= role %></b></div>
            </div>
            <div style="display:flex; gap:10px;">
                <a class="btn" href="managerDashboard.jsp">⬅ Back</a>
                <a class="btn" href="logout">🚪 Logout</a>
            </div>
        </div>

        <div class="stats">
            <div class="stat">
                <div style="font-weight:900; font-size:12px; color:rgba(255,255,255,0.75);">Total Payments</div>
                <div style="font-size:22px; font-weight:900;"><%= count %></div>
            </div>
            <div class="stat">
                <div style="font-weight:900; font-size:12px; color:rgba(255,255,255,0.75);">Total Revenue (LKR)</div>
                <div style="font-size:22px; font-weight:900;"><%= revenue %></div>
            </div>
        </div>

        <h3 style="margin-top:18px;">Recent Payments</h3>

        <% if (payments == null || payments.size() == 0) { %>
            <div class="empty">No payments found yet. Print a bill and click “Save Payment”.</div>
        <% } else { %>

        <table>
            <tr>
                <th>ID</th>
                <th>Reservation No</th>
                <th>Nights</th>
                <th>Rate/Day</th>
                <th>Total</th>
                <th>Date</th>
            </tr>
            <% for (Payment p : payments) { %>
            <tr>
                <td><%= p.getPaymentId() %></td>
                <td><%= p.getReservationNumber() %></td>
                <td><%= p.getNights() %></td>
                <td><%= p.getRatePerDay() %></td>
                <td><%= p.getTotal() %></td>
                <td><%= p.getPaymentDate() %></td>
            </tr>
            <% } %>
        </table>

        <% } %>

    </div>
</div>

</body>
</html>
