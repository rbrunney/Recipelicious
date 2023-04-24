import 'package:get/get.dart';

class UserDataController extends GetxController {
  String name = '';
  String email = '';
  String photoUrl = '';

  setUserData(String name, String email, String photoUrl) {
    this.name = name;
    this.email = email;
    this.photoUrl = photoUrl;
  }

  clearUserData() {
    name = '';
    email = '';
    photoUrl = '';
  }

  showData() {
    print({
      'name' : name,
      'email' : email,
      'photoUrl' : photoUrl
    }.toString());
  }
}