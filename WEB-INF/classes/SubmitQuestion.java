import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.Random;

public class SubmitQuestion extends HttpServlet
{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException
    {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        String question = req.getParameter("question");
        Random random = new Random();
        int q_id = random.nextInt(100000);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quora", "root", "goutham.sql"
            );

            String sql = "INSERT INTO questions(id, question) VALUES(?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, q_id);
            pstmt.setString(2, question);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                out.println("<h1>Your question has been posted.</h1>");
            } else {
                out.println("<h1>Failed to post question.</h1>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<h1>An exception occurred.</h1>");
            out.println("<pre>" + e + "</pre>");
        }
    }
}
