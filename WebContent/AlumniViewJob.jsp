<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Job Opportunities | Alumni Portal</title>
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
        --success: #28a745;
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
        max-width: 1400px;
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
    
    .jobs-container {
        background: white;
        border-radius: 16px;
        box-shadow: var(--card-shadow);
        padding: 30px;
        margin-bottom: 40px;
        overflow: hidden;
    }
    
    .jobs-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
    }
    
    .jobs-table th {
        background: var(--primary-gradient);
        color: white;
        padding: 15px;
        text-align: left;
        font-weight: 600;
        font-family: 'Poppins', sans-serif;
    }
    
    .jobs-table th:first-child {
        border-top-left-radius: 12px;
    }
    
    .jobs-table th:last-child {
        border-top-right-radius: 12px;
    }
    
    .jobs-table td {
        padding: 15px;
        border-bottom: 1px solid var(--light-gray);
        vertical-align: top;
    }
    
    .jobs-table tr:last-child td {
        border-bottom: none;
    }
    
    .jobs-table tr:nth-child(even) {
        background-color: rgba(248, 249, 250, 0.5);
    }
    
    .jobs-table tr:hover {
        background-color: rgba(78, 84, 200, 0.05);
        transition: var(--transition);
    }
    
    .job-title {
        font-weight: 600;
        color: var(--primary);
        font-family: 'Poppins', sans-serif;
    }
    
    .company-name {
        font-weight: 500;
        color: var(--dark);
    }
    
    .job-location {
        color: var(--gray);
        font-size: 0.9rem;
    }
    
    .job-description {
        max-width: 300px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
    }
    
    .apply-btn {
        background: var(--success);
        color: white;
        padding: 8px 15px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 500;
        display: inline-block;
        transition: var(--transition);
        text-align: center;
    }
    
    .apply-btn:hover {
        background: #218838;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        color: white;
    }
    
    .target-badge {
        padding: 5px 10px;
        border-radius: 50px;
        font-size: 0.8rem;
        font-weight: 500;
    }
    
    .target-alumni {
        background: rgba(78, 84, 200, 0.1);
        color: var(--primary);
    }
    
    .target-both {
        background: rgba(255, 126, 95, 0.1);
        color: var(--secondary);
    }
    
    .no-jobs {
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
        text-decoration: none;
    }
    
    .btn-back:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(78, 84, 200, 0.4);
        color: white;
    }
    
    .btn-back i {
        margin-right: 8px;
    }
    
    .action-buttons {
        display: flex;
        justify-content: center;
        margin-top: 30px;
    }
    
    @media (max-width: 992px) {
        .jobs-container {
            overflow-x: auto;
        }
        
        .jobs-table {
            min-width: 900px;
        }
        
        .header h1 {
            font-size: 28px;
        }
        
        .header p {
            font-size: 16px;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-briefcase"></i> Job Opportunities</h1>
            <p>Explore career opportunities from our partner companies</p>
        </div>
        
        <div class="jobs-container">
            <%
                try {
                    Connection con = ConnectDb.getConnect();
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM job");
                    ResultSet rs = ps.executeQuery();
                    boolean hasJobs = false;
            %>
            <table class="jobs-table">
                <thead>
                    <tr>
                        <th>Job Title</th>
                        <th>Company</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>Apply</th>
                        <th>Audience</th>
                    </tr>
                </thead>
                <tbody>
            <%
                    while (rs.next()) {
                        hasJobs = true;
                        String targetClass = "target-" + rs.getString("target").toLowerCase();
            %>
                    <tr>
                        <td><span class="job-title"><%=rs.getString("title")%></span></td>
                        <td><span class="company-name"><%=rs.getString("name")%></span></td>
                        <td><span class="job-location"><i class="fas fa-map-marker-alt"></i> <%=rs.getString("location")%></span></td>
                        <td><div class="job-description"><%=rs.getString("descr")%></div></td>
                        <td>
                            <a href="<%=rs.getString("link")%>" target="_blank" class="apply-btn">
                                <i class="fas fa-external-link-alt"></i> Apply
                            </a>
                        </td>
                        <td>
                            <span class="target-badge <%= targetClass %>">
                                <%=rs.getString("target")%>
                            </span>
                        </td>
                    </tr>
            <%
                    }
                    
                    if(!hasJobs) {
            %>
                    <tr>
                        <td colspan="6" class="no-jobs">
                            <i class="fas fa-briefcase fa-2x mb-3"></i>
                            <h4>No job opportunities available</h4>
                            <p>Check back later for new job postings</p>
                        </td>
                    </tr>
            <%
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
            %>
                    <tr>
                        <td colspan="6" class="error-message">
                            <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                            <h4>Error loading job opportunities</h4>
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
            <a href="AlumniDashboard.html" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>