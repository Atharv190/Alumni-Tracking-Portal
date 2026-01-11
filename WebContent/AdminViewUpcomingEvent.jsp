<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upcoming Events</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
    :root {
        --vibrant-blue: #4361ee;
        --electric-purple: #7209b7;
        --neon-pink: #f72585;
        --lime-green: #4cc9f0;
        --sunny-yellow: #ffbe0b;
        --deep-teal: #4895ef;
        --soft-orange: #f8961e;
        --dark-slate: #1a1a2e;
        --light-gray: #f8f9fa;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #f5f7fa 0%, #e2e8f0 100%);
        min-height: 100vh;
        padding: 20px;
        color: var(--dark-slate);
    }
    
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .header {
        text-align: center;
        margin-bottom: 40px;
        position: relative;
    }
    
    h2 {
        display: inline-block;
        font-size: 2.5rem;
        font-weight: 700;
        background: linear-gradient(90deg, var(--electric-purple), var(--neon-pink));
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        margin-bottom: 15px;
    }
    
    .header i {
        font-size: 2rem;
        margin-right: 10px;
        color: var(--electric-purple);
    }
    
    .subtitle {
        color: #666;
        font-size: 1.1rem;
        max-width: 600px;
        margin: 0 auto;
    }
    
    .events-table-container {
        background: white;
        border-radius: 15px;
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
        padding: 5px;
        margin-bottom: 40px;
        overflow: hidden;
    }
    
    .events-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }
    
    .events-table thead {
        background: linear-gradient(90deg, var(--vibrant-blue), var(--deep-teal));
    }
    
    .events-table th {
        padding: 18px 15px;
        text-align: center;
        font-weight: 600;
        color: white;
        letter-spacing: 0.5px;
        position: relative;
        font-size: 0.95rem;
    }
    
    .events-table th:first-child {
        border-top-left-radius: 10px;
    }
    
    .events-table th:last-child {
        border-top-right-radius: 10px;
    }
    
    .events-table td {
        padding: 16px 15px;
        text-align: center;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        font-size: 0.9rem;
    }
    
    .events-table tbody tr:nth-child(odd) {
        background-color: rgba(248, 249, 250, 0.5);
    }
    
    .events-table tbody tr:nth-child(even) {
        background-color: white;
    }
    
    .events-table tbody tr:hover {
        transform: translateX(5px);
        box-shadow: 5px 0 15px rgba(67, 97, 238, 0.1);
    }
    
    .events-table tbody tr:hover td {
        background: rgba(114, 9, 183, 0.03);
    }
    
    .event-title {
        font-weight: 600;
        color: var(--electric-purple);
    }
    
    .event-date {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        background: linear-gradient(90deg, var(--lime-green), var(--deep-teal));
        color: white;
        font-weight: 500;
        font-size: 0.8rem;
    }
    
    .event-time {
        font-weight: 500;
        color: var(--vibrant-blue);
    }
    
    .event-venue {
        font-weight: 500;
        color: var(--dark-slate);
    }
    
    .event-target {
        display: inline-block;
        padding: 4px 10px;
        border-radius: 4px;
        background-color: rgba(242, 201, 76, 0.2);
        color: #d4a017;
        font-size: 0.8rem;
        font-weight: 500;
    }
    
    .no-events {
        text-align: center;
        padding: 50px;
        color: #888;
        font-style: italic;
        background: white;
        border-radius: 10px;
    }
    
    .no-events i {
        font-size: 2rem;
        color: var(--lime-green);
        margin-bottom: 15px;
        display: block;
    }
    
    .error-message {
        text-align: center;
        padding: 30px;
        color: var(--neon-pink);
        font-weight: 500;
        background: white;
        border-radius: 10px;
    }
    
    .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 12px 28px;
        border-radius: 8px;
        font-weight: 600;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.3s ease;
        border: none;
        font-size: 1rem;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .btn-primary {
        background: linear-gradient(90deg, var(--electric-purple), var(--vibrant-blue));
        color: white;
    }
    
    .btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 15px rgba(114, 9, 183, 0.3);
    }
    
    .btn-primary i {
        margin-right: 8px;
    }
    
    .btn-back {
        display: block;
        margin: 40px auto 20px;
        text-align: center;
        max-width: 250px;
    }
    
    @media (max-width: 768px) {
        .container {
            padding: 10px;
        }
        
        .events-table-container {
            overflow-x: auto;
            border-radius: 10px;
        }
        
        .events-table {
            min-width: 700px;
        }
        
        h2 {
            font-size: 1.8rem;
        }
        
        .subtitle {
            font-size: 0.95rem;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2><i class="fas fa-calendar-alt"></i>Upcoming Events</h2>
            <p class="subtitle">Browse through our exciting upcoming events. Mark your calendars!</p>
        </div>

        <div class="events-table-container">
            <table class="events-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Event</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Venue</th>
                        <th>Details</th>
                        <th>Audience</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Connection con = ConnectDb.getConnect();
                            Statement stmt = con.createStatement();

                            // Only fetch upcoming events
                            String sql = "SELECT * FROM event WHERE date >= CURDATE() ORDER BY date ASC";
                            ResultSet rs = stmt.executeQuery(sql);

                            boolean hasEvents = false;
                            while(rs.next()) {
                                hasEvents = true;
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td class="event-title"><%= rs.getString("title") %></td>
                        <td><span class="event-date"><%= rs.getDate("date") %></span></td>
                        <td class="event-time"><%= rs.getString("time") %></td>
                        <td class="event-venue"><%= rs.getString("venue") %></td>
                        <td><%= rs.getString("descr") %></td>
                        <td><span class="event-target"><%= rs.getString("target") %></span></td>
                    </tr>
                    <%
                            }
                            if(!hasEvents) {
                    %>
                    <tr>
                        <td colspan="8">
                            <div class="no-events">
                                <i class="fas fa-calendar-plus"></i>
                                No upcoming events scheduled yet.<br>
                                Check back later!
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch(Exception e) {
                    %>
                    <tr>
                        <td colspan="8">
                            <div class="error-message">
                                <i class="fas fa-exclamation-triangle"></i><br><br>
                                Error loading events: <%= e.getMessage() %>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <a href="AdminDashboard.html" class="btn btn-primary btn-back">
            <i class="fas fa-arrow-left"></i> Back To Dashboard
        </a>
    </div>
</body>
</html>