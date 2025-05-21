<%@ page import="jakarta.servlet.http.Cookie" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f0fe;
            padding: 30px;
        }
        .profile {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            max-width: 400px;
            margin: auto;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="profile">
        <%
            Cookie[] cookies = request.getCookies();
            String username = "";

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("name")) {
                        username = cookie.getValue();
                        break;
                    }
                }

                if (username.equals("")) {
                    out.println("Some problem occurred");
                } else {
                    out.println("<h2>Welcome, " + username + "</h2>");
                }
            } else {
                out.println("You are not logged in.");
            }
        %>
    </div>
</body>
</html>
