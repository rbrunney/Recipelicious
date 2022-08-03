package com.whatsfordinner.shoppinglistservice.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class ShopListUtil {

    // Decoding the Basic Authorization header from a request
    public static String[] decodeAuth(String encodedString) {
        encodedString = encodedString.substring(encodedString.indexOf(" ") + 1);
        byte[] decodedBytes = Base64.getDecoder().decode(encodedString);
        String decodedString = new String(decodedBytes);
        return decodedString.split(":", 2);
    }

    // Making a response message
    public static Map<String, Object> generateResponse(String message) {
        Map<String, Object> response = new HashMap<>();

        response.put("message", message);
        response.put("date-time", LocalDateTime.now());

        return response;
    }

    // Checking Authorization
    public static boolean userIsAuthorized(String authHead) {
        String[] userInfo = decodeAuth(authHead);
        //TODO Make a request to User service to check if they are a valid user

        return true;
    }

    // Making a Get Request
    public static String getRequest(String urlLink) throws IOException {
        //Starting Connection
        URL url = new URL(urlLink);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        //Setting up response formatting
        connection.setRequestProperty("Accept", "application/json");

        //Getting response data
        BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuilder responseContent = new StringBuilder();
        while ((inputLine = br.readLine()) != null) {
            responseContent.append(inputLine);
        }
        br.close();
        connection.disconnect();

        return responseContent.toString();
    }
}
