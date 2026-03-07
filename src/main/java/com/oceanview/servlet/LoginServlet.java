package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import com.oceanview.dao.UserDAO.LoginResult;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?msg=Please+enter+username+and+password");
            return;
        }

        UserDAO dao = new UserDAO();
        LoginResult result = dao.login(username.trim(), password.trim());

        if (result.isSuccess()) {
            HttpSession session = request.getSession(true);
            session.setAttribute("loggedUser", username.trim());
            session.setAttribute("loggedRole", result.getRole());
            session.setAttribute("loggedName", result.getFullName());

            // Redirect based on role
            String role = result.getRole();

            if (role != null && role.equalsIgnoreCase("ADMIN")) {
                response.sendRedirect("dashboard.jsp");
            } else if (role != null && role.equalsIgnoreCase("MANAGER")) {
                response.sendRedirect("managerDashboard.jsp");
            } else if (role != null && role.equalsIgnoreCase("RECEPTIONIST")) {
                response.sendRedirect("receptionistDashboard.jsp");
            } else {
                response.sendRedirect("dashboard.jsp");
            }

        } else {
            response.sendRedirect("login.jsp?msg=" + result.getMessage().replace(" ", "+"));
        }
    }
}