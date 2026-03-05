package com.oceanview.dao;

import com.oceanview.model.Reservation;
import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // 1) Add Reservation
    public boolean addReservation(Reservation r) {

        // 1) Duplicate check (reservation_no is UNIQUE in DB)
        //    Also check mobile as unique because your UI expects it.
        String dupSql = "SELECT 1 FROM reservations WHERE reservation_no = ? OR guest_mobile = ? LIMIT 1";

        // 2) Map roomType -> room_rate_id
        String roomSql = "SELECT room_rate_id FROM room_rates WHERE room_type = ? LIMIT 1";

        // 3) Correct INSERT (matches your DB schema)
        String insertSql = "INSERT INTO reservations " +
                "(reservation_no, guest_name, guest_address, guest_mobile, room_rate_id, check_in, check_out) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {

            // --- Duplicate check ---
            try (PreparedStatement psDup = con.prepareStatement(dupSql)) {
                psDup.setString(1, r.getReservationNumber());
                psDup.setString(2, r.getCustomerMobile());
                try (ResultSet rsDup = psDup.executeQuery()) {
                    if (rsDup.next()) {
                        return false; // duplicate reservation no OR mobile
                    }
                }
            }

            // --- Get room_rate_id ---
            int roomRateId = 0;
            try (PreparedStatement psRoom = con.prepareStatement(roomSql)) {
                psRoom.setString(1, r.getRoomType());
                try (ResultSet rsRoom = psRoom.executeQuery()) {
                    if (rsRoom.next()) {
                        roomRateId = rsRoom.getInt("room_rate_id");
                    }
                }
            }

            if (roomRateId == 0) {
                return false; // room type not found
            }

            // --- Insert reservation ---
            try (PreparedStatement psIns = con.prepareStatement(insertSql)) {
                psIns.setString(1, r.getReservationNumber());
                psIns.setString(2, r.getGuestName());
                psIns.setString(3, r.getAddress());
                psIns.setString(4, r.getCustomerMobile());
                psIns.setInt(5, roomRateId);
                psIns.setDate(6, r.getCheckIn());
                psIns.setDate(7, r.getCheckOut());
                return psIns.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2) Get Reservation by reservation_number
    public Reservation getReservationByNumber(String reservationNumber) {
        Reservation r = null;

        String sql = "SELECT * FROM reservations WHERE reservation_number = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new Reservation();
                r.setReservationNumber(rs.getString("reservation_number"));
                r.setCustomerId(rs.getString("customer_id"));
                r.setCustomerMobile(rs.getString("customer_mobile"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setRoomType(rs.getString("room_type"));
                r.setCheckIn(rs.getDate("check_in"));
                r.setCheckOut(rs.getDate("check_out"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return r;
    }

    // 3) Get All Reservations
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();

        String sql = "SELECT * FROM reservations ORDER BY reservation_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Reservation r = new Reservation();
                r.setReservationNumber(rs.getString("reservation_number"));
                r.setCustomerId(rs.getString("customer_id"));
                r.setCustomerMobile(rs.getString("customer_mobile"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
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

    // 4) Delete Reservation by reservation_number
    public boolean deleteByReservationNumber(String reservationNumber) {
        boolean deleted = false;

        String sql = "DELETE FROM reservations WHERE reservation_number = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNumber);
            int rows = ps.executeUpdate();
            deleted = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return deleted;
    }

    // 5) Update Reservation (NO contact_number)
    public boolean updateReservation(Reservation r) {
        boolean updated = false;

        String sql = "UPDATE reservations SET " +
                "customer_id=?, customer_mobile=?, guest_name=?, address=?, room_type=?, check_in=?, check_out=? " +
                "WHERE reservation_number=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getCustomerId());
            ps.setString(2, r.getCustomerMobile());
            ps.setString(3, r.getGuestName());
            ps.setString(4, r.getAddress());
            ps.setString(5, r.getRoomType());
            ps.setDate(6, r.getCheckIn());
            ps.setDate(7, r.getCheckOut());
            ps.setString(8, r.getReservationNumber());

            int rows = ps.executeUpdate();
            updated = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false; // duplicate customer_id/customer_mobile can happen here too
        }

        return updated;
    }

    // 6) Filter Reservations
    public List<Reservation> filterReservations(String roomType, Date fromDate, Date toDate) {
        List<Reservation> list = new ArrayList<>();

        String sql = "SELECT * FROM reservations WHERE 1=1";

        if (roomType != null && !roomType.trim().isEmpty() && !"All".equalsIgnoreCase(roomType)) {
            sql += " AND room_type = ?";
        }
        if (fromDate != null) {
            sql += " AND check_in >= ?";
        }
        if (toDate != null) {
            sql += " AND check_in <= ?";
        }

        sql += " ORDER BY reservation_id DESC";

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
                r.setReservationNumber(rs.getString("reservation_number"));
                r.setCustomerId(rs.getString("customer_id"));
                r.setCustomerMobile(rs.getString("customer_mobile"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
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
}