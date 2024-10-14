<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>All Events</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background: linear-gradient(to right, #000000, #800000); /* Gradient background */
                margin: 0;
                padding: 20px;
                color: white; /* Text color set to white for better contrast */
            }

            h1 {
                text-align: center;
                color: #fff;
                margin-bottom: 30px;
                font-size: 2.5em;
                font-weight: bold;
            }

            .event-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
            }

            .event-card {
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                margin: 15px;
                width: 300px;
                overflow: hidden;
                text-align: center;
                transition: transform 0.3s;
            }

            .event-card:hover {
                transform: translateY(-5px);
            }

            .event-card img {
                width: 100%;
                height: 180px; /* Adjusted to increase the image area */
                object-fit: cover;
            }

            .event-card h2 {
                font-size: 1.6em;
                color: #e75480; /* Darker shade for the title */
                margin: 15px 0 5px;
                font-weight: bold;
            }

            .event-details {
                padding: 15px; /* Increased padding for better spacing */
            }

            .event-details p {
                margin: 5px 0;
                color: #555; /* Text color set to dark for readability */
                line-height: 1.5;
                font-size: 0.95em;
            }

            .event-details .date-time {
                font-weight: bold;
                color: #333;
            }

            .book-now-button {
                background-color: #800000; 
                color: white;
                border: none;
                padding: 12px 20px; /* Increased padding for better touch area */
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                font-weight: bold;
                margin-top: 15px;
                display: inline-block;
                transition: background-color 0.3s;
            }

            .book-now-button:hover {
                background-color: #FF0000; 
            }
        </style>
    </head>
    <body>
        <h1>List of Events</h1>
        
        <div class="event-container">
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    // Establish the connection
                    conn = DriverManager.getConnection("jdbc:mysql://localhost/events_db", "root", "root");

                    // Prepare and execute the query
                    String query = "SELECT event_name, description, date_time, location, image FROM events";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    // Loop through the results and display them in cards
                    while (rs.next()) {
                        String eventName = rs.getString("event_name");
                        String description = rs.getString("description");
                        Timestamp dateTime = rs.getTimestamp("date_time");
                        String location = rs.getString("location");
                        Blob imageBlob = rs.getBlob("image");

                        // Convert the image blob into a base64 string
                        String base64Image = null;
                        if (imageBlob != null) {
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
            <div class="event-card">
                <img src="data:image/jpeg;base64,<%= base64Image != null ? base64Image : "" %>" alt="Event Image" onerror="this.style.display='none';">
                <div class="event-details">
                    <h2><%= eventName %></h2>
                    <p><%= description %></p>
                    <p class="date-time"><%= dateTime %></p>
                    <p><strong>Location:</strong> <%= location %></p>
                    
                    <a href="booknow.jsp?event_name=<%= eventName %>" class="book-now-button">Book Now</a>

    
                </div>
            </div>
            <%
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    // Close the result set, statement, and connection
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            %>
        </div>
    </body>
</html>
