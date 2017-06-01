/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import common.AllConstant;
import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;

/**
 *
 * @author DUONG
 */
public class UsersDAO {

    // kiểm tra email tồn tại chưa
    public boolean checkEmailExist(String email) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE Email = '" + email + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // kiểm tra email tồn tại chưa
    public boolean checkEmailExist(long ID, String email) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE ID=" + ID + " AND Email = '" + email + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // kiểm tra username tồn tại chưa
    public boolean checkUserNameExist(String username) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE UserName = '" + username + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // kiểm tra username tồn tại chưa
    public boolean checkUserNameExist(long ID, String username) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE ID= " + ID + " AND UserName = '" + username + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // kiểm tra Số điênh thoại tồn tại chưa
    public boolean checkPhoneExist(String phone) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE Phone = '" + phone + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // kiểm tra Số điênh thoại tồn tại chưa
    public boolean checkPhoneExist(long ID, String phone) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE ID=" + ID + " AND Phone = '" + phone + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // phương thức thêm tài khoản
    public boolean insertUsers(Users u) {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO Users VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setString(1, u.getUserName());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getGroupID());
            ps.setString(4, u.getName());
            ps.setString(5, u.getAddress());
            ps.setString(6, u.getEmail());
            ps.setString(7, u.getPhone());
            ps.setString(8, u.getImage());
            ps.setString(9, u.getProvinceCode());
            ps.setString(10, u.getDistrictCode());
            ps.setTimestamp(11, u.getCreatedDate());
            ps.setString(12, u.getCreatedBy());
            ps.setTimestamp(13, u.getModifiedDate());
            ps.setString(14, u.getModifiedBy());
            ps.setBoolean(15, u.isStatus());

            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // phương thức sửa tài khoản
    public boolean updateUsers(Users u) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Users SET GroupID=?,Name=?,Address=?,Email=?,Phone=?,Image=?,ProvinceCode=?,DistrictCode=?,ModifiedDate=?,ModifiedBy=?,Status=? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, u.getGroupID());
            ps.setString(2, u.getName());
            ps.setString(3, u.getAddress());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPhone());
            ps.setString(6, u.getImage());
            ps.setString(7, u.getProvinceCode());
            ps.setString(8, u.getDistrictCode());
            ps.setTimestamp(9, u.getModifiedDate());
            ps.setString(10, u.getModifiedBy());
            ps.setBoolean(11, u.isStatus());
            ps.setLong(12, u.getID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
        // phương thức update pass
    public boolean changePassword(Users u) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Users SET Password=?,ModifiedDate=?,ModifiedBy=? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
           
            ps.setString(1, u.getPassword());
            ps.setTimestamp(2, u.getModifiedDate());
            ps.setString(3, u.getModifiedBy());
            ps.setLong(4, u.getID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // kiểm tra đăng nhập
    public Users login(String username, String password) {
        Connection con = DBConnect.getConnect();
        String sql = "select * from Users where UserName='" + username + "' and Password='" + password + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users u = new Users();
                u.setID(rs.getLong("ID"));
                u.setUserName(rs.getString("UserName"));
                u.setPassword(rs.getString("Password"));
                u.setGroupID(rs.getString("GroupID"));
                u.setName(rs.getString("Name"));
                u.setAddress(rs.getString("Address"));
                u.setEmail(rs.getString("Email"));
                u.setPhone(rs.getString("Phone"));
                u.setImage(rs.getString("Image"));
                u.setProvinceCode(rs.getString("ProvinceCode"));
                u.setDistrictCode(rs.getString("DistrictCode"));
                u.setCreatedBy(rs.getString("CreatedBy"));
                u.setModifiedBy(rs.getString("ModifiedBy"));
                u.setCreatedDate(rs.getTimestamp("CreatedDate"));
                u.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                u.setStatus(rs.getBoolean("Status"));
                con.close();
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // kiểm tra đăng nhập
    public Users loginByADMIN(String username, String password) {
        Connection con = DBConnect.getConnect();
        String sql = "select * from Users where GroupID != '" + AllConstant.Group_MEMBER + "' AND UserName='" + username + "' and Password='" + password + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users u = new Users();
                u.setID(rs.getLong("ID"));
                u.setUserName(rs.getString("UserName"));
                u.setPassword(rs.getString("Password"));
                u.setGroupID(rs.getString("GroupID"));
                u.setName(rs.getString("Name"));
                u.setAddress(rs.getString("Address"));
                u.setEmail(rs.getString("Email"));
                u.setPhone(rs.getString("Phone"));
                u.setImage(rs.getString("Image"));
                u.setProvinceCode(rs.getString("ProvinceCode"));
                u.setDistrictCode(rs.getString("DistrictCode"));
                u.setCreatedBy(rs.getString("CreatedBy"));
                u.setModifiedBy(rs.getString("ModifiedBy"));
                u.setCreatedDate(rs.getTimestamp("CreatedDate"));
                u.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                u.setStatus(rs.getBoolean("Status"));
                con.close();
                return u;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public Users getUser(long userID) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE ID = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, userID);
        ResultSet rs = ps.executeQuery();
        Users u = new Users();
        while (rs.next()) {
            u.setID(rs.getLong("ID"));
            u.setUserName(rs.getString("UserName"));
            u.setPassword(rs.getString("Password"));
            u.setGroupID(rs.getString("GroupID"));
            u.setName(rs.getString("Name"));
            u.setAddress(rs.getString("Address"));
            u.setEmail(rs.getString("Email"));
            u.setPhone(rs.getString("Phone"));
            u.setImage(rs.getString("Image"));
            u.setProvinceCode(rs.getString("ProvinceCode"));
            u.setDistrictCode(rs.getString("DistrictCode"));
            u.setCreatedDate(rs.getTimestamp("CreatedDate"));
            u.setCreatedBy(rs.getString("CreatedBy"));
            u.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            u.setModifiedBy(rs.getString("ModifiedBy"));
            u.setStatus(rs.getBoolean("Status"));
        }
        return u;
    }
    
       public Users getUserByUserName(String UserName) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Users WHERE UserName = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, UserName);
        ResultSet rs = ps.executeQuery();
        Users u = new Users();
        while (rs.next()) {
            u.setID(rs.getLong("ID"));
            u.setUserName(rs.getString("UserName"));
            u.setPassword(rs.getString("Password"));
            u.setGroupID(rs.getString("GroupID"));
            u.setName(rs.getString("Name"));
            u.setAddress(rs.getString("Address"));
            u.setEmail(rs.getString("Email"));
            u.setPhone(rs.getString("Phone"));
            u.setImage(rs.getString("Image"));
            u.setProvinceCode(rs.getString("ProvinceCode"));
            u.setDistrictCode(rs.getString("DistrictCode"));
            u.setCreatedDate(rs.getTimestamp("CreatedDate"));
            u.setCreatedBy(rs.getString("CreatedBy"));
            u.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            u.setModifiedBy(rs.getString("ModifiedBy"));
            u.setStatus(rs.getBoolean("Status"));
        }
        return u;
    }

    public ArrayList<Users> getListUserByGroupIDNav(String GroupID, String keyword, int offset, int fetchnext) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT * FROM Users WHERE GroupID = '" + GroupID + "' AND dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ORDER BY ID DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY";
            PreparedStatement ps = connection.prepareCall(sql);
//            ps.setString(1, GroupID);
            ResultSet rs = ps.executeQuery();
            ArrayList<Users> lst = new ArrayList<>();
            while (rs.next()) {
                Users u = new Users();
                u.setID(rs.getLong("ID"));
                u.setUserName(rs.getString("UserName"));
                u.setPassword(rs.getString("Password"));
                u.setGroupID(rs.getString("GroupID"));
                u.setName(rs.getString("Name"));
                u.setAddress(rs.getString("Address"));
                u.setEmail(rs.getString("Email"));
                u.setPhone(rs.getString("Phone"));
                u.setImage(rs.getString("Image"));
                u.setProvinceCode(rs.getString("ProvinceCode"));
                u.setDistrictCode(rs.getString("DistrictCode"));
                u.setCreatedDate(rs.getTimestamp("CreatedDate"));
                u.setCreatedBy(rs.getString("CreatedBy"));
                u.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                u.setModifiedBy(rs.getString("ModifiedBy"));
                u.setStatus(rs.getBoolean("Status"));
                lst.add(u);
            }
            return lst;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // tính tổng sản phẩm tìm kiếm
    public int countUsersByGroupIDNav(String GroupID, String keyword) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(ID) FROM Users WHERE GroupID = '" + GroupID + "' AND dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    //cập nhật trạng thái
    public boolean changeStatusUsers(Users u) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Users SET ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setTimestamp(1, u.getModifiedDate());
            ps.setString(2, u.getModifiedBy());
            ps.setBoolean(3, u.isStatus());
            ps.setLong(4, u.getID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //reset mật khẩu
    public boolean ResetPassword(Users u) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Users SET ModifiedDate = ?, ModifiedBy = ?, Password = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setTimestamp(1, u.getModifiedDate());
            ps.setString(2, u.getModifiedBy());
            ps.setString(3, u.getPassword());
            ps.setLong(4, u.getID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) throws SQLException {
        //System.out.println(new Timestamp(new Date().getTime()));
        Users u = new Users();
        u.setModifiedDate(new Timestamp(new Date().getTime()));
        u.setModifiedBy("");
        u.setPassword("ádadasdsadasd");
        u.setID(28);
        new UsersDAO().ResetPassword(u);
        //System.out.println(new UsersDAO().ResetPassword("MEMBER", ""));

    }

}
