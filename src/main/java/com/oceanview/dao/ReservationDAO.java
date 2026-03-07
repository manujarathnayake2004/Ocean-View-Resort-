package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // ✅ Add Reservation (matches your DB)
    public boolean addReservation(Reservation r) {

        String dupSql = "SELECT 1 FROM reservations WHERE reservation_no = ? OR guest_mobile = ? LIMIT 1";
        String roomSql = "SELECT room_rate_id FROM room_rates WHERE room_type = ? LIMIT 1";

        String insertSql = "INSERT INTO reservations " +
                "(reservation_no, guest_name, guest_address, guest_mobile, room_rate_id, check_in, check_out) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {

            // duplicate check
            try (PreparedStatement psDup = con.prepareStatement(dupSql)) {
                psDup.setString(1, r.getReservationNumber());
                psDup.setString(2, r.getCustomerMobile());
                try (ResultSet rsDup = psDup.executeQuery()) {
                    if (rsDup.next()) return false;
                }
            }

            // get room_rate_id
            int roomRateId = 0;
            try (PreparedStatement psRoom = con.prepareStatement(roomSql)) {
                psRoom.setString(1, r.getRoomType());
                try (ResultSet rsRoom = psRoom.executeQuery()) {
                    if (rsRoom.next()) roomRateId = rsRoom.getInt("room_rate_id");
                }
            }

            if (roomRateId == 0) return false;

            // insert
            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                ps.setString(1, r.getReservationNumber());
                ps.setString(2, r.getGuestName());
                ps.setString(3, r.getAddress());
                ps.setString(4, r.getCustomerMobile());
                ps.setInt(5, roomRateId);
                ps.setDate(6, r.getCheckIn());
                ps.setDate(7, r.getCheckOut());
                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Get Reservation by reservation_no
    public Reservation getReservationByNumber(String reservationNumber) {
        Reservation r = null;

        String sql =
                "SELECT r.reservation_no, r.guest_name, r.guest_address, r.guest_mobile, " +
                        "       r.check_in, r.check_out, rr.room_type " +
                        "FROM reservations r " +
                        "JOIN room_rates rr ON r.room_rate_id = rr.room_rate_id " +
                        "WHERE r.reservation_no = ? LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new Reservation();
                r.setReservationNumber(rs.getString("reservation_no"));
                r.setCustomerId("-"); // DB doesn't have customer_id
                r.setCustomerMobile(rs.getString("guest_mobile"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("guest_address"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getDate("check_in"));
                r.setCheckOut(rs.getDate("check_out"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return r;
    }

    // ✅ Get all reservations
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();

        String sql =
                "SELECT r.reservation_no, r.guest_name, r.guest_address, r.guest_mobile, " +
                        "       r.check_in, r.check_out, rr.room_type " +
                        "FROM reservations r " +
                        "JOIN room_rates rr ON r.room_rate_id = rr.room_rate_id " +
                        "ORDER BY r.reservation_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationNumber(rs.getString("reservation_no"));
                r.setCustomerId("-");
                r.setCustomerMobile(rs.getString("guest_mobile"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("guest_address"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getDate("check_in"));
                r.setCheckOut(rs.getDate("check_out"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Filter reservations
    public List<Reservation> filterReservations(String roomType, Date fromDate, Date toDate) {
        List<Reservation> list = new ArrayList<>();

        String sql =
                "SELECT r.reservation_no, r.guest_name, r.guest_address, r.guest_mobile, " +
                        "       r.check_in, r.check_out, rr.room_type " +
                        "FROM reservations r " +
                        "JOIN room_rates rr ON r.room_rate_id = rr.room_rate_id " +
                        "WHERE 1=1 ";

        if (roomType != null && !roomType.trim().isEmpty() && !"All".equalsIgnoreCase(roomType)) {
            sql += " AND rr.room_type = ? ";
        }
        if (fromDate != null) {
            sql += " AND r.check_in >= ? ";
        }
        if (toDate != null) {
            sql += " AND r.check_in <= ? ";
        }

        sql += " ORDER BY r.reservation_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int index = 1;

            if (roomType != null && !roomType.trim().isEmpty() && !"All".equalsIgnoreCase(roomType)) {
                ps.setString(index++, roomType);
            }
            if (fromDate != null) {
                ps.setDate(index++, fromDate);
            }
            if (toDate != null) {
                ps.setDate(index++, toDate);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationNumber(rs.getString("reservation_no"));
                r.setCustomerId("-");
                r.setCustomerMobile(rs.getString("guest_mobile"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("guest_address"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getDate("check_in"));
                r.setCheckOut(rs.getDate("check_out"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ Update Reservation
    public boolean updateReservation(Reservation r) {

        String roomSql = "SELECT room_rate_id FROM room_rates WHERE room_type = ? LIMIT 1";

        String updateSql =
                "UPDATE reservations SET guest_name = ?, guest_address = ?, guest_mobile = ?, " +
                        "room_rate_id = ?, check_in = ?, check_out = ? " +
                        "WHERE reservation_no = ?";

        try (Connection con = DBConnection.getConnection()) {

            int roomRateId = 0;
            try (PreparedStatement psRoom = con.prepareStatement(roomSql)) {
                psRoom.setString(1, r.getRoomType());
                try (ResultSet rs = psRoom.executeQuery()) {
                    if (rs.next()) roomRateId = rs.getInt("room_rate_id");
                }
            }

            if (roomRateId == 0) return false;

            try (PreparedStatement ps = con.prepareStatement(updateSql)) {
                ps.setString(1, r.getGuestName());
                ps.setString(2, r.getAddress());
                ps.setString(3, r.getCustomerMobile());
                ps.setInt(4, roomRateId);
                ps.setDate(5, r.getCheckIn());
                ps.setDate(6, r.getCheckOut());
                ps.setString(7, r.getReservationNumber());

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ DELETE Reservation (THIS FIXES YOUR ERROR)
    public boolean deleteByReservationNumber(String reservationNumber) {

        String sql = "DELETE FROM reservations WHERE reservation_no = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNumber);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}