package com.whatsfordinner.fridge_service.Controller;

import com.whatsfordinner.fridge_service.Bll.FridgeBll;
import com.whatsfordinner.fridge_service.Model.Fridge;
import com.whatsfordinner.fridge_service.Model.Ingredient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/fridge")
public class FridgeController {

//    @Value("${EUREKA_HOST}")
//    private String test;
    @Autowired
    private FridgeBll fridgeBll;

    @GetMapping("/{fridgeID}")
    public ResponseEntity<Map<String, Object>> getFridge(@RequestHeader(value = "Authorization") String auth, @PathVariable String fridgeID){
        return fridgeBll.findFridgeByID(auth, fridgeID);
    }

    @PostMapping("")
    public ResponseEntity<Map<String, Object>> createFridge(@RequestHeader(value = "Authorization") String auth, @RequestBody Fridge fridge){
        return fridgeBll.createFridge(auth, fridge);
    }

    @PutMapping("{fridgeID}")
    public ResponseEntity<Map<String, Object>> updateFridge(@RequestHeader(value = "Authorization") String auth, @PathVariable String fridgeID, @RequestBody Fridge fridge){
        return fridgeBll.updateFridge(auth, fridgeID, fridge);
    }

    @DeleteMapping("{fridgeID}")
    public ResponseEntity<Map<String, Object>> deleteFridge(@RequestHeader(value = "Authorization") String auth,@PathVariable String fridgeID){
        return fridgeBll.deleteFridge(auth, fridgeID);
    }

    @PostMapping("{fridgeID}/addItem")
    public ResponseEntity<Map<String, Object>> addItem(@RequestHeader(value = "Authorization") String auth, @PathVariable String fridgeID, @RequestBody Ingredient ingredient){
        return fridgeBll.addItem(auth, fridgeID, ingredient);
    }

    @PutMapping("{fridgeID}/updateItem")
    public ResponseEntity<Map<String, Object>> updateItem(@RequestHeader(value = "Authorization") String auth, @PathVariable String fridgeID, @RequestBody Ingredient ingredient){
        return fridgeBll.updateItem(auth, fridgeID, ingredient);
    }

    @DeleteMapping("/{fridgeID}/deleteItem")
    public ResponseEntity<Map<String, Object>> deleteItem(@RequestHeader(value = "Authorization") String auth, @PathVariable String fridgeID, @RequestBody Ingredient ingredient){
        return fridgeBll.deleteItem(auth, fridgeID, ingredient);
    }

//    @GetMapping("/test")
//    public String testEurekaENV(){
//        return test;
//    }
}
