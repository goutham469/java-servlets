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
            ServletContext context = req.getServletContext();
            String dbURL = context.getInitParameter("dbURL");
            String dbUser = context.getInitParameter("dbUser");
            String dbPassword = context.getInitParameter("dbPassword");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

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
                
                sql = "UPDATE users SET last_login = current_timestamp() WHERE name=?;";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.executeUpdate();

                // Redirect to home.jsp
                String contextPath = req.getContextPath();
                res.sendRedirect(contextPath + "/dashboard.jsp");
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
