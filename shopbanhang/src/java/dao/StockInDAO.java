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
import model.StockIn;

/**
 *
 * @author DUONG
 */
public class StockInDAO {

    public void insertStockIn(StockIn stockin) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "INSERT INTO StockIn VALUES(?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            
            ps.setString(1, stockin.getCode());
            ps.setTimestamp(2, stockin.getCreatedDate());
            ps.setString(3, stockin.getCreatedBy());
            ps.setTimestamp(4, stockin.getModifiedDate());
            ps.setString(5, stockin.getModifiedBy());
            ps.setString(6, stockin.getNote());
            ps.setInt(7, stockin.getStatus());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StockInDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateStockIn(StockIn stockin) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "UPDATE StockIn SET ModifiedDate = ?, ModifiedBy=?, Note=? WHERE Code = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setTimestamp(1, stockin.getModifiedDate());
            ps.setString(2, stockin.getModifiedBy());
            ps.setString(3, stockin.getNote());
            ps.setString(4, stockin.getCode());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(StockInDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<StockIn> getListStockInByNav(String keyword, int offset, int fetchnext) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT * FROM StockIn WHERE dbo.fuConvertToUnsign1(Code) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<StockIn> list = new ArrayList<>();
            while (rs.next()) {
                StockIn stockin = new StockIn();
                stockin.setID(rs.getLong("ID"));
                stockin.setCode(rs.getString("Code"));
                stockin.setCreatedDate(rs.getTimestamp("CreatedDate"));
                stockin.setCreatedBy(rs.getString("CreatedBy"));
                stockin.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                stockin.setModifiedBy(rs.getString("ModifiedBy"));
                stockin.setNote(rs.getString("Note"));
                stockin.setStatus(rs.getInt("Status"));
                list.add(stockin);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(StockInDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // tính tổng sản phẩm tìm kiếm
    public int countStockInByNav(String keyword) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(Code) FROM StockIn WHERE dbo.fuConvertToUnsign1(Code) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    //cập nhật trạng thái
    public boolean changeStatusStockIn(StockIn stockin) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE StockIn SET ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE Code = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setTimestamp(1, stockin.getModifiedDate());
            ps.setString(2, stockin.getModifiedBy());
            ps.setInt(3, stockin.getStatus());
            ps.setString(4, stockin.getCode());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(StockInDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public StockIn getStockInByCode(String Code) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT * FROM StockIn WHERE  Code= '" + Code + "'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            StockIn stockin = new StockIn();
            while (rs.next()) {
                stockin.setID(rs.getLong("ID"));
                stockin.setCode(rs.getString("Code"));
                stockin.setCreatedDate(rs.getTimestamp("CreatedDate"));
                stockin.setCreatedBy(rs.getString("CreatedBy"));
                stockin.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                stockin.setModifiedBy(rs.getString("ModifiedBy"));
                stockin.setNote(rs.getString("Note"));
                stockin.setStatus(rs.getInt("Status"));
            }
            return stockin;
        } catch (SQLException ex) {
            Logger.getLogger(StockInDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public StockIn getStockInTOP() {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT TOP 1 * FROM StockIn ORDER BY CODE DESC";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            StockIn stockin = new StockIn();
            while (rs.next()) {
                stockin.setID(rs.getLong("ID"));
                stockin.setCode(rs.getString("Code"));
                stockin.setCreatedDate(rs.getTimestamp("CreatedDate"));
                stockin.setCreatedBy(rs.getString("CreatedBy"));
                stockin.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                stockin.setModifiedBy(rs.getString("ModifiedBy"));
                stockin.setNote(rs.getString("Note"));
                stockin.setStatus(rs.getInt("Status"));
            }
            return stockin;
        } catch (SQLException ex) {
            Logger.getLogger(StockInDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static void main(String[] args) {
        
        System.out.println(new StockInDAO().getStockInTOP().getCode());
    }

}
