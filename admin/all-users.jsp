<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All users</title>
</head>
<body>
    <h1>All users</h1>
    <table>
        <thead>
            <th>s.no</th>
            <th>username</th>
            <th>password</th>
            <th>email</th>
        </thead>
        <tbody>
            <%
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    String dbURL = application.getInitParameter("dbURL");
                    String dbUser = application.getInitParameter("dbUser");
                    String dbPassword = application.getInitParameter("dbPassword");

                    Connection conn = DriverManager.getConnection( dbURL , dbUser , dbPassword );
                    
                    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users;");
                    ResultSet res = pstmt.executeQuery();
                    
                    int i=1;
                    while(res.next()){
                        %>
                        <tr>
                            <td><% out.println(i); %> </td>
                            <td><% out.println(res.getString(1)); %>  </td>
                            <td> <% out.println(res.getString(2)); %> </td>
                            <td> <% out.println(res.getString(3)); %> </td>
                        </tr>
                        <%
                        i++;
                    }
                }catch( Exception e ){
                    out.println(e);
                }
            %>
        </tbody>
    </table>
</body>
</html>