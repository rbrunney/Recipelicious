import 'package:get/get.dart';

class TokenController extends GetxController {

  String? accessToken;
  String? refreshToken;

  getAuthenticationTokens(String username, String password) {
    // Make a request here
    accessToken = '';
    refreshToken = '';
  }

  clearAuthenticationTokens() {
    accessToken = '';
    refreshToken = '';
  }
}