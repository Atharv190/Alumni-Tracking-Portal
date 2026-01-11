<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alumni Approval Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary-color: #4361ee;
        --secondary-color: #3f37c9;
        --success-color: #4cc9f0;
        --danger-color: #f72585;
        --light-color: #f8f9fa;
        --dark-color: #212529;
        --gray-color: #6c757d;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }
    
    body {
        background-color: #f5f7fa;
        color: var(--dark-color);
        line-height: 1.6;
    }
    
    .dashboard-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding-bottom: 15px;
        border-bottom: 1px solid #e0e0e0;
    }
    
    .header h1 {
        color: var(--primary-color);
        font-size: 28px;
        font-weight: 600;
    }
    
    .stats-card {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
    }
    
    .stat-item {
        text-align: center;
        padding: 15px;
        border-radius: 8px;
        background: linear-gradient(135deg, #f5f7fa 0%, #e4e8eb 100%);
    }
    
    .stat-number {
        font-size: 28px;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 5px;
    }
    
    .stat-label {
        font-size: 14px;
        color: var(--gray-color);
    }
    
    .account-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        overflow: hidden;
    }
    
    .account-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .account-table thead {
        background-color: var(--primary-color);
        color: white;
    }
    
    .account-table th {
        padding: 15px;
        text-align: left;
        font-weight: 500;
        text-transform: uppercase;
        font-size: 13px;
        letter-spacing: 0.5px;
    }
    
    .account-table td {
        padding: 12px 15px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }
    
    .account-table tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    .account-number {
        font-weight: 600;
        color: var(--primary-color);
    }
    
    .action-buttons {
        display: flex;
        gap: 10px;
    }
    
    .btn {
        padding: 8px 15px;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 500;
        cursor: pointer;
        border: none;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }
    
    .btn-approve {
        background-color: var(--success-color);
        color: white;
    }
    
    .btn-approve:hover {
        background-color: #3aa8d8;
    }
    
    .btn-reject {
        background-color: var(--danger-color);
        color: white;
    }
    
    .btn-reject:hover {
        background-color: #e5177e;
    }
    
    .btn-view {
        background-color: var(--primary-color);
        color: white;
    }
    
    .btn-view:hover {
        background-color: var(--secondary-color);
    }
    
    .back-to-dashboard {
        margin-top: 30px;
        padding: 10px 20px;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: 500;
        transition: background-color 0.3s;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    
    .back-to-dashboard:hover {
        background-color: var(--secondary-color);
    }
    
    .no-pending {
        text-align: center;
        padding: 40px;
        color: var(--gray-color);
    }
    
    .status-badge {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .status-pending {
        background-color: #fff3cd;
        color: #856404;
    }
    
    @media (max-width: 768px) {
        .account-table {
            display: block;
            overflow-x: auto;
        }
        
        .stats-grid {
            grid-template-columns: 1fr 1fr;
        }
    }
</style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1><i class="fas fa-user-check"></i> Alumni Account Approvals</h1>
            <div class="header-actions">
                <button class="btn btn-view" onclick="window.location.href='AdminDashboard.html'">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </button>
            </div>
        </div>
        
        <div class="stats-card">
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number" id="pending-count">0</div>
                    <div class="stat-label">Pending Approvals</div>
                </div>
                
            </div>
        </div>
        
        <div class="account-card">
            <table class="account-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-id-card"></i> ID</th>
                        <th><i class="fas fa-user"></i> Alumni</th>
                        <th><i class="fas fa-envelope"></i> Email</th>
                        <th><i class="fas fa-calendar-alt"></i> Batch</th>
                        <th><i class="fas fa-graduation-cap"></i> Branch</th>
                        <th><i class="fas fa-briefcase"></i> Company</th>
                        <th><i class="fas fa-briefcase"></i> Location</th>
                        <th><i class="fas fa-cog"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int pendingCount = 0;
                        try {
                            Connection con = ConnectDb.getConnect();
                            // Count pending approvals
                            PreparedStatement countPs = con.prepareStatement("SELECT COUNT(*) FROM alumni WHERE status=?");
                            countPs.setString(1,"Pending");
                            ResultSet countRs = countPs.executeQuery();
                            if(countRs.next()) {
                                pendingCount = countRs.getInt(1);
                            }
                            
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM alumni WHERE status=? ORDER BY id DESC");
                            ps.setString(1,"Pending");
                            ResultSet rs = ps.executeQuery();
                            
                            if(!rs.isBeforeFirst()) {
                    %>
                                <tr>
                                    <td colspan="7" class="no-pending">
                                        <i class="fas fa-check-circle" style="font-size: 24px; color: #28a745; margin-bottom: 10px;"></i>
                                        <h3>No Pending Approvals</h3>
                                        <p>All alumni accounts have been processed.</p>
                                    </td>
                                </tr>
                    <%
                            } else {
                                while (rs.next()) {
                    %>
                                    <tr>
                                        <td class="account-number">#<%=rs.getInt(1)%></td>
                                        <td>
                                            <strong><%=rs.getString(2)%></strong>
                                            <div class="status-badge status-pending">
                                                <i class="fas fa-clock"></i> Pending
                                            </div>
                                        </td>
                                        <td><%=rs.getString(3)%></td>
                                        <td><%=rs.getString(6)%></td>
                                        <td><%=rs.getString(7)%></td>
                                        <td><%=rs.getString(8) != null ? rs.getString(8) : "N/A"%></td>
                                        <td><%=rs.getString(9)%></td>
                                        <td class="action-buttons">
                                            <a href="Approve.jsp?id=<%=rs.getInt(1)%>" class="btn btn-approve">
                                                <i class="fas fa-check"></i> Approve
                                            </a>
                                            
                                        </td>
                                    </tr>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            response.sendRedirect("error.html");
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <button class="back-to-dashboard" onclick="window.location.href='AdminDashboard.html'">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </button>
    </div>

    <script>
        // Update the pending count
        document.getElementById('pending-count').textContent = '<%= pendingCount %>';
        
        // You would typically fetch these values from the server in a real application
        // For demo purposes, we're setting static values
        document.getElementById('approved-count').textContent = '5';
        document.getElementById('total-count').textContent = '142';
        
        // Add confirmation for reject action
        document.querySelectorAll('.btn-reject').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if(!confirm('Are you sure you want to reject this alumni account?')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
</html>