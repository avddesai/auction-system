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
<div style="text-align: center">
		<table align="center">
    		<tr>
    			<td><a href="home.jsp">Home</a></td>
    			<td>|</td>
    			<td><a href="index.jsp">Q&A</a></td>
    			<td>|</td>
				<td><a href="index.jsp">Account</a></td>
				<td>|</td>
				<td><a href="logout.jsp">Logout</a></td>
   			</tr>
       	</table>
<% String userid = (String) session.getAttribute("usr");
int itemId = Integer.parseInt(request.getParameter("itemId"));
//String searchUserId = request.getParameter("userId");
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet itemList = st.executeQuery("select i.* from item i where categoryId = (select categoryId from item p where p.itemId ="+itemId+")");
%>
<br><br>
    	<TABLE align="center" BORDER="1">
    	<caption style="text-align:center">Similar items</caption>
            <TR>
               	<TH>Name</TH>
                <TH>ClosingTime</TH>
                <TH>Price</TH>
                <TH>Category</TH>
                <TH>Status</TH>
                <TH>Closing time</TH>
                <TH>Bid</TH>
            </TR>
            <%while(itemList.next()){ 
            %>
            <TR>
            	<TD> <%=itemList.getString(2)%></TD>
                <TD> <%= itemList.getString(9) %></TD>
                <TD> <%= itemList.getString(3) %></TD>
                <TD> <%= itemList.getString(8) %></TD>
                <TD> <%= itemList.getString(10) %></TD>
                <TD> <%= itemList.getString(9) %></TD>
                <TD><a href = "bid.jsp?itemId=<%=itemList.getInt(1)%>">Make a bid</a></TD>
            </TR>
  <%} %>
         </TABLE>
</body>
</html>