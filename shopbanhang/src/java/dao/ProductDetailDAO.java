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
import model.ProductDetail;

/**
 *
 * @author DUONG
 */
public class ProductDetailDAO {

    public void insertProductDetail(ProductDetail productDetail) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO ProductDetail VALUES(?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, productDetail.getProductCode());
        ps.setString(2, productDetail.getAttributeCode()); 
        ps.setString(3, productDetail.getValue());
        ps.executeUpdate();
    }
    
        // xóa dữ liệu
    public boolean deleteProductDetail(String ProductCode) {
        Connection connection = DBConnect.getConnect();
        String sql = "DELETE FROM ProductDetail WHERE ProductCode = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, ProductCode);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //Lấy chi tiet sản phẩm theo mã sản phẩm
    public ArrayList<ProductDetail> getListProductDetailByProduct(String productCode) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from ProductDetail detail, ProductAttribute attribute WHERE detail.AttributeCode=attribute.Code AND detail.ProductCode = '" + productCode + "' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<ProductDetail> list = new ArrayList<>();
        while (rs.next()) {
            ProductDetail productDetail = new ProductDetail();
            productDetail.setID(rs.getLong("ID"));
            productDetail.setProductCode(rs.getString("ProductCode"));
            productDetail.setAttributeCode(rs.getString("AttributeCode"));
            productDetail.setValue(rs.getString("Value"));
            productDetail.setName(rs.getString("Name"));
            list.add(productDetail);
        }
        return list;
    }


}
