package com.whatsfordinner.fridge_service.Repository;

import com.whatsfordinner.fridge_service.Model.Fridge;
import com.whatsfordinner.fridge_service.Model.Ingredient;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FridgeRepo extends MongoRepository<Fridge, String> {

    Fridge findByFridgeID(String fridgeID);

    Fridge findByUserName(String username);

}
