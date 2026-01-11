package com.Atharv.Services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Atharv.dbcon.ConnectDb;
import com.mysql.jdbc.ResultSet;

/**
 * Servlet implementation class RSVPServlet
 */
public class RSVPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RSVPServlet() {
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
		  String eventIdStr = request.getParameter("event_id");

	        if (eventIdStr == null || eventIdStr.isEmpty()) {
	            response.getWriter().println("Missing event ID.");
	            return;
	        }

	        int eventId = Integer.parseInt(eventIdStr);

	        HttpSession session = request.getSession();
	        String email = (String) session.getAttribute("email");

	        if (email == null || email.isEmpty()) {
	            response.getWriter().println("Session expired or user not logged in.");
	            return;
	        }

	        try {
	            Connection con = ConnectDb.getConnect(); // Your DB utility class

	            // Check if already RSVPed
	            PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM event_rsvp WHERE event_id = ? AND alumni_email = ?");
	            checkStmt.setInt(1, eventId);
	            checkStmt.setString(2, email);
	            ResultSet rs = (ResultSet) checkStmt.executeQuery();

	            if (!rs.next()) {
	                PreparedStatement stmt = con.prepareStatement("INSERT INTO event_rsvp (event_id, alumni_email) VALUES (?, ?)");
	                stmt.setInt(1, eventId);
	                stmt.setString(2, email);
	                stmt.executeUpdate();
	                stmt.close();

	                response.sendRedirect("rsvp_success.jsp");
	            } else {
	                response.getWriter().println("You have already RSVPed for this event.");
	            }

	            rs.close();
	            checkStmt.close();
	            con.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().println("Error: " + e.getMessage());
	        }
	    }
}
