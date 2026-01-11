<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.Atharv.dbcon.ConnectDb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>All Events</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4776E6;
            --secondary: #8E54E9;
            --accent: #FF6B6B;
            --dark: #2D3748;
            --light: #F8F9FA;
            --success: #4CAF50;
            --card-bg: #ffffff;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
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
            margin: 30px 0;
            animation: fadeIn 1s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .header h2 {
            font-size: 36px;
            color: var(--primary);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .header p {
            color: #718096;
            font-size: 18px;
        }
        
        .events-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .event-card {
            background: var(--card-bg);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            animation: slideUp 0.5s ease;
            position: relative;
        }
        
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .event-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }
        
        .event-date {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            z-index: 2;
            box-shadow: 0 5px 15px rgba(71, 118, 230, 0.3);
        }
        
        .event-image {
            height: 180px;
            overflow: hidden;
            position: relative;
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .event-image i {
            font-size: 60px;
            color: rgba(255, 255, 255, 0.9);
        }
        
        .event-content {
            padding: 25px;
        }
        
        .event-title {
            font-size: 20px;
            margin-bottom: 15px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .event-title i {
            color: var(--primary);
        }
        
        .event-details {
            margin-bottom: 20px;
        }
        
        .event-detail {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            color: #718096;
        }
        
        .event-detail i {
            width: 20px;
            margin-right: 10px;
            color: var(--primary);
        }
        
        .event-description {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            font-size: 14px;
            line-height: 1.5;
            color: #5a67d8;
        }
        
        .back-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 15px 30px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin: 0 auto;
            box-shadow: 0 5px 15px rgba(71, 118, 230, 0.3);
            text-decoration: none;
            width: fit-content;
        }
        
        .back-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(71, 118, 230, 0.4);
        }
        
        .no-events {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            grid-column: 1 / -1;
        }
        
        .no-events i {
            font-size: 60px;
            color: #e2e8f0;
            margin-bottom: 20px;
        }
        
        .no-events h3 {
            color: #718096;
            margin-bottom: 10px;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .events-container {
                grid-template-columns: 1fr;
            }
            
            .header h2 {
                font-size: 28px;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 15px;
            }
            
            .event-content {
                padding: 20px;
            }
            
            .event-title {
                font-size: 18px;
            }
            
            .event-image {
                height: 150px;
            }
            
            .event-image i {
                font-size: 40px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2><i class="fas fa-calendar-alt"></i> All Events</h2>
            <p>Discover upcoming events tailored for students</p>
        </div>
        
        <div class="events-container">
            <%
                try {
                    Connection con = ConnectDb.getConnect();
                    PreparedStatement pstmt = con.prepareStatement("select * from event where target = ? OR target = ?");
                    pstmt.setString(1, "Students");  
                    pstmt.setString(2, "Both");

                    ResultSet rs = pstmt.executeQuery();
                    
                    if (!rs.isBeforeFirst()) {
                        // No events found
            %>
            <div class="no-events">
                <i class="fas fa-calendar-times"></i>
                <h3>No events available at the moment</h3>
                <p>Check back later for upcoming events!</p>
            </div>
            <%
                    } else {
                        while(rs.next()) {
                            String eventId = rs.getString("id");
                            String title = rs.getString("title");
                            java.sql.Date sqlDate = rs.getDate("date");
                            String time = rs.getString("time");
                            String venue = rs.getString("venue");
                            String description = rs.getString("descr");
                            
                            // Format date
                            String formattedDate = "";
                            if (sqlDate != null) {
                                formattedDate = new java.text.SimpleDateFormat("MMM dd, yyyy").format(sqlDate);
                            }
            %>
            <div class="event-card">
                <div class="event-date">
                    <i class="fas fa-calendar-day"></i> <%= formattedDate %>
                </div>
                <div class="event-image">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="event-content">
                    <h3 class="event-title">
                        <i class="fas fa-star"></i> <%= title %>
                    </h3>
                    <div class="event-details">
                        <div class="event-detail">
                            <i class="fas fa-clock"></i>
                            <span><%= time %></span>
                        </div>
                        <div class="event-detail">
                            <i class="fas fa-map-marker-alt"></i>
                            <span><%= venue %></span>
                        </div>
                    </div>
                    <div class="event-description">
                        <%= description %>
                    </div>
                </div>
            </div>
            <%
                        }
                    }
                    rs.close();
                    pstmt.close();
                    con.close();
                } catch(Exception e) {
            %>
            <div class="no-events">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>Error loading events</h3>
                <p>Please try again later</p>
            </div>
            <%
                }
            %>
        </div>
        
        <a href="StudentDashboard.html" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back To Dashboard
        </a>
    </div>

    <script>
        // Add staggered animation delay to event cards
        document.addEventListener('DOMContentLoaded', function() {
            const eventCards = document.querySelectorAll('.event-card');
            eventCards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });
        });
    </script>
</body>
</html>