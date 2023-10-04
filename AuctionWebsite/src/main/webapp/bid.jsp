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
//int itemId = (int) session.getAttribute("itemId");
int itemId= Integer.parseInt(request.getParameter("itemId"));
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet statusSet = st.executeQuery("select * from item where itemId ="+itemId);
statusSet.next();
int status = statusSet.getInt(10);
int currAmt = 0;
ResultSet bidDetails = st.executeQuery("SELECT b.* FROM BID b WHERE b.itemId = "+itemId+" AND b.bidAmt = (SELECT MAX(bidAmt) from bid x where x.itemId = "+itemId+")");
if(status == 1){
	ResultSet saleDetails = st.executeQuery("select * from sales where itemId = "+itemId);	
	if(saleDetails.next()){
		int saleAmt = saleDetails.getInt(4);
		String userId = saleDetails.getString(2);
	
%>
<p> Item has been sold to <a href="histAuction.jsp?userId=<%=userId%>"><%=userId%></a> for <%=saleAmt%> dollars.</p>
<a href = "alert.jsp?itemId=<%=itemId%>">Create alert</a>
<%
	}
	else{
%>
<p> Item has gone unsold.</p>
<a href = "alert.jsp?itemId=<%=itemId%>">Create alert</a>
<%		
	}
}
else{
	if(bidDetails.next()){
		currAmt = bidDetails.getInt(2);
		System.out.println(status);
	}
%>
	
<form class="form-inline" method="post" action="Verifybid.jsp?itemId=<%=itemId%>">
		Enter Bid amount. Current bid Amount is <%=currAmt%><input type="number" name="bidAmt" /><br><br>
		Enter if you want to auto bid<select name="autoBid" id="autoBid">
		<option>Y</option>
		<option>N</option>
		</select><br><br>
		Enter upper limit for auto bid.<input type="number" name="upperLimit" /><br><br>
		<input type="submit"/><br><br>
  </form>
  
<%
}			
%>


</div>
</body>
</html>