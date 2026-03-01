<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Destroy session
    if (session != null) {
        session.invalidate();
    }

    // Redirect to login page (or index.jsp if you want)
    response.sendRedirect(request.getContextPath() + "/login.jsp");
%>

<a href="<%= request.getContextPath() %>/logout.jsp">Logout</a>

