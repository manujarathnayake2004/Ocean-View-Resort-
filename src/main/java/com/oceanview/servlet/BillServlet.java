package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        // session check
        HttpSession session = req.getSession(false);
        String user = (session == null) ? null : (String) session.getAttribute("loggedUser");
        if (user == null) {
            resp.sendRedirect("login.jsp?msg=Please+login+first");
            return;
        }

        String reservationNumber = req.getParameter("reservationNumber");

        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            req.setAttribute("billError",
                    "Reservation number missing. Please search using reservation number.");
            RequestDispatcher rd = req.getRequestDispatcher("billPrint.jsp");
            rd.forward(req, resp);
            return;
        }

        reservationNumber = reservationNumber.trim();

        Reservation r = reservationDAO.getReservationByNumber(reservationNumber);

        if (r == null) {
            req.setAttribute("billError", "Reservation not found for: " + reservationNumber);
            req.setAttribute("reservationNumber", reservationNumber);
            RequestDispatcher rd = req.getRequestDispatcher("billPrint.jsp");
            rd.forward(req, resp);
            return;
        }

        // Calculate nights
        long nights = 0;
        try {
            LocalDate in = r.getCheckIn().toLocalDate();
            LocalDate out = r.getCheckOut().toLocalDate();
            nights = ChronoUnit.DAYS.between(in, out);
            if (nights < 0) nights = 0;
        } catch (Exception ignored) {
        }

        // Room rates (change if you want)
        double ratePerDay = getRateByRoomType(r.getRoomType());

        double subtotal = nights * ratePerDay;
        double total = subtotal; // add tax/discount later if needed

        // Send values to JSP
        req.setAttribute("reservation", r);
        req.setAttribute("reservationNumber", reservationNumber);
        req.setAttribute("billDate", java.time.LocalDate.now().toString());
        req.setAttribute("nights", nights);
        req.setAttribute("ratePerDay", ratePerDay);
        req.setAttribute("subtotal", subtotal);
        req.setAttribute("total", total);

        RequestDispatcher rd = req.getRequestDispatcher("billPrint.jsp");
        rd.forward(req, resp);
    }

    // You can adjust these prices
    private double getRateByRoomType(String roomType) {
        if (roomType == null) return 0;
        String rt = roomType.trim().toLowerCase();

        if (rt.contains("deluxe")) return 18000;
        if (rt.contains("family")) return 22000;
        if (rt.contains("suite"))  return 35000;
        if (rt.contains("standard")) return 12000;

        return 15000; // default
    }
}