import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/screens/myorder.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Deliverytabs extends StatefulWidget {
  const Deliverytabs({Key? key}) : super(key: key);

  @override
  State<Deliverytabs> createState() => _DeliverytabsState();
}

class _DeliverytabsState extends State<Deliverytabs> {
  late ColorNotifier notifier;
  final OrdersController ordersController = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  Future<void> fetchOrders() async {
    print('fetching orders');
    await ordersController.fetchOrders();
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    final orders = ordersController.orders;
    return Scaffold(
      backgroundColor: notifier.getwhite,
      body: FutureBuilder<void>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (ordersController.hasError.value) {
            return Center(child: Text('Failed to fetch orders'));
          }

          return Obx(() {
            return ListView.builder(
              itemCount: orders.length + 1,
              itemBuilder: (context, index) {
                if (index == orders.length) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyOrder(),
                      ),
                    ),
                    child: Container(
                      height: height / 10,
                      color: Colors.transparent,
                      child: Center(
                          child: Text(
                        'Go to My Orders',
                        style: TextStyle(color: notifier.getblackcolor),
                      )),
                    ),
                  );
                }

                final order = orders[index];
                final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                    .format(order.attributes!.createdAt!);

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.orangeAccent,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Order ID: ${order.id}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price: ${order.attributes?.totalPrice} ${order.attributes?.currency}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$formattedDate',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Order Status: ${order.attributes?.orderStatus}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }

  Widget estbutton() {
    return Container(
      height: height / 28,
      width: width / 2.9,
      decoration: BoxDecoration(
        color: notifier.getred,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
        child: Text(
          "Est. Time 13:45",
          style: TextStyle(
            color: notifier.getwhite,
            fontSize: height / 60,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }
}
