// user_controller.dart
import 'package:get/get.dart';
import 'package:wegast/models/orders_model.dart';
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

  var fullUser = UserFullModel(
    id: 0,
    username: 'username',
    email: 'email',
    provider: 'provider',
    confirmed: true,
    blocked: false,
    phoneNumber: 94728,
    adress: Adress(
        id: 0,
        streetAdress: 'streetAdress',
        latitude: 0,
        longtitude: 0,
        areaCode: 'areaCode',
        type: 'type',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        publishedAt: DateTime.now()),
    appRole: 'client',
    dasherRating: 0,
    dasherProfile: null,
    orders: null,
    role: Role(
        id: 0,
        name: 'name',
        description: 'description',
        type: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ).obs;

  void setUser(UserModel userModel) {
    user.value = userModel;
  }

  void setFullUser(UserFullModel userFullModel) {
    fullUser.value = userFullModel;
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
