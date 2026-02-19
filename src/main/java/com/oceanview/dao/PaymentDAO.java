package com.oceanview.dao;

import com.oceanview.model.Payment;
import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean insertPayment(Payment p) {
        boolean ok = false;

        String sql = "INSERT INTO payments (reservation_number, nights, rate_per_day, subtotal, total) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getReservationNumber());
            ps.setInt(2, p.getNights());
            ps.setDouble(3, p.getRatePerDay());
            ps.setDouble(4, p.getSubtotal());
            ps.setDouble(5, p.getTotal());

            ok = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ok;
    }

    public List<Payment> getAllPayments() {
        List<Payment> list = new ArrayList<>();

        String sql = "SELECT * FROM payments ORDER BY payment_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment p = new Payment();
                p.setPaymentId(rs.getInt("payment_id"));
                p.setReservationNumber(rs.getString("reservation_number"));
                p.setNights(rs.getInt("nights"));
                p.setRatePerDay(rs.getDouble("rate_per_day"));
                p.setSubtotal(rs.getDouble("subtotal"));
                p.setTotal(rs.getDouble("total"));
                p.setPaymentDate(rs.getTimestamp("payment_date"));
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public double getTotalRevenue() {
        double revenue = 0;

        String sql = "SELECT IFNULL(SUM(total),0) AS revenue FROM payments";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble("revenue");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return revenue;
    }

    public int getPaymentCount() {
        int count = 0;

        String sql = "SELECT COUNT(*) AS c FROM payments";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("c");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
}
