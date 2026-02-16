package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/searchReservation")
public class SearchReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String reservationNumber = req.getParameter("reservationNumber");

        Reservation r = reservationDAO.getReservationByNumber(reservationNumber);

        if (r == null) {
            resp.sendRedirect("searchReservation.jsp?err=Reservation+not+found");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("foundReservation", r);
            resp.sendRedirect("viewReservation.jsp");
        }
    }
}