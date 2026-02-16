package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editReservation")
public class EditReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String reservationNumber = req.getParameter("reservationNumber");

        Reservation r = reservationDAO.getReservationByNumber(reservationNumber);

        if (r == null) {
            resp.sendRedirect("listReservations?msg=Reservation+not+found");
        } else {
            req.getSession().setAttribute("editReservation", r);
            resp.sendRedirect("editReservation.jsp");
        }
    }
}