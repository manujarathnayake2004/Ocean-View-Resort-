package com.oceanview.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();

        // allow public pages/resources
        if (uri.endsWith("login.jsp") ||
                uri.contains("/LoginServlet") ||
                uri.contains("/css") ||
                uri.contains("/images") ||
                uri.contains("/js") ||
                uri.contains("/assets") ||
                uri.contains("/WEB-INF")) {

            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        String loggedUser = (session != null) ? (String) session.getAttribute("loggedUser") : null;

        // if not logged in -> redirect
        if (loggedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Please+login+first");
            return;
        }

        chain.doFilter(req, res);
    }
}