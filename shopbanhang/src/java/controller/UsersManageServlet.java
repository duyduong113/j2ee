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

/**
 *
 * @author DUONG
 */
@MultipartConfig
public class UsersManageServlet extends HttpServlet {

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
        Users usersCurrent = (Users) session.getAttribute("users");
        Users users = new Users();

        String command = "null", command_profile = "";
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
        if (request.getParameter("command_profile") != null) {
            command_profile = request.getParameter("command_profile");
        }
        if (request.getParameter("url") != null) {
            url = request.getParameter("url");
        }

        if (command.equals("login")) {
            String err = "";
            if (request.getParameter("UserName").equals("") || request.getParameter("Password").equals("")) {
                err = "Vui lòng nhập đầy đủ thông tin!";
            } else {
                users = usersDAO.loginByADMIN(request.getParameter("UserName"), MD5.encryption(request.getParameter("Password")));
                if (users == null) {
                    err = "Tên đăng nhập hoặc mật khẩu không đúng!";
                } else if (users.isStatus() == false) {
                    err = "Tài khoản đã bị khóa!";
                }
            }
            if (err.length() > 0) {
                request.setAttribute("err", err);
            }
            try {
                if (err.length() == 0) {
                    session.setAttribute("users", users);
                    url = "/shopbanhang/administrator/index.jsp";
                    response.sendRedirect(url);
                } else {
                    url = "/administrator/login.jsp";
                    RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                    rd.forward(request, response);
                }
            } catch (IOException ex) {
            }
        } else if (command.equals("logout")) {
            session = request.getSession();
            session.invalidate();
            response.sendRedirect("/shopbanhang/administrator/login.jsp");
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
                response.sendRedirect("/shopbanhang/administrator/login.jsp");

            } catch (IOException e) {
            }
        } else if (command.equals("changestatus")) {
            long ID = 0;
            boolean Status = true;
            if (request.getParameter("ID") != null) {
                ID = Long.parseLong(request.getParameter("ID"));
            }
            if (request.getParameter("Status") != null) {
                Status = Boolean.parseBoolean(request.getParameter("Status"));
            }
            try {
                users.setModifiedDate(new Timestamp(new Date().getTime()));
                users.setModifiedBy(usersCurrent.getUserName());// chèn người dùng hiện tại
                users.setStatus(Status);
                users.setID(ID);
                usersDAO.changeStatusUsers(users);
                url = "/shopbanhang/administrator/users.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);

            } catch (IOException e) {
            }
        } else if (command.equals("resetpass")) {
            long ID = 0;
            if (request.getParameter("ID") != null) {
                ID = Long.parseLong(request.getParameter("ID"));
            }
            try {
                users.setModifiedDate(new Timestamp(new Date().getTime()));
                users.setModifiedBy("");// chèn người dùng hiện tại
                users.setPassword(MD5.encryption(AllConstant.Password_Default));
                users.setID(ID);
                usersDAO.ResetPassword(users);
                url = "/shopbanhang/administrator/users.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);

            } catch (IOException e) {
            }
        } else if (command.equals("insertupdate")) {
            String ID = "", UserName = "", Password = "", Name = "", Address = "", Email = "", Phone = "", Image = "", ProvinceCode = "",
                    DistrictCode = "", Status = "", Email_err = "", Phone_err = "", UserName_err = "";

            //get data
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
            if (request.getParameter("Status") != null) {
                Status = request.getParameter("Status");
            }

            //set data
            request.setAttribute("ID", ID);
            request.setAttribute("UserName", UserName);
            request.setAttribute("Name", Name);
            request.setAttribute("Address", Address);
            request.setAttribute("Email", Email);
            request.setAttribute("Phone", Phone);
            request.setAttribute("ProvinceCode", ProvinceCode);
            request.setAttribute("DistrictCode", DistrictCode);
            //request.setAttribute("Status", Status);

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
            try {
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

                //Insert_Update Here
                users.setUserName(UserName);
                users.setPassword(Password.length() == 0 ? MD5.encryption(AllConstant.Password_Default) : MD5.encryption(Password));
                users.setGroupID(AllConstant.Group_MOD);
                users.setName(Name);
                users.setAddress(Address);
                users.setEmail(Email);
                users.setPhone(Phone);
                users.setProvinceCode(ProvinceCode);
                users.setDistrictCode(DistrictCode);
                users.setCreatedDate(new Timestamp(new Date().getTime()));
                users.setCreatedBy(usersCurrent.getUserName());// sét admin
                users.setStatus(Status.length() == 0 ? true : Boolean.parseBoolean(Status));

                if (fileName.length() > 0) {
                    users.setImage(Image);
                    request.setAttribute("Image", Image);
                }
                if (ID.length() > 0) {
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
                        if (command_profile.length() > 0) {
                            session.setAttribute("users", users);
                        }
                    } else {
                        if (command_profile.length() > 0) {
                            url = "/administrator/profile.jsp";
                        } else {
                            url = "/administrator/users.jsp";
                        }
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
                        url = "/shopbanhang/administrator/users.jsp";
                    } else {
                        url = "/administrator/users.jsp";
                        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
                        rd.forward(request, response);
                    }
                }
                response.sendRedirect(url);
            } catch (IOException e) {
            } catch (SQLException ex) {
                Logger.getLogger(UsersManageServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
