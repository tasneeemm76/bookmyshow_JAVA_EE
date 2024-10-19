<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events Index</title>
   <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            color: white;
        }

        .navbar {
        background: linear-gradient(45deg, #000000, #800000) ; /* Gradient for navbar */
        padding: 15px 15px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .navbar a {
        color: white;
        text-decoration: none;
        font-size: 15px;
        margin: 0 15px;
    }

    .navbar a:hover {
        color: #ffcc00; /* Highlight effect on hover */
    }

         .header {
        text-align: center;
        padding: 60px 20px;
        background: linear-gradient(45deg, #000000, #800000);
        position: relative;
    }

    .header h1 {
        font-family: cursive;
        margin: 0;
        font-size: 3.5em;
        color: #ffff; 
        text-shadow: 3px 3px 8px rgba(0, 0, 0, 0.7);
    }

        h1 {
            margin: 0;
            font-size: 2.5em;
        }

     .event-container {
    margin: 20px;
    display: flex;
    flex-wrap: wrap;
}

.event-card {
    background-color: white;
    color: #000;
    margin: 10px;
    padding: 10px;
    border-radius: 8px;
    width: 30%;
    border: 2px solid #800000; /* Add a border */
    height: 350px; /* Increase the height */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Optional: Add shadow for a more professional look */
}

.event-card img {
    width: 100%;
    height: 200px; /* Increase the image height */
    object-fit: cover;
    border-radius: 8px;
}

.event-card h2 {
    color: #800000;
}


        .view-all-btn {
            display: block;
            text-align: right;
            margin: 20px 0;
        }

        .view-all-btn a {
            background-color: #800000;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
        }

        .view-all-btn a:hover {
            background-color: #000000;
        }
        
        h2 {
    color: #000000; /* Set the color of the headings to black */
    margin-left: 30px;
    text-align: left;
}

       

    </style>
</head>
<body>
    <!-- Navigation bar -->
    <div class="navbar">
        <a href="index.jsp">Home</a>
        <a href="offers.jsp">Special Offers</a>
        <a href="recommendation.jsp">Recommendations</a>
    </div>

    <!-- Header -->
    <div class="header">
        <h1>Next Fest</h1>
    </div>
    <div class="event-section">
        <!-- Fetch and display events for Party Events (Category 1) -->
        <h2 style="text-align: left; margin-left: 20px; ">Party Events</h2>
        <div class="event-container">
            <%
                Connection conn = null;
                Statement stmt = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "root");

                    String sql = "SELECT * FROM events WHERE category_id = 1 LIMIT 3";  // Assuming '1' is the category ID for 'Party'
                    stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String eventName = rs.getString("event_name");
                        String description = rs.getString("description");
                        Blob imageBlob = rs.getBlob("image");
                        String base64Image = null;

                        if (imageBlob != null) {
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
                <div class="event-card">
                    <img src="data:image/jpeg;base64,<%= base64Image != null ? base64Image : "" %>" alt="Event Image">
                    <h2><%= eventName %></h2>
                    <p><%= description.length() > 100 ? description.substring(0, 100) + "..." : description %></p>
                </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

        <!-- View All Button for Party Events -->
        <div class="view-all-btn">
            <a href="display_events.jsp?category_id=1">View All Events</a>
        </div>
    </div>

    <!-- Repeat for Category 2 -->
    <div class="event-section">
        <h2 style="text-align: left; margin-left: 20px;">Comedy shows</h2>
        <div class="event-container">
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "root");
                    String sql = "SELECT * FROM events WHERE category_id = 2 LIMIT 3"; 
                    stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String eventName = rs.getString("event_name");
                        String description = rs.getString("description");
                        Blob imageBlob = rs.getBlob("image");
                        String base64Image = null;

                        if (imageBlob != null) {
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
                <div class="event-card">
                    <img src="data:image/jpeg;base64,<%= base64Image != null ? base64Image : "" %>" alt="Event Image">
                    <h2><%= eventName %></h2>
                    <p><%= description.length() > 100 ? description.substring(0, 100) + "..." : description %></p>
                </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

        <!-- View All Button for Category 2 Events -->
        <div class="view-all-btn">
            <a href="display_events.jsp?category_id=2">View All Events</a>
        </div>
    </div>

    <!-- Repeat for Category 3, 4, 5, and 6 -->
    <!-- Category 3 -->
    <div class="event-section">
        <h2 style="text-align: left; margin-left: 20px;">Music Shows</h2>
        <div class="event-container">
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "root");
                    String sql = "SELECT * FROM events WHERE category_id = 3 LIMIT 3"; 
                    stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String eventName = rs.getString("event_name");
                        String description = rs.getString("description");
                        Blob imageBlob = rs.getBlob("image");
                        String base64Image = null;

                        if (imageBlob != null) {
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
                <div class="event-card">
                    <img src="data:image/jpeg;base64,<%= base64Image != null ? base64Image : "" %>" alt="Event Image">
                    <h2><%= eventName %></h2>
                    <p><%= description.length() > 100 ? description.substring(0, 100) + "..." : description %></p>
                </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

        <!-- View All Button for Category 3 Events -->
        <div class="view-all-btn">
            <a href="display_events.jsp?category_id=3">View All Events</a>
        </div>
    </div>

   
    <!-- Repeat for Category 5 -->
    <div class="event-section">
        <h2 style="text-align: left; margin-left: 20px;">Dance Shows</h2>
        <div class="event-container">
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "root");
                    String sql = "SELECT * FROM events WHERE category_id = 5 LIMIT 3"; 
                    stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String eventName = rs.getString("event_name");
                        String description = rs.getString("description");
                        Blob imageBlob = rs.getBlob("image");
                        String base64Image = null;

                        if (imageBlob != null) {
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
                <div class="event-card">
                    <img src="data:image/jpeg;base64,<%= base64Image != null ? base64Image : "" %>" alt="Event Image">
                    <h2><%= eventName %></h2>
                    <p><%= description.length() > 100 ? description.substring(0, 100) + "..." : description %></p>
                </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

        <!-- View All Button for Category 5 Events -->
        <div class="view-all-btn">
            <a href="display_events.jsp?category_id=5">View All Events</a>
        </div>
    </div>

    <!-- Repeat for Category 6 -->
    <div class="event-section">
        <h2 style="text-align: left; margin-left: 20px;">Screening</h2>
        <div class="event-container">
            <%
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "root");
                    String sql = "SELECT * FROM events WHERE category_id = 6 LIMIT 3"; 
                    stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String eventName = rs.getString("event_name");
                        String description = rs.getString("description");
                        Blob imageBlob = rs.getBlob("image");
                        String base64Image = null;

                        if (imageBlob != null) {
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
                <div class="event-card">
                    <img src="data:image/jpeg;base64,<%= base64Image != null ? base64Image : "" %>" alt="Event Image">
                    <h2><%= eventName %></h2>
                    <p><%= description.length() > 100 ? description.substring(0, 100) + "..." : description %></p>
                </div>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

        <!-- View All Button for Category 6 Events -->
        <div class="view-all-btn">
            <a href="display_events.jsp?category_id=6">View All Events</a>
        </div>
        
  
    </div>

    </div>

</body>
</html>
