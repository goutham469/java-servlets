<%@ page import="java.sql.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Answers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f3f5;
            padding: 20px;
        }
        .answer {
            background-color: #fff3cd;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }
        .answer p {
            margin: 5px 0;
        }
        .question {
            background-color: #ffffff;
            border-left: 5px solid #0d6efd;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);

            width: 300px;
        }
        b{
            margin-bottom: 5px;
            font-size: 16px;
        }
        button{
            cursor: pointer;
            background-color: bisque;
            border-radius: 5px;
            border: none;
        }
    </style>
</head>
<body>
    <h1>All Answers</h1>
    <div style="display: flex;justify-content: space-around;width: 200px;height: 30px;">
        <button onclick="prevPage()">< Prev</button>
        page <label id="page">1</label>
        <button onclick="nextPage()">Next ></button>
    </div>
    <br>

    <div>
        <div style="display: flex;justify-content: space-around;flex-wrap: wrap;">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                String dbURL = application.getInitParameter("dbURL");
                String dbUser = application.getInitParameter("dbUser");
                String dbPassword = application.getInitParameter("dbPassword");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                int page_no = 0;
                Cookie[] cookies = request.getCookies();
                for(Cookie cookie : cookies )
                {
                    if(cookie.getName().equals("page")){
                        page_no = Integer.parseInt(cookie.getValue());
                        break;
                    }
                }

                String sql = "SELECT * FROM answers LIMIT 10 OFFSET " + page_no*10 + ";" ;
                Statement stmt = conn.createStatement();
                ResultSet result = stmt.executeQuery(sql);

                while (result.next()) {
                    int question_id = result.getInt(2);

                    String question = result.getString(3);
                    String answer = result.getString(4);
                    String author = result.getString(5);
                    String published_on = result.getDate(6).toString();

                    %>
                    <div class="question">
                        <%
                    
                    out.println("<br/><b style='color: red;'>"+question + "</b><br/>");
                    
                    
                        out.println("<img src='./assets/profile.png' width='15px' height='15px' style='border-radius: 20px;' />");
                    out.println("<label style='position: relative;bottom: 5px;'>"+author+"</label>");
                    out.println("<p>" + answer + "</p>");
                    
                    out.println("<p style='font-size: 12px;'>posted on: " + published_on + "</p>");
                    %>
                    </div>
                    <%

                }

                conn.close();
            } catch (Exception e) {
                out.println("<p>Error occurred: " + e.getMessage() + "</p>");
            }
        %>
        </div>
    </div>
    

<script>
    function getCookie(key) {
        let cookies = document.cookie.split('; ');
        for (let i = 0; i < cookies.length; i++) {
            let cookie = cookies[i].split('=');
            if (cookie[0] === key) {
                return cookie[1];
            }
        }
        return null;
    }

    function setCookie(key, value, days) {
        let date = new Date();
        date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
        document.cookie = key + '=' + value + '; expires=' + date.toUTCString() + '; path=/';
    }

    function updatePageDisplay(page) {
        document.getElementById("page").textContent = page;
    }

    function nextPage() {
        let page = parseInt(getCookie("page") || "0", 10);
        page++;
        setCookie("page", page, 1);
        updatePageDisplay(page);
        window.location.reload();
    }

    function prevPage() {
        let page = parseInt(getCookie("page") || "0", 10);
        if (page >= 1) {
            page--;
            setCookie("page", page, 1);
            updatePageDisplay(page);
        }
        window.location.reload();
    }

    // Load initial page value from cookie
    window.onload = function () {
        let savedPage = parseInt(getCookie("page") || "0", 10);
        updatePageDisplay(savedPage);
    }
</script>

</body>
</html>
