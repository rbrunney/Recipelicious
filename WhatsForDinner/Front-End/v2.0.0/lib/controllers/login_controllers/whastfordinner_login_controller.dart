import 'package:get/get.dart';
import 'package:whatsfordinner/controllers/login_controllers/util/ilogin_controller.dart';
import 'package:whatsfordinner/controllers/token_controllers/token_controller.dart';
import 'package:whatsfordinner/controllers/user_data_controllers/user_data_controller.dart';

import 'util/login_type_controller.dart';

class LoginController extends GetxController implements ILoginController{
  final loginTypeController = Get.put(LoginTypeController());
  final userDataController = Get.put(UserDataController());
  final accessTokenController = Get.put(TokenController());

  @override
  void login() {
    // Make Request Here to backend
    loginTypeController.setCurrentLoginType(LoginType.whatsForDinner);

    // Get Access Tokens
    accessTokenController.getAuthenticationTokens("", "");
    
    // Set User Data
    userDataController.setUserData("", "", "");
  }

  @override
  void logout() {
    accessTokenController.clearAuthenticationTokens();
    userDataController.clearUserData();
    loginTypeController.clearCurrentLoginType();
  }
}
