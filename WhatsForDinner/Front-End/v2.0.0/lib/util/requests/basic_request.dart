import 'dart:convert';
import 'package:http/http.dart';

class BasicRequest {
  static Future<String> makeGetRequest(String url) async {
    final requestLink = Uri.parse(url);
    Response response = await get(requestLink);

    return response.body;
  }

  static Future<String> makePostRequest(String url, Map<String, dynamic> requestBody) async {
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      'Accept': 'application/json'
    };

    Response response = await post(requestLink, headers: headers, body: json.encode(requestBody));

    return response.body;
  }

}