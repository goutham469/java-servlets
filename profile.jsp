<%@ page import="jakarta.servlet.http.Cookie" %>

<%
    Cookie[] cookies = request.getCookies();
    String username = "";

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("name")) {
                username = cookie.getValue();
                break;
            }
        }

        if (username.equals("")) {
            out.println("Some problem occurred");
        } else {
            out.println("Username: " + username);
        }
    } else {
        out.println("You are not logged in.");
    }
%>
