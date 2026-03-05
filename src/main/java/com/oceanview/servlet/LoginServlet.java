package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null) username = username.trim();
        if (password != null) password = password.trim();

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            String err = URLEncoder.encode("Please enter username and password", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/login.jsp?err=" + err);
            return;
        }

        User user = userDAO.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession(true);

            // ✅ IMPORTANT: your JSP pages expect STRINGS
            session.setAttribute("loggedUser", user.getUsername());
            session.setAttribute("loggedRole", user.getRoleName());

            // Optional
            session.setAttribute("roleId", user.getRoleId());
            session.setAttribute("userId", user.getUserId());

            session.setMaxInactiveInterval(30 * 60);

            String role = user.getRoleName();

            // ✅ Redirect to files that EXIST in your project
            if (role != null && role.equalsIgnoreCase("RECEPTIONIST")) {
                response.sendRedirect(request.getContextPath() + "/receptionistDashboard.jsp");
            } else if (role != null && role.equalsIgnoreCase("MANAGER")) {
                response.sendRedirect(request.getContextPath() + "/managerDashboard.jsp");
            } else {
                // ADMIN default
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            }

        } else {
            String err = URLEncoder.encode("Invalid Username or Password", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/login.jsp?err=" + err);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}