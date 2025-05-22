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
        String email = req.getParameter("email");

        if( name == null || password == null || name.isEmpty() || password.isEmpty() || email == null || email.isEmpty() )
        {
            out.println("Please enter username , email , password");
        }
        else{
            try
            {
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                ServletContext context = req.getServletContext();
                String dbURL = context.getInitParameter("dbURL");
                String dbUser = context.getInitParameter("dbUser");
                String dbPassword = context.getInitParameter("dbPassword");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                if(checkExistence(conn , name))
                {
                    out.println("User name already exists");
                }
                else
                {
                    String sql = "INSERT INTO users (name, password,email) VALUES (?, ?,?)";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, name);
                    stmt.setString(2, password);
                    stmt.setString(3 , email);

                    int rows = stmt.executeUpdate();
                    conn.close();

                    if (rows > 0)
                    {
                        out.println("<h1>User registration successful!</h1>");
                        out.println("Login to your account<br/>");
                        out.println("<a href='./user-login.jsp'>Click here to login</a>");
                    }
                    else{
                        out.println("<h1>User registration failed.</h1>");
                    }

                }
            }
            catch(Exception e)
            {
                out.println("<h1>User registration Failed.</h1>");
                out.println("<pre>" + e + "</pre>");
            }
        }
    }

    public boolean checkExistence( Connection conn , String username )
    {
        try{
            String sql = "SELECT * FROM users WHERE name = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            return rs.next();
        }catch(Exception e)
        {
            return false;
        }
    }
}
