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
public class ProductAttribute {

    private long ID;
    private String Code;
    private String Type;
    private String Name;
    private Timestamp CreatedDate;
    private String CreatedBy;
    private Timestamp ModifiedDate;
    private String ModifiedBy;
    private boolean Status;

    public ProductAttribute() {
    }

    public long getID() {
        return ID;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public String getCode() {
        return Code;
    }

    public void setCode(String Code) {
        this.Code = Code;
    }

    public String getType() {
        return Type;
    }

    public void setType(String Type) {
        this.Type = Type;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
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

    public boolean isStatus() {
        return Status;
    }

    public void setStatus(boolean Status) {
        this.Status = Status;
    }

}
