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
              Text('Order ID: ${order.attributes!.user!.phoneNumber}'),
              Text(
                  'Total Price: ${order.attributes?.totalPrice} ${order.attributes?.currency}'),
              Text(
                  'Discount: ${order.attributes!.discount != null ? order.attributes?.discount : 0}'),
              Text('Order Status: ${order.attributes?.orderStatus}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: order.attributes?.orderStatus == 'orderPlaced'
                    ? () {
                        ordersController.takeOrder(order!.id!);
                        ordersController.refresh();
                      }
                    : null,
                child: Text('inProgress'),
              ),
              ElevatedButton(
                onPressed: order.attributes?.orderStatus == 'inProgress'
                    ? () {
                        ordersController.updateOrderStatus(
                            order!.id!, 'onRoute');
                        ordersController.refresh();
                      }
                    : null,
                child: Text('onRoute'),
              ),
              ElevatedButton(
                onPressed: order.attributes?.orderStatus == 'onRoute'
                    ? () {
                        ordersController.updateOrderStatus(
                            order!.id!, 'dropOff');
                        ordersController.refresh();
                      }
                    : null,
                child: Text('dropOff'),
              ),
              ElevatedButton(
                onPressed: order.attributes?.orderStatus == 'dropOff'
                    ? () {
                        ordersController.finalizeOrder(order!.id!);
                        ordersController.refresh();
                      }
                    : null,
                child: Text('finalized'),
              ),
              Spacer(),
              if (order.attributes?.orderStatus == 'dropOff')
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'call the Client \n +216 ' +
                          order.attributes!.user!.phoneNumber.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Spacer(),
              // itemsList(order!.attributes!),
            ],
          ),
        ));
  }
}

// itemsList(OrderAttributes orderAttributes) {
//   return ListView.builder(
//     itemCount: 1,
//     itemBuilder: (context, index) {
//       return ListTile(
//         leading: CircleAvatar(child: Text('${order.id}')),
//         hoverColor: Colors.white60,
//         tileColor: order.attributes!.orderStatus == 'orderPlaced'
//             ? Colors.green
//             : order.attributes!.orderStatus == 'inProgress'
//                 ? Colors.yellow
//                 : order.attributes!.orderStatus == 'onRoute'
//                     ? Colors.yellow
//                     : order.attributes!.orderStatus == 'finalized'
//                         ? Colors.blueGrey
//                         : order.attributes!.orderStatus == 'dropOff'
//                             ? Colors.orange
//                             : Colors.white,
//         title: Text('Commande pour: ' +
//             order.attributes!.restaurant!.attributes!.name!),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//                 'Prix total: ${order.attributes?.totalPrice} ${order.attributes?.currency}'),
//             Text('Discount: ${order.attributes?.discount}%'),
//             Text('Status de Commande: ${order.attributes?.orderStatus}'),
//           ],
//         ),
//         onTap: () {
//           Get.to(() => OrderDetailsScreen(order: order));
//         },
//       );
//     },
//   );
// }
