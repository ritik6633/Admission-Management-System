<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="DatabaseConnection.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admission Data</title>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        DatabaseConnection db = new DatabaseConnection();
        conn = db.getConnection();
    %>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #000; /* Black background */
            color: #fff; /* White text */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            background-color: #fff; /* White background for table */
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.3);
            color: #000; /* Black text for content */
        }
        h1 {
            text-align: center;
            color: #009688;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table thead tr {
            background-color: #333;
            color: #fff;
        }
        table th, table td {
            padding: 12px 15px;
            text-align: center;
            border: 1px solid #ddd;
        }
        table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        table tbody tr:nth-child(odd) {
            background-color: #f1f1f1;
        }
        .operation-buttons button {
            background: linear-gradient(45deg, #c04000, #ff6347); /* Brown-Red-Orange gradient */
            border: none;
            color: #fff;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin: 2px;
            font-size: 14px;
            transition: transform 0.2s ease, background-color 0.2s ease;
        }
        .operation-buttons button:hover {
            transform: scale(1.05);
            background: #c03e00; /* Slightly darker shade on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Admission Data Entry</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Date of Birth</th>
                    <th>Email</th>
                    <th>Mobile Number</th>
                    <th>Address</th>
                    <th>Course Selection</th>
                    <th>Operations</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        String sql = "SELECT * FROM AdmissionSystem.registration";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String dob = rs.getString("dob");
                            String email = rs.getString("email");
                            String phone = rs.getString("mobile_number");
                            String add = rs.getString("address");
                            String course = rs.getString("course_selection");
                %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= dob %></td>
                            <td><%= email %></td>
                            <td><%= phone %></td>
                            <td><%= add %></td>
                            <td><%= course %></td>
                            <td>
                                <div class="operation-buttons">
                                    <button onclick="window.location.href='update.jsp?id=<%= id %>'">Update</button>
                                    <button onclick="window.location.href='delete.jsp?id=<%= id %>'">Delete</button>
                                    <button onclick="window.location.href='receipt.jsp?id=<%= id %>'">Print</button>
                                </div>
                            </td>
                        </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) {}
                        if (ps != null) try { ps.close(); } catch (SQLException e) {}
                        if (conn != null) try { conn.close(); } catch (SQLException e) {}
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
