<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project1.ApplicationDb"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bids</title>
</head>
<body>
    <% int id = Integer.parseInt(request.getParameter("itemId")); 
       int bidAmt = Integer.parseInt(request.getParameter("bidAmt"));
       String userId = request.getParameter("userId");
    %>
  
    <%-- Connect to the database --%>
    <%
    ApplicationDb db = new ApplicationDb();	
    Connection conn = db.getConnection();
      PreparedStatement pstmt = null;
        try {
           
            

            // Define the SQL DELETE statement
            String sql = "DELETE FROM bid WHERE userId = ? and bidAmt = ? and itemId = ?";
            
            // Prepare the statement and set the parameter values
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setInt(2,bidAmt);
            pstmt.setInt(3,id);
            
            // Execute the statement
            int rows = pstmt.executeUpdate();
            
            // Display a success message
            out.println(rows + " row deleted successfully!");
            
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