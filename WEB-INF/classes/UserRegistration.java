import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class UserRegistration extends HttpServlet
{
    public void service(HttpServletRequest req , HttpServletResponse res) throws IOException
    {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        String name = req.getParameter("username");
        String password = req.getParameter("password");

        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quora", "root", "goutham.sql");

            String sql = "INSERT INTO users (name, password) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, password);

            int rows = stmt.executeUpdate();
            conn.close();

            if (rows > 0)
                out.println("<h1>User registration successful!</h1>");
            else
                out.println("<h1>User registration failed.</h1>");
        }
        catch(Exception e)
        {
            out.println("<h1>User registration Failed.</h1>");
            out.println("<pre>" + e + "</pre>");
        }
    }
}
