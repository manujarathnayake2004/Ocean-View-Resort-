package com.oceanview.servlet;

import com.oceanview.dao.PaymentDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomRateDAO;
import com.oceanview.model.Payment;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/savePayment")
public class SavePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String reservationNumber = req.getParameter("reservationNumber");

        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            resp.sendRedirect("billPrint.jsp?err=Reservation+number+missing");
            return;
        }

        try {
            ReservationDAO reservationDAO = new ReservationDAO();
            RoomRateDAO roomRateDAO = new RoomRateDAO();
            PaymentDAO paymentDAO = new PaymentDAO();

            // 1) get reservation by number
            Reservation r = reservationDAO.getReservationByNumber(reservationNumber.trim());

            if (r == null) {
                resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&err=Reservation+not+found");
                return;
            }

            // 2) calculate nights
            Date checkIn = r.getCheckIn();
            Date checkOut = r.getCheckOut();

            if (checkIn == null || checkOut == null) {
                resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&err=Invalid+dates");
                return;
            }

            long diff = checkOut.getTime() - checkIn.getTime();
            int nights = (int) (diff / (1000 * 60 * 60 * 24));

            if (nights <= 0) nights = 1;

            // 3) get rate per night by room type
            double ratePerDay = roomRateDAO.getRateByRoomType(r.getRoomType());
            if (ratePerDay <= 0) ratePerDay = 15000; // fallback

            // 4) totals
            double subtotal = nights * ratePerDay;
            double total = subtotal;

            // 5) build payment object
            Payment p = new Payment();
            p.setReservationNumber(reservationNumber.trim());
            p.setNights(nights);
            p.setRatePerDay(ratePerDay);
            p.setSubtotal(subtotal);
            p.setTotal(total);

            // ✅ IMPORTANT: This method must exist in PaymentDAO
            boolean ok = paymentDAO.insertPayment(p);

            if (ok) {
                resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&msg=Payment+saved+successfully");
            } else {
                resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&err=Payment+save+failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("billPrint.jsp?reservationNumber=" + reservationNumber + "&err=Server+error");
        }
    }
}