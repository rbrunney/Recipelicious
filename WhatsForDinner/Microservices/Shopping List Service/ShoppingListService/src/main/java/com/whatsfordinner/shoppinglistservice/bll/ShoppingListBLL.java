package com.whatsfordinner.shoppinglistservice.bll;

import com.whatsfordinner.shoppinglistservice.models.Ingredient;
import com.whatsfordinner.shoppinglistservice.models.ShopList;
import com.whatsfordinner.shoppinglistservice.repository.ShoppingListRepository;
import com.whatsfordinner.shoppinglistservice.util.ShopListUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Map;

@Service
public class ShoppingListBLL {

    @Autowired
    private ShoppingListRepository repo;

    public ResponseEntity<Map<String, Object>> generateShoppingList(String authHead) {

        if (ShopListUtil.userIsAuthorized(authHead)) {
            ShopList currentShopList = new ShopList();
            currentShopList.setUserID(ShopListUtil.decodeAuth(authHead)[0]);
            //TODO Call Meal Service to get the ingredients for meal
            //TODO Call Fridge Service to get the users current ingredients
            //TODO Making Shopping List based off the difference between the ingredients

            repo.save(currentShopList);

            //Making Response Body
            Map<String, Object> response = ShopListUtil.generateResponse("Shopping List has been generated");
            response.put("results", "");

            return new ResponseEntity<>(response, HttpStatus.OK);
        }

        return new ResponseEntity(ShopListUtil.generateResponse("Not Authorized to get shopping list"), HttpStatus.UNAUTHORIZED);
    }

    public ResponseEntity<Map<String, Object>> updateShoppingList(String authHead, String itemName) {

        if(ShopListUtil.userIsAuthorized(authHead)) {
            ShopList shopList = repo.getShopListByUserID(ShopListUtil.decodeAuth(authHead)[0]);
            ArrayList<Ingredient> ingredients = shopList.getIngredients();

            if(ingredients == null || ingredients.size() == 0) {
                return new ResponseEntity<>(ShopListUtil.generateResponse("Shopping List is Empty"), HttpStatus.OK);
            }

            for(Ingredient ingredient: ingredients) {
                if(ingredient.getName().equals(itemName)) {
                    //TODO Update database with new information
                    ingredient.setInCart(true);

                    Map<String, Object> response = ShopListUtil.generateResponse("Shopping List updated successfully");
                    response.put("results", shopList);
                    return new ResponseEntity<>(response, HttpStatus.OK);
                }
            }
        }

        return new ResponseEntity(ShopListUtil.generateResponse("Not Authorized to update shopping list"), HttpStatus.UNAUTHORIZED);
    }

    public ResponseEntity<Map<String, Object>> deleteShoppingList(String authHead) {

        if(ShopListUtil.userIsAuthorized(authHead)) {
            repo.deleteById(ShopListUtil.decodeAuth(authHead)[0]);
            return new ResponseEntity<>(ShopListUtil.generateResponse("Shopping List has been deleted"), HttpStatus.OK);
        }

        return new ResponseEntity(ShopListUtil.generateResponse("Not Authorized to update shopping list"), HttpStatus.UNAUTHORIZED);
    }
}
