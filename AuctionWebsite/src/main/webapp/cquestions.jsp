<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project1.ApplicationDb"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Questions Received</title>
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
//Statement st1 = con.createStatement();
ResultSet itemList = st.executeQuery("SELECT * FROM talksto");
String destPage = "createNewUser.jsp";
//ResultSet totalSales = st1.executeQuery("select SUM(bidAmt) from sales");
%>
<table align="center">
    		<tr>
    			
				<td><a href="homeCR.jsp">Home</a></td>
				<td>|</td>
				<td><a href="logout.jsp">Logout</a></td>
   			</tr>
    	</table>
    	<br><br>
    	<TABLE align="center" BORDER="1">
    	<caption style="text-align:center">All questions</caption>
    	    <p style="text-align:center" ></p>
            <TR>
                <TH>USER</TH>
                <TH>QUERY</TH>
                <TH>ANSWER</TH>
                <TH>ACTION<TH>

            </TR>

<% while(itemList.next()) { 
    String best = itemList.getString(3);
    String question = itemList.getString(4);
    String ans = itemList.getString(5);
 
%>
    <TR>
        <TD> <%=itemList.getString(3)%></TD>
        <TD> <%=itemList.getString(4)%></TD>
        <TD> <%=ans%></TD>
        <TD> <a href="answerq.jsp?tid=<%=itemList.getInt(1)%>">ANSWER THIS QUESTION</a> </TD>
    </TR>
<% } %>
</TABLE>
         
</body>
</html>