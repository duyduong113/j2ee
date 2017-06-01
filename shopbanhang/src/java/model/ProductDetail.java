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
public class ProductDetail {

    private long ID;
    private String ProductCode;
    private String AttributeCode;
    private String Value;

    //ProductAttribute
    private String Name;

    public ProductDetail() {
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

    public String getAttributeCode() {
        return AttributeCode;
    }

    public void setAttributeCode(String AttributeCode) {
        this.AttributeCode = AttributeCode;
    }

    public String getValue() {
        return Value;
    }

    public void setValue(String Value) {
        this.Value = Value;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

}
