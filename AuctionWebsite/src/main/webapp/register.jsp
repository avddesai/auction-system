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
<%
String userid = request.getParameter("usr");
String password = request.getParameter("pwd1");
String email = request.getParameter("email");
String name = request.getParameter("name");
session.setAttribute("usr", userid);
//session["UserName"] = userid;
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("select * from endUser where userId='" + userid + "'");
String destPage = "createNewUser.jsp";
if(rs.next()){
	String message = "UserId already exists. Try a different one.";
    request.setAttribute("existingUser", message);
}
else{
	PreparedStatement ps=con.prepareStatement("insert into enduser values(?,?,?,?,'u')");
	ps.setString(1,userid);  
	ps.setString(2,password);  
	ps.setString(3,name);
	ps.setString(4,email);
	int status=ps.executeUpdate();  
	destPage = "home.jsp";
}
RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
dispatcher.forward(request, response);
%>
</body>
</html>