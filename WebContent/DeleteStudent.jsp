<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Student</title>
</head>
<body>

<%
try{
    int id = Integer.parseInt(request.getParameter("id"));

    Connection con = ConnectDb.getConnect();
    PreparedStatement ps = con.prepareStatement(
        "DELETE FROM student WHERE id=?"
    );
    ps.setInt(1,id);

    int result = ps.executeUpdate();

    if(result>0){
        response.sendRedirect("AdminViewStudent.jsp");
    }else{
        response.sendRedirect("error.html");
    }
}catch(Exception e){
    e.printStackTrace();
    response.sendRedirect("error.html");
}
%>

</body>
</html>
