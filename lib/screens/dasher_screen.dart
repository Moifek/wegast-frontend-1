import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/models/orders_model.dart';
import 'package:wegast/screens/order_details_screen.dart';

class DasherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.put(OrdersController());

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

        final List<OrderData> visibleOrders =
            ordersController.orderPlacedOrders;

        if (visibleOrders.isEmpty) {
          return Center(child: Text('No orders available.'));
        }

        return ListView.builder(
          itemCount: visibleOrders.length,
          itemBuilder: (context, index) {
            final order = visibleOrders[index].obs;
            return ListTile(
              leading: CircleAvatar(child: Text('${order.value.id}')),
              hoverColor: Colors.white60,
              tileColor: order.value.attributes!.orderStatus == 'orderPlaced'
                  ? Colors.green
                  : order.value.attributes!.orderStatus == 'inProgress'
                      ? Colors.yellow
                      : order.value.attributes!.orderStatus == 'onRoute'
                          ? Colors.yellow
                          : order.value.attributes!.orderStatus == 'finalized'
                              ? Colors.blueGrey
                              : order.value.attributes!.orderStatus == 'dropOff'
                                  ? Colors.orange
                                  : Colors.white,
              title: Text('Commande pour: ' +
                  order.value.attributes!.restaurant!.attributes!.name!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Prix total: ${order.value.attributes?.totalPrice} ${order.value.attributes?.currency}'),
                  Text('Discount: ${order.value.attributes?.discount}%'),
                  Text(
                      'Status de Commande: ${order.value.attributes?.orderStatus}'),
                ],
              ),
              onTap: () {
                Get.to(() => OrderDetailsScreen(order: order.value));
              },
            );
          },
        );
      }),
    );
  }
}
