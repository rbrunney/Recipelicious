package com.whatsfordinner.fridge_service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.whatsfordinner.fridge_service.Model.Fridge;
import com.whatsfordinner.fridge_service.Model.Ingredient;
import org.apache.http.HttpHeaders;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.util.Base64Utils;
import java.util.ArrayList;
import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
public class FridgeServiceApplicationTests {

	@SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
	@Autowired
	private MockMvc mockMvc;

	/*
		userName:
		fridgeName:
		ingredients:
	 */

	@Test
	public void testAddItem() throws Exception{

		Fridge fridge = new Fridge();

		fridge.setUserName("testUser04");
		fridge.setFridgeName("testFridge");
		fridge.setIngredients(new ArrayList<>());

		String requestBody = new ObjectMapper().valueToTree(fridge).toString();

		System.out.println(requestBody);

		ResultActions result = mockMvc.perform(MockMvcRequestBuilders.post("/fridge").header(HttpHeaders.AUTHORIZATION, "Basic " +
				Base64Utils.encodeToString("user:secret".getBytes())).content(requestBody).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));



		String jsonResult = result.andDo(print()).andExpect(status().is(HttpStatus.CREATED.value()))
				.andExpect(content().contentType(MediaType.APPLICATION_JSON)).andReturn().getResponse().getContentAsString();

		JSONObject jsonParsed = new JSONObject(jsonResult);

		JSONObject nestedValues = (JSONObject) jsonParsed.get("result");

		Assertions.assertNotEquals(null, jsonParsed.get("result"));
		Assertions.assertNotEquals(null, nestedValues.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), nestedValues.get("name"));
		Assertions.assertNotEquals(null, nestedValues.get("inventory"));
		Assertions.assertNotEquals(null, jsonParsed.get("Date-Time"));
		Assertions.assertEquals("Fridge " +  nestedValues.get("FridgeID") + " by 'username: " + fridge.getUserName() + "' has been added", jsonParsed.get("message"));
	}

	@Test
	public void testGetFridge() throws Exception {
		Fridge fridgeToGet = new Fridge();

		fridgeToGet.setUserName("testUser03");
		fridgeToGet.setFridgeName("testFridge02");
		fridgeToGet.setIngredients(new ArrayList<>());

		String fridgeJson = new ObjectMapper().valueToTree(fridgeToGet).toString();

		ResultActions result = mockMvc.perform(MockMvcRequestBuilders.post("/fridge/").header(HttpHeaders.AUTHORIZATION, "Basic " +
				Base64Utils.encodeToString("user:secret".getBytes())).content(fridgeJson).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

		result.andDo(print());

		String rawJsonResponse = result.andReturn().getResponse().getContentAsString();

		JSONObject jsonResponse = new JSONObject(rawJsonResponse);

		JSONObject resultObject  = (JSONObject) jsonResponse.get("result");

		String fridgeId = (String) resultObject.get("FridgeID");

		System.out.println(fridgeId);

		Assertions.assertNotEquals(null, jsonResponse.get("result"));
		Assertions.assertNotEquals(null, resultObject.get("FridgeID"));
		Assertions.assertEquals(fridgeToGet.getFridgeName(), resultObject.get("name"));
		Assertions.assertNotEquals(null, resultObject.get("inventory"));
		Assertions.assertNotEquals(null, jsonResponse.get("Date-Time"));
		Assertions.assertEquals("Fridge " +  resultObject.get("FridgeID") + " by 'username: " + fridgeToGet.getUserName() + "' has been added", jsonResponse.get("message"));

		ResultActions getFridgeResult = mockMvc.perform(MockMvcRequestBuilders.get("/fridge/" + resultObject.get("FridgeID"))
				.header(HttpHeaders.AUTHORIZATION, "Basic " +
						Base64Utils.encodeToString("testUser03:secret".getBytes())).accept(MediaType.APPLICATION_JSON));
									//Be sure to match the user that created the fridge here
		getFridgeResult.andDo(print());

		String rawJsonGetResponse = getFridgeResult.andReturn().getResponse().getContentAsString();

		System.out.println(rawJsonGetResponse);

		JSONObject getJsonResponse = new JSONObject(rawJsonGetResponse);

		JSONObject getResultObject = (JSONObject) getJsonResponse.get("result");

		Assertions.assertEquals(resultObject.get("FridgeID"), getResultObject.get("FridgeID"));
		Assertions.assertEquals(fridgeToGet.getFridgeName(), getResultObject.get("name"));
		Assertions.assertNotEquals(null, getResultObject.get("inventory"));
		Assertions.assertNotEquals(null, getJsonResponse.get("Date-Time"));
		Assertions.assertEquals("fridge retrieved", getJsonResponse.get("message"));

	}

	@Test
	public void testAddItems() throws Exception{
		Fridge fridge = new Fridge();

		fridge.setUserName("testUser");
		fridge.setFridgeName("testFridge03");
		fridge.setIngredients(new ArrayList<>());

		String content = new ObjectMapper().valueToTree(fridge).toString();

		ResultActions createResult = mockMvc.perform(MockMvcRequestBuilders.post("/fridge/").header(HttpHeaders.AUTHORIZATION, "Basic " +
				Base64Utils.encodeToString("user:secret".getBytes())).content(content)
				.contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

//		createResult.andDo(print());



		String resultString = createResult.andReturn().getResponse().getContentAsString();

		JSONObject jsonResponse = new JSONObject(resultString);

		JSONObject resultObject = (JSONObject) jsonResponse.get("result");

		Assertions.assertNotEquals(null, jsonResponse.get("result"));
		Assertions.assertNotEquals(null, resultObject.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), resultObject.get("name"));
		Assertions.assertNotEquals(null, resultObject.get("inventory"));
		Assertions.assertNotEquals(null, jsonResponse.get("Date-Time"));
		Assertions.assertEquals("Fridge " +  resultObject.get("FridgeID") + " by 'username: " + fridge.getUserName() + "' has been added", jsonResponse.get("message"));

		Ingredient ingredient = new Ingredient();

		ingredient.setName("Potatoes");
		ingredient.setQty("4");

		String ingredientJson = new ObjectMapper().valueToTree(ingredient).toString();

		ResultActions addItemResult = mockMvc.perform(MockMvcRequestBuilders.post("/fridge/" + resultObject.get("FridgeID") + "/addItem").header(HttpHeaders.AUTHORIZATION, "Basic " +
						Base64Utils.encodeToString("testUser:secret".getBytes())).content(ingredientJson)
				.contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

		addItemResult.andDo(print());

		String itemResult = addItemResult.andReturn().getResponse().getContentAsString();

		JSONObject updatedFridge = new JSONObject(itemResult);

		JSONObject updateResult = (JSONObject) updatedFridge.get("result");

		JSONArray ingredients = (JSONArray) updateResult.get("inventory");

		JSONObject arrayItem = (JSONObject) ingredients.get(0);

		Assertions.assertEquals(resultObject.get("FridgeID"), updateResult.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), updateResult.get("name"));
		Assertions.assertEquals(ingredient.getName(), arrayItem.get("name"));
		Assertions.assertEquals(ingredient.getQty(), arrayItem.get("qty"));
		Assertions.assertNotEquals(null, updatedFridge.get("Date-Time"));
		Assertions.assertEquals("Fridge " + resultObject.get("FridgeID") + " has updated its inventory", updatedFridge.get("message"));
	}

	@Test
	public void testDeleteItemFromFridge() throws Exception{
		Fridge fridge = new Fridge();

		fridge.setUserName("testUser04");
		fridge.setFridgeName("testFridge04");
		fridge.setIngredients(new ArrayList<>());

		String content = new ObjectMapper().valueToTree(fridge).toString();

		ResultActions createResult = mockMvc.perform(MockMvcRequestBuilders.post("/fridge/").header(HttpHeaders.AUTHORIZATION, "Basic " +
						Base64Utils.encodeToString("user:secret".getBytes())).content(content)
				.contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

//		createResult.andDo(print());



		String resultString = createResult.andReturn().getResponse().getContentAsString();

		JSONObject jsonResponse = new JSONObject(resultString);

		JSONObject resultObject = (JSONObject) jsonResponse.get("result");

		Assertions.assertNotEquals(null, jsonResponse.get("result"));
		Assertions.assertNotEquals(null, resultObject.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), resultObject.get("name"));
		Assertions.assertNotEquals(null, resultObject.get("inventory"));
		Assertions.assertNotEquals(null, jsonResponse.get("Date-Time"));
		Assertions.assertEquals("Fridge " +  resultObject.get("FridgeID") + " by 'username: " + fridge.getUserName() + "' has been added", jsonResponse.get("message"));

		Ingredient ingredient = new Ingredient();

		ingredient.setName("Potatoes");
		ingredient.setQty("4");

		String ingredientJson = new ObjectMapper().valueToTree(ingredient).toString();

		ResultActions addItemResult = mockMvc.perform(MockMvcRequestBuilders.post("/fridge/" + resultObject.get("FridgeID") + "/addItem").header(HttpHeaders.AUTHORIZATION, "Basic " +
						Base64Utils.encodeToString("testUser04:secret".getBytes())).content(ingredientJson)
				.contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

//		addItemResult.andDo(print());

		String itemResult = addItemResult.andReturn().getResponse().getContentAsString();

		JSONObject updatedFridge = new JSONObject(itemResult);

		JSONObject updateResult = (JSONObject) updatedFridge.get("result");

		JSONArray ingredients = (JSONArray) updateResult.get("inventory");

		JSONObject arrayItem = (JSONObject) ingredients.get(0);

		Assertions.assertEquals(resultObject.get("FridgeID"), updateResult.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), updateResult.get("name"));
		Assertions.assertEquals(ingredient.getName(), arrayItem.get("name"));
		Assertions.assertEquals(ingredient.getQty(), arrayItem.get("qty"));
		Assertions.assertNotEquals(null, updatedFridge.get("Date-Time"));
		Assertions.assertEquals("Fridge " + resultObject.get("FridgeID") + " has updated its inventory", updatedFridge.get("message"));

		ResultActions deleteRequest = mockMvc.perform(delete("/fridge/" + resultObject.get("FridgeID") + "/deleteItem/").header(HttpHeaders.AUTHORIZATION, "Basic " +
				Base64Utils.encodeToString("testUser04:secret".getBytes())).content(ingredientJson).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

		deleteRequest.andDo(print());

		String deleteJson = deleteRequest.andReturn().getResponse().getContentAsString();

		JSONObject deleteJsonObject = new JSONObject(deleteJson);

		Assertions.assertEquals("ingredient Deleted", deleteJsonObject.get("message"));
		Assertions.assertNotEquals(null, deleteJsonObject.get("Date-Time"));
	}

	@Test
	public void testUpdateItem() throws Exception{
		Fridge fridge = new Fridge();

		fridge.setUserName("testUser04");
		fridge.setFridgeName("testFridge04");
		fridge.setIngredients(new ArrayList<>());

		String content = new ObjectMapper().valueToTree(fridge).toString();

		ResultActions createResult = mockMvc.perform(MockMvcRequestBuilders.post("/fridge/").header(HttpHeaders.AUTHORIZATION, "Basic " +
						Base64Utils.encodeToString("user:secret".getBytes())).content(content)
				.contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

//		createResult.andDo(print());



		String resultString = createResult.andReturn().getResponse().getContentAsString();

		JSONObject jsonResponse = new JSONObject(resultString);

		JSONObject resultObject = (JSONObject) jsonResponse.get("result");

		Assertions.assertNotEquals(null, jsonResponse.get("result"));
		Assertions.assertNotEquals(null, resultObject.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), resultObject.get("name"));
		Assertions.assertNotEquals(null, resultObject.get("inventory"));
		Assertions.assertNotEquals(null, jsonResponse.get("Date-Time"));
		Assertions.assertEquals("Fridge " +  resultObject.get("FridgeID") + " by 'username: " + fridge.getUserName() + "' has been added", jsonResponse.get("message"));

		Ingredient ingredient = new Ingredient();

		ingredient.setName("Potatoes");
		ingredient.setQty("4");

		String ingredientJson = new ObjectMapper().valueToTree(ingredient).toString();

		ResultActions addItemResult = mockMvc.perform(MockMvcRequestBuilders.post("/fridge/" + resultObject.get("FridgeID") + "/addItem").header(HttpHeaders.AUTHORIZATION, "Basic " +
						Base64Utils.encodeToString("testUser04:secret".getBytes())).content(ingredientJson)
				.contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

//		addItemResult.andDo(print());

		String itemResult = addItemResult.andReturn().getResponse().getContentAsString();

		JSONObject updatedFridge = new JSONObject(itemResult);

		JSONObject updateResult = (JSONObject) updatedFridge.get("result");

		JSONArray ingredients = (JSONArray) updateResult.get("inventory");

		JSONObject arrayItem = (JSONObject) ingredients.get(0);

		Assertions.assertEquals(resultObject.get("FridgeID"), updateResult.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), updateResult.get("name"));
		Assertions.assertEquals(ingredient.getName(), arrayItem.get("name"));
		Assertions.assertEquals(ingredient.getQty(), arrayItem.get("qty"));
		Assertions.assertNotEquals(null, updatedFridge.get("Date-Time"));
		Assertions.assertEquals("Fridge " + resultObject.get("FridgeID") + " has updated its inventory", updatedFridge.get("message"));

		Ingredient updatedIngredient = new Ingredient();

		updatedIngredient.setName("Potatoes");
		updatedIngredient.setQty("10");

		String updatedItemJson = new ObjectMapper().valueToTree(updatedIngredient).toString();

		ResultActions updateItemResult = mockMvc.perform(put("/fridge/" + updateResult.get("FridgeID") + "/updateItem/" ).header(HttpHeaders.AUTHORIZATION, "Basic " +
						Base64Utils.encodeToString("testUser04:secret".getBytes())).content(updatedItemJson).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));

		updateItemResult.andDo(print());

		String updateItemString = updateItemResult.andReturn().getResponse().getContentAsString();

		System.out.println("raw update json string response: " + updateItemString);

		JSONObject updatedItemObject = new JSONObject(updateItemString);

		JSONObject updatedItemResult = (JSONObject) updatedItemObject.get("result");

		JSONArray updatedIngredients = (JSONArray) updatedItemResult.get("inventory");

		JSONObject updatedItem = (JSONObject) updatedIngredients.get(0);

		Assertions.assertEquals(resultObject.get("FridgeID"), updatedItemResult.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), updatedItemResult.get("name"));
		Assertions.assertEquals(updatedIngredient.getName(), updatedItem.get("name"));
		Assertions.assertEquals(updatedIngredient.getQty(), updatedItem.get("qty"));
		Assertions.assertNotEquals(null, updatedItemObject.get("Date-Time"));
		Assertions.assertEquals("Fridge " + resultObject.get("FridgeID") + " has updated its inventory", updatedItemObject.get("message"));

	}

	@Test
	public void testUpdateFridge() throws Exception{
		Fridge fridge = new Fridge();

		fridge.setUserName("testUser04");
		fridge.setFridgeName("testFridge");
		fridge.setIngredients(new ArrayList<>());

		String requestBody = new ObjectMapper().valueToTree(fridge).toString();

		System.out.println(requestBody);

		ResultActions result = mockMvc.perform(MockMvcRequestBuilders.post("/fridge").header(HttpHeaders.AUTHORIZATION, "Basic " +
				Base64Utils.encodeToString("user:secret".getBytes())).content(requestBody).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));



		String jsonResult = result.andDo(print()).andExpect(status().is(HttpStatus.CREATED.value()))
				.andExpect(content().contentType(MediaType.APPLICATION_JSON)).andReturn().getResponse().getContentAsString();

		JSONObject jsonParsed = new JSONObject(jsonResult);

		JSONObject nestedValues = (JSONObject) jsonParsed.get("result");

		Assertions.assertNotEquals(null, jsonParsed.get("result"));
		Assertions.assertNotEquals(null, nestedValues.get("FridgeID"));
		Assertions.assertEquals(fridge.getFridgeName(), nestedValues.get("name"));
		Assertions.assertNotEquals(null, nestedValues.get("inventory"));
		Assertions.assertNotEquals(null, jsonParsed.get("Date-Time"));
		Assertions.assertEquals("Fridge " +  nestedValues.get("FridgeID") + " by 'username: " + fridge.getUserName() + "' has been added", jsonParsed.get("message"));

		Fridge fridgeToUpdateWith = new Fridge();

		fridgeToUpdateWith.setFridgeName("ShinyNewLGFridge");
		fridgeToUpdateWith.setUserName("testUser04");

		List<Ingredient> newInventory = new ArrayList<>();

		Ingredient newIngredient1 = new Ingredient();

		newIngredient1.setName("cola");
		newIngredient1.setQty("2");

		newInventory.add(newIngredient1);

		Ingredient newIngredient2 = new Ingredient();

		newIngredient2.setName("Potatoes");
		newIngredient2.setQty("10");

		newInventory.add(newIngredient2);

		fridgeToUpdateWith.setIngredients(newInventory);

		String updateJson = new ObjectMapper().valueToTree(fridgeToUpdateWith).toString();

		ResultActions updateFridgeResult = mockMvc.perform(put("/fridge/" + nestedValues.get("FridgeID")).header(HttpHeaders.AUTHORIZATION, "Basic " +
				Base64Utils.encodeToString("testUser04:secret".getBytes())).content(updateJson).contentType(MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON));


		updateFridgeResult.andDo(print());

		String resultJson = updateFridgeResult.andReturn().getResponse().getContentAsString();

		JSONObject updatedFridgeObject = new JSONObject(resultJson);

		JSONObject updatedFridgeResult = (JSONObject) updatedFridgeObject.get("result");

		JSONArray updatedIngredients = (JSONArray) updatedFridgeResult.get("inventory");

		Assertions.assertEquals(nestedValues.get("FridgeID"), updatedFridgeResult.get("FridgeID"));
		Assertions.assertEquals(fridgeToUpdateWith.getFridgeName(), updatedFridgeResult.get("name"));

		for(int i = 0; i < updatedIngredients.length(); i++){
			JSONObject currentIngredient = (JSONObject) updatedIngredients.get(i);

			Assertions.assertEquals(newInventory.get(i).getName(), currentIngredient.get("name"));
			Assertions.assertEquals(newInventory.get(i).getQty(), currentIngredient.get("qty"));
		}
		Assertions.assertNotEquals(null, updatedFridgeObject.get("Date-Time"));
		Assertions.assertEquals("Fridge " + nestedValues.get("FridgeID") + " by 'username: " + fridgeToUpdateWith.getUserName() + "' has been updated", updatedFridgeObject.get("message"));
	}


}
