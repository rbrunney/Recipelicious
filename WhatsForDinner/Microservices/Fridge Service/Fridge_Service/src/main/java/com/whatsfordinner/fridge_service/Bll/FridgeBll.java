package com.whatsfordinner.fridge_service.Bll;

import com.whatsfordinner.fridge_service.Model.Fridge;
import com.whatsfordinner.fridge_service.Model.Ingredient;
import com.whatsfordinner.fridge_service.Repository.FridgeRepo;
import com.whatsfordinner.fridge_service.Util.FridgeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
public class FridgeBll {

    @Autowired
    private FridgeRepo fridgeRepo;

    public ResponseEntity<Map<String, Object>> findFridgeByID(String auth, String fridgeID){

        Map<String, Object> response = new HashMap<>();

        Fridge fridge = fridgeRepo.findByFridgeID(fridgeID);

        if (FridgeUtil.userIsAuthorized(auth) &&
                fridge.getUserName().equals(FridgeUtil.decodeAuth(auth)[0])){

            Map<String, Object> result = new HashMap<>();

            result.put("FridgeID", fridge.getFridgeID());
            result.put("name", fridge.getFridgeName());
            result.put("inventory", fridge.getIngredients());

            response.put("message", "fridge retrieved");
            response.put("result", result);
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.OK);
        }

        response.put("message", "Credential was invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);

    }

    public ResponseEntity<Map<String, Object>> createFridge(String auth, Fridge fridge) {



        Map<String, Object> response = new HashMap<>();

        if (FridgeUtil.userIsAuthorized(auth)) {

            Map<String, Object> result = new HashMap<>();

            fridgeRepo.save(fridge);

            result.put("FridgeID", fridge.getFridgeID());
            result.put("name", fridge.getFridgeName());
            result.put("inventory", fridge.getIngredients());

            response.put("message", "Fridge " + fridge.getFridgeID() + " by 'username: " + fridge.getUserName() + "' has been added");
            response.put("result", result);
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.CREATED);
        }

        response.put("message", "Credential was invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);

    }

    public ResponseEntity<Map<String, Object>> updateFridge (String auth, String fridgeID, Fridge fridge){

        Map<String, Object> response = new HashMap<>();

        Fridge oldFridge = fridgeRepo.findByFridgeID(fridgeID);

        if (FridgeUtil.userIsAuthorized(auth) &&
                oldFridge.getUserName().equals(FridgeUtil.decodeAuth(auth)[0])){

            Map<String, Object> result = new HashMap<>();

            fridgeRepo.save(fridge);

            result.put("FridgeID", fridge.getFridgeID());
            result.put("name", fridge.getFridgeName());
            result.put("inventory", fridge.getIngredients());

            response.put("message", "Fridge " + fridge.getFridgeID() + " by 'username: " + fridge.getUserName() + "' has been updated");
            response.put("result", result);
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.OK);

        }

        response.put("message", "Credential was invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    public ResponseEntity<Map<String, Object>> deleteFridge(String auth, String fridgeID) {

        Map<String, Object> response = new HashMap<>();

        Fridge fridge = fridgeRepo.findByFridgeID(fridgeID);

        if (FridgeUtil.userIsAuthorized(auth) &&
                fridge.getUserName().equals(FridgeUtil.decodeAuth(auth)[0])) {

            fridgeRepo.delete(fridge);

            response.put("message", "Credential was delete");
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.NO_CONTENT);

        }

        response.put("message", "Credential was invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    public ResponseEntity<Map<String, Object>> addItem(String auth, String fridgeID, Ingredient ingredient) {

        Map<String, Object> response = new HashMap<>();

        Fridge fridge = fridgeRepo.findByFridgeID(fridgeID);

        if (FridgeUtil.userIsAuthorized(auth) &&
                fridge.getUserName().equals(FridgeUtil.decodeAuth(auth)[0])){

            Map<String, Object> result = new HashMap<>();

            fridge.getIngredients().add(ingredient);

            fridgeRepo.save(fridge);

            result.put("FridgeID", fridge.getFridgeID());
            result.put("name", fridge.getFridgeName());
            result.put("inventory", fridge.getIngredients());

            response.put("message", "Fridge " + fridge.getFridgeID() + " has updated its inventory");
            response.put("result", result);
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.CREATED);

        }

        response.put("message", "Credential was invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);

    }

    public ResponseEntity<Map<String, Object>> updateItem(String auth, String fridgeID, Ingredient ingredient) {

        Map<String, Object> response = new HashMap<>();

        Fridge fridge = fridgeRepo.findByFridgeID(fridgeID);

        if (FridgeUtil.userIsAuthorized(auth) &&
                fridge.getUserName().equals(FridgeUtil.decodeAuth(auth)[0])){

            for (Ingredient fridgeIngredient: fridge.getIngredients()) {

                if (fridgeIngredient.getName().equals(ingredient.getName())) {

                    fridge.getIngredients().remove(fridgeIngredient);
                    fridge.getIngredients().add(ingredient);
                    break;

                }

            }

            Map<String, Object> result = new HashMap<>();

            result.put("FridgeID", fridge.getFridgeID());
            result.put("name", fridge.getFridgeName());
            result.put("inventory", fridge.getIngredients());

            response.put("message", "Fridge " + fridge.getFridgeID() + " has updated its inventory");
            response.put("result", result);
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.OK);

        }

        response.put("message", "Credential was invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);

    }

    public ResponseEntity<Map<String, Object>> deleteItem(String auth, String fridgeID, Ingredient ingredient) {

        Map<String, Object> response = new HashMap<>();

        Fridge fridge = fridgeRepo.findByFridgeID(fridgeID);

        if (FridgeUtil.userIsAuthorized(auth) &&
                fridge.getUserName().equals(FridgeUtil.decodeAuth(auth)[0])){



            fridge.getIngredients().remove(ingredient);

            fridgeRepo.save(fridge);

            response.put("message", "ingredient Deleted");
            response.put("Date-Time", LocalDateTime.now());

            return new ResponseEntity<>(response, HttpStatus.NO_CONTENT);
        }

        response.put("message", "Credential was invalid");
        response.put("Date-Time", LocalDateTime.now());

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);


    }



}
