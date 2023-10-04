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
<% String userId = request.getParameter("userId");
ApplicationDb db = new ApplicationDb();	
Connection conn = db.getConnection();
  PreparedStatement pstmt = null;
    try {
       
        

        // Define the SQL DELETE statement
        String sql = "DELETE FROM enduser WHERE userId = ? ";
        
        
        // Prepare the statement and set the parameter values
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        
        // Execute the statement
        pstmt.executeUpdate();
        PreparedStatement pstmt2 = conn.prepareStatement("delete from item where userId = ? and status = 0");
        pstmt2.setString(1, userId);
        pstmt2.executeUpdate();
        pstmt2.close();
        PreparedStatement pstmt3 = conn.prepareStatement("delete from alert where userId = ?");
        pstmt3.executeUpdate();
        pstmt3.close();
        PreparedStatement pstmt4 =conn.prepareStatement("delete from bid where userId = ? and itemId in (select * from item where status = 0)");
        pstmt4.setString(1, userId);
        pstmt4.executeUpdate();
        pstmt4.close();
        
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