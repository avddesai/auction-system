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
<% String userid = (String) session.getAttribute("usr");
//int itemId = (int) session.getAttribute("itemId");
int itemId= Integer.parseInt(request.getParameter("itemId"));
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
PreparedStatement ps = con.prepareStatement("insert into alert (itemId, userId) values(?,?)");
ps.setInt(1,itemId);
ps.setString(2,userid);
ps.executeUpdate();
String destPage = "home.jsp";
RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
dispatcher.forward(request, response);
%>
</body>
</html>