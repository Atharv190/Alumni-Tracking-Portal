<%@ page import="java.sql.*" %>
<%@ page import="com.Atharv.dbcon.ConnectDb" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Secure Password Update | Alumni Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6C63FF;
            --primary-light: #837dff;
            --primary-extra-light: #f0efff;
            --secondary: #4D44DB;
            --success: #00C9A7;
            --success-light: #e6f8f5;
            --danger: #FF6584;
            --danger-light: #ffebee;
            --warning: #FFC75F;
            --dark: #2D3748;
            --dark-medium: #4A5568;
            --dark-light: #718096;
            --light: #F8F9FA;
            --border: #E2E8F0;
            --bg-light: #ffffff;
            --bg-extra-light: #f9fafb;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: var(--dark);
            padding: 20px;
        }
        
        .container {
            background-color: var(--bg-light);
            padding: 2.5rem;
            border-radius: 1.5rem;
            box-shadow: 0 25px 50px rgba(108, 99, 255, 0.15);
            width: 100%;
            max-width: 500px;
            position: relative;
            overflow: hidden;
            transform: translateY(0);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            z-index: 1;
            animation: containerSlide 0.6s ease-out;
            border: 1px solid var(--border);
        }
        
        @keyframes containerSlide {
            from { 
                opacity: 0;
                transform: translateY(20px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(108, 99, 255, 0.2);
        }
        
        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(to right, var(--primary), var(--success));
            border-radius: 4px 4px 0 0;
        }
        
        .header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }
        
        .logo {
            width: 90px;
            height: 90px;
            background: var(--primary-extra-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.2rem;
            box-shadow: 0 8px 20px rgba(108, 99, 255, 0.15);
            animation: pulse 2s infinite;
            position: relative;
            border: 2px solid var(--primary);
        }
        
        .logo::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 2px solid var(--primary-extra-light);
            animation: ripple 1.5s linear infinite;
        }
        
        @keyframes ripple {
            0% { transform: scale(1); opacity: 1; }
            100% { transform: scale(1.5); opacity: 0; }
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.03); }
            100% { transform: scale(1); }
        }
        
        .logo i {
            color: var(--primary);
            font-size: 2.2rem;
        }
        
        h2 {
            color: var(--primary);
            font-weight: 600;
            font-size: 1.9rem;
            margin-bottom: 0.5rem;
        }
        
        .subtitle {
            color: var(--dark-light);
            font-size: 0.95rem;
            line-height: 1.5;
        }
        
        .form-group {
            margin-bottom: 1.8rem;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 500;
            color: var(--dark);
            font-size: 0.95rem;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: var(--primary);
            transition: all 0.3s ease;
            z-index: 2;
        }
        
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 16px 15px 16px 50px;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: var(--bg-extra-light);
            font-family: 'Poppins', sans-serif;
            position: relative;
            z-index: 1;
        }
        
        input:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 4px rgba(108, 99, 255, 0.1);
            background-color: white;
        }
        
        input:focus + .input-icon {
            color: var(--secondary);
            transform: translateY(-50%) scale(1.1);
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--dark-light);
            transition: all 0.3s ease;
            z-index: 2;
        }
        
        .password-toggle:hover {
            color: var(--primary);
        }
        
        .btn {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-family: 'Poppins', sans-serif;
            position: relative;
            overflow: hidden;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: 0.5s;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
            box-shadow: 0 5px 18px rgba(108, 99, 255, 0.25);
        }
        
        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(108, 99, 255, 0.35);
        }
        
        .btn-secondary {
            background-color: white;
            color: var(--primary);
            border: 2px solid var(--border);
            margin-top: 1.2rem;
        }
        
        .btn-secondary:hover {
            background-color: var(--bg-extra-light);
            border-color: var(--primary);
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(108, 99, 255, 0.1);
        }
        
        .msg {
            text-align: center;
            margin: 1.5rem 0 0;
            padding: 16px;
            border-radius: 10px;
            font-size: 0.95rem;
            animation: fadeIn 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .success {
            background-color: var(--success-light);
            color: #2F855A;
            border: 1px solid #C6F6D5;
        }
        
        .error {
            background-color: var(--danger-light);
            color: #C53030;
            border: 1px solid #FED7D7;
        }
        
        .warning {
            background-color: #FFFAF0;
            color: #C05621;
            border: 1px solid #FEEBC8;
        }
        
        .strength-meter {
            height: 6px;
            background: var(--border);
            border-radius: 5px;
            margin-top: 8px;
            overflow: hidden;
            position: relative;
        }
        
        .strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s ease, background 0.3s ease;
            border-radius: 5px;
        }
        
        .strength-labels {
            display: flex;
            justify-content: space-between;
            margin-top: 8px;
            font-size: 0.75rem;
            color: var(--dark-light);
        }
        
        .password-tips {
            background-color: var(--bg-extra-light);
            border-left: 4px solid var(--primary);
            padding: 12px 15px;
            border-radius: 0 8px 8px 0;
            margin-top: 10px;
            font-size: 0.85rem;
            color: var(--dark-medium);
        }
        
        .password-tips ul {
            padding-left: 20px;
            margin: 8px 0 0;
        }
        
        .password-tips li {
            margin-bottom: 5px;
        }
        
        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
            pointer-events: none;
        }
        
        .floating-element {
            position: absolute;
            border-radius: 50%;
            opacity: 0.5;
            animation: float linear infinite;
        }
        
        @keyframes float {
            0% { transform: translateY(100vh) rotate(0deg); }
            100% { transform: translateY(-100px) rotate(360deg); }
        }
        
        @media (max-width: 576px) {
            .container {
                padding: 2rem 1.5rem;
            }
            
            h2 {
                font-size: 1.7rem;
            }
            
            .logo {
                width: 80px;
                height: 80px;
            }
        }
    </style>
</head>
<body>

<%
    String message = "";
    String messageClass = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        try {
            Connection con = ConnectDb.getConnect();
            
            // First verify old password
            PreparedStatement checkUser = con.prepareStatement(
                "SELECT * FROM alumni WHERE email = ? AND password = ?");
            checkUser.setString(1, email);
            checkUser.setString(2, oldPassword);
            ResultSet rs = checkUser.executeQuery();

            if (rs.next()) {
                // Old password matches, proceed with update
                if (!oldPassword.equals(newPassword)) {
                    PreparedStatement updatePassword = con.prepareStatement(
                        "UPDATE alumni SET password = ? WHERE email = ?");
                    updatePassword.setString(1, newPassword);
                    updatePassword.setString(2, email);

                    int updated = updatePassword.executeUpdate();
                    if (updated > 0) {
                        message = "Password updated successfully! Redirecting to dashboard...";
                        messageClass = "success";
                        response.setHeader("Refresh", "3;url=AlumniDashboard.html");
                    } else {
                        message = "Failed to update password. Please try again.";
                        messageClass = "error";
                    }
                } else {
                    message = "New password cannot be the same as old password!";
                    messageClass = "warning";
                }
            } else {
                message = "Invalid email or current password!";
                messageClass = "error";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            messageClass = "error";
        }
    }
%>

<div class="floating-elements" id="floating-elements"></div>

<div class="container">
    <div class="header">
        <div class="logo">
            <i class="fas fa-lock"></i>
        </div>
        <h2>Secure Password Update</h2>
        <p class="subtitle">Protect your account with a strong, unique password</p>
    </div>
    
    <% if (!message.isEmpty()) { %>
        <div class="msg <%= messageClass %>">
            <i class="fas <%= messageClass.equals("success") ? "fa-check-circle" : 
                             messageClass.equals("warning") ? "fa-exclamation-triangle" : "fa-times-circle" %>"></i>
            <%= message %>
        </div>
    <% } %>
    
    <form method="post">
        <div class="form-group">
            <label for="email">Email Address</label>
            <div class="input-wrapper">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>
        </div>
        
        <div class="form-group">
            <label for="oldPassword">Current Password</label>
            <div class="input-wrapper">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" id="oldPassword" name="oldPassword" placeholder="Enter current password" required>
                <i class="fas fa-eye password-toggle" onclick="togglePassword('oldPassword')"></i>
            </div>
        </div>
        
        <div class="form-group">
            <label for="newPassword">New Password</label>
            <div class="input-wrapper">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required 
                       oninput="checkPasswordStrength(this.value)">
                <i class="fas fa-eye password-toggle" onclick="togglePassword('newPassword')"></i>
            </div>
            <div class="strength-meter">
                <div class="strength-bar" id="strength-bar"></div>
            </div>
            <div class="strength-labels">
                <span>Weak</span>
                <span>Medium</span>
                <span>Strong</span>
            </div>
            
            <div class="password-tips">
                <strong>Password Tips:</strong>
                <ul>
                    <li>Use at least 8 characters</li>
                    <li>Include uppercase and lowercase letters</li>
                    <li>Add numbers and special characters</li>
                    <li>Avoid common words or patterns</li>
                </ul>
            </div>
        </div>
        
        <button type="submit" class="btn btn-primary">
            <i class="fas fa-shield-alt"></i> Update Password Securely
        </button>
        
        <a href="AlumniDashboard.html" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </form>
</div>

<script>
    function togglePassword(fieldId) {
        const field = document.getElementById(fieldId);
        const icon = field.parentNode.querySelector('.password-toggle');
        
        if (field.type === "password") {
            field.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            field.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    }
    
    function checkPasswordStrength(password) {
        const strengthBar = document.getElementById('strength-bar');
        let strength = 0;
        
        // Check length
        if (password.length > 7) strength += 1;
        if (password.length > 11) strength += 1;
        
        // Check for mixed case
        if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1;
        
        // Check for numbers
        if (password.match(/[0-9]/)) strength += 1;
        
        // Check for special chars
        if (password.match(/[^a-zA-Z0-9]/)) strength += 1;
        
        // Update strength bar
        const width = strength * 25;
        strengthBar.style.width = width + '%';
        
        // Update color
        if (strength <= 1) {
            strengthBar.style.background = '#EF4444'; // red
        } else if (strength <= 3) {
            strengthBar.style.background = '#F59E0B'; // amber
        } else {
            strengthBar.style.background = '#10B981'; // emerald
        }
    }
    
    // Create floating elements
    document.addEventListener('DOMContentLoaded', function() {
        const floatingContainer = document.getElementById('floating-elements');
        const elementCount = 15;
        
        for (let i = 0; i < elementCount; i++) {
            const element = document.createElement('div');
            element.classList.add('floating-element');
            
            // Random size between 5 and 20px
            const size = Math.random() * 15 + 5;
            element.style.width = `${size}px`;
            element.style.height = `${size}px`;
            
            // Random position
            element.style.left = `${Math.random() * 100}%`;
            element.style.top = `${Math.random() * 100}%`;
            
            // Random color from our palette
            const colors = ['#6C63FF', '#837dff', '#00C9A7', '#FFC75F', '#E2E8F0'];
            const randomColor = colors[Math.floor(Math.random() * colors.length)];
            element.style.background = randomColor;
            
            // Random animation duration between 15 and 40s
            const duration = Math.random() * 25 + 15;
            element.style.animationDuration = `${duration}s`;
            
            // Random delay
            element.style.animationDelay = `${Math.random() * 5}s`;
            
            floatingContainer.appendChild(element);
        }
    });
</script>

</body>
</html>