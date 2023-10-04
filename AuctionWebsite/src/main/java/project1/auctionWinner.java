package project1;

import java.sql.Connection;
import java.sql.*;
import java.util.*;
import java.sql.DriverManager;
import java.sql.SQLException;

public class auctionWinner extends Thread{
	
	Connection c;
	public auctionWinner(Connection c) {
		this.c = c;
	}
	public void run() {
		while(true) {
			decideWinner();
			try {
				Thread.sleep(1 * 1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	public void decideWinner() {
		try {
			java.sql.PreparedStatement ps = c.prepareStatement("SELECT * FROM item where status = 0");
			ResultSet open = ps.executeQuery();
			while(open.next()) {
				int itemId = open.getInt(1);
				Timestamp dt = open.getTimestamp(9);
				Timestamp curr_time = new Timestamp(System.currentTimeMillis());
				int minPrice = open.getInt(5);
				if(dt.before(curr_time) || dt.equals(curr_time)) {
					ps = c.prepareStatement("update item set status = 1 where itemId = ?");
					ps.setInt(1,itemId);
					ps.executeUpdate();
					java.sql.PreparedStatement win = c.prepareStatement("SELECT userId, bidAmt from bid where itemId ="+itemId+" and bidAmt = (select max(bidAmt) from bid where itemId ="+itemId+" )");
					ResultSet maxBid = win.executeQuery();
					if(maxBid.next()) {
						int maxBidAmt = maxBid.getInt(2);
						if(maxBidAmt >= minPrice) {
							ps = c.prepareStatement("INSERT INTO sales (itemId,userId,bidAmt) values(?,?,?)");
							ps.setInt(1, itemId);
							ps.setString(2, maxBid.getString(1));
							ps.setInt(3, maxBidAmt);
							ps.executeUpdate();
						}
					}	
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}