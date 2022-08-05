package com.whatsfordinner.mealservice.Models;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;
import java.util.Map;

@Getter
@Setter
@Document(collection = "meals")
public class Meal {

    @Id
    private String id;

    private String creator;

    private String name;

    private double servingSize;

    private List<Ingredient> ingredients;

    private Map<Integer, String> recipe;

    private int likes;

}
