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
        input{
            height: 20px;
            width: 200px;
            border-radius: 2px;
            margin: 5px;
        }
        .change-password-button{
            background-color: rgb(241, 159, 159);
            border-radius: 5px;
            padding: 5px;
            cursor: pointer;
        }
        .change-password{
            background-color: #e8f0fe;
            padding: 10px;
        }
    </style>
</head>
<body>
    <script>
       function logout() {
            // Split and expire all cookies
            document.cookie.split(";").forEach(function(cookie) {
                const eqPos = cookie.indexOf("=");
                const name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
                document.cookie = name.trim() + "=; path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
            });

            // Redirect to login
            window.location.href = "./user-login.jsp";
        }
    </script>

    <div class="profile">
        <img 
            src="./assets/profile.png"
            width="100px"
            height="100px"
        />
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
                    response.sendRedirect("./user-login.jsp");
                } else {
                    out.println("<h2>Welcome, " + username + "</h2>");

                    out.println("<button onclick='logout()'>Log Out</button>");
                    
                    out.println(" <form action='change-password' class='change-password'> <b>Change password</b> <br/> <input placeholder='Enter old password' type='text' required name='old-password' /> <br/>  <input placeholder='Enter new password'  type='text'   required name='new-password' /> <br/> <button class='change-password-button'>Change Password</button>  </form>");
                }
            } else {
                out.println("You are not logged in.");
            }
        %>
    </div>
</body>
</html>
