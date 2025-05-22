<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
</head>
<%
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        String username="",password="";
        for( Cookie cookie : cookies )
        {
            if(cookie.getName().equals("name")){
                username = cookie.getValue();
            }
            if(cookie.getName().equals("password")){
                password = cookie.getValue();
            }
        }

        if( username == "" || password == "" ){
            response.sendRedirect("../user-login.jsp");
        }
    }else{
        response.sendRedirect("../user-login.jsp");
    }
%>
<frameset rows="15%, 80%">
    <frame src="navigation.jsp" name="navigation" />
    <frame src="all-answers.jsp" name="outlet" />
</frameset>
</html>  