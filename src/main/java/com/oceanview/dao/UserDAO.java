package com.oceanview.dao;

import com.oceanview.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public LoginResult login(String username, String password) {

        String sql =
                "SELECT u.user_id, u.username, u.password, u.full_name, u.status, r.role_name " +
                        "FROM users u " +
                        "JOIN roles r ON u.role_id = r.role_id " +
                        "WHERE u.username = ? LIMIT 1";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    String dbPass = rs.getString("password");
                    String status = rs.getString("status");
                    String roleName = rs.getString("role_name");
                    String fullName = rs.getString("full_name");

                    // status must be ACTIVE
                    if (status == null || !status.equalsIgnoreCase("ACTIVE")) {
                        return new LoginResult(false, "Your account is not ACTIVE.", null, null);
                    }

                    // plain password check (as you requested, no password_hash)
                    if (dbPass != null && dbPass.equals(password)) {
                        return new LoginResult(true, "Login success", roleName, fullName);
                    } else {
                        return new LoginResult(false, "Invalid username or password.", null, null);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new LoginResult(false, "Database error. Check console.", null, null);
        }

        return new LoginResult(false, "Invalid username or password.", null, null);
    }

    // Simple result object (inner class)
    public static class LoginResult {
        private boolean success;
        private String message;
        private String role;
        private String fullName;

        public LoginResult(boolean success, String message, String role, String fullName) {
            this.success = success;
            this.message = message;
            this.role = role;
            this.fullName = fullName;
        }

        public boolean isSuccess() { return success; }
        public String getMessage() { return message; }
        public String getRole() { return role; }
        public String getFullName() { return fullName; }
    }
}