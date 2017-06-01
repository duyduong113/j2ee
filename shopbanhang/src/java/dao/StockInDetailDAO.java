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
import model.StockInDetail;

/**
 *
 * @author DUONG
 */
public class StockInDetailDAO {

    public void insertStockInDetail(StockInDetail stockInDetail) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO StockInDetail VALUES(?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, stockInDetail.getStockInCode());
        ps.setString(2, stockInDetail.getProductCode());
        ps.setString(3, stockInDetail.getUnitCode());
        ps.setInt(4, stockInDetail.getQuantity());
        ps.executeUpdate();
    }

    public ArrayList<StockInDetail> getListStockInDetailByStockInCode(String StockInCode) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT detail.*,p.Name as ProductName, u.Name as UnitName FROM StockInDetail detail, Product p, Unit u where detail.ProductCode=p.Code and detail.UnitCode=u.Code AND detail.StockInCode='" + StockInCode + "' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<StockInDetail> list = new ArrayList<>();
        while (rs.next()) {
            StockInDetail stockInDetail = new StockInDetail();
            stockInDetail.setID(rs.getLong("ID"));
            stockInDetail.setStockInCode(rs.getString("StockInCode"));
            stockInDetail.setProductCode(rs.getString("ProductCode"));
            stockInDetail.setUnitCode(rs.getString("UnitCode"));
            stockInDetail.setQuantity(rs.getInt("Quantity"));
            stockInDetail.setProductName(rs.getString("ProductName"));
            stockInDetail.setUnitName(rs.getString("UnitName"));
            list.add(stockInDetail);
        }
        return list;
    }

    // xóa dữ liệu
    public boolean deleteStockInDetail(String StockInCode) {
        Connection connection = DBConnect.getConnect();
        String sql = "DELETE FROM StockInDetail WHERE StockInCode = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, StockInCode);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(StockInDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
