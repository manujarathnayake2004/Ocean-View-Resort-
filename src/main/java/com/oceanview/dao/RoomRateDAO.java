package com.oceanview.dao;

import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RoomRateDAO {

    public double getRateByRoomType(String roomType) {
        double rate = 0;

        String sql = "SELECT rate_per_night FROM room_rates WHERE room_type = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, roomType);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                rate = rs.getDouble("rate_per_night");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rate;
    }
}