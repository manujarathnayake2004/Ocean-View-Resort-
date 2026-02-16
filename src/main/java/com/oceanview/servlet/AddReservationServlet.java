package com.oceanview.servlet;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // Session check
        HttpSession session = req.getSession();
        String user = (String) session.getAttribute("loggedUser");
        if (user == null) {
            resp.sendRedirect("login.jsp?msg=Please+login+first");
            return;
        }

        // Read form data (NO contactNumber)
        String reservationNumber = req.getParameter("reservationNumber");
        String customerId = req.getParameter("customerId");
        String customerMobile = req.getParameter("customerMobile");
        String guestName = req.getParameter("guestName");
        String address = req.getParameter("address");
        String roomType = req.getParameter("roomType");
        String checkIn = req.getParameter("checkIn");
        String checkOut = req.getParameter("checkOut");

        // Validations
        if (reservationNumber == null || reservationNumber.trim().isEmpty()) {
            resp.sendRedirect("addReservation.jsp?err=Reservation+number+is+required");
            return;
        }

        if (customerId == null || customerId.trim().isEmpty()) {
            resp.sendRedirect("addReservation.jsp?err=Customer+ID+is+required");
            return;
        }

        if (customerMobile == null || customerMobile.trim().isEmpty()) {
            resp.sendRedirect("addReservation.jsp?err=Customer+Mobile+is+required");
            return;
        }

        if (!reservationNumber.startsWith("OV")) {
            resp.sendRedirect("addReservation.jsp?err=Reservation+Number+should+start+with+OV");
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
        } catch (Exception ex) {
            resp.sendRedirect("addReservation.jsp?err=Invalid+date+format");
            return;
        }

        boolean saved = reservationDAO.addReservation(r);

        if (saved) {
            resp.sendRedirect("addReservation.jsp?msg=Reservation+saved+successfully");
        } else {
            resp.sendRedirect("addReservation.jsp?err=Duplicate+Customer+ID+or+Mobile+Number");
        }
    }
}