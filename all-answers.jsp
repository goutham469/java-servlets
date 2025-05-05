<%@ page import="java.sql.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Questions</title>
</head>
<body>
    <h1>All Questions</h1>
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
                String question = result.getString(3);

                int question_id = result.getInt(2);
                String answer = result.getString(4);
                
                out.println("<div style='background-color: bisque;border-radius: 5px;width: fit-content;padding: 10px;'>");
                out.println("<p><strong>ID:</strong> " + question_id + "</p>");
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
