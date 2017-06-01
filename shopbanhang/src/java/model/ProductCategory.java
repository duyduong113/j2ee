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
public class ProductCategory {

    private long ID;
    private String Name;
    private String MetaTitle;
    private long ParentID;
    private String Image;
    private int DisplayOrder;
    private String SeoTitle;
    private Timestamp CreatedDate;
    private String CreatedBy;
    private Timestamp ModifiedDate;
    private String ModifiedBy;
    private String MetaKeywords;
    private String MetaDescriptions;
    private boolean Status;
    private boolean ShowOnHome;

    public ProductCategory() {
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

    public String getMetaTitle() {
        return MetaTitle;
    }

    public void setMetaTitle(String MetaTitle) {
        this.MetaTitle = MetaTitle;
    }

    public long getParentID() {
        return ParentID;
    }

    public void setParentID(long ParentID) {
        this.ParentID = ParentID;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getDisplayOrder() {
        return DisplayOrder;
    }

    public void setDisplayOrder(int DisplayOrder) {
        this.DisplayOrder = DisplayOrder;
    }

    public String getSeoTitle() {
        return SeoTitle;
    }

    public void setSeoTitle(String SeoTitle) {
        this.SeoTitle = SeoTitle;
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

    public boolean isShowOnHome() {
        return ShowOnHome;
    }

    public void setShowOnHome(boolean ShowOnHome) {
        this.ShowOnHome = ShowOnHome;
    }

}
