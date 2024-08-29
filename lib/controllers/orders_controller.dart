import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/user_controller.dart';
import 'package:wegast/models/orders_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersController extends GetxController {
  var orders = <OrderData>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  final UserController userController = Get.find();

  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading(true);
    hasError(false);
    try {
      final response =
          await http.get(Uri.parse(baseUrl + 'api/orders?populate=*'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final ordersResponse = OrdersResponse.fromJson(data);
        print(ordersResponse.toJson());
        orders.assignAll(ordersResponse.data);
      } else {
        hasError(true);
        print('Errors: ${response.statusCode}');
      }
    } catch (e) {
      hasError(true);
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateOrderStatus(int orderId, String status) async {
    isLoading(true);
    try {
      final response = await http.put(
        Uri.parse(baseUrl + 'api/order/take?populate=*'),
        body: jsonEncode({
          'id': orderId,
          'dasherId': userController.user.value.id,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("Order updated successfully");
        final updatedOrder =
            OrderData.fromJson(jsonDecode(response.body)['data']);
        int index = orders.indexWhere((order) => order.id == orderId);
        if (index != -1) {
          orders[index] = updatedOrder;
          orders.refresh();
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  List<OrderData> get orderPlacedOrders {
    return orders
        .where((order) => order.attributes.orderStatus == 'orderPlaced')
        .toList();
  }

  /*OrderData get activeOrder {
    return orders.where((order) => order).toList();
  }*/
}
