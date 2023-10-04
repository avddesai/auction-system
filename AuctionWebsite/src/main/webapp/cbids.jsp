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
    <h1>Edit Bids</h1>

    <%-- Connect to the database --%>
    <%
    ApplicationDb db = new ApplicationDb();	
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    %>

    <%-- Display the table --%>
    <table align="center">
    		<tr>
    			
				<td><a href="homeCR.jsp">Home</a></td>
				<td>|</td>
				<td><a href="logout.jsp">Logout</a></td>
   			</tr>
    	</table>
    <table align="center" BORDER="1">
        <tr>
            <th>User Id</th>
            <th>Item Name</th>
            <th>Bid Amount</th>
            <th>Delete</th>
        </tr>
        <%-- Query the database for all rows in the bid table --%>
        <% String sql = "SELECT  max(b.bidAmt) as bidAmt, b.userId, i.name, b.itemId FROM bid b inner join item i on i.itemId = b.itemId group by b.userId, i.name, b.itemId;";
           ResultSet rs = stmt.executeQuery(sql);
           while (rs.next()) {
              
        %>
        <tr>
            <td><%=rs.getString("userId")%></td>
            <td><%=rs.getString("name")%></td>
            <td><%=rs.getInt("bidAmt")%></td>
            <%-- Create a delete button for each row --%>
            <td>
                <form method="post" action="deletebid.jsp?itemId=<%=rs.getInt("itemId")%>&userId=<%=rs.getString("userId")%>&bidAmt=<%=rs.getInt("bidAmt")%>">
                    <input type="hidden" name="id">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <%-- Close the database connection --%>
    <% rs.close();
       stmt.close();
       con.close();
    %>

</body>
</html>
