/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import common.AllConstant;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ProductCategory;
import model.Statistics;

/**
 *
 * @author DUONG
 */
public class StatisticsDAO {
    
    //Thông kê số sản phẩm đang hoạt động trong các chuyên mục đang hoạt động...
     public ArrayList<Statistics> ByProductCategory() {
        try {
            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
            ProductDAO productDAO = new ProductDAO();
            ArrayList<Statistics> list = new ArrayList<>();
            for (ProductCategory productCategory : productCategoryDAO.getListProductCategory()) {
                Statistics statistics = new Statistics();
                statistics.setName(productCategory.getName());
                statistics.setValue(productDAO.getListProduct(AllConstant.Product_BYCATEGORY, productCategory.getID()).size());
                list.add(statistics);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(StatisticsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
     
     public static void main(String[] args) {
         new StatisticsDAO().ByProductCategory();
         for(Statistics s : new StatisticsDAO().ByProductCategory()){
            System.out.println(s.getName() + "------------" + s.getValue());
         }
    }
    
}
