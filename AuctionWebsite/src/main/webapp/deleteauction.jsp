<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project1.ApplicationDb"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% int id = Integer.parseInt(request.getParameter("itemId")); 
ApplicationDb db = new ApplicationDb();	
Connection conn = db.getConnection();
  PreparedStatement pstmt = null;
    try {
       
        

        // Define the SQL DELETE statement
        String sql = "DELETE FROM item WHERE itemId = ?";
        
        // Prepare the statement and set the parameter values
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1,id);
        
        // Execute the statement
         pstmt.executeUpdate();
        
        
    }  catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database connection and statement
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    String destPage = "homeCR.jsp";
    RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
    dispatcher.forward(request, response);
%>
</body>
</html>