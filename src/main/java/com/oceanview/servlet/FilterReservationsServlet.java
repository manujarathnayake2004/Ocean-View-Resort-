package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/filterReservations")
public class FilterReservationsServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String roomType = req.getParameter("roomType");
        String from = req.getParameter("fromDate");
        String to = req.getParameter("toDate");

        Date fromDate = null;
        Date toDate = null;

        if (from != null && !from.trim().isEmpty()) {
            fromDate = Date.valueOf(from);
        }

        if (to != null && !to.trim().isEmpty()) {
            toDate = Date.valueOf(to);
        }

        // If roomType is "All" treat as empty
        if (roomType != null && roomType.equals("All")) {
            roomType = "";
        }

        List<Reservation> list = reservationDAO.filterReservations(roomType, fromDate, toDate);

        HttpSession session = req.getSession();
        session.setAttribute("reservationList", list);

        // Keep filter values so JSP can show them
        session.setAttribute("filterRoomType", roomType);
        session.setAttribute("filterFrom", from);
        session.setAttribute("filterTo", to);

        resp.sendRedirect("listReservations.jsp");
    }
}