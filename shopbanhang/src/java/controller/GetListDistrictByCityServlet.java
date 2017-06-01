/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CustomDataDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.District;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
/**
 *
 * @author DUONG
 */
public class GetListDistrictByCityServlet extends HttpServlet {

   CustomDataDAO customDataDAO = new CustomDataDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        ArrayList<District> lst = new ArrayList<>();
        try {
           lst = customDataDAO.getListDistrictByCity(request.getParameter("CityCode"));
           
   
            JSONObject json = new JSONObject();
            JSONArray lstdistrict = new JSONArray();
            JSONObject district;
           
           for(int i=0;i<lst.size();i++){
                district = new JSONObject();
               
                district.put("Code", lst.get(i).getCode());
                district.put("Name", lst.get(i).getName());
                lstdistrict.add(district);
           }
           
           json.put("lstdistrict", lstdistrict);
           
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
           
       } catch (SQLException ex) {
           Logger.getLogger(GetListDistrictByCityServlet.class.getName()).log(Level.SEVERE, null, ex);
       }
    }
    
    public static void main(String[] args) {
       
    }

}
