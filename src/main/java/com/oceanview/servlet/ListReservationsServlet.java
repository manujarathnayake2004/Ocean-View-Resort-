package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/listReservations")
public class ListReservationsServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        List<Reservation> list = reservationDAO.getAllReservations();

        HttpSession session = req.getSession();
        session.setAttribute("reservationList", list);

        resp.sendRedirect("listReservations.jsp");
    }
}