package com.whatsfordinner.mealservice.Models;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@Setter
@Document(collection = "meals")
public class Ingredient {

    private String name;

    private String qty;

}
