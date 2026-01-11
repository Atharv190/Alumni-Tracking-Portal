<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Opportunities | Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #e0e7ff;
            --primary-dark: #3a56d4;
            --secondary: #7209b7;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
            --dark: #2b2d42;
            --light: #f8f9fa;
            --gray: #6c757d;
            --gray-light: #e9ecef;
            --radius: 8px;
            --radius-lg: 12px;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 15px 30px rgba(0, 0, 0, 0.12);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            --gradient: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f5f7ff;
            color: var(--dark);
            line-height: 1.6;
            padding: 20px;
        }

        .container {
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
            border-bottom: 1px solid var(--gray-light);
        }

        .header h1 {
            font-size: 1.8rem;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header h1 i {
            color: var(--primary);
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: var(--radius);
            font-weight: 500;
            transition: var(--transition);
        }

        .back-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .back-btn i {
            transition: transform 0.3s ease;
        }

        .back-btn:hover i {
            transform: translateX(-3px);
        }

        .job-table-container {
            background-color: white;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .job-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }

        .job-table th {
            background-color: var(--primary);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 500;
        }

        .job-table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--gray-light);
            vertical-align: top;
        }

        .job-table tr:last-child td {
            border-bottom: none;
        }

        .job-table tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }

        .apply-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .apply-link:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .action-link {
            color: var(--danger);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .action-link:hover {
            color: #bb2d3b;
            text-decoration: underline;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--gray);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: var(--gray-light);
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .page-link {
            padding: 8px 15px;
            background-color: white;
            border: 1px solid var(--gray-light);
            border-radius: var(--radius);
            color: var(--dark);
            text-decoration: none;
            transition: var(--transition);
        }

        .page-link:hover, .page-link.active {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .description-cell {
    max-width: 400px;
    white-space: normal;
    word-wrap: break-word;
}

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .header h1 {
                font-size: 1.5rem;
            }
            
            .job-table th, .job-table td {
                padding: 10px;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 576px) {
            .container {
                padding: 15px;
            }
            
            .job-table th, .job-table td {
                padding: 8px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-briefcase"></i> All Job Opportunities</h1>
            <a href="AdminDashboard.html" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <div class="job-table-container">
            <div class="table-responsive">
                <table class="job-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Job Title</th>
                            <th>Company</th>
                            <th>Location</th>
                            <th>Description</th>
                            <th>Apply Link</th>
                            <th>Target Audience</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection con = ConnectDb.getConnect();
                                PreparedStatement ps = con.prepareStatement("select * from job");
                                ResultSet rs = ps.executeQuery();

                                if (!rs.isBeforeFirst()) {
                                    // No records found
                        %>
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <i class="fas fa-inbox"></i>
                                            <h3>No Job Opportunities Found</h3>
                                            <p>There are currently no job postings available.</p>
                                        </td>
                                    </tr>
                        <%
                                } else {
                                    while (rs.next()) {
                        %>
                                        <tr>
                                            <td><%=rs.getString("id")%></td>
                                            <td><strong><%=rs.getString("title")%></strong></td>
                                            <td><%=rs.getString("name")%></td>
                                            <td><%=rs.getString("location")%></td>
                                            <td class="description-cell">
    <%=rs.getString("descr")%>
</td>
                                            <td>
                                                <a href="<%=rs.getString("link")%>" class="apply-link" target="_blank">
                                                    <i class="fas fa-external-link-alt"></i> Apply
                                                </a>
                                            </td>
                                            <td>
                                                <span class="audience-tag">
                                                     <i class="fas fa-users"></i><%=rs.getString("target")%>
                                                </span>
                                            </td>
                                            <td>
                                                <a href="DeleteJob.jsp?id=<%=rs.getString(1)%>" class="action-link">
                                                    <i class="fas fa-trash-alt"></i> Delete
                                                </a>
                                            </td>
                                        </tr>
                        <%
                                    }
                                }
                                rs.close();
                                ps.close();
                                con.close();
                            } catch (Exception e) {
                        %>
                                <tr>
                                    <td colspan="8" style="color: var(--danger); padding: 20px; text-align: center;">
                                        <i class="fas fa-exclamation-triangle"></i> Error loading job opportunities: <%=e.getMessage()%>
                                    </td>
                                </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination would go here if implemented -->
        <!-- <div class="pagination">
            <a href="#" class="page-link active">1</a>
            <a href="#" class="page-link">2</a>
            <a href="#" class="page-link">3</a>
            <a href="#" class="page-link">Next</a>
        </div> -->
    </div>

    <script>
        // Add hover effects and tooltips for description cells
        document.querySelectorAll('.description-cell').forEach(cell => {
            cell.addEventListener('mouseenter', function() {
                if (this.offsetWidth < this.scrollWidth) {
                    this.style.whiteSpace = 'normal';
                    this.style.overflow = 'visible';
                    this.style.position = 'absolute';
                    this.style.backgroundColor = 'white';
                    this.style.boxShadow = '0 0 10px rgba(0,0,0,0.1)';
                    this.style.zIndex = '100';
                    this.style.maxWidth = '400px';
                    this.style.border = '1px solid #eee';
                    this.style.borderRadius = '8px';
                    this.style.padding = '10px';
                }
            });
            
            cell.addEventListener('mouseleave', function() {
                this.style.whiteSpace = 'nowrap';
                this.style.overflow = 'hidden';
                this.style.position = 'static';
                this.style.backgroundColor = 'transparent';
                this.style.boxShadow = 'none';
                this.style.zIndex = 'auto';
                this.style.maxWidth = '300px';
                this.style.border = 'none';
                this.style.borderRadius = '0';
                this.style.padding = '12px 15px';
            });
        });
    </script>
</body>
</html>