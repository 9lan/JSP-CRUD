<%@page import="javax.swing.JOptionPane"%> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <%@ include file="head.jsp" %>
    <body class="container my-3">
        <%
            String no_rekening = request.getParameter("d");

            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                
                String url = "jdbc:mysql://localhost:3306/koperasi";
                
                Connection conn = DriverManager.getConnection(url, "root", "");

                Statement statement = conn.createStatement();

                statement.executeUpdate("DELETE FROM nasabah WHERE no_rekening='"+no_rekening+"'");

                response.sendRedirect("index.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>