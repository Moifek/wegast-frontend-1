import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/models/items_models.dart';
import 'package:wegast/models/orders_model.dart';
import 'package:wegast/web_services.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderData order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrdersController ordersController = Get.find();

  @override
  void initState() {
    super.initState();

    // Fetch items for this specific order
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Find the index of the current order in the controller's orders list
      final orderIndex =
          ordersController.orders.indexWhere((o) => o.id == widget.order.id);
      if (orderIndex != -1) {
        ordersController.fetchOrderItems(orderIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Obx(() {
        if (ordersController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderSummary(),
              const SizedBox(height: 20),
              _buildOrderStatusButtons(),
              const Spacer(),
              _buildClientContactInfo(),
              const SizedBox(height: 3),
              _buildOrderItemsList(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order No: ${widget.order.id}'),
        Text(
          'Total Amount: ${widget.order.attributes?.totalPrice} ${widget.order.attributes?.currency}',
        ),
        Text(
          'Discount: ${widget.order.attributes?.discount ?? 0}',
        ),
        Text(
          'Order Status: ${widget.order.attributes?.orderStatus}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildOrderItemsList() {
    return Obx(() {
      final fullItems = widget.order.attributes?.orderItems ?? [];
      final items = ordersController.orderItems;
      return items.isNotEmpty
          ? Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Commande',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: fullItems.length,
                      itemBuilder: (context, index) {
                        final item = fullItems[index];

                        return ListTile(
                          title: Text(items[index].attributes.name ??
                              'Commande inconnue'),
                          subtitle: Text('Quantité: ${item.quantity}'),
                          trailing: Text(
                            '${item.price} ${widget.order.attributes?.currency}',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink();
    });
  }

  Widget _buildOrderStatusButtons() {
    return Column(
      children: [
        _buildStatusButton(
          'In Progress',
          widget.order.attributes?.orderStatus == 'orderPlaced',
          () => ordersController.takeOrder(widget.order.id!),
        ),
        _buildStatusButton(
          'On Route',
          widget.order.attributes?.orderStatus == 'inProgress',
          () => ordersController.updateOrderStatus(widget.order.id!, 'onRoute'),
        ),
        _buildStatusButton(
          'Drop Off',
          widget.order.attributes?.orderStatus == 'onRoute',
          () => ordersController.updateOrderStatus(widget.order.id!, 'dropOff'),
        ),
        _buildStatusButton(
          'Finalized',
          widget.order.attributes?.orderStatus == 'dropOff',
          () => ordersController.finalizeOrder(widget.order.id!),
        ),
      ],
    );
  }

  Widget _buildStatusButton(
    String text,
    bool isEnabled,
    VoidCallback? onPressed,
  ) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      child: Text(text),
    );
  }

  Widget _buildClientContactInfo() {
    return widget.order.attributes?.orderStatus == 'dropOff'
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Call the Client \n +216 ${widget.order.attributes?.user?.phoneNumber}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
