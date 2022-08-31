package com.whatsfordinner.mealservice.Controllers;

import com.whatsfordinner.mealservice.Bll.MealBll;
import com.whatsfordinner.mealservice.Models.Ingredient;
import com.whatsfordinner.mealservice.Models.Meal;
import org.apache.http.protocol.ResponseServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/meal")
@CrossOrigin()
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

    @GetMapping("/like/{mealID}/{username}")
    public ResponseEntity<Map<String, Object>> likeMeal(@PathVariable String mealID, @PathVariable String username){return mealBll.likeMeal(mealID, username);}

    @GetMapping("/save/{mealID}/{username}")
    public ResponseEntity<Map<String, Object>> saveMeal(@PathVariable String mealID, @PathVariable String username) {
        return mealBll.saveMeal(mealID, username);
    }

    @GetMapping("/unlike/{mealID}/{username}")
    public ResponseEntity<Map<String, Object>> unlikeMeal(@PathVariable String mealID, @PathVariable String username){return mealBll.unlikeMeal(mealID, username);}

    @GetMapping("/unsave/{mealID}/{username}")
    public ResponseEntity<Map<String, Object>> unsaveMeal(@PathVariable String mealID, @PathVariable String username) {
        return mealBll.unsaveMeal(mealID, username);
    }

    @GetMapping("/getLikedMeals/{username}")
    public ResponseEntity<Map<String, Object>> getLikedMealsByUser(@PathVariable String username) {
        return mealBll.getLikedMealsByUsername(username);
    }

    @GetMapping("/getSavedMeals/{username}")
    public ResponseEntity<Map<String, Object>> getSavedMealsByUser(@PathVariable String username) {
        return mealBll.getSavedMealsByUsername(username);
    }

    @GetMapping("/findByMostLikes/{offset}")
    public ResponseEntity<Map<String, Object>> getByMostLiked(@PathVariable int offset){return mealBll.returnSortedMeals(offset);}

    @GetMapping("/findByLeastLikes/{offset}")
    public ResponseEntity<Map<String, Object>> getByLeastLiked(@PathVariable int offset){
        return mealBll.returnLowestLikedFirst(offset);
    }

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
