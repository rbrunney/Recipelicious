package com.whatsfordinner.shoppinglistservice.controller;

import com.whatsfordinner.shoppinglistservice.bll.ShoppingListBLL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/shoppingList")
public class ShoppingListController {

    @Autowired
    private ShoppingListBLL listBLL;

    @GetMapping("")
    public ResponseEntity<Map<String, Object>> createShoppingList(@RequestHeader(value="Authorization") String authHead) {
        return listBLL.generateShoppingList(authHead);
    }

    @PutMapping("/{item}")
    public ResponseEntity<Map<String, Object>>  updateShoppingCart(@RequestHeader(value="Authorization") String authHead, @PathVariable String item) {
        return listBLL.updateShoppingList(authHead, item);
    }

    @DeleteMapping("")
    public ResponseEntity<Map<String, Object>> deleteShoppingList(@RequestHeader(value="Authorization") String authHead) {
        return listBLL.deleteShoppingList(authHead);
    }
}
