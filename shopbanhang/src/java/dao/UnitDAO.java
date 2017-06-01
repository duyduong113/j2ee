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
import model.City;
import model.Unit;

/**
 *
 * @author DUONG
 */
public class UnitDAO {

    public ArrayList<Unit> getListUnit() throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Unit";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Unit> list = new ArrayList<>();
        while (rs.next()) {
            Unit unit = new Unit();
            unit.setID(rs.getInt("ID"));
            unit.setCode(rs.getString("Code"));
            unit.setName(rs.getString("Name"));
            unit.setStatus(rs.getBoolean("Status"));
            list.add(unit);
        }
        return list;

    }

    public Unit getUnitByCode(String Code) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from Unit where Code = '" + Code + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Unit unit = new Unit();
        while (rs.next()) {
            unit.setID(rs.getInt("ID"));
            unit.setCode(rs.getString("Code"));
            unit.setName(rs.getString("Name"));
            unit.setStatus(rs.getBoolean("Status"));
        }
        return unit;

    }
}
