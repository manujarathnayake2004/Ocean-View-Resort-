package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.util.DBConnection;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public User validateUser(String username, String password) {

        String sql = "SELECT username, password_hash, role, status FROM users WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (con == null) return null;

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    String dbPass = rs.getString("password_hash");
                    String role = rs.getString("role");
                    String status = null;

                    try {
                        status = rs.getString("status");
                    } catch (Exception ignore) {
                        // if your table doesn't have status column
                    }

                    // If status is used, allow only ACTIVE
                    if (status != null && !status.equalsIgnoreCase("ACTIVE")) {
                        return null;
                    }

                    String inputHash = sha256(password);

                    boolean ok = dbPass != null && (
                            dbPass.equals(password) ||          // plain text match
                                    dbPass.equalsIgnoreCase(inputHash)  // sha-256 match
                    );

                    if (ok) {
                        return new User(rs.getString("username"), role);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    private String sha256(String text) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(text.getBytes("UTF-8"));

        StringBuilder sb = new StringBuilder();
        for (byte b : hash) sb.append(String.format("%02x", b));
        return sb.toString();
    }
}