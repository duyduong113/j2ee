package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import model.Feedback;
import org.json.simple.JSONObject;

public class getFeedbackServlet extends HttpServlet {

    FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        try {
            String ID = "0";
            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            Feedback feedback = new Feedback();
            feedback = feedbackDAO.getFeedback(Long.parseLong(ID));
            DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
            //change status
            if(feedback.isStatus()==false){
                feedback.setStatus(true);
                feedbackDAO.changeStatusFeedback(feedback);
            }
            //return data
            JSONObject json = new JSONObject();
            JSONObject jfeedback;
            jfeedback = new JSONObject();
            jfeedback.put("ID", feedback.getID());
            jfeedback.put("Name", feedback.getName());
            jfeedback.put("Phone", feedback.getPhone());
            jfeedback.put("Email", feedback.getEmail());
            jfeedback.put("Address", feedback.getAddress());
            jfeedback.put("Content", feedback.getContent());
            jfeedback.put("CreatedDate", feedback.getCreatedDate() == null ? "" : dateformat.format(feedback.getCreatedDate()).toString());
            jfeedback.put("Status", feedback.isStatus());

            json.put("feedback", jfeedback);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getOrdersServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
