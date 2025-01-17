<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="DatabaseConnection.jsp" %>
<%@ page import ="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Index</title>
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
            text-align: center;
        }
        .button-link {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #ffffff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
        }
        .button-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            Connection con = null;
            DatabaseConnection db = new DatabaseConnection();
            con = db.getConnection();
            if(con != null){
        %>
            <h1>Connection successful.</h1>
            <a class="button-link" href="registration.jsp">Proceed to Registration</a>
        <%
            } else {
        %>
            <h1>Connection failed.</h1>
        <%
            }
        %>
    </div>
</body>
</html>
