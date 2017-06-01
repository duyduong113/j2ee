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
import model.OrdersDetail;

/**
 *
 * @author DUONG
 */
public class OrdersDetailDAO {

    public void insertOrderDetail(OrdersDetail orderDetail) throws SQLException {
        Connection connection = DBConnect.getConnect();
        String sql = "INSERT INTO OrdersDetail VALUES(?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, orderDetail.getProductCode());
        ps.setString(2, orderDetail.getOrdersCode());
        ps.setInt(3, orderDetail.getQuantity());
        ps.setDouble(4, orderDetail.getPrice());
        ps.executeUpdate();
    }

    public ArrayList<OrdersDetail> getListOrdersDetailByOrdersCode(String OrdersCode) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT a.*,b.Name as ProductName from OrdersDetail a, Product b where a.ProductCode=b.Code AND  a.OrdersCode = '"+OrdersCode+"' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<OrdersDetail> list = new ArrayList<>();
        while (rs.next()) {
            OrdersDetail ordersDetail = new OrdersDetail();
            ordersDetail.setID(rs.getLong("ID"));
            ordersDetail.setProductCode(rs.getString("ProductCode"));
            ordersDetail.setOrdersCode(rs.getString("OrdersCode"));
            ordersDetail.setQuantity(rs.getInt("Quantity"));
            ordersDetail.setPrice(rs.getDouble("Price"));
            ordersDetail.setProductName(rs.getString("ProductName"));
            list.add(ordersDetail);
        }
        return list;
    }
    
    public double Total(String OrdersCode) throws SQLException{
        double total = 0;
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from OrdersDetail  where OrdersCode = '"+OrdersCode+"' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            total += rs.getDouble("Price") * rs.getInt("Quantity");
        }
        return total;
    }

    public static void main(String[] args) throws SQLException {
        OrdersDetail orderDetail = new OrdersDetail();
        OrdersDetailDAO dao = new OrdersDetailDAO();

        orderDetail.setPrice(12500);
        orderDetail.setProductCode("SP00");
        orderDetail.setQuantity(55);
        orderDetail.setOrdersCode("123");

        dao.insertOrderDetail(orderDetail);

    }

}
