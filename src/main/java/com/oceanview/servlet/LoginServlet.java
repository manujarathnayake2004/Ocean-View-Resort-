package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            resp.sendRedirect("login.jsp?err=Please+enter+username+and+password");
            return;
        }

        User u = userDAO.login(username.trim(), password.trim());

        if (u == null) {
            resp.sendRedirect("login.jsp?err=Invalid+username+or+password");
            return;
        }

        // Create session
        HttpSession session = req.getSession(true);
        session.setAttribute("loggedUser", u.getUsername());
        session.setAttribute("loggedRole", u.getRole());
        session.setMaxInactiveInterval(30 * 60);

        // ✅ IMPORTANT: DO NOT change your existing admin page
        // ADMIN -> dashboard.jsp (your current admin page)
        // RECEPTIONIST -> receptionistDashboard.jsp
        // MANAGER -> managerDashboard.jsp

        if ("ADMIN".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect("dashboard.jsp");
        } else if ("RECEPTIONIST".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect("receptionistDashboard.jsp");
        } else if ("MANAGER".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect("managerDashboard.jsp");
        } else {
            resp.sendRedirect("login.jsp?err=Role+not+recognized");
        }
    }
}