<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Students | Admin Panel</title>
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
        background: linear-gradient(90deg, var(--primary) 0%, var(--success) 100%);
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
    
    /* Search bar styles */
    .search-container {
        margin-bottom: 1.5rem;
        background: white;
        padding: 1rem 1.5rem;
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        animation: fadeIn 0.6s ease-out;
    }
    
    .search-box {
        position: relative;
        max-width: 400px;
    }
    
    .search-box input {
        width: 100%;
        padding: 0.75rem 1rem 0.75rem 2.5rem;
        border-radius: var(--radius);
        border: 1px solid var(--gray-light);
        background-color: white;
        font-size: 0.875rem;
        transition: var(--transition);
    }
    
    .search-box input:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
    }
    
    .search-box i {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: var(--gray);
    }
    
    /* No records message */
    .no-records {
        text-align: center;
        padding: 3rem;
        color: var(--gray);
        display: none;
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
    
    /* Database empty message */
    .db-empty {
        text-align: center;
        padding: 3rem;
        color: var(--gray);
    }
    
    .db-empty i {
        font-size: 3rem;
        margin-bottom: 1rem;
        color: var(--gray-light);
    }
    
    .db-empty h3 {
        font-weight: 500;
        margin-bottom: 0.5rem;
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
        
        .search-box {
            max-width: 100%;
        }
    }
</style>
</head>
<body>
    <div class="dashboard">
        <div class="header">
            <h1><i class="fas fa-user-graduate"></i> All Students</h1>
            <div class="header-actions">
                <a href="AdminDashboard.html" class="back-to-dashboard">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </div>
        </div>
        
        <!-- Search bar -->
        <div class="search-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search students by name, email, or branch...">
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
                        <th><i class="fas fa-calendar-alt"></i>Delete</th>
                    </tr>
                </thead>
                <tbody id="studentsTableBody">
                <%
                    boolean hasStudents = false;
                    try {    
                        Connection con = ConnectDb.getConnect();
                        PreparedStatement ps = con.prepareStatement("SELECT * FROM student");
                        ResultSet rs = ps.executeQuery();
                        while(rs.next()) {
                            hasStudents = true;
                %>
                    <tr>
                        <td class="account-number"><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("branch") %></td>
                        <td><%= rs.getString("year") %></td>
                        <td>
        <a href="DeleteStudent.jsp?id=<%=rs.getInt("id")%>"
           class="delete-btn"
           onclick="return confirm('Are you sure you want to delete this student?');">
           <i class="fas fa-trash"></i> Delete
        </a>
    </td>
                    </tr>
                <%
                        }
                        con.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                %>
                    <tr>
                        <td colspan="5" style="color: var(--danger); text-align: center;">
                            <i class="fas fa-exclamation-circle"></i> Error loading students
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            
            <!-- No search results message -->
            <div class="no-records" id="noResultsMessage">
                <i class="fas fa-search"></i>
                <h3>No Students Found</h3>
                <p>Your search did not match any student records.</p>
            </div>
            
            <!-- Empty database message -->
            <% if(!hasStudents) { %>
            <div class="db-empty">
                <i class="fas fa-user-graduate"></i>
                <h3>No Student Records</h3>
                <p>There are currently no students in the database.</p>
            </div>
            <% } %>
        </div>
        
        <button class="back-to-dashboard" onclick="window.location.href='AdminDashboard.html'">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </button>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // Search functionality
            $('#searchInput').on('keyup', function() {
                const value = $(this).val().toLowerCase();
                let visibleRows = 0;
                
                $('#studentsTableBody tr').each(function() {
                    const rowText = $(this).text().toLowerCase();
                    const isVisible = rowText.indexOf(value) > -1;
                    $(this).toggle(isVisible);
                    if (isVisible) visibleRows++;
                });
                
                // Show/hide no results message
                if (visibleRows === 0 && value !== '') {
                    $('#noResultsMessage').show();
                } else {
                    $('#noResultsMessage').hide();
                }
            });
            
            // Add animation to table rows
            const tableRows = document.querySelectorAll('#studentsTableBody tr');
            tableRows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.05}s`;
            });
        });
    </script>
</body>
</html>