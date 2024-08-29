import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wegast/models/user_model.dart';
import 'package:wegast/controllers/user_controller.dart';

class LoginController extends GetxController {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  var isLoading = false.obs;

  Future<void> login(String identifier, String password) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(baseUrl + 'api/auth/local'),
        body: jsonEncode({
          'identifier': identifier,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['jwt'] != null) {
          final String jwt = data['jwt'];
          final UserController userController = Get.find();
          UserModel loggedInUser = UserModel.fromJson(data['user']);
          userController.setUser(loggedInUser);

          await fetchUserRole(jwt);
        } else {
          Get.snackbar('Error', 'Invalid credentials');
        }
      } else {
        var errorData = jsonDecode(response.body);
        print('Error data: $errorData');
        Get.snackbar('Error',
            'Invalid credentials: ${errorData['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to connect to the server');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserRole(String jwt) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'api/users/me?populate=*'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        var userDetails = jsonDecode(response.body);

        if (userDetails['role'] != null &&
                userDetails['role']['name'] == 'DeliveryDriver' ||
            userDetails['AppRole'] == 'dasher') {
          Get.offNamed('/dasher');
        } else {
          Get.offNamed('/home');
        }
      } else {
        print('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }
}
