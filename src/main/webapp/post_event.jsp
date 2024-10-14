<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Post Event</title>
    </head>
    <body>
        <form action="PostEventServlet" method="post" enctype="multipart/form-data">
            <label>Event Name:</label>
            <input type="text" name="event_name" required><br>

            <label>Description:</label>
            <textarea name="description" required></textarea><br>

            <label>Date and Time:</label>
            <input type="datetime-local" name="date_time" required><br>

            <label>Location:</label>
            <input type="text" name="location" required><br>

            <label>Category:</label>
            <select name="category_id" required>
                <option value="">Select a category</option>
                <option value="1">Party</option>
                <option value="2">Comedy Shows</option>
                <option value="3">Music shows</option>
                <option value="4">Business</option>
                <option value="5">Dance</option>
                <option value="6">Screening</option>
                <option value="7">Competition</option>
            </select><br>

            <label>Upload Event Image:</label>
            <input type="file" name="event_image" accept="image/*" required><br>

            <button type="submit">Post Event</button>
        </form>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 0;
            }
            form {
                background-color: #fff;
                width: 50%;
                margin: 50px auto;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            label {
                font-weight: bold;
                margin-bottom: 5px;
                display: block;
            }
            input[type="text"], textarea, select, input[type="datetime-local"], input[type="file"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </body>
</html>