import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class AuthRequest {

  static Future<String> makeGetRequest(String url, String token) async {
    String jwtToken = "Bearer $token";
    final requestLink = Uri.parse(url);
    final headers = {HttpHeaders.authorizationHeader: jwtToken};

    Response response = await get(requestLink, headers: headers);

    return response.body;
  }

  static Future<String> makePostRequest(String url, Map<String, dynamic> requestBody, String token) async {
    String jwtToken = "Bearer $token";
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: jwtToken,
    };
    Response response = await post(requestLink, headers: headers, body: json.encode(requestBody));

    return response.body;
  }

  static Future<String> makePutRequest(String url, Map<String, dynamic> requestBody, String token) async {
    String jwtToken = "Bearer $token";
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: jwtToken
    };
    Response response = await put(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }
}