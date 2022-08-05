package com.whatsfordinner.mealservice.Controllers;

import com.whatsfordinner.mealservice.Bll.MealBll;
import com.whatsfordinner.mealservice.Models.Ingredient;
import com.whatsfordinner.mealservice.Models.Meal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/meal")
public class MealController {

    @Autowired
    private MealBll mealBll;

    @GetMapping("")
    public ResponseEntity<Map<String, Object>> findAllMeals(){return mealBll.findAllMeals();}

    @GetMapping("/{mealID}")
    public ResponseEntity<Map<String, Object>> findByID(@PathVariable String mealID){return mealBll.getMealById(mealID);}

    @GetMapping("/findByCreator/{creator}")
    public ResponseEntity<Map<String, Object>> findByCreator(@PathVariable String creator){return mealBll.getMealByCreator(creator);}

    @GetMapping("/findByName/{name}")
    public ResponseEntity<Map<String, Object>> findByName(@PathVariable String name){return mealBll.getMealByName(name);}

    @GetMapping("/like/{mealID}")
    public ResponseEntity<Map<String, Object>> likeMeal(@PathVariable String mealID){return mealBll.likeMeal(mealID);}

    @GetMapping("/unlike/{mealID}")
    public ResponseEntity<Map<String, Object>> unlikeMeal(@PathVariable String mealID){return mealBll.unlikeMeal(mealID);}

    @PostMapping("/findByIngredients")
    public ResponseEntity<Map<String, Object>> findByIngredients(@RequestBody List<Ingredient> ingredients){
        return mealBll.findByIngredient(ingredients);
    }

    @PostMapping("")
    public ResponseEntity<Map<String, Object>> createMeal(@RequestBody Meal meal){return mealBll.createMeal(meal);}

    @PutMapping("")
    public ResponseEntity<Map<String, Object>> updateMeal(@RequestHeader(value = "Authorization") String auth, @RequestBody Meal meal){
        return mealBll.updateMeal(auth, meal);
    }

    @DeleteMapping("/{mealID}")
    public ResponseEntity<Map<String, Object>> deleteMeal(@RequestHeader(value = "Authorization") String auth, @PathVariable String mealID){
        return mealBll.deleteMeal(auth, mealID);
    }
}
