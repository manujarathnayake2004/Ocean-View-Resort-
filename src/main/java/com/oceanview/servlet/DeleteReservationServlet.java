package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationNumber = request.getParameter("reservationNumber");

        ReservationDAO dao = new ReservationDAO();
        boolean deleted = dao.deleteByReservationNumber(reservationNumber);

        if (deleted) {
            response.sendRedirect("listReservations?msg=Deleted+successfully");
        } else {
            response.sendRedirect("listReservations?msg=Delete+failed");
        }
    }
}