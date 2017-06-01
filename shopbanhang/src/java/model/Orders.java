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
public class Orders {

    private long ID;
    private String Code;
    private long CustomerID;
    private String ShipName;
    private String ShipMobile;
    private String ShipAddress;
    private String ShipEmail;
    private Timestamp CreatedDate;
    private String CreatedBy;
    private Timestamp ModifiedDate;
    private String ModifiedBy;
    private int Status;

    public Orders() {
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

    public long getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(long CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getShipName() {
        return ShipName;
    }

    public void setShipName(String ShipName) {
        this.ShipName = ShipName;
    }

    public String getShipMobile() {
        return ShipMobile;
    }

    public void setShipMobile(String ShipMobile) {
        this.ShipMobile = ShipMobile;
    }

    public String getShipAddress() {
        return ShipAddress;
    }

    public void setShipAddress(String ShipAddress) {
        this.ShipAddress = ShipAddress;
    }

    public String getShipEmail() {
        return ShipEmail;
    }

    public void setShipEmail(String ShipEmail) {
        this.ShipEmail = ShipEmail;
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

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

}
