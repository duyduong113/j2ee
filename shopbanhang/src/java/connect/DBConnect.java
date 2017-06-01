/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DUONG
 */
public class DBConnect {
    protected static Connection conn;
    static String HostName = "Localhost";
    static String port = "1433";
    static String dbName = "OnlineShop";
    static String use = "sa";
    static String pass = "sa";
    static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; 
    static String URL = "jdbc:sqlserver://" + HostName + ":" + port + ";database=" + dbName;
    
    public static Connection getConnect(){
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(URL, use, pass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }
    
//    public void Close(){
//        try {
//            conn.close();
//        } catch (SQLException ex) {
//            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
    
//    public static void main(String[] args) {
//        System.out.println(getConnect());
//    }
    
}
