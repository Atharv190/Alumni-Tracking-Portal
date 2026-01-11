<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alumni Profile | Alumni Portal</title>
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
    
    .dashboard {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
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
    
    .header::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        transform: rotate(30deg);
    }
    
    .header h1 {
        font-family: 'Poppins', sans-serif;
        font-weight: 700;
        font-size: 36px;
        margin-bottom: 10px;
        position: relative;
        z-index: 1;
    }
    
    .header p {
        font-size: 18px;
        opacity: 0.9;
        position: relative;
        z-index: 1;
    }
    
    .profile-container {
        display: flex;
        flex-wrap: wrap;
        gap: 30px;
        margin-bottom: 40px;
    }
    
    .profile-card {
        background: white;
        border-radius: 16px;
        box-shadow: var(--card-shadow);
        padding: 30px;
        flex: 1;
        min-width: 300px;
        transition: var(--transition);
        position: relative;
        overflow: hidden;
    }
    
    .profile-card::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 5px;
        height: 100%;
        background: var(--primary-gradient);
    }
    
    .profile-card:hover {
        transform: translateY(-8px);
        box-shadow: var(--hover-shadow);
    }
    
    .profile-header {
        display: flex;
        align-items: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 1px solid var(--light-gray);
    }
    
    .profile-avatar {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: var(--primary-gradient);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 40px;
        font-weight: 600;
        margin-right: 25px;
        box-shadow: 0 5px 15px rgba(78, 84, 200, 0.3);
        border: 3px solid white;
    }
    
    .profile-info h2 {
        color: var(--dark);
        margin-bottom: 8px;
        font-family: 'Poppins', sans-serif;
        font-size: 24px;
    }
    
    .profile-info p {
        color: var(--gray);
        font-size: 16px;
    }
    
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 20px;
    }
    
    .info-item {
        margin-bottom: 20px;
        padding: 15px;
        background: rgba(248, 249, 250, 0.7);
        border-radius: 12px;
        transition: var(--transition);
    }
    
    .info-item:hover {
        background: rgba(78, 84, 200, 0.05);
        transform: translateX(5px);
    }
    
    .info-label {
        font-size: 13px;
        text-transform: uppercase;
        color: var(--gray);
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        font-weight: 600;
        letter-spacing: 0.5px;
    }
    
    .info-label i {
        margin-right: 10px;
        color: var(--primary);
        font-size: 16px;
        width: 20px;
        text-align: center;
    }
    
    .info-value {
        font-weight: 500;
        color: var(--dark);
        font-size: 17px;
        padding-left: 30px;
    }
    
    .social-section {
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid var(--light-gray);
    }
    
    .social-title {
        font-family: 'Poppins', sans-serif;
        font-size: 18px;
        margin-bottom: 15px;
        color: var(--dark);
        display: flex;
        align-items: center;
    }
    
    .social-title i {
        margin-right: 10px;
        color: var(--primary);
    }
    
    .social-badges {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .badge {
        background: #f0f5ff;
        color: var(--primary);
        padding: 12px 20px;
        border-radius: 50px;
        font-size: 15px;
        display: inline-flex;
        align-items: center;
        transition: var(--transition);
        box-shadow: 0 4px 10px rgba(78, 84, 200, 0.15);
        text-decoration: none;
    }
    
    .badge:hover {
        background: var(--primary);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 8px 15px rgba(78, 84, 200, 0.3);
    }
    
    .badge i {
        margin-right: 8px;
        font-size: 18px;
    }
    
    .action-buttons {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin-top: 40px;
    }
    
    .btn {
        padding: 14px 30px;
        border-radius: 50px;
        border: none;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    
    .btn-primary {
        background: var(--primary-gradient);
        color: white;
    }
    
    .btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(78, 84, 200, 0.4);
    }
    
    .btn-outline {
        background: transparent;
        color: var(--primary);
        border: 2px solid var(--primary);
    }
    
    .btn-outline:hover {
        background: var(--primary);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(78, 84, 200, 0.3);
    }
    
    .btn i {
        margin-right: 10px;
        font-size: 18px;
    }
    
    .footer {
        text-align: center;
        margin-top: 50px;
        padding: 20px;
        color: var(--gray);
        font-size: 14px;
    }
    
    @media (max-width: 768px) {
        .profile-container {
            flex-direction: column;
        }
        
        .profile-header {
            flex-direction: column;
            text-align: center;
        }
        
        .profile-avatar {
            margin-right: 0;
            margin-bottom: 20px;
        }
        
        .info-grid {
            grid-template-columns: 1fr;
        }
        
        .action-buttons {
            flex-direction: column;
            align-items: center;
        }
        
        .btn {
            width: 100%;
            max-width: 300px;
        }
        
        .header h1 {
            font-size: 28px;
        }
    }
</style>
</head>
<body>
	<div class="dashboard">
        <div class="header">
            <h1><i class="fas fa-user-graduate"></i> My Alumni Profile</h1>
            <p>View and manage your alumni information</p>
        </div>
        
        <div class="profile-container">
            <div class="profile-card">
            <%
            try
            {	
            String email = com.pogo.users.getEmail();
            Connection con = ConnectDb.getConnect();
            PreparedStatement ps = con.prepareStatement("select * from alumni where email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) 
            {
                String name = rs.getString(2);
                String initial = name.substring(0, 1).toUpperCase();
            %>
                <div class="profile-header">
                    <div class="profile-avatar"><%= initial %></div>
                    <div class="profile-info">
                        <h2><%= name %></h2>
                        <p>Alumni Member</p>
                    </div>
                </div>
                
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-id-card"></i> ID</div>
                        <div class="info-value"><%=rs.getInt(1)%></div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-envelope"></i> Email</div>
                        <div class="info-value"><%=rs.getString(3)%></div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-phone"></i> Contact No</div>
                        <div class="info-value"><%=rs.getString(5)%></div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-calendar-alt"></i> Batch</div>
                        <div class="info-value"><%=rs.getString(6)%></div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-code-branch"></i> Branch</div>
                        <div class="info-value"><%=rs.getString(7)%></div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-building"></i> Company</div>
                        <div class="info-value"><%=rs.getString(8)%></div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label"><i class="fas fa-map-marker-alt"></i> Location</div>
                        <div class="info-value"><%=rs.getString(9)%></div>
                    </div>
                </div>
                
                <% if(rs.getString(10) != null && !rs.getString(10).isEmpty()) { %>
                <div class="social-section">
                    <h3 class="social-title"><i class="fas fa-share-alt"></i> Social Connection</h3>
                    <div class="social-badges">
                        <a href="<%=rs.getString(10)%>" target="_blank" class="badge">
                            <i class="fab fa-linkedin"></i> LinkedIn Profile
                        </a>
                    </div>
                </div>
                <% } %>
            <%
            }
            %>
            </div>
        </div>
        
        <div class="action-buttons">
            <button class="btn btn-primary" onclick="window.location.href='AlumniDashboard.html'">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </button>
            <button class="btn btn-outline" onclick="window.print()">
                <i class="fas fa-print"></i> Print Profile
            </button>
        </div>
        
        <div class="footer">
            <p>&copy; 2023 Alumni Portal. All rights reserved.</p>
        </div>
        <%
            }
            catch(Exception e) 
            {
                e.printStackTrace();
                response.sendRedirect("error.html");
            }
        %>
    </div>
    
    <script>
        // Add subtle animations to page elements
        document.addEventListener('DOMContentLoaded', function() {
            const profileCard = document.querySelector('.profile-card');
            if (profileCard) {
                profileCard.style.opacity = '0';
                profileCard.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    profileCard.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    profileCard.style.opacity = '1';
                    profileCard.style.transform = 'translateY(0)';
                }, 300);
            }
            
            // Animate info items one by one
            const infoItems = document.querySelectorAll('.info-item');
            infoItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateX(-20px)';
                
                setTimeout(() => {
                    item.style.transition = 'opacity 0.5s ease, transform 0.5s ease, background 0.3s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateX(0)';
                }, 500 + (index * 100));
            });
        });
    </script>
</body>
</html>