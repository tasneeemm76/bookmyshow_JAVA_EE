<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to bottom, #000000, #800000);
            margin: 0;
            padding: 0;
            color: white;
        }

        .navbar {
            background-color: #800000;
            padding: 10px;
            text-align: left;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            padding: 10px 20px;
        }

        .header {
            text-align: center;
            padding: 10px;
            
        }

        h1 {
            margin: 0;
            font-size: 2.5em;
        }

        .event-container {
            margin: 20px auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            max-width: 1200px; /* Max width for larger screens */
            overflow: hidden; /* Ensures rounded corners are effective */
            display: flex; /* Flex layout for image and details */
        }

        .image-container {
            width: 40%;
            position: relative;
        }

        .image-container img {
            width: 100%;
            height: auto;
            border-radius: 10px 0 0 10px; /* Rounded corners on left */
        }

        .details-container {
            width: 60%;
            padding: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background-color: #fff;
            color: #000; /* Text color inside the details */
            border-radius: 0 10px 10px 0; /* Rounded corners on right */
        }

        .details-container h2 {
            font-size: 2em;
            color: #800000;
            margin-bottom: 10px;
        }

        .details-container p {
            margin: 5px 0;
            font-size: 1.2em;
            line-height: 1.6;
            color: #555;
        }

        .date-time, .location {
            font-weight: bold;
            font-size: 1.2em;
            color: #228B22;
        }

        .book-now-button {
            background-color: #800000; /* Button color */
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            font-size: 1.5em;
            font-weight: bold;
            cursor: pointer;
            align-self: flex-start; /* Aligns button to the start */
            transition: background-color 0.3s;
        }

        .book-now-button:hover {
            background-color: #000000; /* Darker color on hover */
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .event-container {
                flex-direction: column; /* Stack elements on smaller screens */
            }
            .image-container, .details-container {
                width: 100%; /* Full width for smaller screens */
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="index.jsp">Home</a>
    <a href="about.jsp">About</a>
    <a href="contact.jsp">Contact</a>
</div>

<div class="header">
    <h1>Event Details</h1>
</div>

<%
    String eventName = request.getParameter("event_name");
    String description = "";
    String dateTime = "";
    String location = "";
    String base64Image = null;

    // Database connection
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/events_db", "root", "root");

        // Query to get event details by name
        String sql = "SELECT * FROM events WHERE event_name = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, eventName);
        rs = stmt.executeQuery();

        if (rs.next()) {
            description = rs.getString("description");
            dateTime = rs.getString("date_time");
            location = rs.getString("location");
            Blob imageBlob = rs.getBlob("image");

            if (imageBlob != null) {
                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                base64Image = Base64.getEncoder().encodeToString(imageBytes);
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<div class="event-container">
    <div class="image-container">
        <% if (base64Image != null) { %>
            <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Event Image">
        <% } else { %>
            <img src="https://via.placeholder.com/600x400?text=Event+Image+Not+Available" alt="Event Image">
        <% } %>
    </div>
    <div class="details-container">
        <h2><%= eventName %></h2>
        <p class="date-time">Date & Time: <%= dateTime %></p>
        <p class="location">Location: <%= location %></p>
        <p><%= description %></p>

        <!-- Book Now button -->
        <form action="booknow.jsp" method="GET">
            <input type="hidden" name="event_name" value="<%= eventName %>">
            <button type="submit" class="book-now-button">Book Now</button>
        </form>
    </div>
</div>

</body>
</html>
