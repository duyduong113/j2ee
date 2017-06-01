/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import common.MD5;
import dao.HelperDAO;
import dao.UsersDAO;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
import model.Users;

@MultipartConfig
public class UsersServlet extends HttpServlet {

    UsersDAO usersDAO = new UsersDAO();
    HelperDAO helperDAO = new HelperDAO();

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
        Users usersCurrent = (Users) session.getAttribute("user");

        String command = "", url = "";
        if (request.getParameter("command") != null) {
            command = request.getParameter("command");
        }

        Users users = new Users();
        if (command.equals("login")) {
            String login_err = "";
            if (request.getParameter("UserName").equals("") || request.getParameter("Password").equals("")) {
                login_err = "Vui lòng nhập đầy đủ thông tin!";
            } else {
                users = usersDAO.login(request.getParameter("UserName"), MD5.encryption(request.getParameter("Password")));
                if (users == null) {
                    login_err = "Tên đăng nhập hoặc mật khẩu không đúng!";
                }else if(users.isStatus()==false){
                     login_err = "Tài khoản của bạn đã bị khóa!";
                }
            }
            if (login_err.length() > 0) {
                request.setAttribute("login_err", login_err);
            }
            try {
                if (login_err.length() == 0) {
                    session.setAttribute("user", users);
                    url = "/shopbanhang/index.jsp";
                    response.sendRedirect(url);
                } else {
                    url = "/login.jsp";
                    RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                    rd.forward(request, response);
                }
            } catch (IOException | ServletException e) {
            }
        } else if (command.equals("insertupdate")) {
            String UserName_err = "", Email_err = "", Phone_err = "",
                    ID = "", UserName = "", Password = "", Name = "", Address = "", Email = "", Phone = "", Image = "", ProvinceCode = "", DistrictCode = "";

            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            if (request.getParameter("UserName") != null) {
                UserName = request.getParameter("UserName");
            }
            if (request.getParameter("Password") != null) {
                Password = request.getParameter("Password");
            }
            if (request.getParameter("Name") != null) {
                Name = request.getParameter("Name");
            }
            if (request.getParameter("Address") != null) {
                Address = request.getParameter("Address");
            }
            if (request.getParameter("Email") != null) {
                Email = request.getParameter("Email");
            }
            if (request.getParameter("Phone") != null) {
                Phone = request.getParameter("Phone");
            }
            if (request.getParameter("ProvinceCode") != null) {
                ProvinceCode = request.getParameter("ProvinceCode");
            }
            if (request.getParameter("DistrictCode") != null) {
                DistrictCode = request.getParameter("DistrictCode");
            }

            //set data
            request.setAttribute("UserName", UserName);
            request.setAttribute("Password", Password);
            request.setAttribute("Name", Name);
            request.setAttribute("Address", Address);
            request.setAttribute("Email", Email);
            request.setAttribute("Phone", Phone);
            request.setAttribute("ProvinceCode", ProvinceCode);
            request.setAttribute("DistrictCode", DistrictCode);

            try {
                //Insert_Update Here
                users.setUserName(UserName);
                users.setPassword(Password.length() == 0 ? MD5.encryption(AllConstant.Password_Default) : MD5.encryption(Password));
                users.setGroupID(AllConstant.Group_MEMBER);
                users.setName(Name);
                users.setAddress(Address);
                users.setEmail(Email);
                users.setPhone(Phone);
                users.setProvinceCode(ProvinceCode);
                users.setDistrictCode(DistrictCode);
                users.setCreatedDate(new Timestamp(new Date().getTime()));
                users.setCreatedBy(AllConstant.System);// sét admin
                users.setStatus(true);

                if (ID.length() > 0) {
                    // UPLOAD FILE 
                    String appPath = request.getServletContext().getRealPath("");
                    // constructs path of the directory to save uploaded file
                    String savePath = appPath + File.separator + AllConstant.UPLOAD_DIRECTORY_USERS;
                    // creates the directory if it does not exist
                    File uploadDir = new File(savePath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    Part part = request.getPart("file");
                    String fileName = part.getSubmittedFileName();
                    fileName = new File(fileName).getName();
                    //set image link
                    Image = AllConstant.UPLOAD_DIRECTORY_USERS + File.separator + fileName;
                    OutputStream out = null;
                    InputStream filecontent = null;
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
                    if (fileName.length() > 0) {
                        users.setImage(Image);
                        request.setAttribute("Image", Image);
                    }

                    //Validate data UPDATE
                    if (helperDAO.isValidEmailAddress(Email) == false) {
                        Email_err = "Địa chỉ Email không hợp lệ!";
                    } else if (usersDAO.checkEmailExist(Email)) {
                        if (usersDAO.checkEmailExist(Long.parseLong(ID), Email) == false) {
                            Email_err = "Địa chỉ Email này đã tồn tại!";
                        }
                    }
                    if (Email_err.length() > 0) {
                        request.setAttribute("Email_err", Email_err);
                    }
                    if (usersDAO.checkPhoneExist(Phone)) {
                        if (usersDAO.checkPhoneExist(Long.parseLong(ID), Phone) == false) {
                            Phone_err = "Số điện thoại này đã tồn tại!";
                        }
                    }
                    if (Phone_err.length() > 0) {
                        request.setAttribute("Phone_err", Phone_err);
                    }
                    if (Email_err.length() == 0 && Phone_err.length() == 0) {
                        //update customer
                        users.setModifiedDate(new Timestamp(new Date().getTime()));
                        users.setModifiedBy("");// sét admin
                        users.setID(Long.parseLong(ID));
                        users.setImage(fileName.length() == 0 ? usersDAO.getUser(Long.parseLong(ID)).getImage() : Image);
                        users.setPassword(Password.length() == 0 ? MD5.encryption(usersDAO.getUser(Long.parseLong(ID)).getPassword()) : MD5.encryption(Password));
                        usersDAO.updateUsers(users);

                        //update session current
                        session.setAttribute("user", users);
                        url = "/shopbanhang/profile.jsp";
                        response.sendRedirect(url);
                    } else {
                        url = "/profile.jsp";
                        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                        rd.forward(request, response);
                    }
                } else {
                    //Validate data INSERT
                    if (usersDAO.checkUserNameExist(UserName)) {
                        UserName_err = "Tên đăng nhập đã tồn tại!";
                    }
                    if (UserName_err.length() > 0) {
                        request.setAttribute("UserName_err", UserName_err);
                    }
                    if (helperDAO.isValidEmailAddress(Email) == false) {
                        Email_err = "Địa chỉ Email không hợp lệ!";
                    } else if (usersDAO.checkEmailExist(Email)) {
                        Email_err = "Địa chỉ Email này đã tồn tại!";
                    }
                    if (Email_err.length() > 0) {
                        request.setAttribute("Email_err", Email_err);
                    }
                    if (usersDAO.checkPhoneExist(Phone)) {
                        Phone_err = "Số điện thoại này đã tồn tại!";
                    }
                    if (Phone_err.length() > 0) {
                        request.setAttribute("Phone_err", Phone_err);
                    }
                    if (UserName_err.length() == 0 && Email_err.length() == 0 && Phone_err.length() == 0) {
                        //Insert Product
                        usersDAO.insertUsers(users);
                        users = usersDAO.getUserByUserName(UserName);
                         session.setAttribute("user", users);
                         url = "/shopbanhang/index.jsp";
                         response.sendRedirect(url);
                    } else {
                        url = "/register.jsp";
                        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                        rd.forward(request, response);
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(UsersServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (command.equals("changepassword")) {
            long ID = 0;
            String Password = "";
            if (request.getParameter("Password") != null) {
                Password = request.getParameter("Password");
            }
            if (request.getParameter("ID") != null) {
                ID = Long.parseLong(request.getParameter("ID"));
            }
            try {
                users.setModifiedDate(new Timestamp(new Date().getTime()));
                users.setModifiedBy(usersCurrent.getUserName());// chèn người dùng hiện tại
                users.setPassword(Password.length() > 0 ? MD5.encryption(Password) : MD5.encryption(AllConstant.Password_Default));
                users.setID(usersCurrent.getID());
                usersDAO.changePassword(users);
                session.invalidate();
                response.sendRedirect("/shopbanhang//login.jsp");

            } catch (IOException e) {
            }

        } else if (command.equals("logout")) {
            session.invalidate();
            response.sendRedirect("/shopbanhang/index.jsp");
        }
    }
}
