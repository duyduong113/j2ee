/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import common.AllConstant;
import connect.DBConnect;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.ProductCategory;

/**
 *
 * @author DUONG
 */
public class ProductDAO {

    //Lấy danh sách sản phẩm
    public ArrayList<Product> getListProduct(String condition, Long category) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * FROM PRODUCT WHERE Status=1 ORDER BY Code DESC";
        if (condition.equals(AllConstant.Product_ALL)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 ORDER BY Code DESC";
        } else if (condition.equals(AllConstant.Product_BYCATEGORY)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 and CategoryID = '" + category + "' ORDER BY Code DESC";
        } else if (condition.equals(AllConstant.Product_FEATURED)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 ORDER BY ViewCount DESC";
        } else if (condition.equals(AllConstant.Product_LATEST)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 ORDER BY CreatedDate DESC";
        } else if (condition.equals(AllConstant.Product_PROMOTION)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 AND PromotionPrice > 0 ORDER BY PromotionPrice ASC";
        } else {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 and CategoryID = '" + category + "' AND Code != '" + condition + "' ORDER BY Code DESC";
        }

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setID(rs.getInt("ID"));
            product.setCategoryID(rs.getInt("CategoryID"));
            product.setWarranty(rs.getInt("Warranty"));
            product.setViewCount(rs.getInt("ViewCount"));
            //product.setQuantity(rs.getInt("Quantity"));
            product.setName(rs.getString("Name"));
            product.setCode(rs.getString("Code"));
            product.setMetaTitle(rs.getString("MetaTitle"));
            product.setDescription(rs.getString("Description"));
            product.setImage(rs.getString("Image"));
            product.setDetail(rs.getString("Detail"));
            product.setCreatedBy(rs.getString("CreatedBy"));
            product.setModifiedBy(rs.getString("ModifiedBy"));
            product.setMetaKeywords(rs.getString("MetaKeywords"));
            product.setMetaDescriptions(rs.getString("MetaDescriptions"));
            product.setMoreImages(rs.getString("MoreImages"));
            product.setIncludedVAT(rs.getBoolean("IncludedVAT"));
            product.setStatus(rs.getBoolean("Status"));
            product.setPrice(rs.getDouble("Price"));
            product.setPromotionPrice(rs.getDouble("PromotionPrice"));
            product.setCreatedDate(rs.getTimestamp("CreatedDate"));
            product.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            product.setTopHot(rs.getDate("TopHot"));
            list.add(product);
        }
        return list;

    }

    //Lấy danh sách sản phẩm PHÂN TRANG
    public ArrayList<Product> getListProductByNav(String condition, Long category, int offset, int fetchnext) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * FROM PRODUCT WHERE Status=1 ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY ";
        if (condition.equals(AllConstant.Product_ALL)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY ";
        } else if (condition.equals(AllConstant.Product_BYCATEGORY)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 AND CategoryID = '" + category + "' ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY ";
        } else if (condition.equals(AllConstant.Product_FEATURED)) {
            sql = "SELECT * FROM PRODUCT  WHERE Status=1 ORDER BY ViewCount DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY ";
        } else if (condition.equals(AllConstant.Product_LATEST)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 ORDER BY CreatedDate DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY ";
        } else if (condition.equals(AllConstant.Product_PROMOTION)) {
            sql = "SELECT * FROM PRODUCT WHERE Status=1 and PromotionPrice > 0 ORDER BY PromotionPrice DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY ";
        } else {// sản phẩm liên quan
            sql = "SELECT * FROM PRODUCT WHERE Status =1 and CategoryID = '" + category + "' AND Code != '" + condition + "' ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY ";
        }

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setID(rs.getInt("ID"));
            product.setCategoryID(rs.getInt("CategoryID"));
            product.setWarranty(rs.getInt("Warranty"));
            product.setViewCount(rs.getInt("ViewCount"));
            //product.setQuantity(rs.getInt("Quantity"));
            product.setName(rs.getString("Name"));
            product.setCode(rs.getString("Code"));
            product.setMetaTitle(rs.getString("MetaTitle"));
            product.setDescription(rs.getString("Description"));
            product.setImage(rs.getString("Image"));
            product.setDetail(rs.getString("Detail"));
            product.setCreatedBy(rs.getString("CreatedBy"));
            product.setModifiedBy(rs.getString("ModifiedBy"));
            product.setMetaKeywords(rs.getString("MetaKeywords"));
            product.setMetaDescriptions(rs.getString("MetaDescriptions"));
            product.setMoreImages(rs.getString("MoreImages"));
            product.setIncludedVAT(rs.getBoolean("IncludedVAT"));
            product.setStatus(rs.getBoolean("Status"));
            product.setPrice(rs.getDouble("Price"));
            product.setPromotionPrice(rs.getDouble("PromotionPrice"));
            product.setCreatedDate(rs.getTimestamp("CreatedDate"));
            product.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            product.setTopHot(rs.getDate("TopHot"));
            list.add(product);
        }
        return list;

    }


    //Lấy danh sách sản phẩm TIM KIẾM PHÂN TRANG
    public ArrayList<Product> getListProductByNavSearch(String txtSearch, int offset, int fetchnext) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * FROM Product WHERE Status=1 and dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + txtSearch + "')+'%' ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY  ";

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setID(rs.getInt("ID"));
            product.setCategoryID(rs.getInt("CategoryID"));
            product.setWarranty(rs.getInt("Warranty"));
            product.setViewCount(rs.getInt("ViewCount"));
            //product.setQuantity(rs.getInt("Quantity"));
            product.setName(rs.getString("Name"));
            product.setCode(rs.getString("Code"));
            product.setMetaTitle(rs.getString("MetaTitle"));
            product.setDescription(rs.getString("Description"));
            product.setImage(rs.getString("Image"));
            product.setDetail(rs.getString("Detail"));
            product.setCreatedBy(rs.getString("CreatedBy"));
            product.setModifiedBy(rs.getString("ModifiedBy"));
            product.setMetaKeywords(rs.getString("MetaKeywords"));
            product.setMetaDescriptions(rs.getString("MetaDescriptions"));
            product.setMoreImages(rs.getString("MoreImages"));
            product.setIncludedVAT(rs.getBoolean("IncludedVAT"));
            product.setStatus(rs.getBoolean("Status"));
            product.setPrice(rs.getDouble("Price"));
            product.setPromotionPrice(rs.getDouble("PromotionPrice"));
            product.setCreatedDate(rs.getTimestamp("CreatedDate"));
            product.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            product.setTopHot(rs.getDate("TopHot"));
            list.add(product);
        }
        return list;

    }

    //Lấy danh sách sản phẩm TIM KIẾM PHÂN TRANG ADMIN
    public ArrayList<Product> getListProductByAdminNavSearch(String txtSearch, int offset, int fetchnext) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * FROM Product WHERE dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + txtSearch + "')+'%' ORDER BY CODE DESC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY  ";

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setID(rs.getInt("ID"));
            product.setCategoryID(rs.getInt("CategoryID"));
            product.setWarranty(rs.getInt("Warranty"));
            product.setViewCount(rs.getInt("ViewCount"));
            //product.setQuantity(rs.getInt("Quantity"));
            product.setName(rs.getString("Name"));
            product.setCode(rs.getString("Code"));
            product.setMetaTitle(rs.getString("MetaTitle"));
            product.setDescription(rs.getString("Description"));
            product.setImage(rs.getString("Image"));
            product.setDetail(rs.getString("Detail"));
            product.setCreatedBy(rs.getString("CreatedBy"));
            product.setModifiedBy(rs.getString("ModifiedBy"));
            product.setMetaKeywords(rs.getString("MetaKeywords"));
            product.setMetaDescriptions(rs.getString("MetaDescriptions"));
            product.setMoreImages(rs.getString("MoreImages"));
            product.setIncludedVAT(rs.getBoolean("IncludedVAT"));
            product.setStatus(rs.getBoolean("Status"));
            product.setPrice(rs.getDouble("Price"));
            product.setPromotionPrice(rs.getDouble("PromotionPrice"));
            product.setCreatedDate(rs.getTimestamp("CreatedDate"));
            product.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            product.setTopHot(rs.getDate("TopHot"));
            list.add(product);
        }
        return list;

    }
    
    
    // tính tổng sản phẩm theo danh mục sản phẩm
    public int countProductByCategory(long categoryID) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(Code) FROM Product WHERE Status = 1 AND CategoryID = '" + categoryID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    // tính tổng sản phẩm khuyến mãi
    public int countProductByPromotion() throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(Code) FROM Product WHERE Status = 1 AND PromotionPrice > 0 ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    // tính tổng sản phẩm tìm kiếm
    public int countProductBySearch(String txtSearch) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(Code) FROM Product WHERE Status = 1 AND dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + txtSearch + "')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    // tính tổng sản phẩm tìm kiếm
    public int countProductByAdminSearch(String txtSearch) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(Code) FROM Product WHERE dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + txtSearch + "')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }
    
    //Lấy sản phẩm theo mã sản phẩm 
    public Product getProductByCode(String CODE) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Product WHERE Code = '" + CODE + "' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Product product = new Product();
        while (rs.next()) {
            product.setID(rs.getInt("ID"));
            product.setCategoryID(rs.getInt("CategoryID"));
            product.setWarranty(rs.getInt("Warranty"));
            product.setViewCount(rs.getInt("ViewCount"));
            //product.setQuantity(rs.getInt("Quantity"));
            product.setName(rs.getString("Name"));
            product.setCode(rs.getString("Code"));
            product.setMetaTitle(rs.getString("MetaTitle"));
            product.setDescription(rs.getString("Description"));
            product.setImage(rs.getString("Image"));
            product.setDetail(rs.getString("Detail"));
            product.setCreatedBy(rs.getString("CreatedBy"));
            product.setModifiedBy(rs.getString("ModifiedBy"));
            product.setMetaKeywords(rs.getString("MetaKeywords"));
            product.setMetaDescriptions(rs.getString("MetaDescriptions"));
            product.setMoreImages(rs.getString("MoreImages"));
            product.setIncludedVAT(rs.getBoolean("IncludedVAT"));
            product.setStatus(rs.getBoolean("Status"));
            product.setPrice(rs.getDouble("Price"));
            product.setPromotionPrice(rs.getDouble("PromotionPrice"));
            product.setCreatedDate(rs.getTimestamp("CreatedDate"));
            product.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            product.setTopHot(rs.getDate("TopHot"));
        }
        return product;
    }

    // thêm mới dữ liệu
    public boolean insertProduct(Product p) {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO Product VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, p.getName());
            ps.setString(2, p.getCode());
            ps.setString(3, p.getMetaTitle());
            ps.setString(4, p.getDescription());
            ps.setString(5, p.getImage());
            ps.setString(6, p.getMoreImages());
            ps.setDouble(7, p.getPrice());
            ps.setDouble(8, p.getPromotionPrice());
            ps.setBoolean(9, p.isIncludedVAT());
            //ps.setInt(10, p.getQuantity());
            ps.setLong(10, p.getCategoryID());
            ps.setString(11, p.getDetail());
            ps.setInt(12, p.getWarranty());
            ps.setTimestamp(13, p.getCreatedDate());
            ps.setString(14, p.getCreatedBy());
            ps.setTimestamp(15, p.getModifiedDate());
            ps.setString(16, p.getModifiedBy());
            ps.setString(17, p.getMetaKeywords());
            ps.setString(18, p.getMetaDescriptions());
            ps.setBoolean(19, p.isStatus());
            ps.setDate(20, (Date) p.getTopHot());
            ps.setInt(21, p.getViewCount());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cập nhật dữ liệu
    public boolean updateProduct(Product p) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Product SET Name = ?,Price= ?,PromotionPrice=?,CategoryID=?,Description=?, Image = ?, ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE Code = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, p.getName());
             ps.setDouble(2, p.getPrice());
            ps.setDouble(3, p.getPromotionPrice());
            ps.setLong(4, p.getCategoryID());
            ps.setString(5, p.getDescription());
            ps.setString(6, p.getImage());
            ps.setTimestamp(7, p.getModifiedDate());
            ps.setString(8, p.getModifiedBy());
            ps.setBoolean(9, p.isStatus());
            ps.setString(10, p.getCode());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cập nhật trạng thái
    public boolean changeStatusProduct(Product p) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Product SET ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE Code = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setTimestamp(1, p.getModifiedDate());
            ps.setString(2, p.getModifiedBy());
            ps.setBoolean(3, p.isStatus());
            ps.setString(4, p.getCode());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    //Lấy sản phẩm đầu tiên
    public Product getProductTOP() throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT TOP 1 * from Product ORDER BY Code DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Product product = new Product();
        while (rs.next()) {
            product.setID(rs.getInt("ID"));
            product.setCategoryID(rs.getInt("CategoryID"));
            product.setWarranty(rs.getInt("Warranty"));
            product.setViewCount(rs.getInt("ViewCount"));
            //product.setQuantity(rs.getInt("Quantity"));
            product.setName(rs.getString("Name"));
            product.setCode(rs.getString("Code"));
            product.setMetaTitle(rs.getString("MetaTitle"));
            product.setDescription(rs.getString("Description"));
            product.setImage(rs.getString("Image"));
            product.setDetail(rs.getString("Detail"));
            product.setCreatedBy(rs.getString("CreatedBy"));
            product.setModifiedBy(rs.getString("ModifiedBy"));
            product.setMetaKeywords(rs.getString("MetaKeywords"));
            product.setMetaDescriptions(rs.getString("MetaDescriptions"));
            product.setMoreImages(rs.getString("MoreImages"));
            product.setIncludedVAT(rs.getBoolean("IncludedVAT"));
            product.setStatus(rs.getBoolean("Status"));
            product.setPrice(rs.getDouble("Price"));
            product.setPromotionPrice(rs.getDouble("PromotionPrice"));
            product.setCreatedDate(rs.getTimestamp("CreatedDate"));
            product.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            product.setTopHot(rs.getDate("TopHot"));
        }
        return product;
    }
    
    
    
    

    public static void main(String[] args) throws SQLException {
        ProductDAO productDAO = new ProductDAO();
        System.err.println(new ProductDAO().countProductBySearch("iphone"));

        for (Product p : new ProductDAO().getListProductByNavSearch("iphone", 8, 8)) {
            System.err.println(p.getCode());
        }
    }
}
