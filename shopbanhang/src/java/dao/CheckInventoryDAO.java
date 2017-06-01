/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CheckInventory;

/**
 *
 * @author DUONG
 */
public class CheckInventoryDAO {

    public void insertCheckInventory(CheckInventory checkInventory) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "INSERT INTO CheckInventory VALUES(?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setString(1, checkInventory.getCode());
            ps.setString(2, checkInventory.getDescription());
            ps.setTimestamp(3, checkInventory.getCreatedDate());
            ps.setString(4, checkInventory.getCreatedBy());
            ps.setTimestamp(5, checkInventory.getModifiedDate());
            ps.setString(6, checkInventory.getModifiedBy());
            ps.setBoolean(7, checkInventory.isStatus());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateCheckInventory(CheckInventory checkInventory) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "UPDATE CheckInventory SET ModifiedDate = ?, ModifiedBy=?, Description=? WHERE Code = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setTimestamp(1, checkInventory.getModifiedDate());
            ps.setString(2, checkInventory.getModifiedBy());
            ps.setString(3, checkInventory.getDescription());
            ps.setString(4, checkInventory.getCode());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<CheckInventory> getListCheckInventoryByNav(String keyword, int offset, int fetchnext) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT * FROM CheckInventory WHERE dbo.fuConvertToUnsign1(Code) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<CheckInventory> list = new ArrayList<>();
            while (rs.next()) {
                CheckInventory checkInventory = new CheckInventory();
                checkInventory.setID(rs.getLong("ID"));
                checkInventory.setCode(rs.getString("Code"));
                checkInventory.setDescription(rs.getString("Description"));
                checkInventory.setCreatedDate(rs.getTimestamp("CreatedDate"));
                checkInventory.setCreatedBy(rs.getString("CreatedBy"));
                checkInventory.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                checkInventory.setModifiedBy(rs.getString("ModifiedBy"));
                checkInventory.setStatus(rs.getBoolean("Status"));
                list.add(checkInventory);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // tính tổng sản phẩm tìm kiếm
    public int countCheckInventoryByNav(String keyword) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(Code) FROM CheckInventory WHERE dbo.fuConvertToUnsign1(Code) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    //cập nhật trạng thái
    public boolean changeStatusCheckInventory(CheckInventory checkInventory) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE CheckInventory SET ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE Code = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setTimestamp(1, checkInventory.getModifiedDate());
            ps.setString(2, checkInventory.getModifiedBy());
            ps.setBoolean(3, checkInventory.isStatus());
            ps.setString(4, checkInventory.getCode());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public CheckInventory getCheckInventoryByCode(String Code) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT * FROM CheckInventory WHERE  Code= '" + Code + "'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            CheckInventory checkInventory = new CheckInventory();
            while (rs.next()) {
                checkInventory.setID(rs.getLong("ID"));
                checkInventory.setCode(rs.getString("Code"));
                checkInventory.setDescription(rs.getString("Description"));
                checkInventory.setCreatedDate(rs.getTimestamp("CreatedDate"));
                checkInventory.setCreatedBy(rs.getString("CreatedBy"));
                checkInventory.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                checkInventory.setModifiedBy(rs.getString("ModifiedBy"));
                checkInventory.setStatus(rs.getBoolean("Status"));
            }
            return checkInventory;
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
        public CheckInventory getTOPCheckInventory() {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT TOP 1 * FROM CheckInventory order by Code Desc";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            CheckInventory checkInventory = new CheckInventory();
            while (rs.next()) {
                checkInventory.setID(rs.getLong("ID"));
                checkInventory.setCode(rs.getString("Code"));
                checkInventory.setDescription(rs.getString("Description"));
                checkInventory.setCreatedDate(rs.getTimestamp("CreatedDate"));
                checkInventory.setCreatedBy(rs.getString("CreatedBy"));
                checkInventory.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                checkInventory.setModifiedBy(rs.getString("ModifiedBy"));
                checkInventory.setStatus(rs.getBoolean("Status"));
            }
            return checkInventory;
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
