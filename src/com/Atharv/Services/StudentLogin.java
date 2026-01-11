package com.Atharv.Services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Atharv.dbcon.ConnectDb;
import com.pogo.users;

/**
 * Servlet implementation class StudentLogin
 */
public class StudentLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		try
		{
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			Connection con = ConnectDb.getConnect();
			PreparedStatement ps1 = con.prepareStatement("select * from student where email=? and password=?");
			ps1.setString(1, email);
			ps1.setString(2, password);
			
			ResultSet rs = ps1.executeQuery();
			if(rs.next())
			{
				users.setEmail(rs.getString(3));
				response.sendRedirect("StudentDashboard.html");
			}
			else
			{
				response.sendRedirect("error.html");
			}	
		}
		catch(Exception e)
		{
			e.printStackTrace();
			response.sendRedirect("error.html");
			
		}
	}

}
