/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import dao.ProductCategoryDAO;
import dao.UsersDAO;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.ProductCategory;
import model.Users;

/**
 *
 * @author DUONG
 */
@MultipartConfig
//@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
//        maxFileSize = 1024 * 1024 * 10,
//        maxRequestSize = 1024 * 1024 * 50,
//        location = "/")
public class ProductCategoryServlet extends HttpServlet {

    ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
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

        HttpSession session = request.getSession();
        Users usersCurrent = (Users) session.getAttribute("users");

        ProductCategory productCategory = new ProductCategory();

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
                productCategory.setModifiedDate(new Timestamp(new Date().getTime()));
                productCategory.setModifiedBy("");// chèn người dùng hiện tại
                productCategory.setStatus(Status);
                productCategory.setID(ID);
                productCategoryDAO.changeStatusProductCategory(productCategory);
                url = "/shopbanhang/administrator/category.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);

            } catch (IOException e) {
            }
        } else if (command.equals("insertupdate")) {
            String ID = "", Name = "", Status = "true", Image = "",
                    Name_err = "";
            //get data
            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            if (request.getParameter("Name") != null) {
                Name = request.getParameter("Name");
            }
            if (request.getParameter("Status") != null) {
                Status = request.getParameter("Status");
            }

            //set data
            request.setAttribute("ID", ID);
            request.setAttribute("Name", Name);
            request.setAttribute("Status", Status);

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
//                        if (writer != null) {
//                            writer.close();
//                        }
                }
                //Insert_Update Here
                productCategory.setName(Name);
                productCategory.setCreatedDate(new Timestamp(new Date().getTime()));
                productCategory.setCreatedBy(usersCurrent.getUserName());// sét admin
                productCategory.setStatus(Status == null ? true : Boolean.parseBoolean(Status));
                if (fileName.length() > 0) {
                    productCategory.setImage(Image);
                    request.setAttribute("Image", Image);
                }
                if (ID.length() > 0) {
                    //Validate data UPDATE
                    if (productCategoryDAO.checkProductCategoryNameExist(Name)) {
                        if (productCategoryDAO.checkProductCategoryNameExist(Long.parseLong(ID), Name) == false) {
                            Name_err = "Tên danh mục đã tồn tại!";
                        }
                    }
                    if (Name_err.length() > 0) {
                        request.setAttribute("Name_err", Name_err);
                    }
                    if (Name_err.length() == 0) {
                        //Insert Productcategory
                        productCategory.setID(Long.parseLong(ID));
                        productCategory.setImage(fileName.length() == 0 ? productCategoryDAO.getProductCategoryByID(Long.parseLong(ID)).getImage() : Image);
                        productCategoryDAO.updateProductCategory(productCategory);
                    } else {
                        url = "/administrator/category.jsp";
                        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                        rd.forward(request, response);
                    }

                } else {
                    //validate insert
                    if (productCategoryDAO.checkProductCategoryNameExist(Name)) {
                        Name_err = "Tên danh mục đã tồn tại!";
                    }
                    if (Name_err.length() > 0) {
                        request.setAttribute("Name_err", Name_err);
                    }
                    if (Name_err.length() == 0) {
                        productCategoryDAO.insertProductCategory(productCategory);
                        url = "/shopbanhang/administrator/category.jsp";

                    } else {
                        url = "/administrator/category.jsp";
                        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                        rd.forward(request, response);
                    }
                }
                response.sendRedirect(url);
            } catch (IOException e) {
            } catch (SQLException ex) {
                Logger.getLogger(ProductCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }
}
