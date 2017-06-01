/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

import dao.ProductDAO;
import dao.StockInDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Product;

/**
 *
 * @author DUONG
 */
public class CodeAutoIncrease {

    public String getCode(String code, String prefix) {
        String Code = "";
        try {
            if (code != null) {
                int nextNo = Integer.parseInt(code.substring(2)) + 1;
                Code = prefix + String.format("%07d", nextNo);
            } else {
                Code = prefix + String.format("%07d", 1);
            }

        } catch (Exception e) {
        }
        return Code;
    }

    public static void main(String[] args) throws SQLException {
        //System.out.println(new CodeAutoIncrease().getCode(new ProductDAO().getProductTOP().getCode(), AllConstant.Prefix_Product));
        System.out.println(new StockInDAO().getStockInTOP().getCode());
        System.out.println(new CodeAutoIncrease().getCode(new StockInDAO().getStockInTOP().getCode(), AllConstant.Prefix_StockIn));

    }

}
