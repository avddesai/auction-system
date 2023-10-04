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
<%String userid = (String) session.getAttribute("usr");
int itemId= Integer.parseInt(request.getParameter("itemId"));
int bidAmt= Integer.parseInt(request.getParameter("bidAmt"));
ApplicationDb db = new ApplicationDb();	
Connection con = db.getConnection();
Statement st = con.createStatement();
String destPage = "home.jsp";
int flag =1;
int inFlag = 0;
ResultSet otherUsers = st.executeQuery("select b.userId, max(bidAmt) from bid b inner join item i on b.itemId = i.itemId WHERE b.itemId = "+itemId+" AND b.autoIncrement = 'Y' AND b.userId <> '"+ userid+"' AND b.bidAmt <= "+bidAmt+"  group by b.userId;");
while(flag == 1){
	PreparedStatement ps = con.prepareStatement("insert into bid (bidAmt, bidTime, upperLimit, userId, itemId, autoIncrement) VALUES(?,CURRENT_TIMESTAMP,?,?,?,?)");
	while(otherUsers.next()){
		//ps.setInt(1,bidAmt);
		String othrUsr = otherUsers.getString(1);
		System.out.println(othrUsr);
		int othrUsrbidAmt = otherUsers.getInt(2);
		Statement st2 = con.createStatement();
		ResultSet otherUsrDets = st2.executeQuery("select b.*, i.bidIncrement from bid b inner join item i on b.itemId = i.itemId where b.userId = '"+othrUsr+"' and b.bidAmt ="+othrUsrbidAmt+" and b.itemId ="+itemId);
		//ps.setString(2,dt);
		otherUsrDets.next();
		int othrUsrUpperLimit = otherUsrDets.getInt(4);
		int newBidAmt = bidAmt + otherUsrDets.getInt(8);
		//ps.executeUpdate();	
		if(newBidAmt <= othrUsrUpperLimit){
			ps.setInt(1,newBidAmt);
			//ps.setString(2,dt);
			ps.setInt(2,othrUsrUpperLimit);
			ps.setString(3,othrUsr);
			ps.setInt(4,itemId);
			ps.setString(5,"Y");
			ps.executeUpdate();
			inFlag = 1;
		}
		otherUsrDets.close();
	}
	if(inFlag == 0){
		flag = 0;
	}
	inFlag = 0;
	otherUsers.close();
	ResultSet maxUser = st.executeQuery("SELECT userId, bidAmt from bid where itemId ="+itemId+" and bidAmt = (select max(bidAmt) from bid where itemId ="+itemId+" )");
	maxUser.next();
	int maxAmt = maxUser.getInt(2);
	System.out.println(11);
	String avoidUser = maxUser.getString(1);
	otherUsers = st.executeQuery("select b.userId, max(bidAmt) from bid b inner join item i on b.itemId = i.itemId WHERE b.itemId = "+itemId+" AND b.autoIncrement = 'Y' AND b.userId <> '"+ avoidUser+"' AND b.bidAmt <= "+maxAmt+" group by b.userId;");
	if(!otherUsers.isBeforeFirst()){
		flag =0;
	}
	else{
		bidAmt = maxAmt;
	}
}
RequestDispatcher dispatcher = request.getRequestDispatcher(destPage);
dispatcher.forward(request, response);
%>
</body>
</html>