package com.mycompany.mavenproject2;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "PostEventServlet", urlPatterns = {"/PostEventServlet"})
@MultipartConfig // This annotation enables handling multipart/form-data
public class PostEventServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Retrieve form fields
            String eventName = request.getParameter("event_name");
            String description = request.getParameter("description");
            String dateTime = request.getParameter("date_time");
            String location = request.getParameter("location");

            // Get category_id from dropdown
            String categoryStr = request.getParameter("category_id");

            int categoryId = 0;
            if (categoryStr != null && !categoryStr.isEmpty()) {
                categoryId = Integer.parseInt(categoryStr);
            } else {
                out.println("Please select a valid category.");
                return;  // Exit if no valid category is selected
            }

            // Get the uploaded file (image)
            Part imagePart = request.getPart("event_image");

            // Load the JDBC driver and establish a connection
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/events_db","root","root")) {

                // Prepare SQL statement
                String sql = "INSERT INTO events (event_name, description, date_time, location, category_id, image) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, eventName);
                stmt.setString(2, description);
                stmt.setString(3, dateTime);
                stmt.setString(4, location);
                stmt.setInt(5, categoryId);

                // Handle the image upload
                if (imagePart != null && imagePart.getSize() > 0) {
                    InputStream inputStream = imagePart.getInputStream();
                    stmt.setBlob(6, inputStream);
                } else {
                    out.println("No image uploaded.");
                    return; // Exit if no image is uploaded
                }

                // Execute the insert query
                int result = stmt.executeUpdate();
                if (result > 0) {
                    out.println("Event successfully posted!");
                } else {
                    out.println("Error posting event.");
                }
            } catch (SQLException e) {
                out.println("Database error: " + e.getMessage());
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
        return "Post Event Servlet";
    }
}