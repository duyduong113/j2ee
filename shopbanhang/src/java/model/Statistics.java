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
public class Statistics {
    private String Name;
    private double Value;

    public double getValue() {
        return Value;
    }

    public void setValue(double Value) {
        this.Value = Value;
    }

    public Statistics() {
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    

    @Override
    public String toString() {
        return Name;
    }
    
    
    
}
