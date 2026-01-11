<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alumni Directory</title>
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
    
    .dashboard {
        width: 100%;
        max-width: 1400px;
        margin: 30px auto;
        background: var(--card-bg);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.1);
        position: relative;
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
    
    .header h1 {
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
    
    .search-container {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
        animation: slideUp 0.5s ease;
    }
    
    @keyframes slideUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .search-container h3 {
        margin-bottom: 20px;
        color: var(--dark);
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .search-container h3 i {
        color: var(--primary);
    }
    
    .filter-form {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        align-items: end;
    }
    
    .filter-group {
        display: flex;
        flex-direction: column;
    }
    
    .filter-group label {
        margin-bottom: 8px;
        font-weight: 500;
        color: var(--dark);
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .filter-group label i {
        color: var(--primary);
    }
    
    .filter-group select {
        padding: 12px 15px;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: white;
        cursor: pointer;
    }
    
    .filter-group select:focus {
        border-color: var(--primary);
        outline: none;
        box-shadow: 0 0 0 3px rgba(71, 118, 230, 0.2);
        transform: translateY(-2px);
    }
    
    .filter-group select:hover {
        border-color: #c3cfe2;
    }
    
    .search-btn {
        padding: 12px 25px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 16px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        box-shadow: 0 4px 6px rgba(71, 118, 230, 0.2);
    }
    
    .search-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(71, 118, 230, 0.3);
    }
    
    .search-btn:active {
        transform: translateY(1px);
        box-shadow: 0 2px 4px rgba(71, 118, 230, 0.2);
    }
    
    .table-container {
        overflow-x: auto;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
        animation: slideUp 0.7s ease;
    }
    
    .account-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
    }
    
    .account-table th {
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        padding: 18px 15px;
        text-align: left;
        font-weight: 500;
        font-size: 16px;
        position: sticky;
        top: 0;
    }
    
    .account-table th i {
        margin-right: 8px;
    }
    
    .account-table td {
        padding: 16px 15px;
        border-bottom: 1px solid #e2e8f0;
        transition: all 0.3s ease;
    }
    
    .account-table tr {
        transition: all 0.3s ease;
    }
    
    .account-table tr:last-child td {
        border-bottom: none;
    }
    
    .account-table tr:hover {
        background: rgba(71, 118, 230, 0.03);
    }
    
    .account-table tr:hover td {
        transform: translateX(5px);
    }
    
    .alumni-id {
        font-weight: 600;
        color: var(--primary);
    }
    
    .alumni-name {
        font-weight: 500;
        color: var(--dark);
    }
    
    .contact-info {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }
    
    .email-link {
        color: var(--primary);
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 5px;
        transition: all 0.2s ease;
    }
    
    .email-link:hover {
        text-decoration: underline;
        color: var(--secondary);
    }
    
    .phone-link {
        color: #64748b;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 5px;
        transition: all 0.2s ease;
    }
    
    .phone-link:hover {
        color: var(--primary);
    }
    
    .linkedin-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 8px 15px;
        background: #0077B5;
        color: white;
        text-decoration: none;
        border-radius: 6px;
        font-weight: 500;
        font-size: 14px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 119, 181, 0.2);
    }
    
    .linkedin-link:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 119, 181, 0.3);
        gap: 12px;
    }
    
    .no-results {
        text-align: center;
        padding: 40px;
        background: white;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        grid-column: 1 / -1;
    }
    
    .no-results i {
        font-size: 60px;
        color: #e2e8f0;
        margin-bottom: 20px;
    }
    
    .no-results h3 {
        color: #718096;
        margin-bottom: 10px;
    }
    
    /* Compact Dashboard Button */
    .dashboard-button {
        position: absolute;
        top: 20px;
        right: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 45px;
        height: 45px;
        background: white;
        color: var(--primary);
        border: 2px solid var(--primary);
        border-radius: 50%;
        font-size: 18px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        box-shadow: 0 4px 6px rgba(71, 118, 230, 0.1);
    }
    
    .dashboard-button:hover {
        background: var(--primary);
        color: white;
        transform: translateY(-3px) rotate(5deg);
        box-shadow: 0 8px 15px rgba(71, 118, 230, 0.2);
    }
    
    .dashboard-button:active {
        transform: translateY(1px);
        box-shadow: 0 2px 4px rgba(71, 118, 230, 0.1);
    }
    
    /* Responsive Design */
    @media (max-width: 1024px) {
        .dashboard {
            padding: 20px;
        }
        
        .filter-form {
            grid-template-columns: 1fr;
        }
        
        .dashboard-button {
            top: 15px;
            right: 15px;
            width: 40px;
            height: 40px;
            font-size: 16px;
        }
    }
    
    @media (max-width: 768px) {
        .header h1 {
            font-size: 28px;
        }
        
        .account-table {
            font-size: 14px;
        }
        
        .account-table th, 
        .account-table td {
            padding: 12px 10px;
        }
        
        .linkedin-link {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        .dashboard-button {
            position: relative;
            top: auto;
            right: auto;
            margin: 0 auto 20px;
            width: 45px;
            height: 45px;
        }
    }
    
    @media (max-width: 480px) {
        body {
            padding: 15px;
        }
        
        .dashboard {
            border-radius: 15px;
            padding: 15px;
        }
        
        .header h1 {
            font-size: 24px;
        }
        
        .account-table th, 
        .account-table td {
            padding: 10px 8px;
            font-size: 13px;
        }
    }
</style>
</head>
<body>
    <div class="dashboard">
        <!-- Compact Dashboard Button -->
        <a href="StudentDashboard.html" class="dashboard-button" title="Back to Dashboard">
            <i class="fas fa-arrow-left"></i>
        </a>

        <div class="header">
            <h1><i class="fas fa-user-graduate"></i> Alumni Directory</h1>
            <p>Connect with successful graduates from our institution</p>
        </div>

        <!-- Search and Filter Section -->
        <div class="search-container">
            <h3><i class="fas fa-filter"></i> Filter Alumni</h3>
            <form method="get" class="filter-form">
                <div class="filter-group">
                    <label for="batch"><i class="fas fa-calendar-alt"></i> Batch</label>
                    <select name="batch" id="batch">
                        <option value="">-- All Batches --</option>
                        <%
                            Connection con = null;
                            try {
                                con = ConnectDb.getConnect();
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT DISTINCT batch FROM alumni ORDER BY batch");
                                while(rs.next()) {
                                    String batchVal = rs.getString(1);
                                    String selected = (batchVal.equals(request.getParameter("batch"))) ? "selected" : "";
                        %>
                            <option value="<%=batchVal%>" <%=selected%>><%=batchVal%></option>
                        <%
                                }
                                rs.close(); st.close();
                            } catch(Exception e) { e.printStackTrace(); }
                        %>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="branch"><i class="fas fa-graduation-cap"></i> Branch</label>
                    <select name="branch" id="branch">
                        <option value="">-- All Branches --</option>
                        <%
                            try {
                                Statement st2 = con.createStatement();
                                ResultSet rs2 = st2.executeQuery("SELECT DISTINCT branch FROM alumni ORDER BY branch");
                                while(rs2.next()) {
                                    String branchVal = rs2.getString(1);
                                    String selected = (branchVal.equals(request.getParameter("branch"))) ? "selected" : "";
                        %>
                            <option value="<%=branchVal%>" <%=selected%>><%=branchVal%></option>
                        <%
                                }
                                rs2.close(); st2.close();
                            } catch(Exception e) { e.printStackTrace(); }
                        %>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="company"><i class="fas fa-building"></i> Company</label>
                    <select name="company" id="company">
                        <option value="">-- All Companies --</option>
                        <%
                            try {
                                Statement st3 = con.createStatement();
                                ResultSet rs3 = st3.executeQuery("SELECT DISTINCT company FROM alumni ORDER BY company");
                                while(rs3.next()) {
                                    String companyVal = rs3.getString(1);
                                    String selected = (companyVal.equals(request.getParameter("company"))) ? "selected" : "";
                        %>
                            <option value="<%=companyVal%>" <%=selected%>><%=companyVal%></option>
                        <%
                                }
                                rs3.close(); st3.close();
                            } catch(Exception e) { e.printStackTrace(); }
                        %>
                    </select>
                </div>

                <button type="submit" class="search-btn">
                    <i class="fas fa-search"></i> Search
                </button>
            </form>
        </div>

        <!-- Alumni Table -->
        <div class="table-container">
            <table class="account-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-user"></i> Name</th>
                        <th><i class="fas fa-envelope"></i> Contact</th>
                        <th><i class="fas fa-calendar-alt"></i> Batch</th>
                        <th><i class="fas fa-graduation-cap"></i> Branch</th>
                        <th><i class="fas fa-building"></i> Company</th>
                        <th><i class="fas fa-map-marker-alt"></i> Location</th>
                        <th><i class="fas fa-external-link-alt"></i> LinkedIn</th>
                    </tr>
                </thead>
                <tbody>
                <%
                try {
                    String batch = request.getParameter("batch");
                    String branch = request.getParameter("branch");
                    String company = request.getParameter("company");

                    String query = "SELECT * FROM alumni WHERE 1=1";
                    if(batch != null && !batch.isEmpty()) query += " AND batch=?";
                    if(branch != null && !branch.isEmpty()) query += " AND branch=?";
                    if(company != null && !company.isEmpty()) query += " AND company=?";

                    PreparedStatement ps = con.prepareStatement(query);
                    int idx = 1;
                    if(batch != null && !batch.isEmpty()) ps.setString(idx++, batch);
                    if(branch != null && !branch.isEmpty()) ps.setString(idx++, branch);
                    if(company != null && !company.isEmpty()) ps.setString(idx++, company);

                    ResultSet rs = ps.executeQuery();
                    boolean found = false;
                    while(rs.next()) {
                        found = true;
                %>
                        <tr>
                            <td class="alumni-id">#<%=rs.getInt("id")%></td>
                            <td class="alumni-name"><%=rs.getString("name")%></td>
                            <td>
                                <div class="contact-info">
                                    <a href="mailto:<%=rs.getString("email")%>" class="email-link">
                                        <i class="fas fa-envelope"></i> <%=rs.getString("email")%>
                                    </a>
                                    <a href="tel:<%=rs.getString("phone")%>" class="phone-link">
                                        <i class="fas fa-phone"></i> <%=rs.getString("phone")%>
                                    </a>
                                </div>
                            </td>
                            <td><%=rs.getString("batch")%></td>
                            <td><%=rs.getString("branch")%></td>
                            <td><%=rs.getString("company")%></td>
                            <td><%=rs.getString("location")%></td>
                            <td>
                                <a href="<%=rs.getString("linkedin")%>" target="_blank" class="linkedin-link">
                                    <i class="fab fa-linkedin"></i> Connect
                                </a>
                            </td>
                        </tr>
                <%
                    }
                    if(!found) {
                %>
                        <tr>
                            <td colspan="8">
                                <div class="no-results">
                                    <i class="fas fa-user-graduate"></i>
                                    <h3>No alumni found for selected filters</h3>
                                    <p>Try adjusting your search criteria</p>
                                </div>
                            </td>
                        </tr>
                <%
                    }
                    rs.close(); ps.close(); con.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Add animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('.account-table tr');
            tableRows.forEach((row, index) => {
                row.style.animationDelay = `${index * 0.05}s`;
            });
            
            // Add subtle animation to filter dropdowns
            const filterSelects = document.querySelectorAll('select');
            filterSelects.forEach(select => {
                select.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'translateY(-2px)';
                });
                
                select.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</body>
</html>