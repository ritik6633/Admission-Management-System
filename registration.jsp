<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000; /* Black background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #ffffff; /* White text for readability */
        }
        .container {
            width: 100%;
            max-width: 500px;
            background: #1e1e1e; /* Dark gray card background */
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            border-radius: 8px;
        }
        .registration-form h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #ffffff;
            text-align: center;
        }
        .registration-form label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #f0f0f0;
        }
        .registration-form input[type="text"],
        .registration-form input[type="date"],
        .registration-form input[type="email"],
        .registration-form input[type="tel"],
        .registration-form input[type="password"],
        .registration-form textarea,
        .registration-form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #333;
            border-radius: 4px;
            font-size: 14px;
            background-color: #2e2e2e; /* Input background */
            color: #ffffff; /* Input text */
        }
        .registration-form input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .registration-form input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .registration-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
        .registration-link a {
            color: #007bff;
            text-decoration: none;
        }
        .registration-link a:hover {
            text-decoration: underline;
        }
    </style>
<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    DatabaseConnection db = new DatabaseConnection();
    connection = db.getConnection();
%>
</head>
<body>
    <div class="container">
        <div class="registration-form">
            <h2>Register</h2>
            <form name="registration-form" method="POST" onsubmit="return validateForm()">  
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
                
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                
                <label for="mobile">Mobile Number:</label>
                <input type="tel" id="mobile" name="mobile" placeholder="Enter your mobile number" required>
                
                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="4" placeholder="Enter your address" required></textarea>
                
                <label for="course">Course Selection:</label>
                <select id="course" name="course" required>
                    <option value="">Select a course</option>
                    <option value="science">Science</option>
                    <option value="commerce">Commerce</option>
                    <option value="arts">Arts</option>
                    <option value="technology">Technology</option>
                </select>
                
                <label for="Password">Password:</label>
                <input type="password" id="pass" name="password" placeholder="Enter Password" required>

                <input type="submit" value="Register">
            </form>
            <%
                if(request.getMethod().equalsIgnoreCase("POST")){
                    String name = request.getParameter("name");
                    String dob = request.getParameter("dob");
                    String email = request.getParameter("email");
                    String mobile = request.getParameter("mobile");
                    String address = request.getParameter("address");
                    String course = request.getParameter("course");
                    String pass = request.getParameter("password");

                    preparedStatement = connection.prepareStatement(
                        "INSERT INTO AdmissionSystem.registration(name, dob, email, mobile_number, address, course_selection, password) VALUES(?, ?, ?, ?, ?, ?, ?)"
                    );
                    preparedStatement.setString(1, name);
                    preparedStatement.setString(2, dob);
                    preparedStatement.setString(3, email);
                    preparedStatement.setString(4, mobile);
                    preparedStatement.setString(5, address);
                    preparedStatement.setString(6, course);
                    preparedStatement.setString(7, pass);
                    int row = preparedStatement.executeUpdate();
                    if (row > 0){
                        response.sendRedirect("login.jsp");
                    }
                }
            %>
        </div>
    </div>
</body>
<script>
    function validateForm() {
        var mobile = document.forms["registration-form"]["mobile"].value;

        // Validate mobile number
        if (mobile == "" || !/^\d{10}$/.test(mobile)) {
            alert("Please enter a valid 10-digit mobile number.");
            return false;
        }
        return true;
    }
</script>
</html>
