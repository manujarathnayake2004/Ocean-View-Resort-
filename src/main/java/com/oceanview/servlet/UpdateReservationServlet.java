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

@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationNumber = request.getParameter("reservationNumber");
        String guestName = request.getParameter("guestName");
        String address = request.getParameter("address");
        String customerMobile = request.getParameter("customerMobile");
        String roomType = request.getParameter("roomType");
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        try {
            Reservation r = new Reservation();
            r.setReservationNumber(reservationNumber);
            r.setGuestName(guestName);
            r.setAddress(address);
            r.setCustomerMobile(customerMobile);
            r.setRoomType(roomType);

            if (checkInStr != null && !checkInStr.trim().isEmpty()) {
                r.setCheckIn(Date.valueOf(checkInStr)); // yyyy-MM-dd
            }
            if (checkOutStr != null && !checkOutStr.trim().isEmpty()) {
                r.setCheckOut(Date.valueOf(checkOutStr)); // yyyy-MM-dd
            }

            ReservationDAO dao = new ReservationDAO();
            boolean ok = dao.updateReservation(r);

            if (ok) {
                response.sendRedirect("listReservations?msg=Reservation+updated+successfully");
            } else {
                response.sendRedirect("editReservation.jsp?reservationNumber=" + reservationNumber + "&msg=Update+failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editReservation.jsp?reservationNumber=" + reservationNumber + "&msg=Error");
        }
    }
}