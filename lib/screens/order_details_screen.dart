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
                'Total Price: ${order.attributes?.totalPrice} ${order.attributes?.currency}'),
            Text('Discount: ${order.attributes?.discount}'),
            Text('Order Status: ${order.attributes?.orderStatus}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: order.attributes?.orderStatus == 'orderPlaced'
                  ? () {
                      ordersController.takeOrder(order!.id!);
                    }
                  : null,
              child: Text('inProgress'),
            ),
            ElevatedButton(
              onPressed: order.attributes?.orderStatus == 'inProgress'
                  ? () {
                      ordersController.updateOrderStatus(order!.id!, 'onRoute');
                    }
                  : null,
              child: Text('onRoute'),
            ),
            ElevatedButton(
              onPressed: order.attributes?.orderStatus == 'onRoute'
                  ? () {
                      ordersController.finalizeOrder(order!.id!);
                    }
                  : null,
              child: Text('finalized'),
            ),
            Spacer(),
            if (order.attributes?.orderStatus == 'finalized')
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'This order has been finalized. call the Client \n +216 ' +
                        order.attributes!.user!.phoneNumber.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
