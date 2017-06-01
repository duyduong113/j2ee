/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author DUONG
 */
public class Product {
    private long ID;
    private String Name;
    private String Code;
    private String MetaTitle;
    private String Description;
    private String Image;
    private String MoreImages;  //XML???????????????
    private double Price;
    private double PromotionPrice;
    private boolean IncludedVAT;
    //private int Quantity;
    private long CategoryID;
    private String Detail;
    private int Warranty;
    private Timestamp CreatedDate;
    private String CreatedBy;
    private Timestamp ModifiedDate;
    private String ModifiedBy;
    private String MetaKeywords;
    private String MetaDescriptions;
    private boolean Status;
    private Date TopHot;
    private int ViewCount;

    public Product() {
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public String getCode() {
        return Code;
    }

    public void setCode(String Code) {
        this.Code = Code;
    }

    public String getMetaTitle() {
        return MetaTitle;
    }

    public void setMetaTitle(String MetaTitle) {
        this.MetaTitle = MetaTitle;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public String getMoreImages() {
        return MoreImages;
    }

    public void setMoreImages(String MoreImages) {
        this.MoreImages = MoreImages;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double Price) {
        this.Price = Price;
    }

    public double getPromotionPrice() {
        return PromotionPrice;
    }

    public void setPromotionPrice(double PromotionPrice) {
        this.PromotionPrice = PromotionPrice;
    }

    public boolean isIncludedVAT() {
        return IncludedVAT;
    }

    public void setIncludedVAT(boolean IncludedVAT) {
        this.IncludedVAT = IncludedVAT;
    }

//    public int getQuantity() {
//        return Quantity;
//    }
//
//    public void setQuantity(int Quantity) {
//        this.Quantity = Quantity;
//    }

    public long getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(long CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getDetail() {
        return Detail;
    }

    public void setDetail(String Detail) {
        this.Detail = Detail;
    }

    public int getWarranty() {
        return Warranty;
    }

    public void setWarranty(int Warranty) {
        this.Warranty = Warranty;
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

    public String getMetaKeywords() {
        return MetaKeywords;
    }

    public void setMetaKeywords(String MetaKeywords) {
        this.MetaKeywords = MetaKeywords;
    }

    public String getMetaDescriptions() {
        return MetaDescriptions;
    }

    public void setMetaDescriptions(String MetaDescriptions) {
        this.MetaDescriptions = MetaDescriptions;
    }

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

    public Date getTopHot() {
        return TopHot;
    }

    public void setTopHot(Date TopHot) {
        this.TopHot = TopHot;
    }

    public int getViewCount() {
        return ViewCount;
    }

    public void setViewCount(int ViewCount) {
        this.ViewCount = ViewCount;
    }

    
}
