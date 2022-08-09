package com.whatsfordinner.fridge_service.Util;

import java.util.Base64;

public class FridgeUtil {

    public static boolean userIsAuthorized(String authHead) {
        String[] userInfo = decodeAuth(authHead);
        //TODO Make a request to User service to check if they are a valid user

        return true;
    }
    public static String[] decodeAuth(String encodedString) {
        encodedString = encodedString.substring(encodedString.indexOf(" ") + 1);
        byte[] decodedBytes = Base64.getDecoder().decode(encodedString);
        String decodedString = new String(decodedBytes);
        return decodedString.split(":", 2);
    }

}
