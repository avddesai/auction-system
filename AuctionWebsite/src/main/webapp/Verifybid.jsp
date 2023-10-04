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
<style>@charset "ISO-8859-1";
body {
  background-color: #f2f2f2;
  font-family: Arial, sans-serif;
}

title {
  text-align: center;
  color: #4CAF50;
}

form {
  background-color: #ffffff;
  border-radius: 5px;
  box-shadow: 0px 0px 30px #d9d9f9;
  padding: 30px;
  width: 300px;
  margin: 40px auto;
}
a{
  font-size: 13px;
}
h2 {
  text-align: center;
  color: #4CAF50;
}
  
input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #d9d9d9;
  margin-bottom: 10px;
}

input[type="submit"] {
  font-family: sans-serif;
  font-size: 16px;
  background-color: #4CAF50;
  width: 100%;
  padding: 10px;
  border-radius: 10px;
  border: 1px solid #d9d9d9;
  cursor: pointer;
  }

table {
  border-collapse: separate;
  border-spacing: 0;
  width: 100%;
  max-width: 800px;
  background-color: #fff;
  color: #333;
  font-size: 14px;
  text-align: left;
  margin-bottom: 20px;
}

table th {
  font-weight: 700;
  background-color: #f8f8f8;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  padding: 10px;
  border-bottom: 2px solid #ddd;
}

table td {
  padding: 10px;
  border-bottom: 1px solid #ddd;
}



table caption {
  margin-bottom: 10px;
  font-style: italic;
  font-size: 12px;
}

</style>
</head>
<body>
<%String userid = (String) session.getAttribute("usr");
//int itemId = (int) session.getAttribute("itemId");
int itemId= Integer.parseInt(request.getParameter("itemId"));
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
Statement st = con.createStatement();
int bidAmt= Integer.parseInt(request.getParameter("bidAmt"));
String autoBid = request.getParameter("autoBid");
int upperLimit = Integer.parseInt(request.getParameter("upperLimit"));
String dt = request.getParameter("dt");
String destPage = "home.jsp";
ResultSet bidDetails = st.executeQuery("SELECT * FROM BID WHERE itemId = "+itemId+" AND userId = '"+userid+"'");

PreparedStatement ps = con.prepareStatement("insert into bid (bidAmt, bidTime, upperLimit, userId, itemId, autoIncrement) VALUES(?,CURRENT_TIMESTAMP,?,?,?,?)");
ps.setInt(1,bidAmt);
//ps.setString(2,dt);
ps.setInt(2,upperLimit);
ps.setString(3,userid);
ps.setInt(4,itemId);
ps.setString(5,autoBid);
ps.executeUpdate();	


ResultSet otherUsers = st.executeQuery("SELECT * FROM BID WHERE itemId = '"+itemId+"' AND autoIncrement = 'Y' AND bidAmt <="+bidAmt+ " AND userId <>'"+userid+"'");
if(otherUsers.next()){
	destPage = "autoBid.jsp?itemId="+ itemId;
	request.setAttribute("bidAmt",bidAmt);
}
RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
dispatcher.forward(request, response);
%>
</body>
</html>