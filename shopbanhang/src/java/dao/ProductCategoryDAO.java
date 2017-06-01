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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ProductCategory;

/**
 *
 * @author DUONG
 */
public class ProductCategoryDAO {

    public ArrayList<ProductCategory> getListProductCategory() throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * from ProductCategory where Status = 1 order by ID DESC";

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<ProductCategory> list = new ArrayList<>();
        while (rs.next()) {
            ProductCategory productCategory = new ProductCategory();
            productCategory.setID(rs.getInt("ID"));
            productCategory.setName(rs.getString("Name"));
            productCategory.setMetaTitle(rs.getString("MetaTitle"));
            productCategory.setParentID(rs.getInt("ParentID"));  
            productCategory.setImage(rs.getString("Image"));
            productCategory.setDisplayOrder(rs.getInt("DisplayOrder"));
            productCategory.setSeoTitle(rs.getString("SeoTitle"));
            productCategory.setCreatedDate(rs.getTimestamp("CreatedDate"));
            productCategory.setCreatedBy(rs.getString("CreatedBy"));
            productCategory.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            productCategory.setModifiedBy(rs.getString("ModifiedBy"));
            productCategory.setMetaKeywords(rs.getString("MetaKeywords"));
            productCategory.setMetaDescriptions(rs.getString("MetaDescriptions"));
            productCategory.setStatus(rs.getBoolean("Status"));
            productCategory.setShowOnHome(rs.getBoolean("ShowOnHome"));

            list.add(productCategory);
        }
        return list;
    }
    
    public ArrayList<ProductCategory> getListProductCategoryByNav(String txtSearch,int offset,int fetchnext) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * from ProductCategory where dbo.fuConvertToUnsign1(Name) like N'%'+dbo.fuConvertToUnsign1('"+txtSearch+"')+'%' order by ID DESC OFFSET "+offset+" ROWS FETCH NEXT "+fetchnext+" ROWS ONLY ";

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<ProductCategory> list = new ArrayList<>();
        while (rs.next()) {
            ProductCategory productCategory = new ProductCategory();
            productCategory.setID(rs.getInt("ID"));
            productCategory.setName(rs.getString("Name"));
            productCategory.setMetaTitle(rs.getString("MetaTitle"));
            productCategory.setParentID(rs.getInt("ParentID"));
            productCategory.setImage(rs.getString("Image"));
            productCategory.setDisplayOrder(rs.getInt("DisplayOrder"));
            productCategory.setSeoTitle(rs.getString("SeoTitle"));
            productCategory.setCreatedDate(rs.getTimestamp("CreatedDate"));
            productCategory.setCreatedBy(rs.getString("CreatedBy"));
            productCategory.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            productCategory.setModifiedBy(rs.getString("ModifiedBy"));
            productCategory.setMetaKeywords(rs.getString("MetaKeywords"));
            productCategory.setMetaDescriptions(rs.getString("MetaDescriptions"));
            productCategory.setStatus(rs.getBoolean("Status"));
            productCategory.setShowOnHome(rs.getBoolean("ShowOnHome"));

            list.add(productCategory);
        }
        return list;
    }
    
    // tính tổng danh mục sản phẩm 
    public int countProductCategory(String txtSearch) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(ID) FROM ProductCategory where dbo.fuConvertToUnsign1(Name) like N'%'+dbo.fuConvertToUnsign1('"+txtSearch+"')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    public ProductCategory getProductCategoryByID(long ID) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * from ProductCategory WHERE ID = '" + ID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ProductCategory productCategory = new ProductCategory();
        while (rs.next()) {
            productCategory.setID(rs.getInt("ID"));
            productCategory.setName(rs.getString("Name"));
            productCategory.setMetaTitle(rs.getString("MetaTitle"));
            productCategory.setParentID(rs.getInt("ParentID"));
     
            productCategory.setImage(rs.getString("Image"));
            productCategory.setDisplayOrder(rs.getInt("DisplayOrder"));
            productCategory.setSeoTitle(rs.getString("SeoTitle"));
            productCategory.setCreatedDate(rs.getTimestamp("CreatedDate"));
            productCategory.setCreatedBy(rs.getString("CreatedBy"));
            productCategory.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            productCategory.setModifiedBy(rs.getString("ModifiedBy"));
            productCategory.setMetaKeywords(rs.getString("MetaKeywords"));
            productCategory.setMetaDescriptions(rs.getString("MetaDescriptions"));
            productCategory.setStatus(rs.getBoolean("Status"));
            productCategory.setShowOnHome(rs.getBoolean("ShowOnHome"));
        }
        return productCategory;
    }

    // thêm mới dữ liệu
    public boolean insertProductCategory(ProductCategory c) {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO ProductCategory VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, c.getName());
            ps.setString(2, c.getMetaTitle());
            ps.setLong(3, c.getParentID());
            ps.setString(4, c.getImage());
    
            ps.setInt(5, c.getDisplayOrder());
            ps.setString(6, c.getSeoTitle());
            ps.setTimestamp(7, c.getCreatedDate());
            ps.setString(8, c.getCreatedBy());
            ps.setTimestamp(9, c.getModifiedDate());
            ps.setString(10, c.getModifiedBy());
            ps.setString(11, c.getMetaKeywords());
            ps.setString(12, c.getMetaDescriptions());
            ps.setBoolean(13, c.isStatus());
            ps.setBoolean(14, c.isShowOnHome());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cập nhật dữ liệu
    public boolean updateProductCategory(ProductCategory c) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE ProductCategory SET Name = ?, Image = ?, ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, c.getName());
            ps.setString(2, c.getImage());
        
            ps.setTimestamp(3, c.getModifiedDate());
            ps.setString(4, c.getModifiedBy());
            ps.setBoolean(5, c.isStatus());
            ps.setLong(6, c.getID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cập nhật trạng thái
    public boolean changeStatusProductCategory(ProductCategory c) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE ProductCategory SET ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setTimestamp(1, c.getModifiedDate());
            ps.setString(2, c.getModifiedBy());
            ps.setBoolean(3, c.isStatus());
            ps.setLong(4, c.getID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // xóa dữ liệu
//    public boolean deleteCategory(long category_id) {
//        Connection connection = DBConnect.getConnect();
//        String sql = "DELETE FROM ProductCategory WHERE category_id = ?";
//        try {
//            PreparedStatement ps = connection.prepareCall(sql);
//            ps.setLong(1, category_id);
//            return ps.executeUpdate() == 1;
//        } catch (SQLException ex) {
//            Logger.getLogger(ProductCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
    
    
    // kiểm tra username tồn tại chưa
    public boolean checkProductCategoryNameExist(String Name) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM ProductCategory WHERE Name = '" + Name + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // kiểm tra username tồn tại chưa
    public boolean checkProductCategoryNameExist(long ID, String Name) {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM ProductCategory WHERE ID= " + ID + " AND Name = '" + Name + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
    
    public static void main(String[] args) throws SQLException {
        ProductCategoryDAO dao = new ProductCategoryDAO();

        ProductCategory c = new ProductCategory();
        c.setName("TEST");
        c.setImage("/image");
  

        c.setModifiedDate(new Timestamp(new Date().getTime()));
        c.setModifiedBy("admin");

        c.setStatus(true);
        c.setID(5);

        dao.insertProductCategory(c);

//        for (ProductCategory ds : dao.getListProductCategory()) {
//            System.out.println(ds.getName());
//        }
    }
}
