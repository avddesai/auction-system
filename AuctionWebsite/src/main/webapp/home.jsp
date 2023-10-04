<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="project1.ApplicationDb"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction Home</title>
<link rel="stylesheet" type="text/css" href="style.css">
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
String userid = (String) session.getAttribute("usr");
//HttpSession session = request.getSession();
session.setAttribute("usr", userid);
String password = request.getParameter("password");
//Class.forName("com.mysql.jdbc.Driver");
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
Statement st = con.createStatement();
%>
    <div style="text-align: center">
        <h1>Welcome to the Auction</h1>
        <b><%=userid%></b>
        <br><br>
        <table align="center">
    		<tr>
    			<td><a href="pa.jsp">Q&A</a>
    			<td>|</td>
				<td><a href="index.jsp">Account</a></td>
				<td>|</td>
				<td><a href="logout.jsp">Logout</a></td>
				<td>|</td>
				<td><a href="createItem.jsp">Add new item</a></td>
   			</tr>
    	</table>
    <form class="form-inline" method="post" action="search.jsp">
    <input type="text" name="search" class="form-control" placeholder="Search goes here..."> <br><br>
    <select name="sortParam" id="sortby">
			<option value="None">---</option>
	    	<option value="Name">Name</option>
	    	<option value="lowToHigh">Price (Ascending)</option>
	    	<option value="highToLow">Price (Descending)</option>
	    	<option value="Tag">Tag</option>
	    	<option value="Open">Status: Open</option>
	    	<option value="Closed">Status: Closed</option>
		</select>
    <button type="submit" name="save" class="btn btn-primary">Search</button>
  </form>
    	<%
    	ResultSet itemList = st.executeQuery("SELECT * FROM ITEM");
    	%>
    	<br><br>
    	<TABLE align="center" BORDER="1">
    	<caption style="text-align:center">ITEMS CURRENTLY IN AUCTION</caption>
            <TR>
                <TH>Name</TH>
                <TH>View similar items</TH>
                <TH>ClosingTime</TH>
                <TH>Price</TH>
                <TH>Status</TH>
                <TH>Closing time</TH>
                <TH>Bid</TH>
                <TH>History of Bid</TH>
            </TR>
            <%while(itemList.next()){ 
            	int itemId = itemList.getInt(1);
            	String ss = "closed";
            	if(itemList.getInt(10) == 0){
            		ss = "open";
            	}
            	//session.setAttribute("itemId", itemId);
            %>
            <TR>
            	<TD> <%=itemList.getString(2)%></TD>
            	<TD> <a href = "simItems.jsp?itemId=<%=itemList.getInt(1)%>">View Similar items</a></TD>
                <TD> <%= itemList.getString(9) %></TD>
                <TD> <%= itemList.getString(3) %></TD>
                <TD> <%= ss %></TD>
                <TD> <%= itemList.getString(9) %></TD>
                <TD><a href = "bid.jsp?itemId=<%=itemList.getInt(1)%>">Make a bid</a></TD>
                <TD><a href = "histBid.jsp?itemId=<%=itemList.getInt(1)%>">Check bidding history</a>
            </TR>
            <%} %>
         </TABLE>
<%
itemList.close();
ResultSet userBuys = st.executeQuery("select s.*, i.name from sales s inner join item i on s.itemId = i.itemId where s.userId = '"+userid+"'");
%>
<br><br>
    	<TABLE align="center" BORDER="1">
    	<caption style="text-align:center">ITEMS Bought by you</caption>
            <TR>
                <TH>Name</TH>           
                <TH>Price</TH>
            </TR>
<%
while(userBuys.next()){	
%>
		<TR>
           	<TD> <%=userBuys.getString(5)%></TD>
            <TD> <%=userBuys.getInt(4)%></TD>
		</TR>
		<%}%>
		</TABLE>
<%
userBuys.close();
Statement st2 = con.createStatement();
ResultSet userAlert = st2.executeQuery("select distinct i.name,i.status from alert a inner join item i on i.itemId = a.itemId where a.userId = '"+userid+"'");
userAlert.isBeforeFirst();
%>
<br><br>
    	<TABLE align="center" BORDER="1">
    	<caption style="text-align:center">Alerts set by you</caption>
            <TR>
                <TH>Item</TH>           
                <TH>Status</TH>
            </TR>
<%
while(userAlert.next()){
	String status = "closed";
	String iName = userAlert.getString("name");
	Statement st3 = con.createStatement();
	ResultSet s = st3.executeQuery("select * from item where name like '%"+iName+"%' and status = 0");
	if(s.next()){
		status = "open";
	}
%>
<TR>
           	<TD> <%=userAlert.getString("name")%></TD>
            <TD> <%=status%></TD>
		</TR>
<%	
}
%>
</TABLE>
    </div>
</body>
</html>