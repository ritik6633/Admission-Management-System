<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="DatabaseConnection.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Record</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #000; /* Black background */
            color: #fff; /* White text */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #333; /* Dark background for the container */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            padding: 30px;
            box-sizing: border-box;
        }

        h1 {
            color: #fff; /* White text */
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            font-size: 14px;
            color: #ddd; /* Light gray color for the labels */
        }

        input[type="text"],
        input[type="tel"],
        input[type="date"],
        input[type="email"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #666; /* Dark border */
            border-radius: 4px;
            font-size: 14px;
            color: #fff; /* White text in inputs */
            background-color: #444; /* Darker input background */
        }

        input[type="submit"],
        button.btn-back {
            padding: 12px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover,
        button.btn-back:hover {
            background-color: #0056b3;
        }

        .btn-back {
            background-color: #e0e0e0;
            margin-top: 10px;
            width: 100%;
        }

        .message {
            margin-top: 20px;
            text-align: center;
            font-size: 16px;
            color: #d9534f; /* Error message color */
        }

        .message.success {
            color: #28a745; /* Success message color */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Record</h1>

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            int id = Integer.parseInt(request.getParameter("id"));
            String name = "";
            String dob = "";
            String email = "";
            String mobile = "";
            String address = "";
            String course = "";
            DatabaseConnection db = new DatabaseConnection();

            try {
                conn = db.getConnection();
                String query = "SELECT name, dob, email, mobile_number, address, course_selection FROM AdmissionSystem.registration WHERE id = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, id);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    name = rs.getString("name");
                    dob = rs.getString("dob");
                    email = rs.getString("email");
                    mobile = rs.getString("mobile_number");
                    address = rs.getString("address");
                    course = rs.getString("course_selection");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (ps != null) try { ps.close(); } catch (SQLException e) {}
            }
        %>

        <form method="POST">
            <input type="hidden" name="id" value="<%= id %>">

            <label for="name">Name</label>
            <input type="text" name="name" value="<%= name %>" required>

            <label for="dob">Date of Birth</label>
            <input type="date" name="dob" value="<%= dob %>" required>

            <label for="email">Email</label>
            <input type="email" name="email" value="<%= email %>" required>

            <label for="mobile">Mobile</label>
            <input type="tel" name="mobile" value="<%= mobile %>" required>

            <label for="address">Address</label>
            <input type="text" name="address" value="<%= address %>" required>

            <label for="course">Course</label>
            <input type="text" name="course" value="<%= course %>" required>

            <input type="submit" value="Update Record">
        </form>

        <button class="btn-back" onclick="window.location.href='Crud_op.jsp'">Back to List</button>

        <%
            if(request.getMethod().equalsIgnoreCase("POST")) {
                String newName = request.getParameter("name");
                String newDOB = request.getParameter("dob");
                String newEmail= request.getParameter("email");
                String newMobile = request.getParameter("mobile");
                String newAddress= request.getParameter("address");
                String newCourse = request.getParameter("course");

                try {
                    conn = db.getConnection();
                    String updateQuery = "UPDATE AdmissionSystem.registration SET name = ?, dob = ?, email = ?, mobile_number = ?, address = ?, course_selection = ? WHERE id = ?";
                    ps = conn.prepareStatement(updateQuery);
                    ps.setString(1, newName);
                    ps.setString(2, newDOB);
                    ps.setString(3, newEmail);
                    ps.setString(4, newMobile);
                    ps.setString(5, newAddress);
                    ps.setString(6, newCourse);
                    ps.setInt(7, id);

                    int rowsUpdated = ps.executeUpdate();

                    if (rowsUpdated > 0) {
                        out.println("<p class='message success'>Record updated successfully!</p>");
                        response.sendRedirect("Crud_op.jsp");
                    } else {
                        out.println("<p class='message'>Error updating record.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (ps != null) try { ps.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            }
        %>
    </div>
</body>
</html>
