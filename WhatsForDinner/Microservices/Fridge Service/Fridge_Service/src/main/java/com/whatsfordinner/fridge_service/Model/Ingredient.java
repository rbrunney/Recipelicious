package com.whatsfordinner.fridge_service.Model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;

@Getter
@Setter
public class Ingredient {

    private String name;

    private String qty;

    private String type;

}
