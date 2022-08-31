package com.whatsfordinner.mealservice.Models;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@Setter
public class Ingredient {

    private String name;

    private int qty;

    private String measurement;

}
