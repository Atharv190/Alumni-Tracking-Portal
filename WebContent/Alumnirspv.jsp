<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>RSVP for Event</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Same styling as before */
        body { font-family: 'Poppins', sans-serif; background-color: #f5f7ff; color: #2b2d42; margin:0; padding:0; }
        .container { max-width:700px; margin:2rem auto; padding:2rem; }
        .card { background:white; padding:2rem; border-radius:12px; box-shadow:0 4px 20px rgba(0,0,0,0.08);}
        h2 { text-align:center; color:#4361ee; margin-bottom:1.5rem; }
        .form-group { margin-bottom:1.25rem; }
        label { display:block; margin-bottom:0.5rem; font-weight:500; }
        input, select { width:100%; padding:0.75rem; border:1px solid #e9ecef; border-radius:6px; font-size:1rem; }
        .btn { display:inline-block; background:#4361ee; color:white; padding:0.75rem 1.5rem; border:none; border-radius:6px; font-size:1rem; cursor:pointer; }
        .btn:hover { background:#3a0ca3; }
        .back-link { display:inline-block; margin-top:1rem; text-decoration:none; color:#3a0ca3; font-weight:500; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2><i class="fas fa-handshake"></i> RSVP for Event</h2>
            <form action="Alumnirspv" method="post">
                <!-- Name -->
                <div class="form-group">
                    <label for="alumniName">Your Name</label>
                    <input type="text" id="alumniName" name="alumniName" placeholder="Enter your name" required>
                </div>
                
                <!-- Email -->
                <div class="form-group">
                    <label for="email">Your Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                
                <!-- Event Dropdown -->
                <div class="form-group">
                    <label for="event">Select Event</label>
                    <select id="event" name="eventName" required>
                        <option value="">-- Select Event --</option>
                        <%
                            Connection con = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                con = ConnectDb.getConnect();
                                stmt = con.createStatement();
                                
                                // Robust query: ignore case and handle DATETIME
                                String query = "SELECT title FROM event " +
                                               "WHERE (LOWER(target)='alumni' OR LOWER(target)='both') " +
                                               "AND date >= NOW() " +
                                               "ORDER BY date ASC";
                                rs = stmt.executeQuery(query);
                                
                                boolean hasEvents = false;
                                while(rs.next()) {
                                    hasEvents = true;
                        %>
                                    <option value="<%= rs.getString("title") %>"><%= rs.getString("title") %></option>
                        <%
                                }
                                if(!hasEvents){
                                    out.println("<option disabled>No upcoming events available</option>");
                                }
                            } catch(Exception e) {
                                out.println("<option disabled>Error: "+e.getMessage()+"</option>");
                            } finally {
                                if(rs != null) try { rs.close(); } catch(Exception ex) {}
                                if(stmt != null) try { stmt.close(); } catch(Exception ex) {}
                                if(con != null) try { con.close(); } catch(Exception ex) {}
                            }
                        %>
                    </select>
                </div>
                
                <div style="text-align:center;">
                    <button type="submit" class="btn"><i class="fas fa-paper-plane"></i> Submit RSVP</button>
                </div>
            </form>
            <a href="AlumniDashboard.html" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
