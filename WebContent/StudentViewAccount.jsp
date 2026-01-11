<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Profile</title>
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
        --sidebar-bg: linear-gradient(135deg, #1a237e, #283593);
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
        display: flex;
        justify-content: center;
        align-items: center;
    }
    
    .profile-container {
        width: 100%;
        max-width: 1000px;
        background: var(--card-bg);
        border-radius: 20px;
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        padding: 0;
    }
    
    .profile-header {
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        padding: 40px 30px 30px;
        text-align: center;
        position: relative;
    }
    
    .back-btn {
        position: absolute;
        left: 30px;
        top: 30px;
        background: rgba(255, 255, 255, 0.2);
        width: 45px;
        height: 45px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    
    .back-btn:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateX(-5px);
    }
    
    .profile-img {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        object-fit: cover;
        border: 5px solid rgba(255, 255, 255, 0.3);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        margin-bottom: 20px;
    }
    
    .profile-header h1 {
        font-size: 28px;
        margin-bottom: 5px;
    }
    
    .profile-header p {
        opacity: 0.9;
        font-size: 18px;
    }
    
    .profile-content {
        padding: 40px 30px;
    }
    
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }
    
    .info-card {
        background: white;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        padding: 25px;
        transition: all 0.3s ease;
    }
    
    .info-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }
    
    .card-header {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 15px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }
    
    .card-header i {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 18px;
        margin-right: 15px;
    }
    
    .card-header h2 {
        font-size: 20px;
        color: var(--dark);
    }
    
    .info-group {
        margin-bottom: 15px;
        display: flex;
    }
    
    .info-label {
        width: 120px;
        font-weight: 500;
        color: #718096;
    }
    
    .info-value {
        flex: 1;
        font-weight: 500;
    }
    
    .action-buttons {
        display: flex;
        gap: 15px;
        justify-content: center;
    }
    
    .action-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 15px 25px;
        background: white;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        color: var(--dark);
    }
    
    .action-btn:hover {
        border-color: var(--primary);
        color: var(--primary);
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(71, 118, 230, 0.1);
    }
    
    .action-btn.primary {
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        border: none;
    }
    
    .action-btn.primary:hover {
        box-shadow: 0 5px 15px rgba(71, 118, 230, 0.3);
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
        .profile-header {
            padding: 30px 20px 25px;
        }
        
        .profile-content {
            padding: 30px 20px;
        }
        
        .info-grid {
            grid-template-columns: 1fr;
        }
        
        .action-buttons {
            flex-direction: column;
        }
    }
    
    @media (max-width: 480px) {
        body {
            padding: 10px;
        }
        
        .profile-header h1 {
            font-size: 24px;
        }
        
        .profile-header p {
            font-size: 16px;
        }
        
        .info-group {
            flex-direction: column;
            margin-bottom: 20px;
        }
        
        .info-label {
            width: 100%;
            margin-bottom: 5px;
        }
    }
</style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-header">
            <a href="StudentDashboard.html" class="back-btn">
                <i class="fas fa-arrow-left"></i>
            </a>
            
            <%
            try {
                String email = com.pogo.users.getEmail();
                Connection con = ConnectDb.getConnect();
                PreparedStatement ps = con.prepareStatement("select * from student where email=?");
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next()) {
                    String studentName = rs.getString(2);
                    String branch = rs.getString(5);
            %>
            
            <img src="https://ui-avatars.com/api/?name=<%= studentName %>&background=4776E6&color=fff&size=120" 
                 alt="Profile" class="profile-img">
            <h1><%= studentName %></h1>
            <p><%= branch %> Student</p>
        </div>
        
        <div class="profile-content">
            <div class="info-grid">
                <div class="info-card">
                    <div class="card-header">
                        <i class="fas fa-id-card"></i>
                        <h2>Basic Information</h2>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Student ID:</div>
                        <div class="info-value"><%= rs.getInt(1) %></div>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Full Name:</div>
                        <div class="info-value"><%= studentName %></div>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Email:</div>
                        <div class="info-value"><%= rs.getString(3) %></div>
                    </div>
                </div>
                
                <div class="info-card">
                    <div class="card-header">
                        <i class="fas fa-graduation-cap"></i>
                        <h2>Academic Details</h2>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Branch:</div>
                        <div class="info-value"><%= branch %></div>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Year:</div>
                        <div class="info-value"><%= rs.getString(6) %></div>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Status:</div>
                        <div class="info-value">Active</div>
                    </div>
                </div>
            </div>
            
            <div class="action-buttons">
                <a href="StudentViewAccount.jsp" class="action-btn">
                    <i class="fas fa-sync-alt"></i> Refresh
                </a>
                <a href="StudentDashboard.html" class="action-btn primary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
        
        <%
                }
            } catch(Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.html");
            }
        %>
    </div>
</body>
</html>