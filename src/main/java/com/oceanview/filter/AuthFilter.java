package com.oceanview.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String ctx = req.getContextPath();

        boolean isPublic =
                uri.equals(ctx + "/login.jsp") ||
                        uri.equals(ctx + "/login") ||
                        uri.equals(ctx + "/LoginServlet") ||
                        uri.endsWith(".css") || uri.endsWith(".js") ||
                        uri.endsWith(".png") || uri.endsWith(".jpg") || uri.endsWith(".jpeg") ||
                        uri.endsWith(".woff") || uri.endsWith(".woff2");

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        String user = (session == null) ? null : (String) session.getAttribute("loggedUser");

        if (user == null) {
            res.sendRedirect(ctx + "/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}