import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/models/orders_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderData order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}'),
            Text(
                'Total Price: ${order.attributes.totalPrice} ${order.attributes.currency}'),
            Text('Discount: ${order.attributes.discount}'),
            Text('Order Status: ${order.attributes.orderStatus}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ordersController.updateOrderStatus(order.id, 'inProgress');
              },
              child: Text('inProgress'),
            ),
            ElevatedButton(
              onPressed: () {
                ordersController.updateOrderStatus(order.id, 'onRoute');
              },
              child: Text('onRoute'),
            ),
            ElevatedButton(
              onPressed: () {
                ordersController.updateOrderStatus(order.id, 'finalized');
              },
              child: Text('finalized'),
            ),
          ],
        ),
      ),
    );
  }
}
