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
 * Servlet implementation class AlumniJobs
 */
public class AlumniJobs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlumniJobs() {
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
		
		try {
			int id=0;
	        String title = request.getParameter("title");
	        String company = request.getParameter("company");
	        String location = request.getParameter("location");
	        String description = request.getParameter("description");
	        String applyLink = request.getParameter("applyLink");
	        String targetAudience = request.getParameter("targetAudience");

	        Connection con = ConnectDb.getConnect();

	        PreparedStatement ps2 = con.prepareStatement("insert into job values (?,?, ?, ?, ?, ?, ?)");
	        ps2.setInt(1, id);
	        ps2.setString(2, title);
	        ps2.setString(3, company);
	        ps2.setString(4, location);
	        ps2.setString(5, description);
	        ps2.setString(6, applyLink);
	        ps2.setString(7, targetAudience);

	        int i = ps2.executeUpdate();
	        if (i > 0) {
	            System.out.println("Job added successfully!");
	            response.sendRedirect("AlumniViewJob.jsp");
	        } else {
	            response.sendRedirect("error.html");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("error.html");
	    }
	}

}
