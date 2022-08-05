package com.whatsfordinner.mealservice.Bll;


import com.whatsfordinner.mealservice.Models.Ingredient;
import com.whatsfordinner.mealservice.Models.Meal;
import com.whatsfordinner.mealservice.Repository.MealRepo;
import com.whatsfordinner.mealservice.Util.MealUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MealBll {

    @Autowired
    private MealRepo mealRepo;

    public ResponseEntity<Map<String, Object>> findAllMeals(){

        Map<String, Object> response = new HashMap<>();

        response.put("message", "meals retrieved");
        response.put("results", mealRepo.findAll());
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    public ResponseEntity<Map<String, Object>> findByIngredient(List<Ingredient> ingredients){

        List<Map<String, String>> ingredientsJSON = new ArrayList<>();

        for (Ingredient ingredient : ingredients){

            Map<String, String> ingredientJSON = new HashMap<>();

            ingredientJSON.put("ingredients.name", ingredient.getName());
            ingredientsJSON.add(ingredientJSON);
        }

        List<Meal> meals = mealRepo.findMealByIngredient(ingredientsJSON);
        List<Meal> foundMeals = new ArrayList<>();

        for (Meal meal : meals){
            if (meal.getIngredients().size() <= ingredients.size()){
                foundMeals.add(meal);
            }
        }

        Map<String, Object> response = new HashMap<>();

        response.put("message", "meals retrieved");
        response.put("results", foundMeals);
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    public ResponseEntity<Map<String, Object>> getMealById(String mealID){

        Map<String, Object> response = new HashMap<>();

        response.put("message", "meal retrieved from " + mealID);
        response.put("results", mealRepo.findMealById(mealID));
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    public ResponseEntity<Map<String, Object>> getMealByCreator(String creator){

        Map<String, Object> response = new HashMap<>();

        response.put("message", "meal retrieved from " + creator);
        response.put("results", mealRepo.findMealByCreator(creator));
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    public ResponseEntity<Map<String, Object>> getMealByName(String name){

        Map<String, Object> response = new HashMap<>();

        response.put("message", "meal retrieved from " + name);
        response.put("results", mealRepo.findMealByName(name));
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    public ResponseEntity<Map<String, Object>> createMeal(Meal meal){

        mealRepo.save(meal);

        Map<String, Object> response = new HashMap<>();
        Map<String, Object> result = new HashMap<>();

        result.put("mealID", mealRepo.findMealByCreatorAndName(meal.getCreator(), meal.getName()).getId());
        result.put("name", meal.getName());

        response.put("message", "meal created");
        response.put("results", result);
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.CREATED);

    }

    public ResponseEntity<Map<String, Object>> updateMeal(String auth, Meal newMeal){

        Map<String, Object> response = new HashMap<>();

        if (MealUtil.userIsAuthorized(auth) && mealRepo.findMealById(newMeal.getId()).getCreator().equals(newMeal.getCreator())){

            mealRepo.save(newMeal);


            Map<String, Object> result = new HashMap<>();

            result.put("mealID", newMeal.getId());
            result.put("name", newMeal.getName());

            response.put("message", "meal updated");
            response.put("results", result);
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.OK);
        }

        response.put("message", "Credential were invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);

    }

    public ResponseEntity<Map<String, Object>> deleteMeal(String auth, String mealID){

        Map<String, Object> response = new HashMap<>();

        if (MealUtil.userIsAuthorized(auth) && mealRepo.findMealById(mealID).getCreator().equals(MealUtil.decodeAuth(auth)[0])){

            mealRepo.deleteById(mealID);

            response.put("message", "Meal Deleted");
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.NO_CONTENT);

        }

        response.put("message", "Credential were invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);

    }

    public ResponseEntity<Map<String, Object>> likeMeal(String mealID){

        Map<String, Object> response = new HashMap<>();

        Meal meal = mealRepo.findMealById(mealID);

        int likes = meal.getLikes();

        meal.setLikes(likes + 1);

        mealRepo.save(meal);

        response.put("message", "meal Liked");
        response.put("results", meal.getLikes());
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    public ResponseEntity<Map<String, Object>> unlikeMeal(String mealID){

        Map<String, Object> response = new HashMap<>();

        Meal meal = mealRepo.findMealById(mealID);

        int likes = meal.getLikes();

        meal.setLikes(likes - 1);

        mealRepo.save(meal);

        response.put("message", "meal Unliked");
        response.put("results", meal.getLikes());
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}
