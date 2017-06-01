/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.BannerDAO;
import dao.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Banner;
import org.json.simple.JSONObject;

/**
 *
 * @author DUONG
 */
public class getBannerServlet extends HttpServlet {

    BannerDAO bannerDAO = new BannerDAO();
    UsersDAO usersDAO = new UsersDAO();

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
            long ID = 0;
            if (request.getParameter("ID") != null) {
                ID = Long.parseLong(request.getParameter("ID"));
            }
            Banner banner = new Banner();
            banner = bannerDAO.getBannerByID(ID);

            JSONObject json = new JSONObject();
            JSONObject jbanner;
            jbanner = new JSONObject();
            jbanner.put("ID", banner.getID());
            jbanner.put("ProductCode", banner.getProductCode());
            jbanner.put("Advertisement_Name", banner.getAdvertisement_Name());
            jbanner.put("Image", banner.getImage());
            jbanner.put("StartDate", banner.getStartDate().toString());
            jbanner.put("EndDate", banner.getEndDate().toString());
            jbanner.put("CreatedDate", banner.getCreatedDate() == null ? banner.getCreatedDate() : banner.getCreatedDate().toString());
            jbanner.put("CreatedBy", usersDAO.getUserByUserName(banner.getCreatedBy()).getName());
            jbanner.put("ModifiedDate", banner.getModifiedDate() == null ? banner.getModifiedDate() : banner.getModifiedDate().toString());
            jbanner.put("ModifiedBy", usersDAO.getUserByUserName(banner.getModifiedBy()).getName());
            jbanner.put("Status", banner.isStatus());

            json.put("banner", jbanner);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());

        } catch (SQLException ex) {
            Logger.getLogger(getBannerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
