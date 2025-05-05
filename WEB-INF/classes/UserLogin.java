import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class UserLogin extends HttpServlet
{
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException
    {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quora", "root", "goutham.sql");

            String sql = "SELECT * FROM users WHERE name = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery(); // Corrected here

            if (rs.next()) {
                // Set cookies
                Cookie userCookie = new Cookie("name", username);
                Cookie passCookie = new Cookie("password", password);
                res.addCookie(userCookie);
                res.addCookie(passCookie);

                // Redirect to home.jsp
                res.sendRedirect("all-questions.jsp");
            } else {
                out.println("<h2>User not found or incorrect password.</h2>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<h3>Exception occurred</h3>");
            out.println("<pre>" + e + "</pre>");
        }
    }
}
