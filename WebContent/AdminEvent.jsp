<%@page import="com.Atharv.dbcon.ConnectDb"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #4895ef;
            --primary-dark: #3a0ca3;
            --secondary: #7209b7;
            --danger: #f72585;
            --success: #4cc9f0;
            --warning: #f8961e;
            --text: #2b2d42;
            --text-light: #6c757d;
            --light: #f8f9fa;
            --white: #ffffff;
            --border: #e9ecef;
            --radius: 12px;
            --radius-sm: 6px;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            --shadow-hover: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7ff;
            color: var(--text);
            line-height: 1.6;
            padding: 0;
            min-height: 100vh;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Header Styles */
        .header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 1.5rem 2rem;
            border-radius: var(--radius);
            margin-bottom: 2rem;
            box-shadow: var(--shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-title i {
            font-size: 1.8rem;
        }

        /* Button Styles */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius-sm);
            font-family: inherit;
            font-size: 0.95rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            gap: 0.5rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid white;
            color: white;
        }

        .btn-outline:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        /* Table Styles */
        .events-container {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .events-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .events-table th {
            background-color: var(--primary-light);
            color: white;
            text-align: left;
            padding: 1.25rem 1.5rem;
            font-weight: 500;
            position: sticky;
            top: 0;
        }

        .events-table td {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
            transition: all 0.3s ease;
        }

        .events-table tr:last-child td {
            border-bottom: none;
        }

        .events-table tr:hover td {
            background-color: rgba(67, 97, 238, 0.05);
        }

        /* Badge Styles */
        .badge {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 500;
            text-transform: capitalize;
        }

        .badge-students {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success);
        }

        .badge-alumni {
            background-color: rgba(248, 150, 30, 0.1);
            color: var(--warning);
        }

        .badge-both {
            background-color: rgba(114, 9, 183, 0.1);
            color: var(--secondary);
        }

        /* Action Links */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .action-link {
            padding: 0.5rem;
            border-radius: 4px;
            color: white;
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .action-link i {
            font-size: 0.9rem;
        }

        .action-link:hover {
            opacity: 0.9;
        }

        .edit-link {
            background-color: var(--primary-light);
        }

        .edit-link:hover {
            background-color: var(--primary);
        }

        .delete-link {
            background-color: var(--danger);
        }

        .delete-link:hover {
            background-color: #d91a63;
        }

        /* Empty State */
        .no-events {
            text-align: center;
            padding: 3rem;
            color: var(--text-light);
            font-size: 1.1rem;
        }

        .no-events i {
            font-size: 3rem;
            color: var(--primary-light);
            margin-bottom: 1rem;
            opacity: 0.7;
        }

        .no-events h3 {
            font-size: 1.5rem;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        /* Footer Actions */
        .footer-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 1.5rem;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .container {
                padding: 1.5rem;
            }
            
            .header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
                padding: 1.5rem;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .events-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="page-title">
                <i class="fas fa-calendar-alt"></i>
                Event Management
            </h1>
            <a href="AdminDashboard.html" class="btn btn-outline">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </header>

        <div class="events-container">
            <table class="events-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Venue</th>
                        <th>Audience</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        boolean hasEvents = false;
                        try {
                            Connection con = ConnectDb.getConnect();
                            Statement stmt = con.createStatement();
                            ResultSet rs = stmt.executeQuery("select * from event");

                            while(rs.next()) {
                                hasEvents = true;
                                String target = rs.getString("target");
                                String audienceClass = "";
                                
                                if ("Students".equals(target)) {
                                    audienceClass = "badge-students";
                                } else if ("Alumni".equals(target)) {
                                    audienceClass = "badge-alumni";
                                } else if ("Both".equals(target)) {
                                    audienceClass = "badge-both";
                                }
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td>
                            <strong><%= rs.getString("title") %></strong>
                            <div class="text-muted" style="font-size: 0.85rem; color: var(--text-light); margin-top: 0.25rem;">
                                <%= rs.getString("descr").length() > 50 ? 
                                    rs.getString("descr").substring(0, 50) + "..." : 
                                    rs.getString("descr") %>
                            </div>
                        </td>
                        <td><%= rs.getDate("date") %></td>
                        <td><%= rs.getString("time") %></td>
                        <td><%= rs.getString("venue") %></td>
                        <td><span class="badge <%= audienceClass %>"><%= target %></span></td>
                        <td>
                            <div class="action-buttons">
                                <a href="EditEvent.jsp?id=<%=rs.getInt(1)%>" class="action-link edit-link" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="DeleteEvent.jsp?id=<%=rs.getInt(1)%>" class="action-link delete-link" title="Delete">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                            con.close();
                        } catch(Exception e) {
                            out.println("<tr><td colspan='7' style='color: var(--danger); padding: 1.5rem; text-align: center;'>Error loading events: " + e.getMessage() + "</td></tr>");
                        }
                        
                        if (!hasEvents) {
                            out.println("<tr><td colspan='7'><div class='no-events'><i class='fas fa-calendar-times'></i><h3>No Events Found</h3><p>There are currently no events scheduled. Create your first event!</p></div></td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="footer-actions">
            <a href="Events.html" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Event
            </a>
        </div>
    </div>
</body>
</html>