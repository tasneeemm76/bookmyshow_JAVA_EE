<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Recommendations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(45deg, #000000, #800000);
            color: white;
        }
        
        .container {
            margin: 50px;
        }

        .dropdown {
            margin-bottom: 20px;
        }

        .dropdown select {
            padding: 10px;
            font-size: 16px;
            background-color: #800000;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .event-container {
            display: flex;
            flex-wrap: wrap;
        }

        .event-card {
            background-color: white;
            color: black;
            margin: 15px;
            padding: 20px;
            border-radius: 8px;
            width: 30%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .event-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }

        .event-card h2 {
            color: #800000;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Recommended Events</h1>

    <!-- Dropdown for event locations -->
    <div class="dropdown">
        <form method="GET" action="recommendation.jsp">
            <label for="location">Select Location:</label>
            <select name="location" id="location" onchange="this.form.submit()">
                <option value="">--Select Location--</option>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "root");

                        String sql = "SELECT DISTINCT location FROM events";
                        stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            String location = rs.getString("location");
                %>
                            <option value="<%= location %>"><%= location %></option>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </form>
    </div>

    <!-- Display events based on selected location -->
    <div class="event-container">
        <%
            String selectedLocation = request.getParameter("location");
            if (selectedLocation != null && !selectedLocation.isEmpty()) {
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/events_db", "root", "root");

                    String sql = "SELECT * FROM events WHERE location = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, selectedLocation);
                    ResultSet rs = ps.executeQuery();

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
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</div>

</body>
</html>
