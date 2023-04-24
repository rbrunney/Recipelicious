import 'package:get/get.dart';

// Defining Log In Types
enum LoginType { none, google, facebook, whatsForDinner }

class LoginController extends GetxController {

  LoginType currentLoginType = LoginType.none;

  setCurrentLoginType(LoginType loginType) {
    currentLoginType = loginType;
  }

  clearCurrentLoginType() {
    currentLoginType = LoginType.none;
  }

  // Google Login methods
  googleLogin() async {

  }

  googleLogout() async {

  }

  // WhatsForDinner Login methods
  mainLogin(String username, String password) async {

  }

  mainLogout() async {

  }
}
