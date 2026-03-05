package com.oceanview.dao;

import com.oceanview.model.User;
import com.oceanview.util.DBConnection;

import java.sql.*;

public class UserDAO {

    private boolean hasColumn(Connection con, String table, String column) throws SQLException {
        DatabaseMetaData meta = con.getMetaData();
        ResultSet rs = meta.getColumns(null, null, table, column);
        boolean ok = rs.next();
        rs.close();
        return ok;
    }

    public User login(String username, String password) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            boolean hasStatus = hasColumn(con, "users", "status");

            String sql;
            if (hasStatus) {
                sql = "SELECT u.user_id, u.role_id, r.role_name, u.username, u.full_name, u.status " +
                        "FROM users u INNER JOIN roles r ON u.role_id = r.role_id " +
                        "WHERE u.username=? AND u.password=? AND u.status='ACTIVE'";
            } else {
                sql = "SELECT u.user_id, u.role_id, r.role_name, u.username, u.full_name, 'ACTIVE' AS status " +
                        "FROM users u INNER JOIN roles r ON u.role_id = r.role_id " +
                        "WHERE u.username=? AND u.password=?";
            }

            ps = con.prepareStatement(sql);
            ps.setString(1, username == null ? "" : username.trim());
            ps.setString(2, password == null ? "" : password.trim());

            rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setRoleId(rs.getInt("role_id"));
                user.setRoleName(rs.getString("role_name"));   // IMPORTANT
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                user.setStatus(rs.getString("status"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        return null;
    }
}