<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Job Opportunities</title>
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
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    
    .container {
        width: 100%;
        max-width: 1200px;
        background: var(--card-bg);
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        padding: 30px;
        margin-top: 20px;
    }
    
    .header {
        text-align: center;
        margin-bottom: 30px;
        animation: fadeIn 1s ease;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .header h2 {
        font-size: 32px;
        color: var(--primary);
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 15px;
    }
    
    .header p {
        color: #718096;
        font-size: 16px;
    }
    
    .table-container {
        overflow-x: auto;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
        animation: slideUp 0.5s ease;
    }
    
    @keyframes slideUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .jobs-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
    }
    
    .jobs-table th {
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        padding: 18px 15px;
        text-align: left;
        font-weight: 500;
        font-size: 16px;
        position: sticky;
        top: 0;
    }
    
    .jobs-table th i {
        margin-right: 8px;
    }
    
    .jobs-table td {
        padding: 16px 15px;
        border-bottom: 1px solid #e2e8f0;
        transition: all 0.3s ease;
    }
    
    .jobs-table tr {
        transition: all 0.3s ease;
    }
    
    .jobs-table tr:last-child td {
        border-bottom: none;
    }
    
    .jobs-table tr:hover {
        background: rgba(71, 118, 230, 0.03);
    }
    
    .jobs-table tr:hover td {
        transform: translateX(5px);
    }
    
    .job-id {
        font-weight: 600;
        color: var(--primary);
    }
    
    .job-title {
        font-weight: 500;
        color: var(--dark);
    }
    
    .company-name {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .company-icon {
        width: 35px;
        height: 35px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: 600;
        font-size: 14px;
    }
    
    .location {
        display: flex;
        align-items: center;
        gap: 8px;
        color: #64748b;
    }
    
    .location i {
        color: var(--accent);
    }
    
    .description {
        color: #64748b;
        font-size: 14px;
        max-width: 300px;
        line-height: 1.4;
    }
    
    .apply-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 18px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.3s ease;
    }
    
    .apply-link:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(71, 118, 230, 0.3);
        gap: 12px;
    }
    
    .back-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 14px 28px;
        background: white;
        color: var(--primary);
        border: 2px solid var(--primary);
        border-radius: 8px;
        font-size: 16px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        width: fit-content;
        margin: 0 auto;
    }
    
    .back-btn:hover {
        background: var(--primary);
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(71, 118, 230, 0.2);
    }
    
    .no-jobs {
        text-align: center;
        padding: 40px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }
    
    .no-jobs i {
        font-size: 60px;
        color: #e2e8f0;
        margin-bottom: 20px;
    }
    
    .no-jobs h3 {
        color: #718096;
        margin-bottom: 10px;
    }
    
    /* Responsive Design */
    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }
        
        .header h2 {
            font-size: 26px;
        }
        
        .jobs-table {
            font-size: 14px;
        }
        
        .jobs-table th, 
        .jobs-table td {
            padding: 12px 10px;
        }
        
        .company-icon {
            width: 30px;
            height: 30px;
            font-size: 12px;
        }
    }
    
    @media (max-width: 480px) {
        body {
            padding: 10px;
        }
        
        .container {
            border-radius: 10px;
            padding: 15px;
        }
        
        .header h2 {
            font-size: 22px;
        }
        
        .jobs-table th, 
        .jobs-table td {
            padding: 10px 8px;
            font-size: 13px;
        }
        
        .apply-link {
            padding: 8px 12px;
            font-size: 12px;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2><i class="fas fa-briefcase"></i> Job Opportunities</h2>
            <p>Find your next career opportunity</p>
        </div>
        
        <div class="table-container">
            <%
                try {
                    Connection con = ConnectDb.getConnect();
                    PreparedStatement ps = con.prepareStatement("select * from job where target = ? OR target = ?");
                    ps.setString(1, "Students");  
                    ps.setString(2, "Both");
            
                    ResultSet rs = ps.executeQuery();
                    
                    if (!rs.isBeforeFirst()) {
                        // No jobs found
            %>
            <div class="no-jobs">
                <i class="fas fa-briefcase"></i>
                <h3>No job opportunities available at the moment</h3>
                <p>Check back later for new job postings!</p>
            </div>
            <%
                    } else {
            %>
            <table class="jobs-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-laptop-code"></i> Job Title</th>
                        <th><i class="fas fa-building"></i> Company</th>
                        <th><i class="fas fa-map-marker-alt"></i> Location</th>
                        <th><i class="fas fa-align-left"></i> Description</th>
                        <th><i class="fas fa-paper-plane"></i> Apply</th>
                    </tr>
                </thead>
                <tbody>
            <%
                        while (rs.next()) {
                            String jobId = rs.getString("id");
                            String jobTitle = rs.getString("title");
                            String companyName = rs.getString("name");
                            String location = rs.getString("location");
                            String description = rs.getString("descr");
                            String applyLink = rs.getString("link");
                            
                            // Get first letter of company for icon
                            String companyInitial = companyName.substring(0, 1).toUpperCase();
            %>
                    <tr>
                        <td class="job-id">#<%= jobId %></td>
                        <td class="job-title"><%= jobTitle %></td>
                        <td>
                            <div class="company-name">
                                <div class="company-icon"><%= companyInitial %></div>
                                <%= companyName %>
                            </div>
                        </td>
                        <td>
                            <div class="location">
                                <i class="fas fa-map-marker-alt"></i>
                                <%= location %>
                            </div>
                        </td>
                        <td class="description"><%= description %></td>
                        <td>
                            <a href="<%= applyLink %>" target="_blank" class="apply-link">
                                <i class="fas fa-paper-plane"></i> Apply
                            </a>
                        </td>
                    </tr>
            <%
                        }
            %>
                </tbody>
            </table>
            <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
            %>
            <div class="no-jobs">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>Error loading job opportunities</h3>
                <p>Please try again later</p>
            </div>
            <%
                }
            %>
        </div>
        
        <a href="StudentDashboard.html" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <script>
        // Add animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('.jobs-table tr');
            tableRows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.05}s`;
            });
        });
    </script>
</body>
</html>