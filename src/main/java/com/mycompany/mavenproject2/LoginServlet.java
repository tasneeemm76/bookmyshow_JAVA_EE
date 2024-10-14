package com.mycompany.mavenproject2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Database connection URL
            String url = "jdbc:mysql://localhost:3306/events_db?useSSL=false&serverTimezone=UTC";

            // Try to login
            try (Connection conn = DriverManager.getConnection(url, "root", "root")) {
                String sql = "SELECT * FROM users WHERE username=? AND password=?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, username);
                    ps.setString(2, password);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            // User found, create a session
                            HttpSession session = request.getSession();
                            session.setAttribute("username", rs.getString("username"));
                            session.setAttribute("email", rs.getString("email"));
                            session.setAttribute("age", rs.getInt("age"));
                            session.setAttribute("location", rs.getString("location"));

                            // Redirect to a user dashboard or welcome page
                            response.sendRedirect("display_events.jsp");
                        } else {
                            // Invalid login
                            response.getWriter().println("Invalid username or password.");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
