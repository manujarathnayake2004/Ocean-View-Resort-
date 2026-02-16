<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("loggedUser");
    String role = (String) session.getAttribute("loggedRole");
    if (user == null) { response.sendRedirect("login.jsp?msg=Please+login+first"); return; }
    if (!"MANAGER".equalsIgnoreCase(role)) { response.sendRedirect("login.jsp?err=Access+Denied"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager | Dashboard</title>
</head>
<body style="font-family:Segoe UI, Arial;">
<h2>Welcome, <%= user %> (Manager)</h2>

<ul>
    <li><a href="listReservations">View All Reservations</a></li>
    <li><a href="report.jsp">Generate Reports</a></li>
    <li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
</ul>
</body>
</html>