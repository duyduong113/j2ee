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
import model.Orders;

/**
 *
 * @author DUONG
 */
public class OrdersDAO {

    public void insertOrder(Orders order) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO Orders VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);

        ps.setString(1, order.getCode());
        ps.setLong(2, order.getCustomerID());
        ps.setString(3, order.getShipName());
        ps.setString(4, order.getShipMobile());
        ps.setString(5, order.getShipAddress());
        ps.setString(6, order.getShipEmail());
        ps.setTimestamp(7, order.getCreatedDate());
        ps.setTimestamp(8, order.getModifiedDate());
        ps.setString(9, order.getCreatedBy());
        ps.setString(10, order.getModifiedBy());
        ps.setInt(11, order.getStatus());

        ps.executeUpdate();
    }

    public ArrayList<Orders> getListOrderByNav(String keyword, int offset, int fetchnext) {
        try {
            Connection connection = DBConnect.getConnect();
            String sql = "SELECT * FROM Orders WHERE dbo.fuConvertToUnsign1(Code) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ORDER BY CODE ASC OFFSET " + offset + " ROWS FETCH NEXT " + fetchnext + " ROWS ONLY";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Orders> list = new ArrayList<>();
            while (rs.next()) {
                Orders order = new Orders();
                order.setID(rs.getLong("ID"));
                order.setCode(rs.getString("Code"));
                order.setCustomerID(rs.getLong("CustomerID"));
                order.setShipName(rs.getString("ShipName"));
                order.setShipMobile(rs.getString("ShipMobile"));
                order.setShipAddress(rs.getString("ShipAddress"));
                order.setShipEmail(rs.getString("ShipEmail"));
                order.setCreatedDate(rs.getTimestamp("CreatedDate"));
                order.setCreatedBy(rs.getString("CreatedBy"));
                order.setModifiedDate(rs.getTimestamp("ModifiedDate"));
                order.setModifiedBy(rs.getString("ModifiedBy"));
                order.setStatus(rs.getInt("Status"));
                list.add(order);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Orders getOrderByCode(String Code) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT * FROM Orders WHERE Code= '" + Code + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Orders order = new Orders();
        while (rs.next()) {

            order.setID(rs.getLong("ID"));
            order.setCode(rs.getString("Code"));
            order.setCustomerID(rs.getLong("CustomerID"));
            order.setShipName(rs.getString("ShipName"));
            order.setShipMobile(rs.getString("ShipMobile"));
            order.setShipAddress(rs.getString("ShipAddress"));
            order.setShipEmail(rs.getString("ShipEmail"));
            order.setCreatedDate(rs.getTimestamp("CreatedDate"));
            order.setCreatedBy(rs.getString("CreatedBy"));
            order.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            order.setModifiedBy(rs.getString("ModifiedBy"));
            order.setStatus(rs.getInt("Status"));
        }
        return order;
    }
        // tính tổng sản phẩm tìm kiếm
    public int countOrderByNav(String keyword) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "SELECT count(Code) FROM Orders WHERE dbo.fuConvertToUnsign1(Code) LIKE N'%'+dbo.fuConvertToUnsign1('" + keyword + "')+'%' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    //cập nhật trạng thái
    public boolean changeStatusOrders(Orders orders) {
        Connection connection = DBConnect.getConnect();
        String sql = "UPDATE Orders SET ModifiedDate = ?, ModifiedBy = ?, Status = ? WHERE Code = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setTimestamp(1, orders.getModifiedDate());
            ps.setString(2, orders.getModifiedBy());
            ps.setInt(3, orders.getStatus());
            ps.setString(4, orders.getCode());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static void main(String[] args) throws SQLException {
        Orders orderDetail = new Orders();
        OrdersDAO dao = new OrdersDAO();

        orderDetail.setCode("213123");

        dao.insertOrder(orderDetail);

    }

}
