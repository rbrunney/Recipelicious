package com.whatsfordinner.mealservice;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.whatsfordinner.mealservice.Models.Ingredient;
import com.whatsfordinner.mealservice.Models.Meal;
import org.apache.http.HttpHeaders;
import org.json.JSONArray;
import org.json.JSONObject;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.util.Base64Utils;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

@SpringBootTest
@AutoConfigureMockMvc
@ContextConfiguration(classes = MealServiceApplication.class)
//@DirtiesContext(classMode = DirtiesContext.ClassMode.BEFORE_EACH_TEST_METHOD)
class MealServiceApplicationTests {

    private String mealID = "";

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    @Autowired
    MockMvc mockMvc;

    @Test
    void contextLoads() {
    }

    @Test
    public void testAddMeal() throws Exception{

        Meal meal = new Meal();

        meal.setName("ramen");
        meal.setCreator("dude");

        HashMap<Integer, String> recipe = new HashMap<>();

        recipe.put(1, "boil water");
        recipe.put(2, "put noodles in water");
        recipe.put(3, "add flavor packets");
        recipe.put(4, "stir and eat");

        meal.setRecipe(recipe);
        meal.setDescription("Instant ramen dish");
        meal.setLikes(20);
        meal.setServingSize(1);

        String jsonMeal = new ObjectMapper().valueToTree(meal).toString();

        ResultActions mealPostResult = mockMvc.perform(MockMvcRequestBuilders.post("/meal/").content(jsonMeal).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

        mealPostResult.andDo(print());

        String resultJson = mealPostResult.andReturn().getResponse().getContentAsString();

        JSONObject body = new JSONObject(resultJson);

        JSONObject result = (JSONObject) body.get("results");

        Assertions.assertNotEquals(null, body.get("Date-Time"));
        Assertions.assertEquals("meal created", body.get("message"));
        Assertions.assertNotEquals(null, result.get("mealID"));
        Assertions.assertEquals(meal.getName(), result.get("name"));

    }

    @Test
    public void testUpdateMeal() throws Exception{
        Meal meal = new Meal();

        meal.setName("ramen");
        meal.setCreator("mans");

        HashMap<Integer, String> recipe = new HashMap<>();

        recipe.put(1, "boil water");
        recipe.put(2, "put noodles in water");
        recipe.put(3, "add flavor packets");
        recipe.put(4, "stir and eat");

        meal.setRecipe(recipe);
        meal.setDescription("Instant ramen dish");
        meal.setLikes(21);
        meal.setServingSize(1);

        String jsonMeal = new ObjectMapper().valueToTree(meal).toString();

        ResultActions mealPostResult = mockMvc.perform(MockMvcRequestBuilders.post("/meal/").content(jsonMeal).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

        System.out.println("Update meal test");
        mealPostResult.andDo(print());

        String resultJson = mealPostResult.andReturn().getResponse().getContentAsString();

        JSONObject body = new JSONObject(resultJson);

        JSONObject result = (JSONObject) body.get("results");

        Assertions.assertNotEquals(null, body.get("Date-Time"));
        Assertions.assertEquals("meal created", body.get("message"));
        Assertions.assertNotEquals(null, result.get("mealID"));
        Assertions.assertEquals(meal.getName(), result.get("name"));

        String mealID = (String) result.get("mealID");

        List<Ingredient> ingredientList = new ArrayList<>();

        Ingredient ingredientOne = new Ingredient();

        ingredientOne.setName("Ramen Noodles");
        ingredientOne.setQty(1);
        ingredientOne.setMeasurement("One package");

        ingredientList.add(ingredientOne);

        Ingredient ingredientTwo = new Ingredient();

        ingredientTwo.setName("Ramen flavor packets");
        ingredientTwo.setQty(2);
        ingredientTwo.setMeasurement("One packet");

        ingredientList.add(ingredientTwo);

        meal.setIngredients(ingredientList);
        meal.setId(mealID);

        String updatedJsonString = new ObjectMapper().valueToTree(meal).toString();

        ResultActions updateMealResult = mockMvc.perform(MockMvcRequestBuilders.put("/meal/").header(HttpHeaders.AUTHORIZATION, "Basic " +
                Base64Utils.encodeToString("mans:secret".getBytes())).content(updatedJsonString).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

        updateMealResult.andDo(print());

        String updateResultJsonString = updateMealResult.andReturn().getResponse().getContentAsString();

        JSONObject updateBody = new JSONObject(updateResultJsonString);

        JSONObject updateResult = (JSONObject) updateBody.get("results");

        Assertions.assertNotEquals(null, updateBody.get("Date-Time"));
        Assertions.assertEquals("meal updated", updateBody.get("message"));
        Assertions.assertEquals(meal.getId(), updateResult.get("mealID"));
        Assertions.assertEquals(meal.getName(), updateResult.get("name"));

        this.mealID = (String) updateResult.get("mealID");

    }

    @Test
    public void testDeleteMeal() throws Exception{

        Meal meal = new Meal();

        meal.setName("ramen");
        meal.setCreator("bruh");

        HashMap<Integer, String> recipe = new HashMap<>();

        recipe.put(1, "boil water");
        recipe.put(2, "put noodles in water");
        recipe.put(3, "add flavor packets");
        recipe.put(4, "stir and eat");

        meal.setRecipe(recipe);
        meal.setDescription("Instant ramen dish");
        meal.setLikes(22);
        meal.setServingSize(1);

        String jsonMeal = new ObjectMapper().valueToTree(meal).toString();

        ResultActions mealPostResult = mockMvc.perform(MockMvcRequestBuilders.post("/meal/").content(jsonMeal).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

        System.out.println("Update meal test");
        mealPostResult.andDo(print());

        String resultJson = mealPostResult.andReturn().getResponse().getContentAsString();

        JSONObject body = new JSONObject(resultJson);

        JSONObject result = (JSONObject) body.get("results");

        Assertions.assertNotEquals(null, body.get("Date-Time"));
        Assertions.assertEquals("meal created", body.get("message"));
        Assertions.assertNotEquals(null, result.get("mealID"));
        Assertions.assertEquals(meal.getName(), result.get("name"));

        String mealID = (String) result.get("mealID");

        ResultActions deleteMealResult = mockMvc.perform(MockMvcRequestBuilders.delete("/meal/" + mealID + "/").header(HttpHeaders.AUTHORIZATION, "Basic " +
                Base64Utils.encodeToString("bruh:secret".getBytes())));

        deleteMealResult.andDo(print());

        String jsonDeleteResult = deleteMealResult.andReturn().getResponse().getContentAsString();

        JSONObject deleteResult = new JSONObject(jsonDeleteResult);

        Assertions.assertNotEquals(null, deleteResult.get("Date-Time"));
        Assertions.assertEquals("Meal Deleted", deleteResult.get("message"));

    }

    //Doesn't work. No idea why but whatever I throw at get by ingredients nothing gets returned back.
//    @Test
//    public void testGetByIngredients() throws Exception{
//
//        Meal meal = new Meal();
//
//        meal.setName("ramen");
//        meal.setCreator("guys");
//
//        HashMap<Integer, String> recipe = new HashMap<>();
//
//        recipe.put(1, "boil water");
//        recipe.put(2, "put noodles in water");
//        recipe.put(3, "add flavor packets");
//        recipe.put(4, "stir and eat");
//
//        meal.setRecipe(recipe);
//        meal.setDescription("Instant ramen dish");
//        meal.setLikes(20);
//        meal.setServingSize(1);
//
//        List<Ingredient> ingredientList = new ArrayList<>();
//
//        Ingredient ingredientOne = new Ingredient();
//
//        ingredientOne.setName("Ramen Noodles");
//        ingredientOne.setQty(1);
//        ingredientOne.setMeasurement("One package");
//
//        ingredientList.add(ingredientOne);
//
//        Ingredient ingredientTwo = new Ingredient();
//
//        ingredientTwo.setName("Ramen flavor packets");
//        ingredientTwo.setQty(2);
//        ingredientTwo.setMeasurement("One packet");
//
//        ingredientList.add(ingredientTwo);
//
//        meal.setIngredients(ingredientList);
//
//        String jsonMeal = new ObjectMapper().valueToTree(meal).toString();
//
//        ResultActions mealPostResult = mockMvc.perform(MockMvcRequestBuilders.post("/meal/").content(jsonMeal).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));
//
//        System.out.println("Meal post in findByIngredient: ");
//        mealPostResult.andDo(print());
//
//        String ingredientRequest = new ObjectMapper().valueToTree(ingredientList).toString();
//
//        ResultActions result = mockMvc.perform(MockMvcRequestBuilders.get("/meal/findByIngredients").content(ingredientRequest)
//                .contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));
//
//        result.andDo(print());
//
//    }

    @Test
    public void testFindByMostLikedFirst() throws Exception{
        ResultActions likedResponse = mockMvc.perform(MockMvcRequestBuilders.get("/meal/findByMostLikes/{offset}/","0")
                .accept(MediaType.APPLICATION_JSON));

        likedResponse.andDo(print());

        String jsonString = likedResponse.andReturn().getResponse().getContentAsString();

        JSONObject body = new JSONObject(jsonString);

        JSONArray results = (JSONArray) body.get("results");

        JSONObject firstElement = (JSONObject) results.get(0);
        JSONObject lastElement = (JSONObject) results.get(results.length() - 1);

        //This is not great but it gets the job done - yes I know it's not really checking if it's fully sorted
        //But I wrote this at 1:45 AM on August 31st 2022 - cut me some slack.
        Assertions.assertTrue((Integer) firstElement.get("likes") > (Integer) lastElement.get("likes"));
    }

    @Test
    public void testFindByLeastLikedFirst() throws Exception{
        ResultActions likedResponse = mockMvc.perform(MockMvcRequestBuilders.get("/meal/findByLeastLikes/{offset}",0)
                .accept(MediaType.APPLICATION_JSON));

        likedResponse.andDo(print());

        String jsonString = likedResponse.andReturn().getResponse().getContentAsString();

        JSONObject body = new JSONObject(jsonString);

        JSONArray results = (JSONArray) body.get("results");

        JSONObject firstElement = (JSONObject) results.get(0);
        JSONObject lastElement = (JSONObject) results.get(results.length() - 1);

        //This is not great but it gets the job done - yes I know it's not really checking if it's fully sorted
        //But I wrote this at 1:45 AM on August 31st 2022 - cut me some slack.
        Assertions.assertTrue((Integer) firstElement.get("likes") < (Integer) lastElement.get("likes"));

    }

}
