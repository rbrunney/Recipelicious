package com.whatsfordinner.shoppinglistservice.models;

public class Ingredient {

    private String name;
    private double quantity;
    private boolean isInCart;

    public Ingredient() {}

    public Ingredient(String name, double quantity, boolean isInCart) {
        this.name = name;
        this.quantity = quantity;
        this.isInCart = isInCart;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }

    public boolean isInCart() {
        return isInCart;
    }

    public void setInCart(boolean inCart) {
        isInCart = inCart;
    }
}
