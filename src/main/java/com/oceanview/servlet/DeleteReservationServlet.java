package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String reservationNumber = req.getParameter("reservationNumber");

        boolean deleted = reservationDAO.deleteByReservationNumber(reservationNumber);

        if (deleted) {
            resp.sendRedirect("listReservations?msg=Deleted+successfully");
        } else {
            resp.sendRedirect("listReservations?msg=Delete+failed");
        }
    }
}