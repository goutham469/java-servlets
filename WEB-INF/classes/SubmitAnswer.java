import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.Random;

public class SubmitAnswer extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        // Ensure form uses POST method
        if (!"POST".equalsIgnoreCase(req.getMethod())) {
            out.println("<h2>Invalid Request Method. Please submit the form correctly.</h2>");
            return;
        }

        String q_id = req.getParameter("id");
        String question = req.getParameter("question");
        String answer = req.getParameter("answer");

        if (q_id == null || question == null || answer == null || answer.trim().isEmpty()) {
            out.println("<h2>All fields are required.</h2>");
            return;
        }

        try {
            int questionId = Integer.parseInt(q_id);
            int answerId = new Random().nextInt(100000);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quora", "root", "goutham.sql"
            );

            String sql = "INSERT INTO answers(id, question_id, question, answer) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, answerId);
            pstmt.setInt(2, questionId);
            pstmt.setString(3, question);
            pstmt.setString(4, answer);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                out.println("<h2>Answer posted successfully!</h2>");
            } else {
                out.println("<h2>Failed to post answer.</h2>");
            }

            conn.close();
        } catch (NumberFormatException e) {
            out.println("<h2>Error: Invalid question ID</h2>");
        } catch (Exception e) {
            out.println("<h2>Error: An exception occurred</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
        }
    }
}
