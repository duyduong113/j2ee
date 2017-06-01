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
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Banner;

/**
 *
 * @author DUONG
 */
public class BannerDAO {

    public ArrayList<Banner> getListBanner() throws SQLException {
        Date currentDate = new Date();
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Banner WHERE Status = 1 AND StartDate <= '" + new java.sql.Date(currentDate.getTime()) + "' and EndDate >= '" + new java.sql.Date(currentDate.getTime()) + "' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Banner> list = new ArrayList<>();
        while (rs.next()) {
            Banner banner = new Banner();
            banner.setID(rs.getInt("ID"));
            banner.setProductCode(rs.getString("ProductCode"));
            banner.setAdvertisement_Name(rs.getString("Advertisement_Name"));
            banner.setImage(rs.getString("Image"));
            banner.setStartDate(rs.getDate("StartDate"));
            banner.setEndDate(rs.getDate("EndDate"));
            banner.setStatus(rs.getBoolean("Status"));
            banner.setCreatedBy(rs.getString("CreatedBy"));
            banner.setModifiedBy(rs.getString("ModifiedBy"));
            banner.setCreatedDate(rs.getTimestamp("CreatedDate"));
            banner.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            list.add(banner);
        }
        return list;

    }

    public ArrayList<Banner> getListBannerByNav(String keyword,int offset,int fetchnext) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Banner where dbo.fuConvertToUnsign1(Advertisement_Name) like N'%'+dbo.fuConvertToUnsign1('"+keyword+"')+'%' order by ID DESC OFFSET "+offset+" ROWS FETCH NEXT "+fetchnext+" ROWS ONLY ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Banner> list = new ArrayList<>();
        while (rs.next()) {
            Banner banner = new Banner();
            banner.setID(rs.getInt("ID"));
            banner.setProductCode(rs.getString("ProductCode"));
            banner.setAdvertisement_Name(rs.getString("Advertisement_Name"));
            banner.setImage(rs.getString("Image"));
            banner.setStartDate(rs.getDate("StartDate"));
            banner.setEndDate(rs.getDate("EndDate"));
            banner.setStatus(rs.getBoolean("Status"));
            banner.setCreatedBy(rs.getString("CreatedBy"));
            banner.setModifiedBy(rs.getString("ModifiedBy"));
            banner.setCreatedDate(rs.getTimestamp("CreatedDate"));
            banner.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            list.add(banner);
        }
        return list;

    }
    
        // tính tổng danh mục sản phẩm 
    public int countBanner(String keyword) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(ID) FROM Banner where dbo.fuConvertToUnsign1(Advertisement_Name) like N'%'+dbo.fuConvertToUnsign1('"+keyword+"')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }
    
      // thêm mới dữ liệu
    public boolean insertBanner(Banner c) {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO Banner VALUES(?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, c.getProductCode());
            ps.setString(2, c.getAdvertisement_Name());
            ps.setString(3, c.getImage());
            ps.setDate(4,  new java.sql.Date(c.getStartDate().getTime()));
            ps.setDate(5, new java.sql.Date(c.getEndDate().getTime()));
            ps.setBoolean(6, c.isStatus());
            ps.setTimestamp(7, c.getCreatedDate());
            ps.setString(8, c.getCreatedBy());
            ps.setTimestamp(9, c.getModifiedDate());
            ps.setString(10, c.getModifiedBy());
 
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //cập nhật dữ liệu
    public boolean updateBanner(Banner c) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Banner SET ProductCode = ?, Advertisement_Name = ?,Image=?,StartDate=?,EndDate=?,Status=?, ModifiedDate = ?, ModifiedBy = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, c.getProductCode());
            ps.setString(2, c.getAdvertisement_Name());
            ps.setString(3, c.getImage());
            ps.setDate(4, (java.sql.Date) c.getStartDate());
            ps.setDate(5, (java.sql.Date) c.getEndDate());
            ps.setBoolean(6, c.isStatus());
            ps.setTimestamp(7, c.getModifiedDate());
            ps.setString(8, c.getModifiedBy());
            ps.setLong(9, c.getID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
       //cập nhật trạng thái
    public boolean changeStatusBanner(Banner c) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Banner SET ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setTimestamp(1, c.getModifiedDate());
            ps.setString(2, c.getModifiedBy());
            ps.setBoolean(3, c.isStatus());
            ps.setLong(4, c.getID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(BannerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
     public Banner getBannerByID(long ID) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Banner WHERE ID= "+ID+" ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
         Banner banner = new Banner();
        while (rs.next()) {
            banner.setID(rs.getInt("ID"));
            banner.setProductCode(rs.getString("ProductCode"));
            banner.setAdvertisement_Name(rs.getString("Advertisement_Name"));
            banner.setImage(rs.getString("Image"));
            banner.setStartDate(rs.getDate("StartDate"));
            banner.setEndDate(rs.getDate("EndDate"));
            banner.setStatus(rs.getBoolean("Status"));
            banner.setCreatedBy(rs.getString("CreatedBy"));
            banner.setModifiedBy(rs.getString("ModifiedBy"));
            banner.setCreatedDate(rs.getTimestamp("CreatedDate"));
            banner.setModifiedDate(rs.getTimestamp("ModifiedDate"));
        }
        return banner;
    }
    

    public static void main(String[] args) throws SQLException {

        Date currentDate = new Date();
        System.out.println(new java.sql.Date(currentDate.getTime()));

        BannerDAO bannerDAO = new BannerDAO();
        for (Banner banner : bannerDAO.getListBanner()) {
            System.out.println(banner.getImage());
        }

    }
}
