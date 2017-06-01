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
import model.City;
import model.Feedback;

/**
 *
 * @author DUONG
 */
public class FeedbackDAO {

    public boolean insertFeedback(Feedback feedback) {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO Feedback VALUES(?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setString(1, feedback.getName());
            ps.setString(2, feedback.getPhone());
            ps.setString(3, feedback.getEmail());
            ps.setString(4, feedback.getAddress());
            ps.setString(5, feedback.getContent());
            ps.setTimestamp(6, feedback.getCreatedDate());
            ps.setBoolean(7, feedback.isStatus());

            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
        public boolean changeStatusFeedback(Feedback feedback) {
        Connection connection = DBConnect.getConnect();
        String sql = "Update Feedback SET Status = ? WHERE ID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setBoolean(1, feedback.isStatus());
            ps.setLong(2, feedback.getID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public ArrayList<Feedback> getListFeedback(String keyword, int offset, int fetchnext) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Feedback WHERE dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ORDER BY ID ASC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Feedback> list = new ArrayList<>();
        while (rs.next()) {
            Feedback feedback = new Feedback();
            feedback.setID(rs.getInt("ID"));
            feedback.setName(rs.getString("Name"));
            feedback.setName(rs.getString("Name"));
            feedback.setPhone(rs.getString("Phone"));
            feedback.setEmail(rs.getString("Email"));
            feedback.setAddress(rs.getString("Address"));
            feedback.setContent(rs.getString("Content"));
            feedback.setCreatedDate(rs.getTimestamp("CreatedDate"));
            feedback.setStatus(rs.getBoolean("Status"));
            list.add(feedback);
        }
        return list;
    }

    public Feedback getFeedback(long ID) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Feedback WHERE ID= "+ID+"";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Feedback feedback = new Feedback();
        while (rs.next()) {
            feedback.setID(rs.getInt("ID"));
            feedback.setName(rs.getString("Name"));
            feedback.setName(rs.getString("Name"));
            feedback.setPhone(rs.getString("Phone"));
            feedback.setEmail(rs.getString("Email"));
            feedback.setAddress(rs.getString("Address"));
            feedback.setContent(rs.getString("Content"));
            feedback.setCreatedDate(rs.getTimestamp("CreatedDate"));
            feedback.setStatus(rs.getBoolean("Status"));
        }
        return feedback;
    }

    // tính tổng sản phẩm tìm kiếm
    public int countFeedback(String keyword) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(ID) FROM Feedback WHERE dbo.fuConvertToUnsign1(Name) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }
}
