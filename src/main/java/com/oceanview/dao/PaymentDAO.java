package com.oceanview.dao;

import com.oceanview.model.Payment;
import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    // ✅ FIX: SavePaymentServlet calls this method
    // Finds reservation_id using reservation_no, then inserts into payments table
    public boolean insertPayment(Payment p) {

        String findResIdSql = "SELECT reservation_id FROM reservations WHERE reservation_no = ? LIMIT 1";

        String insertSql =
                "INSERT INTO payments (reservation_id, nights, rate_per_night, subtotal, total, payment_method, paid_amount) " +
                        "VALUES (?, ?, ?, ?, ?, 'CASH', ?)";

        try (Connection con = DBConnection.getConnection()) {

            long reservationId = 0;

            // 1) Find reservation_id by reservation_no
            try (PreparedStatement ps1 = con.prepareStatement(findResIdSql)) {
                ps1.setString(1, p.getReservationNumber());
                try (ResultSet rs = ps1.executeQuery()) {
                    if (rs.next()) {
                        reservationId = rs.getLong("reservation_id");
                    }
                }
            }

            if (reservationId == 0) {
                return false; // reservation not found
            }

            // 2) Insert payment
            try (PreparedStatement ps2 = con.prepareStatement(insertSql)) {
                ps2.setLong(1, reservationId);
                ps2.setInt(2, p.getNights());
                ps2.setDouble(3, p.getRatePerDay());  // store as rate_per_night
                ps2.setDouble(4, p.getSubtotal());
                ps2.setDouble(5, p.getTotal());
                ps2.setDouble(6, p.getTotal());       // paid_amount = total (simple)
                return ps2.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ FIX: Report - Total Payments
    public int getPaymentCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS cnt FROM payments";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("cnt");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // ✅ FIX: Report - Total Revenue (LKR)
    public double getTotalRevenue() {
        double revenue = 0.0;
        String sql = "SELECT IFNULL(SUM(total), 0) AS revenue FROM payments";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                revenue = rs.getDouble("revenue");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return revenue;
    }

    // ✅ For report recent payments list
    public List<Payment> getAllPayments() {
        List<Payment> list = new ArrayList<>();

        String sql =
                "SELECT p.payment_id, r.reservation_no, p.nights, p.rate_per_night, p.subtotal, p.total, p.paid_at " +
                        "FROM payments p " +
                        "JOIN reservations r ON p.reservation_id = r.reservation_id " +
                        "ORDER BY p.payment_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setReservationNumber(rs.getString("reservation_no"));
                p.setNights(rs.getInt("nights"));
                p.setRatePerDay(rs.getDouble("rate_per_night")); // show as rate/night
                p.setSubtotal(rs.getDouble("subtotal"));
                p.setTotal(rs.getDouble("total"));
                p.setPaymentDate(rs.getTimestamp("paid_at"));
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}