import 'package:http/http.dart';

class Requests {
  Future<void> makePostRequest(
      String url, Map<String, dynamic> requestBody) async {
    final requestLink = Uri.parse(url);
    final headers = {"Content-type": "application/json"};
    final json = requestBody.toString();
    final response = await post(requestLink, headers: headers, body: json);

    print(response);
  }

  Future<String> makeGetRequest(String url) async {
    final requestLink = Uri.parse(url);
    Response response = await get(requestLink);

    return response.body;
  }
}
