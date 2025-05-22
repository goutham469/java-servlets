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
        String author = "";
        Random random = new Random();
        int q_id = random.nextInt(100000);
        Cookie[] cookies = req.getCookies();
        
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("name")) {
                    author = cookie.getValue();
                }
            }
        }
        else{
            author = "Anonymous";
        }

        

        if( question == null || question.isEmpty() )
        {
            out.println("Error: Question is required.");
        }
        else
        {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                ServletContext context = req.getServletContext();
                String dbURL = context.getInitParameter("dbURL");
                String dbUser = context.getInitParameter("dbUser");
                String dbPassword = context.getInitParameter("dbPassword");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                String sql = "INSERT INTO questions(id, question,author) VALUES(?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, q_id);
                pstmt.setString(2, question);
                pstmt.setString(3,author);

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
}
