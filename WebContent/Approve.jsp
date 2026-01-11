<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			String id = request.getParameter("id");
			Connection con = ConnectDb.getConnect();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM alumni WHERE id=?");
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				PreparedStatement ps1 = con.prepareStatement("UPDATE alumni SET status=? WHERE id=?");
				ps1.setString(1, "Approve");
				ps1.setString(2, id);
				int i = ps1.executeUpdate();

				if (i > 0) {
					response.sendRedirect("ApproveRegistrations.jsp");
				} else {
					response.sendRedirect("error.html");
				}
			} else {
				response.sendRedirect("error.html");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.html");
		}
	%>



</body>
</html>