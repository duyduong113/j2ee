/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author DUONG
 */
public class Cart {

    private HashMap<String, Item> cartItems;

    public Cart() {
        cartItems = new HashMap<>();
    }

    public Cart(HashMap<String, Item> cartItems) {
        this.cartItems = cartItems;
    }

    public HashMap<String, Item> getCartItems() {
        return cartItems;
    }

    public void setCartItems(HashMap<String, Item> cartItems) {
        this.cartItems = cartItems;
    }

    // insert to cart
    public void plusToCart(String key, Item item) {
        boolean check = cartItems.containsKey(key);
        if (check) {
            int quantity_old = item.getQuantity();
            item.setQuantity(quantity_old + 1);
            cartItems.put(key, item);
        } else {
            cartItems.put(key, item);
        }
    }

    // sub to cart
    public void subToCart(String key, Item item) {
        boolean check = cartItems.containsKey(key);
        if (check) {
            int quantity_old = item.getQuantity();
            if (quantity_old <= 1) {
                cartItems.remove(key);
            } else {
                item.setQuantity(quantity_old - 1);
                cartItems.put(key, item);
            }
        }
    }

    // remove to cart
    public void removeToCart(String key) {
        boolean check = cartItems.containsKey(key);
        if (check) {
            cartItems.remove(key);
        }
    }

    //remove all item cart
    public void clearCart() {
        cartItems.clear();

    }

    // count item
    public int countItem() {
        return cartItems.size();
    }

    // total 1 item
    public double totalItem(String key, Item item) {
        double count = 0;
        // count = price * quantity
        boolean check = cartItems.containsKey(key);
        if (check) {
            count = (item.getProduct().getPromotionPrice()==0?item.getProduct().getPrice():item.getProduct().getPromotionPrice())* item.getQuantity();
        }
        return count;
    }

    // sum total 
    public double totalCart() {
        double count = 0;
        // count = price * quantity
        for (Map.Entry<String, Item> list : cartItems.entrySet()) {
            count += (list.getValue().getProduct().getPromotionPrice()==0?list.getValue().getProduct().getPrice():list.getValue().getProduct().getPromotionPrice()) * list.getValue().getQuantity();
        }
        return count;
    }
}
