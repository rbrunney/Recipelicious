package com.whatsfordinner.fridge_service.Model;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Getter
@Setter
@Document(collection = "fridges")
public class Fridge {

    @Id
    private String fridgeID;

    private String userName;

    private String fridgeName;

    private List<Ingredient> ingredients;

}
