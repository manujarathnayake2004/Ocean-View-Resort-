package com.oceanview.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/dashboard.jsp",
        "/receptionistDashboard.jsp",
        "/managerDashboard.jsp",
        "/addReservation.jsp",
        "/editReservation.jsp",
        "/billPrint.jsp",
        "/listReservations.jsp",
        "/searchReservation.jsp",
        "/viewReservation.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?msg=Please+login+first");
            return;
        }

        chain.doFilter(request, response);
    }
}