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

/**
 * Servlet implementation class AlumniRegister
 */
public class AlumniRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlumniRegister() {
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
			int id=0;
			String name=request.getParameter("name");
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			String phone=request.getParameter("phone");
			String batch=request.getParameter("batch");
			String branch=request.getParameter("branch");
			String company=request.getParameter("company");
			String location=request.getParameter("location");
			String linkedin=request.getParameter("linkedin");
			System.out.println(batch);
				Connection con = ConnectDb.getConnect();
				PreparedStatement ps2 = con.prepareStatement("insert into alumni values(?,?,?,?,?,?,?,?,?,?,?)");
				ps2.setInt(1, id);
				ps2.setString(2, name);
				ps2.setString(3, email);
				ps2.setString(4, password);
				ps2.setString(5, phone);
				ps2.setString(6, batch);
				ps2.setString(7, branch);
				ps2.setString(8, company);
				ps2.setString(9, location);
				ps2.setString(10, linkedin);
				ps2.setString(11, "Pending");
				int i = ps2.executeUpdate();
				if(i>0)
				{
					System.out.println("Register Successfully...!!");
					response.sendRedirect("alumnilogin.html");
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
