<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException" %>
<%
    String jdbcDriver = "com.mysql.cj.jdbc.Driver";
    String dbURL = "jdbc:mysql://localhost:3306/AdmissionSystem";
    String dbUserName="root";
    String dbPassword="root";

    class DatabaseConnection{
        Connection conn = null;

        private Connection getConnection(){
            try {
                Class.forName(jdbcDriver);
                conn = DriverManager.getConnection(dbURL,dbUserName,dbPassword);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            return conn;
        }
    }
%>