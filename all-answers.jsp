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
    </style>
</head>
<body>
    <h1>All Answers</h1>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quora", "root", "goutham.sql"
            );

            String sql = "SELECT * FROM answers;";
            Statement stmt = conn.createStatement();
            ResultSet result = stmt.executeQuery(sql);

            while (result.next()) {
                int id = result.getInt(1);
                int question_id = result.getInt(2);
                String question = result.getString(3);
                String answer = result.getString(4);
                
                out.println("<div class='answer'>");
                out.println("<p><strong>Question ID:</strong> " + question_id + "</p>");
                out.println("<p><strong>Question:</strong> " + question + "</p>");
                out.println("<p><strong>Answer ID:</strong> " + id + "</p>");
                out.println("<p><strong>Answer:</strong> " + answer + "</p>");
                out.println("</div>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p>Error occurred: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
