import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class SubmitAnswerForm extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        String id = req.getParameter("id");
        String question = req.getParameter("question");

        String form =
            "<form action='submit-answer' method='post'>" +
            "<label>Question ID:</label><br/>" +
            "<input type='text' name='id' value='" + id + "' readonly /><br/><br/>" +
            "<label>Question:</label><br/>" +
            "<input type='text' name='question' value='" + question + "' readonly /><br/><br/>" +
            "<label>Your Answer:</label><br/>" +
            "<textarea name='answer' rows='5' cols='50'></textarea><br/><br/>" +
            "<input type='submit' value='Submit Answer' />" +
            "</form>";

        out.println("<html><body>");
        out.println("<h2>Submit Your Answer</h2>");
        out.println(form);
        out.println("</body></html>");
    }
}
