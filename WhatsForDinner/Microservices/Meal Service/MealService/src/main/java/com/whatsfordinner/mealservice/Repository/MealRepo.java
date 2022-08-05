package com.whatsfordinner.mealservice.Repository;

import com.whatsfordinner.mealservice.Models.Meal;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface MealRepo extends MongoRepository<Meal, String> {

    @Query("{$and : ?0}")
    List<Meal> findMealByIngredient(List<Map<String, String>> ingredients);

    List<Meal> findMealByCreator(String creator);

    List<Meal> findMealByName(String name);

    Meal findMealById(String id);

    Meal findMealByCreatorAndId(String creator, String id);

    Meal findMealByCreatorAndName(String creator, String name);
}
