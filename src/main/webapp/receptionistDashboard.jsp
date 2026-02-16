<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("loggedUser");
    String role = (String) session.getAttribute("loggedRole");
    if (user == null) { response.sendRedirect("login.jsp?msg=Please+login+first"); return; }
    if (!"RECEPTIONIST".equalsIgnoreCase(role)) { response.sendRedirect("login.jsp?err=Access+Denied"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Receptionist | Dashboard</title>
</head>
<body style="font-family:Segoe UI, Arial;">
<h2>Welcome, <%= user %> (Receptionist)</h2>

<ul>
    <li><a href="addReservation.jsp">Add New Reservation</a></li>
    <li><a href="listReservations">View Reservations</a></li>
    <li><a href="searchReservation.jsp">Search Reservation</a></li>
    <li><a href="billPrint.jsp">Calculate & Print Bill</a></li>
    <li><a href="<%=request.getContextPath()%>/logout">Logout</a></li>
</ul>
</body>
</html>