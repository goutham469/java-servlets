import java.sql.*;

public class Main
{
    public static void main(String[] args)
    {
        String url = "jdbc:mysql://3.108.9.115:3306/quora?useSSL=false&allowPublicKeyRetrieval=true";
        String username = "goutham";
        String password = "Goutham@123";

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            String query = "SELECT * FROM users;";
            Statement stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(query);

            while(res.next())
            {
                System.out.println(res.getString(1) + " " + res.getString(2));
            }

            conn.close();
        } catch(Exception e){
            System.out.println( e);
        }
    }
}
