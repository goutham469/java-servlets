<%@ page import="java.sql.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Questions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .question {
            background-color: #ffffff;
            border-left: 5px solid #0d6efd;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        .submit-answer-button{
            text-decoration: none;
            background-color: rgb(177, 177, 177);
            border-radius: 5px;
            padding: 3px;
            color: rgb(68, 68, 68);
            width: fit-content;
        }
    </style>
</head>
<body>
    <h1>All Questions</h1>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");


            String dbURL = application.getInitParameter("dbURL");
            String dbUser = application.getInitParameter("dbUser");
            String dbPassword = application.getInitParameter("dbPassword");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String sql = "SELECT * FROM questions;";
            Statement stmt = conn.createStatement();
            ResultSet result = stmt.executeQuery(sql);

            boolean found = false;
            while (result.next()) {
                found = true;
                int id = result.getInt(1);
                String question = result.getString(2);
                String author = result.getString(3);
                String published_on = result.getDate(4).toString();

                out.println("<div class='question'>");
                out.println("<img src='./assets/profile.png' width='20px' height='20px' style='border-radius: 20px;' />");
                out.println("<label style='position: relative;bottom: 5px;'>"+author+"</label>");
                out.println("<br/><b style='color: red;'>"+question + "</b><br/>");
                out.println("<p style='font-size: 12px;'>posted on: " + published_on + "</p>");
                %>
                <div class="submit-answer-button">
                <img src="./assets/submit.png" width="20px" height="20px"/>
                <%
                Cookie [] cookies = request.getCookies();
                String username = "";
                for(Cookie cookie : cookies) {
                    if( cookie.getName().equals("name") ){
                        username = cookie.getValue();
                        break;
                    }
                }
                    String encodedQuestion = java.net.URLEncoder.encode(question, "UTF-8");
                    String encodedAuthor = java.net.URLEncoder.encode(username, "UTF-8");

                    out.println("<a class='submit-answer-button' href='submit-answer-form?id=" + id + "&question=" + encodedQuestion + "&author=" + encodedAuthor + "'>Submit Answer</a>");
            

                %>
                </div>
                <%
                out.println("</div>");
            }

            if (!found) {
                out.println("<p>No Questions Yet!</p>");
            }


            conn.close();
        } catch (Exception e) {
            out.println("<p>Error occurred: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
