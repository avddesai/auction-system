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
<%String userId = (String) session.getAttribute("usr");
//int itemId = (int) session.getAttribute("itemId");
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
String name = request.getParameter("name");
int initialPrice= Integer.parseInt(request.getParameter("initialPrice"));
int bidIncrement= Integer.parseInt(request.getParameter("bidIncrement"));
int secretMinPrice= Integer.parseInt(request.getParameter("secretMinPrice"));
String dt = request.getParameter("dateTimeClosing");
String category = request.getParameter("category");
System.out.println(category);
Statement st = con.createStatement();
ResultSet categorySet = st.executeQuery("SELECT categoryId from category WHERE categoryId = '"+category+"'");
String cid = null;
while(categorySet.next()) {
  cid = categorySet.getString(1);
  System.out.println(cid);
}


int auctionId = 1;

String destPage = "home.jsp";

PreparedStatement ps = con.prepareStatement("insert into item (name, initialPrice, bidIncrement, secretMinPrice, auctionId, userId, categoryId, dateTimeClosing, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, 0)");
ps.setString(1,name);
ps.setInt(2,initialPrice);
ps.setInt(3,bidIncrement);
ps.setInt(4,secretMinPrice);
ps.setInt(5,auctionId);
ps.setString(6,userId);
ps.setString(7,cid);
ps.setString(8,dt);
ps.executeUpdate();	

RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
dispatcher.forward(request, response);
%>
</body>
</html>