/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author DUONG
 */
public class CheckInventoryDetail {

    private long ID;
    private String CheckInventoryCode;
    private String ProductCode;
    private int Quantity;
    private int StockOnhand;

    public CheckInventoryDetail() {
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public String getCheckInventoryCode() {
        return CheckInventoryCode;
    }

    public void setCheckInventoryCode(String CheckInventoryCode) {
        this.CheckInventoryCode = CheckInventoryCode;
    }

    public String getProductCode() {
        return ProductCode;
    }

    public void setProductCode(String ProductCode) {
        this.ProductCode = ProductCode;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public int getStockOnhand() {
        return StockOnhand;
    }

    public void setStockOnhand(int StockOnhand) {
        this.StockOnhand = StockOnhand;
    }

}
