/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import common.AllConstant;
import common.CodeAutoIncrease;
import dao.ProductAttributeDAO;
import dao.ProductCategoryDAO;
import dao.ProductDAO;
import dao.ProductDetailDAO;
import dao.ProductWarehouseDAO;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Product;
import model.ProductAttribute;
import model.ProductCategory;
import model.ProductDetail;
import model.ProductWarehouse;
import model.Users;

/**
 *
 * @author DUONG
 */
@MultipartConfig
public class ProductServlet extends HttpServlet {

    ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO();
    ProductDAO productDAO = new ProductDAO();
    ProductDetailDAO productDetailDAO = new ProductDetailDAO();
    ProductAttributeDAO productAttributeDAO = new ProductAttributeDAO();
    ProductWarehouseDAO productWarehouseDAO = new ProductWarehouseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        Users usersCurrent = (Users) session.getAttribute("users");

        ProductCategory productCategory = new ProductCategory();
        Product product = new Product();
        ProductDetail productDetail = new ProductDetail();

        String command = "null";
        String pages = "1";
        String url = "";
        String keyword = "";

        if (request.getParameter("keyword") != null) {
            keyword = request.getParameter("keyword");
        }
        if (request.getParameter("command") != null) {
            command = request.getParameter("command");
        }
        if (request.getParameter("pages") != null) {
            pages = request.getParameter("pages");
        }

        if (command.equals("changestatus")) {
            String Code = "";
            boolean Status = true;
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            if (request.getParameter("Status") != null) {
                Status = Boolean.parseBoolean(request.getParameter("Status"));
            }
            try {
                product.setModifiedDate(new Timestamp(new Date().getTime()));
                product.setModifiedBy(usersCurrent.getUserName());// chèn người dùng hiện tại
                product.setStatus(Status);
                product.setCode(Code);

                productDAO.changeStatusProduct(product);

                url = "/shopbanhang/administrator/product.jsp?keyword=" + keyword + "&pages=" + pages + "";
                response.sendRedirect(url);

            } catch (IOException e) {
            }
        } else if (command.equals("insertupdate")) {
            String ID = "", Name = "", Code = "", Price = "", PromotionPrice = "", Warranty = "", CategoryID = "", Description = "", Image = "", Status = "true";

            //get data
            if (request.getParameter("ID") != null) {
                ID = request.getParameter("ID");
            }
            if (request.getParameter("Name") != null) {
                Name = request.getParameter("Name");
            }
            if (request.getParameter("Code") != null) {
                Code = request.getParameter("Code");
            }
            if (request.getParameter("Price") != null) {
                Price = request.getParameter("Price");
            }
            if (request.getParameter("PromotionPrice") != null) {
                PromotionPrice = request.getParameter("PromotionPrice");
            }
            if (request.getParameter("Warranty") != null) {
                Warranty = request.getParameter("Warranty");
            }
            if (request.getParameter("CategoryID") != null) {
                CategoryID = request.getParameter("CategoryID");
            }
            if (request.getParameter("Description") != null) {
                Description = request.getParameter("Description");
            }
            if (request.getParameter("Status") != null) {
                Status = request.getParameter("Status");
            }

            // UPLOAD FILE 
            String appPath = request.getServletContext().getRealPath("");
            // constructs path of the directory to save uploaded file
            String savePath = appPath + File.separator + AllConstant.UPLOAD_DIRECTORY_PRODUCTS;
            // creates the directory if it does not exist
            File uploadDir = new File(savePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            Part part = request.getPart("file");
            String fileName = part.getSubmittedFileName();
            fileName = new File(fileName).getName();

            //set image link
            Image = AllConstant.UPLOAD_DIRECTORY_PRODUCTS + File.separator + fileName;
            try {
                OutputStream out = null;
                InputStream filecontent = null;
                try {
                    out = new FileOutputStream(new File(savePath + File.separator + fileName));
                    filecontent = part.getInputStream();
                    int read = 0;
                    final byte[] bytes = new byte[1024];
                    while ((read = filecontent.read(bytes)) != -1) {
                        out.write(bytes, 0, read);
                    }
                } catch (FileNotFoundException fne) {
                } finally {
                    if (out != null) {
                        out.close();
                    }
                    if (filecontent != null) {
                        filecontent.close();
                    }
                }

                //Insert_Update Here
                product.setCode(Code);
                product.setName(Name);
                product.setPrice(Double.parseDouble(Price));
                product.setPromotionPrice(Double.parseDouble(PromotionPrice));
                product.setWarranty(Integer.parseInt(Warranty));
                product.setCategoryID(Long.parseLong(CategoryID));
                product.setDescription(Description);
                product.setCreatedDate(new Timestamp(new Date().getTime()));
                product.setCreatedBy("");// sét admin
                product.setStatus(Status == null ? true : Boolean.parseBoolean(Status));

                if (fileName.length() > 0) {
                    product.setImage(Image);
                }
                if (ID.length() > 0) {
                    //update Product
                    product.setImage(fileName.length() == 0 ? productDAO.getProductByCode(Code).getImage() : Image);
                    productDAO.updateProduct(product);

                    //Delte ProductDetail
                    productDetailDAO.deleteProductDetail(Code);
                    //Insert ProductDetail
                    for (ProductAttribute productAttribute : productAttributeDAO.getListProductAttribute()) {
                        productDetail.setProductCode(Code);
                        productDetail.setAttributeCode(productAttribute.getCode());
                        productDetail.setValue(request.getParameter(productAttribute.getCode()) != null ? request.getParameter(productAttribute.getCode()) : "");
                        productDetailDAO.insertProductDetail(productDetail);
                    }

                } else {
                    //Insert Product
                    Code = new CodeAutoIncrease().getCode(productDAO.getProductTOP().getCode(), AllConstant.Prefix_Product);
                    product.setCode(Code);
                    productDAO.insertProduct(product);
                    //Insert Product Warehouse
                    ProductWarehouse productWarehouse = new ProductWarehouse();
                    productWarehouse.setProductCode(Code);
                    productWarehouse.setStockOnhand(0);
                    productWarehouse.setStockAvailable(0);
                    productWarehouse.setCreatedDate(new Timestamp(new Date().getTime()));
                    productWarehouse.setCreatedBy(usersCurrent.getUserName());
                    productWarehouseDAO.insertProductWarehouse(productWarehouse);

                }
                url = "/shopbanhang/administrator/product.jsp";
                response.sendRedirect(url);
            } catch (IOException e) {
            } catch (SQLException ex) {
                Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

}
