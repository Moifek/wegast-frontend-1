import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  fetchRestaurants() async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + 'api/restaurants?populate=*'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return data;
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      return null;
    }
  }

  fetchItems(String restaurantName, String category) async {
    try {
      final response = await http.get(Uri.parse(baseUrl +
          "api/items?populate=*&restaurants.name=" +
          restaurantName +
          "&item_category.name=" +
          category));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return data;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      return null;
    }
  }

  fetchCategories(String restaurantName) async {
    try {
      final response = await http.get(Uri.parse(
          baseUrl + "api/item-categories?restaurants.name=" + restaurantName));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];

        return data;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> validateOrder(int orderId, int dasherId) async {
    final url = Uri.parse(
        baseUrl + 'api/order/validate?order=$orderId&dasher=$dasherId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to validate order $orderId');
    }
  }

  Future<void> validateAllOrders(List<int> orderIds, int dasherId) async {
    for (int orderId in orderIds) {
      await validateOrder(orderId, dasherId);
    }
  }
}
