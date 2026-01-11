<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Students | Admin Panel</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<style>
    :root {
        --primary: #4361ee;
        --primary-light: #e0e7ff;
        --primary-dark: #3a56d4;
        --secondary: #3f37c9;
        --success: #4cc9f0;
        --danger: #f72585;
        --danger-light: #fde8ef;
        --warning: #f8961e;
        --dark: #1e293b;
        --dark-light: #334155;
        --light: #f8fafc;
        --gray: #94a3b8;
        --gray-light: #e2e8f0;
        --radius: 12px;
        --radius-sm: 8px;
        --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }
    
    body {
        background: #f8fafc;
        color: var(--dark);
        line-height: 1.6;
    }
    
    .dashboard {
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem;
    }
    
    /* Header Styles */
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
        padding: 1.5rem;
        background: white;
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        animation: fadeInDown 0.6s ease-out;
    }
    
    .header h1 {
        color: var(--dark);
        font-size: 1.75rem;
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        margin: 0;
    }
    
    .header h1 i {
        color: var(--primary);
        font-size: 1.5rem;
    }
    
    /* Table Styles */
    .account-card {
        background: white;
        border-radius: var(--radius);
        box-shadow: var(--shadow-lg);
        overflow: hidden;
        animation: fadeInUp 0.8s ease-out;
        position: relative;
        margin-bottom: 2rem;
    }
    
    .account-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--warning) 0%, var(--danger) 100%);
    }
    
    .account-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .account-table thead {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
        position: sticky;
        top: 0;
    }
    
    .account-table th {
        padding: 1rem 1.5rem;
        text-align: left;
        font-weight: 500;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.5px;
        position: relative;
    }
    
    .account-table th:not(:last-child)::after {
        content: '';
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        height: 60%;
        width: 1px;
        background: rgba(255, 255, 255, 0.2);
    }
    
    .account-table td {
        padding: 1rem 1.5rem;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        vertical-align: middle;
        transition: var(--transition);
    }
    
    .account-table tbody tr:last-child td {
        border-bottom: none;
    }
    
    .account-table tbody tr {
        transition: var(--transition);
    }
    
    .account-table tbody tr:hover {
        background-color: rgba(67, 97, 238, 0.05);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }
    
    .account-number {
        font-weight: 600;
        color: var(--primary);
        font-family: 'Courier New', monospace;
    }
    
    .action-buttons {
        display: flex;
        gap: 0.75rem;
    }
    
    .btn {
        padding: 0.5rem 1rem;
        border-radius: var(--radius-sm);
        font-size: 0.875rem;
        font-weight: 500;
        cursor: pointer;
        border: none;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        text-decoration: none;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    .btn-sm {
        padding: 0.5rem 0.875rem;
        font-size: 0.75rem;
    }
    
    .btn-success {
        background-color: var(--success);
        color: white;
    }
    
    .btn-success:hover {
        background-color: #3ab5d8;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(76, 201, 240, 0.3);
    }
    
    .btn-view {
        background-color: var(--primary);
        color: white;
    }
    
    .btn-view:hover {
        background-color: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(67, 97, 238, 0.3);
    }
    
    .back-to-dashboard {
        margin-top: 1rem;
        padding: 0.875rem 1.75rem;
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
        border-radius: var(--radius);
        cursor: pointer;
        font-weight: 500;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        border: none;
        box-shadow: var(--shadow-lg);
        position: relative;
        overflow: hidden;
        text-decoration: none;
    }
    
    .back-to-dashboard::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
        transition: 0.5s;
    }
    
    .back-to-dashboard:hover::before {
        left: 100%;
    }
    
    .back-to-dashboard:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
    }
    
    .view-approved-link {
        display: inline-block;
        margin-top: 1rem;
        margin-left: 1rem;
        padding: 0.875rem 1.75rem;
        background: white;
        color: var(--primary);
        border-radius: var(--radius);
        font-weight: 500;
        transition: var(--transition);
        text-decoration: none;
        box-shadow: var(--shadow);
        border: 1px solid var(--gray-light);
    }
    
    .view-approved-link:hover {
        background: var(--primary-light);
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
    }
    
    /* Status badge */
    .status-badge {
        display: inline-block;
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .status-pending {
        background-color: #fff3bf;
        color: #e67700;
    }
    
    /* Toolbar styles */
    .toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
        background: white;
        padding: 1rem 1.5rem;
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        animation: fadeIn 0.6s ease-out;
    }
    
    /* Animations */
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes fadeInDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    /* No records message */
    .no-records {
        text-align: center;
        padding: 3rem;
        color: var(--gray);
    }
    
    .no-records i {
        font-size: 3rem;
        margin-bottom: 1rem;
        color: var(--gray-light);
    }
    
    .no-records h3 {
        font-weight: 500;
        margin-bottom: 0.5rem;
    }
    
    .no-records p {
        font-size: 0.875rem;
    }
    
    /* Responsive Design */
    @media (max-width: 1200px) {
        .dashboard {
            padding: 1.5rem;
        }
        
        .account-table {
            display: block;
            overflow-x: auto;
        }
    }
    
    @media (max-width: 768px) {
        .header {
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
            padding: 1.25rem;
        }
        
        .action-buttons {
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .back-to-dashboard, .view-approved-link {
            width: 100%;
            text-align: center;
            margin-left: 0;
            margin-top: 1rem;
        }
    }
</style>
</head>
<body>
    <div class="dashboard">
        <div class="header">
            <h1><i class="fas fa-users-cog"></i> Pending Student Approvals</h1>
            <div class="header-actions">
                <a href="AdminDashboard.html" class="btn btn-view">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </div>
        </div>
        
        <!-- Toolbar -->
        <div class="toolbar">
            <div class="status-badge status-pending">
                <i class="fas fa-clock"></i> Pending Approvals
            </div>
        </div>
        
        <!-- Main table -->
        <div class="account-card">
            <table class="account-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-id-card"></i> ID</th>
                        <th><i class="fas fa-user"></i> Name</th>
                        <th><i class="fas fa-envelope"></i> Email</th>
                        <th><i class="fas fa-code-branch"></i> Branch</th>
                        <th><i class="fas fa-calendar-alt"></i> Year</th>
                        <th><i class="fas fa-check-circle"></i> Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                boolean hasRecords = false;
                try {    
                    Connection con = ConnectDb.getConnect();
                    PreparedStatement ps = con.prepareStatement("select * from student where status=?");
                    ps.setString(1,"Pending");
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()) {
                        hasRecords = true;
                %>
                    <tr class="animate__animated animate__fadeIn">
                        <td class="account-number"><%=rs.getInt(1)%></td>
                        <td><%=rs.getString(2)%></td>
                        <td><%=rs.getString(3)%></td>
                        <td><%=rs.getString(5)%></td>
                        <td><%=rs.getString(6)%></td>
                        <td>
                            <a href="ApproveStudent.jsp?id=<%=rs.getInt(1)%>" class="btn btn-success btn-sm">
                                <i class="fas fa-check"></i> Approve
                            </a>
                        </td>
                    </tr>
                <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.html");
                }
                %>
                </tbody>
            </table>
            
            <% if(!hasRecords) { %>
            <div class="no-records">
                <i class="fas fa-user-graduate"></i>
                <h3>No Pending Approvals</h3>
                <p>There are currently no students waiting for approval.</p>
            </div>
            <% } %>
        </div>
        
        <div class="action-buttons">
            <a href="AdminDashboard.html" class="back-to-dashboard">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
            <a href="AdminViewStudent.jsp" class="view-approved-link">
                <i class="fas fa-eye"></i> View Approved Students
            </a>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        // Add animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('.account-table tbody tr');
            tableRows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.05}s`;
            });
        });
    </script>
</body>
</html>