/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import dao.BannerDAO;
import dao.UsersDAO;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Banner;
import model.Users;

/**
 *
 * @author DUONG
 */
@MultipartConfig
public class BannerServlet extends HttpServlet {

    UsersDAO usersDAO = new UsersDAO();
    BannerDAO bannerDAO = new BannerDAO();

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

        HttpSession session = request.getSession();
        Users usersCurrent = (Users) session.getAttribute("users");

        Banner banner = new Banner();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

        String command = "null";
        String url = "";
        String pages = "1";
        String keyword = "";
        if (request.getParameter("keyword") != null) {
            keyword = request.getParameter("keyword");
        }
        if (request.getParameter("pages") != null) {
            pages = request.getParameter("pages");
        }
        if (request.getParameter("command") != null) {
            command = request.getParameter("command");
        }
        if (request.getParameter("url") != null) {
            url = request.getParameter("url");
        }

        if (command.equals("changestatus")) {
            long ID = 0;
            boolean Status = true;
            if (request.getParameter("ID") != null) {
                ID = Long.parseLong(request.getParameter("ID"));
            }
            if (request.getParameter("Status") != null) {
                Status = Boolean.parseBoolean(request.getParameter("Status"));
            }
            try {
                banner.setModifiedDate(new Timestamp(new Date().getTime()));
                banner.setModifiedBy(usersCurrent.getUserName());// chèn người dùng hiện tại
                banner.setStatus(Status);
                banner.setID(ID);
                bannerDAO.changeStatusBanner(banner);
                url = "/shopbanhang/administrator/banner.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);

            } catch (IOException e) {
            }
        } else if (command.equals("insertupdate")) {

            String ID = "", ProductCode = "", Advertisement_Name = "", Image = "", StartDate = "", EndDate = "", Status = "";
            //get dataEndDate
            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            if (request.getParameter("ProductCode") != null) {
                ProductCode = request.getParameter("ProductCode");
            }
            if (request.getParameter("Advertisement_Name") != null) {
                Advertisement_Name = request.getParameter("Advertisement_Name");
            }
            if (request.getParameter("StartDate") != null) {
                StartDate = request.getParameter("StartDate");
            }
            if (request.getParameter("EndDate") != null) {
                EndDate = request.getParameter("EndDate");
            }
            if (request.getParameter("Status") != null) {
                Status = request.getParameter("Status");
            }

            // UPLOAD FILE 
            String appPath = request.getServletContext().getRealPath("");
            // constructs path of the directory to save uploaded file
            String savePath = appPath + File.separator + AllConstant.UPLOAD_DIRECTORY_CATEGORYS;
            // creates the directory if it does not exist
            File uploadDir = new File(savePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            Part part = request.getPart("file");
            String fileName = part.getSubmittedFileName();
            fileName = new File(fileName).getName();
            //set image link
            Image = AllConstant.UPLOAD_DIRECTORY_CATEGORYS + File.separator + fileName;

            //File storeFile = new File(PathFile);                
            //String absolutePath = storeFile.getAbsolutePath();
            //part.write(PathFile);
            try {
                OutputStream out = null;
                InputStream filecontent = null;
                //final PrintWriter writer = response.getWriter();
                try {
                    out = new FileOutputStream(new File(savePath + File.separator + fileName));
                    filecontent = part.getInputStream();
                    int read = 0;
                    final byte[] bytes = new byte[1024];
                    while ((read = filecontent.read(bytes)) != -1) {
                        out.write(bytes, 0, read);
                    }
                } catch (FileNotFoundException fne) {
                } finally {
                    if (out != null) {
                        out.close();
                    }
                    if (filecontent != null) {
                        filecontent.close();
                    }
                }

                //Date test = df.parse(StartDate);
                //Insert_Update Here
                banner.setProductCode(ProductCode);
                banner.setAdvertisement_Name(Advertisement_Name);
                banner.setStartDate(df.parse(StartDate));
                banner.setEndDate(df.parse(EndDate));
                banner.setCreatedDate(new Timestamp(new Date().getTime()));
                banner.setCreatedBy(usersCurrent.getUserName());// sét admin
                banner.setStatus(Status.length() == 0 ? true : Boolean.parseBoolean(Status));
                if (fileName.length() > 0) {
                    banner.setImage(Image);
                }
                if (ID.length() > 0) {
                    //Insert Productcategory
                    banner.setID(Long.parseLong(ID));
                    banner.setImage(fileName.length() == 0 ? bannerDAO.getBannerByID(Long.parseLong(ID)).getImage() : Image);
                    banner.setModifiedDate(new Timestamp(new Date().getTime()));
                    banner.setModifiedBy(usersCurrent.getUserName());// sét admin
                    bannerDAO.updateBanner(banner);
                } else {
                    bannerDAO.insertBanner(banner);
                    url = "/shopbanhang/administrator/banner.jsp";
                }
                response.sendRedirect(url);
            } catch (IOException e) {
            } catch (SQLException ex) {
                Logger.getLogger(BannerServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ParseException ex) {
                Logger.getLogger(BannerServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
