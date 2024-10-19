<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Offers Page</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(45deg, #000000, #800000); /* Background color scheme */
            color: white;
            text-align: center;
        }

        .navbar {
            background: linear-gradient(90deg, #000000, #800000);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            margin: 0 15px;
        }

        .navbar a:hover {
            color: #ffcc00;
        }

        h1 {
            font-size: 3em;
            margin-top: 20px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.7);
        }

        .offers-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin: 50px 0;
        }

        .offer-card {
            background-color: white;
            color: #000;
            padding: 20px;
            border-radius: 10px;
            margin: 20px;
            width: 25%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease;
        }

        .offer-card:hover {
            transform: scale(1.05);
        }

        .offer-card h2 {
            color: #800000;
            margin-bottom: 10px;
        }

        .offer-card p {
            color: #333;
        }

        .offer-code {
            background-color: #800000;
            color: white;
            padding: 10px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            margin: 10px 0;
        }

    </style>
</head>
<body>
    <!-- Navigation bar -->
    <div class="navbar">
        <a href="index.jsp">Home</a>
        <a href="categories.jsp">Categories</a>
        <a href="offers.jsp">Offers</a>
        <a href="about.jsp">About</a>
    </div>

    <!-- Header -->
    <h1>Exclusive Offers</h1>

    <!-- Offers Section -->
    <div class="offers-container">
        <!-- Offer 1 -->
        <div class="offer-card">
            <h2>Get 20% off on all events</h2>
            <p>Use this coupon to get an exclusive 20% discount on your next booking!</p>
            <div class="offer-code">CODE: SAVE20</div>
        </div>

        <!-- Offer 2 -->
        <div class="offer-card">
            <h2>Buy 1 Get 1 Free</h2>
            <p>Enjoy a special offer for selected events. Grab this coupon now!</p>
            <div class="offer-code">CODE: BOGO2024</div>
        </div>

        <!-- Offer 3 -->
        <div class="offer-card">
            <h2>Flat ?500 off on any booking</h2>
            <p>Book your favorite event and get a flat ?500 off with this offer.</p>
            <div class="offer-code">CODE: FLAT500</div>
        </div>

        <!-- Offer 4 -->
        <div class="offer-card">
            <h2>Exclusive 10% off for new users</h2>
            <p>Sign up now and get a special 10% discount on your first booking!</p>
            <div class="offer-code">CODE: NEWUSER10</div>
        </div>

        <!-- Offer 5 -->
        <div class="offer-card">
            <h2>Get ?300 Cashback</h2>
            <p>Complete your booking and get ?300 cashback in your wallet.</p>
            <div class="offer-code">CODE: CASHBACK300</div>
        </div>
    </div>

</body>
</html>
