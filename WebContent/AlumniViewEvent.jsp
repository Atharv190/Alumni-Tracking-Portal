  <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.Atharv.dbcon.ConnectDb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Upcoming Events | Alumni Portal</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4e54c8;
            --primary-gradient: linear-gradient(to right, #4e54c8, #8f94fb);
            --secondary: #ff7e5f;
            --light: #f8f9fa;
            --dark: #2d3436;
            --gray: #636e72;
            --light-gray: #dfe6e9;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            --hover-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Open Sans', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: var(--dark);
            line-height: 1.6;
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px 0;
            background: var(--primary-gradient);
            border-radius: 15px;
            color: white;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
        }
        
        .header h1 {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 36px;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 18px;
            opacity: 0.9;
        }
        
        .events-container {
            background: white;
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            padding: 30px;
            margin-bottom: 40px;
        }
        
        .events-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .events-table th {
            background: var(--primary-gradient);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
        }
        
        .events-table th:first-child {
            border-top-left-radius: 12px;
        }
        
        .events-table th:last-child {
            border-top-right-radius: 12px;
        }
        
        .events-table td {
            padding: 15px;
            border-bottom: 1px solid var(--light-gray);
            vertical-align: top;
        }
        
        .events-table tr:last-child td {
            border-bottom: none;
        }
        
        .events-table tr:nth-child(even) {
            background-color: rgba(248, 249, 250, 0.5);
        }
        
        .events-table tr:hover {
            background-color: rgba(78, 84, 200, 0.05);
            transition: var(--transition);
        }
        
        .event-title {
            font-weight: 600;
            color: var(--primary);
            font-family: 'Poppins', sans-serif;
        }
        
        .event-date {
            font-weight: 600;
            color: var(--secondary);
        }
        
        .no-events {
            text-align: center;
            padding: 40px;
            color: var(--gray);
            font-style: italic;
        }
        
        .error-message {
            text-align: center;
            padding: 40px;
            color: #dc3545;
            font-weight: 500;
        }
        
        .btn-back {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(78, 84, 200, 0.4);
        }
        
        .btn-back i {
            margin-right: 8px;
        }
        
        .action-buttons {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        @media (max-width: 768px) {
            .events-table {
                display: block;
                overflow-x: auto;
            }
            
            .header h1 {
                font-size: 28px;
            }
            
            .events-container {
                padding: 15px;
            }
            
            .events-table th, 
            .events-table td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-calendar-alt"></i> Upcoming Events</h1>
            <p>Discover networking events, reunions, and workshops</p>
        </div>
        
        <div class="events-container">
            <%
                try {
                    Connection con = ConnectDb.getConnect();
                    PreparedStatement pstmt = con.prepareStatement(
                        "SELECT * FROM event WHERE (target = ? OR target = ?) AND date >= CURDATE() ORDER BY date ASC"
                    );
                    pstmt.setString(1, "Alumni");  
                    pstmt.setString(2, "Both");

                    ResultSet rs = pstmt.executeQuery();
                    boolean hasEvents = false;
            %>
            <table class="events-table">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Venue</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
            <%
                    while(rs.next()) {
                        hasEvents = true;
            %>
                    <tr>
                        <td><span class="event-title"><%= rs.getString("title") %></span></td>
                        <td><span class="event-date"><%= rs.getDate("date") %></span></td>
                        <td><%= rs.getString("time") %></td>
                        <td><%= rs.getString("venue") %></td>
                        <td><%= rs.getString("descr") %></td>
                    </tr>
            <%
                    }
                    
                    if(!hasEvents){
            %>
                    <tr>
                        <td colspan="5" class="no-events">
                            <i class="fas fa-calendar-times fa-2x mb-3"></i>
                            <h4>No upcoming events found</h4>
                            <p>Check back later for new events</p>
                        </td>
                    </tr>
            <%
                    }
                    rs.close();
                    pstmt.close();
                    con.close();
                } catch(Exception e) {
            %>
                    <tr>
                        <td colspan="5" class="error-message">
                            <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                            <h4>Error loading events</h4>
                            <p><%= e.getMessage() %></p>
                        </td>
                    </tr>
            <%
                }
            %>
                </tbody>
            </table>
        </div>
        
        <div class="action-buttons">
            <button class="btn-back" onclick="window.location.href='AlumniDashboard.html'">
                <i class="fas fa-arrow-left"></i> Back To Dashboard
            </button>
        </div>
    </div>
</body>
</html>