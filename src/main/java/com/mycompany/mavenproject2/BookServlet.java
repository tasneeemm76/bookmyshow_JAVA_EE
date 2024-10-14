package com.mycompany.mavenproject2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        // Retrieve form data from booking.jsp
        String userName = request.getParameter("user_name");
        String userEmail = request.getParameter("user_email");
        String eventIdStr = request.getParameter("event_id");

        // Convert event ID to integer
        int eventId = 0;
        if (eventIdStr != null && !eventIdStr.isEmpty()) {
            eventId = Integer.parseInt(eventIdStr);
        }

        // Load JDBC driver and establish a database connection
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/events_db", "root", "root")) {

                // Insert booking details into the bookings table
                String sql = "INSERT INTO bookings (event_id, user_name, user_email) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, eventId);
                stmt.setString(2, userName);
                stmt.setString(3, userEmail);

                // Execute the query
                int result = stmt.executeUpdate();
                if (result > 0) {
                    response.getWriter().println("Booking confirmed! Thank you, " + userName + ".");
                } else {
                    response.getWriter().println("Error: Could not confirm booking.");
                }
            } catch (SQLException e) {
                response.getWriter().println("Database error: " + e.getMessage());
            }
        } catch (ClassNotFoundException e) {
            response.getWriter().println("JDBC Driver not found: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles event bookings";
    }
}
