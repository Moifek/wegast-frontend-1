import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wegast/custtomscreens/custtombutton.dart';
import 'package:wegast/screens/myorder.dart';
import 'package:wegast/screens/ordersucsess.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/screens/yourorder/deliveryadrees.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wegast/web_services.dart';

class OrderConformation extends StatefulWidget {
  const OrderConformation({Key? key}) : super(key: key);

  @override
  State<OrderConformation> createState() => _OrderConformationState();
}

class _OrderConformationState extends State<OrderConformation> {
  final OrdersController ordersController = Get.put(OrdersController());
  final ApiCalls apiCalls = ApiCalls();

  late ColorNotifier notifier;
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
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  Future<void> validateAllOrders() async {
    try {
      final orderIds =
          ordersController.orders.map((order) => order.id).toList();
      if (orderIds.length > 0) {
        await apiCalls.validateAllOrders(orderIds as List<int>, 1);
      }
    } catch (e) {
      print(e);
    }
  }

  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifier.getwhite,
        leading: GestureDetector(
          onTap: () {
            Get.offNamedUntil('/home', (Route<dynamic> route) => route.isFirst);
          },
          child: Icon(Icons.arrow_back_ios,
              color: notifier.getblackcolor, size: height / 50),
        ),
        centerTitle: true,
        title: Text(
          LanguageFr.orderconfirmation,
          style: TextStyle(
            color: notifier.getblackcolor,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressUpdates(),
                  ),
                );
              },
              child: Center(
                child: Container(
                  color: Colors.transparent,
                  height: height / 13,
                  width: width / 1.1,
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: notifier.getstarcolor, size: height / 25),
                      SizedBox(width: width / 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height / 70),
                          Text(
                            LanguageFr.deliveryto,
                            style: TextStyle(
                                color: notifier.getgrey,
                                fontFamily: 'GilroyMedium',
                                fontSize: height / 50),
                          ),
                          Text(
                            "Rue Pasteur, Nabeul",
                            style: TextStyle(
                                color: notifier.getblackcolor,
                                fontFamily: 'GilroyBold',
                                fontSize: height / 50),
                          )
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: notifier.getblackcolor, size: height / 50),
                      SizedBox(width: width / 30),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Divider(color: notifier.getgrey),
            ),
            SizedBox(height: height / 50),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageFr.yourorder,
                  style: TextStyle(
                      color: notifier.getgrey,
                      fontFamily: 'GilroyBold',
                      fontSize: height / 50),
                )
              ],
            ),
            Obx(() {
              if (ordersController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (ordersController.orders.isEmpty) {
                return Center(child: Text('No orders have been made yet'));
              } else if (ordersController.hasError.value) {
                return Center(child: Text('Failed to fetch orders'));
              }
              //TODO: calculate order ammount
              final orders = ordersController.orders;
              final subtotal = orders.fold<double>(
                0.0,
                (sum, order) => sum + order.attributes!.totalPrice!,
              );
              final deliveryCharges = 2.0;
              final total = subtotal + deliveryCharges;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height / 40),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                            .format(order.attributes!.createdAt!);

                        return Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '$subtotal TND',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery charges',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '$deliveryCharges TND',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$total TND',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyOrder(),
                        ),
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            SizedBox(height: height / 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                showmodelbottomsheet();
              },
              child: Visibility(
                visible: !ordersController.orders.isEmpty,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: button(
                    notifier.getred,
                    notifier.getwhite,
                    "Order",
                    width / 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showmodelbottomsheet() {
    return showModalBottomSheet(
      backgroundColor: notifier.getwhite,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height / 40),
                    Row(
                      children: [
                        SizedBox(width: width / 2.4),
                        Text(
                          LanguageFr.payment,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontSize: height / 47,
                              fontFamily: "GilroyBold"),
                        ),
                        SizedBox(width: width / 3.5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.clear,
                              color: notifier.getblackcolor, size: height / 40),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 30),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 0;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageFr.cash,
                        "assets/cash.png",
                        height / 29,
                        0,
                        Radio(
                          activeColor: notifier.getred,
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 1;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageFr.cardvisa,
                        "assets/visa.png",
                        height / 32,
                        1,
                        Radio(
                          activeColor: notifier.getred,
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 2;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageFr.cardmaster,
                        "assets/master.png",
                        height / 20,
                        2,
                        Radio(
                          activeColor: notifier.getred,
                          value: 2,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            _groupValue = 3;
                          },
                        );
                      },
                      child: chashtype(
                        LanguageFr.yummywallet,
                        "assets/yummy.png",
                        height / 25,
                        3,
                        Radio(
                          activeColor: notifier.getred,
                          value: 3,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value as int;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () async {
                        await validateAllOrders();
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderSucsess(),
                          ),
                        );
                      },
                      child: Container(
                        height: height / 17,
                        width: width / 1.1,
                        decoration: BoxDecoration(
                          color: notifier.getred,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            LanguageFr.completeorder,
                            style: TextStyle(
                              color: notifier.getwhite,
                              fontFamily: 'GilroyMedium',
                              fontSize: height / 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget chashtype(name, image, imageheight, val, rado) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        color: Colors.transparent,
        child: Row(
          children: [
            rado,
            SizedBox(width: width / 25),
            Image.asset(image, height: imageheight),
            const Spacer(),
            Text(
              name,
              style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 50,
                  fontFamily: 'GilroyMedium'),
            ),
            SizedBox(width: width / 15),
          ],
        ),
      );
    });
  }
}
