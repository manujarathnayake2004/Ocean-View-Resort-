package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/filterReservations")
public class FilterReservationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roomType = request.getParameter("roomType");
        String fromStr = request.getParameter("fromDate");
        String toStr = request.getParameter("toDate");

        Date fromDate = null;
        Date toDate = null;

        try {
            if (fromStr != null && !fromStr.trim().isEmpty()) fromDate = Date.valueOf(fromStr);
            if (toStr != null && !toStr.trim().isEmpty()) toDate = Date.valueOf(toStr);
        } catch (Exception ignored) { }

        ReservationDAO dao = new ReservationDAO();
        List<Reservation> list = dao.filterReservations(roomType, fromDate, toDate);

        request.getSession().setAttribute("reservationList", list);
        response.sendRedirect(request.getContextPath() + "/listReservations.jsp");
    }
}