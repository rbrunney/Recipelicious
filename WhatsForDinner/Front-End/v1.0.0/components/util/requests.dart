import 'dart:io';

import 'package:http/http.dart';
import 'dart:convert';

class Requests {
  Future<String> makePostRequest(
      String url, Map<String, dynamic> requestBody) async {
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      'Accept': 'application/json'
    };
    Response response = await post(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }

  Future<String> makePostRequestForList(
      String url, List<Map<String, dynamic>> requestBody) async {
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      'Accept': 'application/json'
    };
    Response response = await post(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }

  Future<String> makePostRequestWithAuth(
      String url,
      Map<String, dynamic> requestBody,
      String username,
      String password) async {
    String basicAuth =
        "Basic ${base64.encode(utf8.encode('$username:$password'))}";
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: basicAuth,
    };
    Response response = await post(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }

  Future<String> makeGetRequest(String url) async {
    final requestLink = Uri.parse(url);
    Response response = await get(requestLink);

    return response.body;
  }

  Future<String> makeGetRequestWithAuth(
      String url, String username, String password) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final requestLink = Uri.parse(url);
    final headers = {HttpHeaders.authorizationHeader: basicAuth};

    Response response = await get(requestLink, headers: headers);

    return response.body;
  }

  Future<String> makeDeleteRequest(
      String url, Map<String, dynamic> requestBody) async {
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    Response response = await delete(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }

  Future<String> makeDeleteRequestWithAuth(
      String url, Map<String, dynamic> requestBody, String username,
      String password) async {
        String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: basicAuth
    };
    Response response = await delete(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }

  Future<String> makePutRequest(
      String url, Map<String, dynamic> requestBody) async {
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    Response response = await put(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }

  Future<String> makePutRequestWithAuth(
      String url,
      Map<String, dynamic> requestBody,
      String username,
      String password) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final requestLink = Uri.parse(url);
    final headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: basicAuth
    };
    Response response = await put(requestLink,
        headers: headers, body: json.encode(requestBody));

    return response.body;
  }
}
