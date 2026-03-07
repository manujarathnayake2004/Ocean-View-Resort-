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

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {

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

        // ✅ NEW: return page
        String returnPage = request.getParameter("returnPage");

        // validation
        if (reservationNumber == null || reservationNumber.trim().isEmpty() ||
                guestName == null || guestName.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                customerMobile == null || customerMobile.trim().isEmpty() ||
                roomType == null || roomType.trim().isEmpty() ||
                checkInStr == null || checkInStr.trim().isEmpty() ||
                checkOutStr == null || checkOutStr.trim().isEmpty()) {

            redirectBack(request, response, returnPage, "Please fill all required fields.");
            return;
        }

        try {
            Reservation r = new Reservation();
            r.setReservationNumber(reservationNumber.trim());
            r.setGuestName(guestName.trim());
            r.setAddress(address.trim());
            r.setCustomerMobile(customerMobile.trim());
            r.setRoomType(roomType.trim());
            r.setCheckIn(Date.valueOf(checkInStr));
            r.setCheckOut(Date.valueOf(checkOutStr));

            ReservationDAO dao = new ReservationDAO();
            boolean ok = dao.addReservation(r);

            if (ok) {
                redirectBack(request, response, returnPage, "Reservation saved successfully.");
            } else {
                redirectBack(request, response, returnPage,
                        "Duplicate Reservation No or Mobile OR Room type not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectBack(request, response, returnPage, "Error occurred. Check server console.");
        }
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response,
                              String returnPage, String msg) throws IOException {

        // default admin page
        String page = (returnPage != null && !returnPage.trim().isEmpty())
                ? returnPage.trim()
                : "addReservation.jsp";

        msg = msg.replace(" ", "+");
        response.sendRedirect(request.getContextPath() + "/" + page + "?msg=" + msg);
    }
}