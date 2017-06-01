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
import model.District;
import model.Product;

/**
 *
 * @author DUONG
 */
public class CustomDataDAO {
     public ArrayList<City> getListCity() throws SQLException{
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from City";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<City> list = new ArrayList<>();
        while(rs.next()){
            City city = new City();
            city.setID(rs.getInt("ID"));
            city.setCode(rs.getString("Code"));
            city.setName(rs.getString("Name"));
            city.setAreaCode(rs.getString("AreaCode"));
            city.setStatus(rs.getBoolean("Status"));
            city.setCreatedBy(rs.getString("CreatedBy"));
            city.setModifiedBy(rs.getString("ModifiedBy"));
            city.setCreatedDate(rs.getTimestamp("CreatedDate"));
            city.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            list.add(city);
        }
        return list;

    }
     
     public ArrayList<District> getListDistrictByCity(String CityCode) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from District WHERE CityCode = '"+CityCode+"' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<District> list = new ArrayList<>();
        while (rs.next()) {
            District district = new District();
            district.setID(rs.getInt("ID"));
            district.setCode(rs.getString("Code"));
            district.setName(rs.getString("Name"));
            district.setCityCode(rs.getString("CityCode"));
            district.setStatus(rs.getBoolean("Status"));
            district.setCreatedBy(rs.getString("CreatedBy"));
            district.setModifiedBy(rs.getString("ModifiedBy"));
            district.setCreatedDate(rs.getTimestamp("CreatedDate"));
            district.setModifiedDate(rs.getTimestamp("ModifiedDate"));
            list.add(district);
        }
        return list;

    }
     
     public District getDistrictByCode(String Code) throws SQLException {
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from District WHERE Code = '"+Code+"' ";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        District district = new District();
        while (rs.next()) {
            
            district.setID(rs.getInt("ID"));
            district.setCode(rs.getString("Code"));
            district.setName(rs.getString("Name"));
            district.setCityCode(rs.getString("CityCode"));
            district.setStatus(rs.getBoolean("Status"));
            district.setCreatedBy(rs.getString("CreatedBy"));
            district.setModifiedBy(rs.getString("ModifiedBy"));
            district.setCreatedDate(rs.getTimestamp("CreatedDate"));
            district.setModifiedDate(rs.getTimestamp("ModifiedDate"));
        }
        return district;

    }
     
     public City getCityByCode(String Code) throws SQLException{
        Connection connection = connect.DBConnect.getConnect();
        String sql = "SELECT * from City WHERE Code = '"+Code+"'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        City city = new City();
        while(rs.next()){
            
            city.setID(rs.getInt("ID"));
            city.setCode(rs.getString("Code"));
            city.setName(rs.getString("Name"));
            city.setAreaCode(rs.getString("AreaCode"));
            city.setStatus(rs.getBoolean("Status"));
            city.setCreatedBy(rs.getString("CreatedBy"));
            city.setModifiedBy(rs.getString("ModifiedBy"));
            city.setCreatedDate(rs.getTimestamp("CreatedDate"));
            city.setModifiedDate(rs.getTimestamp("ModifiedDate"));
        }
        return city;

    }
     
}
