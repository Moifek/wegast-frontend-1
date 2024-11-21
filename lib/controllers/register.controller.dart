import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationController extends GetxController {
  var isLoading = false.obs;
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<void> register(String name, String email, String username,
      String password, String phoneNumber) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(baseUrl + 'api/auth/local/register'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'username': username,
          'password': password,
          'PhoneNumber': phoneNumber
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['jwt'] != null) {
          Get.snackbar('Success', 'Registration successful');
          // await Future.delayed(Duration(seconds: 2));
          // showRoleSelectionDialog(data['jwt']);
          Get.offNamed('/');
        } else {
          Get.snackbar('Error', 'Registration failed: No JWT received');
        }
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = 'Registration failed';
        if (errorData['error'] != null) {
          var errors = errorData['error']['details']['errors'];
          if (errors != null && errors.isNotEmpty) {
            errorMessage = errors.map((e) => e['message']).join(', ');
          }
        }
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to the server');
    } finally {
      isLoading.value = false;
    }
  }

  void showRoleSelectionDialog(String jwt) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text('Rôle'),
        content: Text('S.V.P Choisir votre rôle'),
        actions: [
          CupertinoDialogAction(
            child: Text('Dasher'),
            onPressed: () => updateUserRole(jwt, 1),
          ),
          CupertinoDialogAction(
            child: Text('User'),
            onPressed: () => updateUserRole(jwt, 0),
          ),
        ],
      ),
    );
  }

  Future<void> updateUserRole(String jwt, int role) async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl + 'api/users/me?populate=*'),
        body: jsonEncode({
          'role': {
            'type': role,
          }
        }),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Get.offNamed('/');
      } else {
        Get.snackbar('Error', 'Failed to update user role');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to the server');
    }
  }
}
