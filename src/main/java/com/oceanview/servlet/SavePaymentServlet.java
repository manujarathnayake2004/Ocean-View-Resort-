package com.oceanview.servlet;

import com.oceanview.dao.PaymentDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomRateDAO;
import com.oceanview.model.Payment;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet("/savePayment")
public class SavePaymentServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final RoomRateDAO roomRateDAO = new RoomRateDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        HttpSession session = req.getSession(false);
        String user = (session == null) ? null : (String) session.getAttribute("loggedUser");
        String role = (session == null) ? null : (String) session.getAttribute("loggedRole");

        if (user == null) {
            resp.sendRedirect("login.jsp?msg=Please+login+first");
            return;
        }

        // basic role check (receptionist/admin)
        if (role == null || !("RECEPTIONIST".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role))) {
            resp.sendRedirect("login.jsp?err=Access+Denied");
            return;
        }

        String reservationNumber = req.getParameter("reservationNumber");
        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            resp.sendRedirect("searchBill.jsp?err=Reservation+number+missing");
            return;
        }

        reservationNumber = reservationNumber.trim();

        Reservation r = reservationDAO.getReservationByNumber(reservationNumber);
        if (r == null) {
            resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&err=Reservation+not+found");
            return;
        }

        long nights = 0;
        try {
            LocalDate in = r.getCheckIn().toLocalDate();
            LocalDate out = r.getCheckOut().toLocalDate();
            nights = ChronoUnit.DAYS.between(in, out);
            if (nights < 0) nights = 0;
        } catch (Exception ignored) {
        }

        double ratePerDay = roomRateDAO.getRateByRoomType(r.getRoomType());
        if (ratePerDay <= 0) ratePerDay = 15000;

        double subtotal = nights * ratePerDay;
        double total = subtotal;

        Payment p = new Payment();
        p.setReservationNumber(reservationNumber);
        p.setNights((int) nights);
        p.setRatePerDay(ratePerDay);
        p.setSubtotal(subtotal);
        p.setTotal(total);

        boolean ok = paymentDAO.insertPayment(p);

        if (ok) {
            resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&msg=Payment+saved+successfully");
        } else {
            resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&err=Payment+save+failed");
        }
    }
}
