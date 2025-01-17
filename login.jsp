<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
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
            color: #ffffff; /* White text for visibility */
        }
        .container {
            width: 100%;
            max-width: 400px;
            background: #1e1e1e; /* Dark gray card background */
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
            border-radius: 8px;
        }
        .login-form h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #ffffff; /* White heading */
            text-align: center;
        }
        .login-form label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #f0f0f0; /* Light gray for labels */
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #333;
            border-radius: 4px;
            font-size: 14px;
            background-color: #2e2e2e; /* Darker input background */
            color: #ffffff; /* White text for inputs */
        }
        .login-form input[type="submit"] {
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
        .login-form input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .captcha-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .captcha-container span {
            display: inline-block;
            background-color: #333;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            border: 1px solid #444;
            border-radius: 4px;
            color: #ffffff;
        }
        .captcha-container input {
            flex: 1;
            margin-left: 10px;
            background-color: #2e2e2e;
            color: #ffffff;
            border: 1px solid #333;
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
    ResultSet resultSet = null;

    DatabaseConnection db = new DatabaseConnection();
    connection = db.getConnection();

    // Generate a CAPTCHA code for GET requests
    if (request.getMethod().equalsIgnoreCase("GET")) {
        String captchaCode = "";
        for (int i = 0; i < 6; i++) {
            captchaCode += (char) ((int) (Math.random() * 26) + 'A');
        }
        session.setAttribute("captchaCode", captchaCode); // Store CAPTCHA in session
    }
%>
</head>
<body>
    <div class="container">
        <div class="login-form">
            <h2>Login</h2>
            <form name="loginForm" method="POST" onsubmit="return validateLoginForm()">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" placeholder="Enter Email" required>
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter Password" required>
                
                <label for="captcha">Enter CAPTCHA:</label>
                <div class="captcha-container">
                    <span><%= session.getAttribute("captchaCode") %></span>
                    <input type="text" id="captcha" name="captcha" placeholder="Enter CAPTCHA" required>
                </div>
                
                <input type="submit" value="Login">
            </form>
            <p class="registration-link">Don't have an account? <a href="registration.jsp">Register-Up</a></p>
        </div>
        <%
         if (request.getMethod().equalsIgnoreCase("POST")) {
            String username = request.getParameter("email");
            String password = request.getParameter("password");
            String enteredCaptcha = request.getParameter("captcha");
            String sessionCaptcha = (String) session.getAttribute("captchaCode");

            // Validate CAPTCHA
            if (enteredCaptcha == null || sessionCaptcha == null || !enteredCaptcha.equalsIgnoreCase(sessionCaptcha)) {
                out.println("<script>alert('Invalid CAPTCHA. Please try again.');</script>");
                response.sendRedirect("inValidCaptcha.jsp");
                return;
            }

            // Validate email and password
            preparedStatement = connection.prepareStatement("SELECT email, password FROM AdmissionSystem.registration WHERE email = ?");
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();
            if (resultSet != null && resultSet.next()) {
                if (resultSet.getString("password") != null && password.equals(resultSet.getString("password"))) {
                    session.setAttribute("user", username);
                    response.sendRedirect("Crud_op.jsp");
                } else {
                    response.sendRedirect("wrongPassword.jsp");
                }
            } else {
                response.sendRedirect("registration.jsp");
            }
         }
        %>
    </div>
</body>
<script>
function validateLoginForm() {
    var email = document.forms["loginForm"]["email"].value;
    var password = document.forms["loginForm"]["password"].value;
    var captcha = document.forms["loginForm"]["captcha"].value;

    if (email == "") {
        alert("Email must be filled out");
        return false;
    }
    
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address");
        return false;
    }
    
    if (password == "") {
        alert("Password must be filled out");
        return false;
    }

    if (captcha == "") {
        alert("CAPTCHA must be filled out");
        return false;
    }

    return true;
}
</script>
</html>
