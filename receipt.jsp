<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appointment Receipt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000; /* Black background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #fff; /* Default text color */
        }

        .container {
            background: #1a1a1a; /* Dark gray background for the container */
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            max-width: 600px;
            width: 100%;
            color: #fff; /* White text inside the container */
        }

        h1, h2 {
            text-align: center;
            color: #ffa500; /* Orange color for headings */
        }

        .receipt-box {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #444; /* Dark border */
            border-radius: 8px;
            background: #262626; /* Slightly lighter black for the receipt box */
        }

        .receipt-box p {
            margin: 8px 0;
            font-size: 16px;
            color: #ddd; /* Light gray text for details */
        }

        .receipt-box strong {
            color: #fff; /* White text for strong elements */
        }

        button {
            display: block;
            width: 100%;
            padding: 10px 0;
            margin-top: 20px;
            background: #cc5500; /* Orange-brown-red button color */
            color: #fff; /* White text for the button */
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #a63e00; /* Slightly darker orange-brown-red on hover */
        }

        /* Print styling */
        @media print {
            body {
                background: #fff; /* White background for printing */
                color: #000; /* Black text for printing */
            }

            .container {
                box-shadow: none;
                border: none;
            }

            button {
                display: none; /* Hide buttons in print */
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Department of Admission</h1>
        <h2>Admission Appointment Receipt</h2>

        <%
            // Database connection and retrieval logic
            Connection connection = null;
            PreparedStatement stmt = null;
            ResultSet resultSet = null;
            try {
                int id = Integer.parseInt(request.getParameter("id")); // Get ID from query parameters
                DatabaseConnection db = new DatabaseConnection();
                connection = db.getConnection();

                String query = "SELECT * FROM AdmissionSystem.registration WHERE id = ?";
                stmt = connection.prepareStatement(query);
                stmt.setInt(1, id);
                resultSet = stmt.executeQuery();

                if (resultSet.next()) {
                    String name = resultSet.getString("name");
                    String dob = resultSet.getString("dob");
                    String email = resultSet.getString("email");
                    String phone = resultSet.getString("mobile_number");
                    String address = resultSet.getString("address");
                    String course = resultSet.getString("course_selection");
        %>

        <div class="receipt-box">
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Date of Birth:</strong> <%= dob %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Contact Number:</strong> <%= phone %></p>
            <p><strong>Address:</strong> <%= address %></p>
            <p><strong>Course Selection:</strong> <%= course %></p>
        </div>

        <%
                } else {
        %>
        <p style="color: red; text-align: center;">No admission details found for the provided Student ID.</p>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <p style="color: red; text-align: center;">An error occurred while fetching the Student details. Please try again.</p>
        <%
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (stmt != null) stmt.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <button onclick="printReceipt()">Print Receipt</button>
    </div>

    <script>
        function printReceipt() {
            window.print();
        }
    </script>
</body>
</html>
