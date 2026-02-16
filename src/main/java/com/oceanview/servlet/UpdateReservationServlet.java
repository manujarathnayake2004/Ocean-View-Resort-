package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // session check
        HttpSession session = req.getSession();
        String user = (String) session.getAttribute("loggedUser");
        if (user == null) {
            resp.sendRedirect("login.jsp?msg=Please+login+first");
            return;
        }

        // get parameters (NO contactNumber)
        String reservationNumber = req.getParameter("reservationNumber");
        String customerId = req.getParameter("customerId");
        String customerMobile = req.getParameter("customerMobile");

        String guestName = req.getParameter("guestName");
        String address = req.getParameter("address");
        String roomType = req.getParameter("roomType");
        String checkIn = req.getParameter("checkIn");
        String checkOut = req.getParameter("checkOut");

        // validations (student-level)
        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            resp.sendRedirect("listReservations?msg=Reservation+Number+missing");
            return;
        }

        if (customerId == null || customerId.trim().isEmpty()) {
            resp.sendRedirect("editReservation.jsp?err=Customer+ID+is+required");
            return;
        }

        if (customerMobile == null || customerMobile.trim().isEmpty()) {
            resp.sendRedirect("editReservation.jsp?err=Customer+Mobile+is+required");
            return;
        }

        Reservation r = new Reservation();
        r.setReservationNumber(reservationNumber.trim());
        r.setCustomerId(customerId.trim());
        r.setCustomerMobile(customerMobile.trim());
        r.setGuestName(guestName);
        r.setAddress(address);
        r.setRoomType(roomType);

        try {
            r.setCheckIn(Date.valueOf(checkIn));
            r.setCheckOut(Date.valueOf(checkOut));
        } catch (Exception e) {
            resp.sendRedirect("editReservation.jsp?err=Invalid+date+format");
            return;
        }

        boolean updated = reservationDAO.updateReservation(r);

        if (updated) {
            // clear edit session object (optional)
            session.removeAttribute("editReservation");
            resp.sendRedirect("listReservations?msg=Updated+successfully");
        } else {
            // duplicate unique values or update failed
            resp.sendRedirect("editReservation.jsp?err=Update+failed+(Duplicate+Customer+ID+or+Mobile)");
        }
    }
}