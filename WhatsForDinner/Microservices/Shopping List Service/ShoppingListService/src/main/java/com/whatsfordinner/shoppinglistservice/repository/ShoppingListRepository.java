package com.whatsfordinner.shoppinglistservice.repository;

import com.whatsfordinner.shoppinglistservice.models.ShopList;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ShoppingListRepository extends MongoRepository<ShopList, String> {
    ShopList getShopListByUserID(String userID);
}
