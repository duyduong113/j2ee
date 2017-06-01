/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author DUONG
 */
public class ProductWarehouse {
    private long ID;
    private String ProductCode;
    private int StockOnhand;
    private int StockAvailable;
    private Timestamp CreatedDate;
    private String CreatedBy;
    private Timestamp ModifiedDate;
    private String ModifiedBy;

    public ProductWarehouse() {
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public String getProductCode() {
        return ProductCode;
    }

    public void setProductCode(String ProductCode) {
        this.ProductCode = ProductCode;
    }

    public int getStockOnhand() {
        return StockOnhand;
    }

    public void setStockOnhand(int StockOnhand) {
        this.StockOnhand = StockOnhand;
    }

    public int getStockAvailable() {
        return StockAvailable;
    }

    public void setStockAvailable(int StockAvailable) {
        this.StockAvailable = StockAvailable;
    }

    public Timestamp getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(Timestamp CreatedDate) {
        this.CreatedDate = CreatedDate;
    }

    public String getCreatedBy() {
        return CreatedBy;
    }

    public void setCreatedBy(String CreatedBy) {
        this.CreatedBy = CreatedBy;
    }

    public Timestamp getModifiedDate() {
        return ModifiedDate;
    }

    public void setModifiedDate(Timestamp ModifiedDate) {
        this.ModifiedDate = ModifiedDate;
    }

    public String getModifiedBy() {
        return ModifiedBy;
    }

    public void setModifiedBy(String ModifiedBy) {
        this.ModifiedBy = ModifiedBy;
    }
    

}
