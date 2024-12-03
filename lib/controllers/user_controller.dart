// user_controller.dart
import 'package:get/get.dart';
import 'package:wegast/models/user_model.dart';

class UserController extends GetxController {
  var token = '';

  var user = UserModel(
    id: 0,
    username: '',
    email: '',
    provider: '',
    confirmed: false,
    blocked: false,
    createdAt: DateTime.now(),
    phoneNumber: 0,
    updatedAt: DateTime.now(),
  ).obs;

  void setUser(UserModel userModel) {
    user.value = userModel;
  }

  void setToken(String token) {
    this.token = token;
  }

  void logout() {
    user.value = UserModel(
      id: 0,
      username: '',
      email: '',
      provider: '',
      confirmed: false,
      blocked: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      phoneNumber: 0,
    );

    Get.offNamed('/');
  }
}
