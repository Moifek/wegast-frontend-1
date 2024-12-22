import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/user_controller.dart';
import 'package:wegast/models/items_models.dart';
import 'package:wegast/models/orders_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wegast/web_services.dart';

class OrdersController extends GetxController {
  var orders = <OrderData>[].obs;
  var orderItems = <ItemData>[].obs;
  var personalOrders = <OrderData>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  final UserController userController = Get.find();

  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  @override
  void onInit() async {
    super.onInit();
    await fetchOrders();
    orderItems.value = [];
    // await fetchPersonalOrders();
  }

  Future<void> fetchOrderItems(int? orderId) async {
    try {
      isLoading(true);
      orderItems.clear();

      if (orderId != null && orderId >= 0 && orderId < orders.length) {
        for (var item in orders[orderId].attributes!.orderItems!) {
          final ItemData? data = await ApiCalls().fetchItemById(item);
          if (data != null) {
            orderItems.add(data);
          }
        }
      }
    } catch (e) {
      print('Error fetching order items: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchOrders() async {
    isLoading(true);
    hasError(false);
    try {
      if (userController.fullUser.value.dasherProfile == null)
        throw ('ERROR: NO DASHER');
      final response = await http.get(
          Uri.parse(baseUrl +
              'api/orders?populate=*&filters[\$and][0][\$or][0][dasher_profile][id][\$eq]=' +
              userController.fullUser.value.dasherProfile!.id.toString() +
              '&filters[\$and][0][\$or][1][OrderStatus][\$ne]=initialized' +
              '&sort[0]=OrderStatus:desc&sort[1]=createdAt:desc'),
          headers: {'Authorization': 'Bearer ${userController.token}'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final ordersResponse = OrdersResponse.fromJson(
          data,
        );
        orders.assignAll(ordersResponse!.data!);
      } else {
        hasError(true);
        print('Errors: ${response}');
      }
    } catch (e) {
      hasError(true);
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchPersonalOrders() async {
    isLoading(true);
    hasError(false);
    try {
      final response = await http.get(
          Uri.parse(baseUrl +
              'api/orders?populate=*&filters[user][id][\$eq]=${userController.user.value.id}&filters[OrderStatus][\$ne]=finalized'),
          headers: {'Authorization': 'Bearer ${userController.token}'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final ordersResponse = OrdersResponse.fromJson(
          data,
        );
        personalOrders.assignAll(ordersResponse!.data!);
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
        Uri.parse(baseUrl + 'api/orders/' + orderId.toString() + '?populate=*'),
        body: jsonEncode({
          'data': {
            'OrderStatus': status,
          }
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<void> takeOrder(int orderId) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(baseUrl + 'api/order/take'),
        body: jsonEncode({
          'id': orderId,
          'userId': userController.fullUser.value.id,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<void> finalizeOrder(int orderId) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse(baseUrl + 'api/order/finalize'),
        body: jsonEncode({
          'id': orderId,
          'dasherId': userController.fullUser.value.id,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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
        .where((order) => true)
        // .where((order) => order.attributes?.orderStatus == 'orderPlaced')
        .toList();
  }

//TODO: Add active order
  // OrderData get activeOrder {
  //   return orders.where((order) => order.attributes).toList();
  // }
}
