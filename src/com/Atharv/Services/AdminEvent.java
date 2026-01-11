package com.Atharv.Services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Atharv.dbcon.ConnectDb;

/**
 * Servlet implementation class AdminEvent
 */
public class AdminEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminEvent() {
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
			String title=request.getParameter("title");
			String date=request.getParameter("date");
			String time=request.getParameter("time");
			String venue=request.getParameter("venue");
			String description=request.getParameter("description");
			String audience=request.getParameter("audience");
				Connection con = ConnectDb.getConnect();
				PreparedStatement ps2 = con.prepareStatement("insert into event values(?,?,?,?,?,?,?)");
				ps2.setInt(1, id);
				ps2.setString(2, title);
				ps2.setString(3, date);
				ps2.setString(4, time);
				ps2.setString(5, venue);
				ps2.setString(6, description);
				ps2.setString(7, audience);
				
				int i = ps2.executeUpdate();
				if(i>0)
				{
					System.out.println("Event Added Successfully...!!");
					response.sendRedirect("AdminEvent.jsp");
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

