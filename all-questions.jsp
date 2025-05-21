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
        a {
            color: #0d6efd;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>All Questions</h1>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quora", "root", "goutham.sql"
            );

            String sql = "SELECT * FROM questions;";
            Statement stmt = conn.createStatement();
            ResultSet result = stmt.executeQuery(sql);

            while (result.next()) {
                int id = result.getInt(1);
                String question = result.getString(2);

                out.println("<div class='question'>");
                out.println("<p><strong>ID:</strong> " + id + "</p>");
                out.println("<p><strong>Question:</strong> " + question + "</p>");
                out.println("<a href='submit-answer-form?id=" + id + "&question=" + question + "'>Submit Answer</a>");
                out.println("</div>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p>Error occurred: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
