package com.Atharv.Services;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Atharv.dbcon.ConnectDb;
import com.mysql.jdbc.Connection;
import com.pogo.users;

/**
 * Servlet implementation class Alumnirspv
 */
public class Alumnirspv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Alumnirspv() {
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
		    // Get form values
		    String alumniName = request.getParameter("alumniName");
		    String eventName  = request.getParameter("eventName");

		    // ✅ Get email directly from form (manual input)
		    String email = request.getParameter("email");

		    if (email == null || email.trim().isEmpty()) {
		        response.sendRedirect("RsvpForm.jsp?msg=Please enter your email");
		        return;
		    }

		    // Connect to DB
		    Connection con = (Connection) ConnectDb.getConnect();

		    // Insert RSVP record
		    PreparedStatement ps = con.prepareStatement(
		        "INSERT INTO rsvp (name, email, event_name) VALUES (?, ?, ?)"
		    );
		    ps.setString(1, alumniName);
		    ps.setString(2, email);
		    ps.setString(3, eventName);

		    int i = ps.executeUpdate();

		    if (i > 0) {
		        System.out.println("RSVP Submitted Successfully...!!");
		        response.sendRedirect("AlumniDashboard.html");
		    } else {
		        response.sendRedirect("error.html");
		    }

		    ps.close();
		    con.close();

		} catch (Exception e) {
		    e.printStackTrace();
		    response.sendRedirect("error.html");
		}
	}
}