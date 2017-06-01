/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ProductAttribute;
import model.ProductDetail;

/**
 *
 * @author DUONG
 */
public class ProductAttributeDAO {
     //Lấy chi tiet sản phẩm theo mã sản phẩm
    public ArrayList<ProductAttribute> getListProductAttribute() throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from ProductAttribute";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<ProductAttribute> list = new ArrayList<>();
        while (rs.next()) {
            ProductAttribute productAttribute = new ProductAttribute();
            productAttribute.setID(rs.getLong("ID"));
            productAttribute.setCode(rs.getString("Code"));
            productAttribute.setType(rs.getString("Type"));
            productAttribute.setName(rs.getString("Name"));
            productAttribute.setCreatedDate(rs.getTimestamp("CreatedDate"));
            productAttribute.setCreatedBy(rs.getString("CreatedBy"));
            productAttribute.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            productAttribute.setModifiedBy(rs.getString("ModifiedBy"));
            productAttribute.setStatus(rs.getBoolean("Status"));
            list.add(productAttribute);
        }
        return list;
    }
}
