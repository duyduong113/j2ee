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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ProductWarehouse;

/**
 *
 * @author DUONG
 */
public class ProductWarehouseDAO {

    public ProductWarehouse getProductWarehouseByCode(String ProductCode) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT * FROM ProductWarehouse WHERE  ProductCode= '" + ProductCode + "'";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ProductWarehouse productWarehouse = new ProductWarehouse();
            while (rs.next()) {
                productWarehouse.setID(rs.getLong("ID"));
                productWarehouse.setProductCode(rs.getString("ProductCode"));
                productWarehouse.setStockOnhand(rs.getInt("StockOnhand"));
                productWarehouse.setStockAvailable(rs.getInt("StockAvailable"));
                productWarehouse.setCreatedDate(rs.getTimestamp("CreatedDate"));
                productWarehouse.setCreatedBy(rs.getString("CreatedBy"));
                productWarehouse.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                productWarehouse.setModifiedBy(rs.getString("ModifiedBy"));
            }
            return productWarehouse;
        } catch (SQLException ex) {
            Logger.getLogger(ProductWarehouseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertProductWarehouse(ProductWarehouse productWarehouse) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "INSERT INTO ProductWarehouse VALUES(?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, productWarehouse.getProductCode());
            ps.setInt(2, productWarehouse.getStockOnhand());
            ps.setInt(3, productWarehouse.getStockAvailable());
            ps.setTimestamp(4, productWarehouse.getCreatedDate());
            ps.setString(5, productWarehouse.getCreatedBy());
            ps.setTimestamp(6, productWarehouse.getModifiedDate());
            ps.setString(7, productWarehouse.getModifiedBy());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductWarehouseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateProductWarehouse(ProductWarehouse productWarehouse) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "UPDATE ProductWarehouse SET StockOnhand=?, StockAvailable=?,ModifiedDate=?,ModifiedBy=? WHERE ProductCode=?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, productWarehouse.getStockOnhand());
            ps.setInt(2, productWarehouse.getStockAvailable());
            ps.setTimestamp(3, productWarehouse.getModifiedDate());
            ps.setString(4, productWarehouse.getModifiedBy());
            ps.setString(5, productWarehouse.getProductCode());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductWarehouseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
