package com.Atharv.dbcon;
import java.sql.*;
import java.sql.DriverManager;

public class ConnectDb {
	static Connection con = null;
	public static Connection getConnect()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/alumni_portal_db", "root", "");
		}
		catch(Exception e)
		{
			System.err.println("Failed To Connect to the database...!!");
			e.printStackTrace();
		}
		return con;
	}
}