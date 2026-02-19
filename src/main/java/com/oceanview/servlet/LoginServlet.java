package com.oceanview.servlet;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.validateUser(username, password);

        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedUser", user.getUsername());
            session.setAttribute("loggedRole", user.getRole());

            String role = user.getRole();

            if ("ADMIN".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");
            } else if ("RECEPTIONIST".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/receptionistDashboard.jsp");
            } else if ("MANAGER".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/managerDashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/login.jsp?msg=Role+not+assigned");
            }

        } else {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?msg=Invalid+Username+or+Password");
        }
    }
}