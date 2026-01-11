<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Alumni</title>
</head>
<body>

<%
try {
    int id = Integer.parseInt(request.getParameter("id"));

    Connection con = ConnectDb.getConnect();
    PreparedStatement ps = con.prepareStatement(
        "DELETE FROM alumni WHERE id = ?"
    );
    ps.setInt(1, id);

    int i = ps.executeUpdate();

    if (i > 0) {
        response.sendRedirect("AdminAlumni.jsp");
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
