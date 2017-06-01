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
import model.CheckInventoryDetail;

/**
 *
 * @author DUONG
 */
public class CheckInventoryDetailDAO {
     public void insertCheckInventoryDetail(CheckInventoryDetail checkInventoryDetail) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "INSERT INTO CheckInventoryDetail VALUES(?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, checkInventoryDetail.getCheckInventoryCode());
            ps.setString(2, checkInventoryDetail.getProductCode());
            ps.setInt(3, checkInventoryDetail.getQuantity());
             ps.setInt(4, checkInventoryDetail.getStockOnhand());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
     
         public ArrayList<CheckInventoryDetail> getListCheckInventoryDetailByStockInCode(String CheckInventoryCode) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * FROM CheckInventoryDetail where CheckInventoryCode='" + CheckInventoryCode + "' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<CheckInventoryDetail> list = new ArrayList<>();
        while (rs.next()) {
            CheckInventoryDetail checkInventoryDetail = new CheckInventoryDetail();
            checkInventoryDetail.setID(rs.getLong("ID"));
            checkInventoryDetail.setCheckInventoryCode(rs.getString("CheckInventoryCode"));
            checkInventoryDetail.setProductCode(rs.getString("ProductCode"));
            checkInventoryDetail.setQuantity(rs.getInt("Quantity"));
            checkInventoryDetail.setStockOnhand(rs.getInt("StockOnhand"));
            list.add(checkInventoryDetail);
        }
        return list;
    }

    // xóa dữ liệu
    public boolean deleteCheckInventoryDetail(String CheckInventoryCode) {
        Connection connection = DBConnect.getConnect();
        String sql = "DELETE FROM CheckInventoryDetail WHERE CheckInventoryCode = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, CheckInventoryCode);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CheckInventoryDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
