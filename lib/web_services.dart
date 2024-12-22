import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:wegast/models/items_models.dart';
import 'package:wegast/models/orders_model.dart';

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
      restaurantName = restaurantName.toLowerCase();
      category = category.toLowerCase();
      final response = await http.get(Uri.parse(baseUrl +
          "api/items?populate=*&filters[restaurant][Name][\$eq]=" +
          restaurantName +
          "&filters[item_category][Name][\$eq]=" +
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

  Future<ItemData?> fetchItemById(OrderItems item) async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl + 'api/items/${item.id - 1}?populate=*'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return ItemData.fromJson(data);
      }

      // If no item is successfully fetched
      throw Exception('Failed to load any items');
    } catch (e) {
      print('Error fetching item: $e');
      return null;
    }
  }

  fetchCategories(String restaurantName) async {
    try {
      restaurantName = restaurantName.toLowerCase();
      final response = await http.get(Uri.parse(baseUrl +
          'api/item-categories?filters[restaurants][Name][\$eq]=' +
          restaurantName +
          '&populate=*'));
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
