import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/models/orders_model.dart';
import 'package:wegast/screens/order_details_screen.dart';

class DasherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dasher Orders'),
        actions: [
          IconButton(
            onPressed: () {
              ordersController.fetchOrders();
            },
            icon: Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Obx(() {
        if (ordersController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (ordersController.hasError.value) {
          return Center(child: Text('Failed to load orders'));
        }

        final List<OrderData> orderPlacedOrders =
            ordersController.orderPlacedOrders;

        if (orderPlacedOrders.isEmpty) {
          return Center(child: Text('No orders available.'));
        }

        return ListView.builder(
          itemCount: orderPlacedOrders.length,
          itemBuilder: (context, index) {
            final order = orderPlacedOrders[index];
            return ListTile(
              title: Text('Order ID: ${order.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Total Price: ${order.attributes.totalPrice} ${order.attributes.currency}'),
                  Text('Discount: ${order.attributes.discount}'),
                  Text('Order Status: ${order.attributes.orderStatus}'),
                ],
              ),
              onTap: () {
                Get.to(() => OrderDetailsScreen(order: order));
              },
            );
          },
        );
      }),
    );
  }
}
