package com.whatsfordinner.shoppinglistservice.models;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;

@Document(collection = "ShopLists")
public class ShopList {

    @Id
    private String userID;
    private ArrayList<Ingredient> ingredients;

    public ShopList() {}

    public ShopList(String userID, ArrayList<Ingredient> ingredients) {
        this.userID = userID;
        this.ingredients = ingredients;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public ArrayList<Ingredient> getIngredients() {
        return ingredients;
    }

    public void setIngredients(ArrayList<Ingredient> ingredients) {
        this.ingredients = ingredients;
    }
}
