import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/screens/ordertabs/deliverytabs.dart';
import 'package:wegast/screens/ordertabs/history.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourOrder extends StatefulWidget {
  const YourOrder({Key? key}) : super(key: key);

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
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
            Get.offNamedUntil('/', (Route<dynamic> route) => route.isFirst);
          },
          child: Icon(Icons.arrow_back_ios,
              color: Colors.black, size: height / 40),
        ),
        centerTitle: true,
        title: Text(
          LanguageFr.yourorder,
          style: TextStyle(
            color: Colors.black,
            fontSize: height / 40,
            fontFamily: 'GilroyBold',
          ),
        ),
        actions: [
          Icon(Icons.search_rounded,
              color: notifier.getblackcolor, size: height / 28),
          SizedBox(width: width / 40),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: height / 50),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.transparent,
                    ),
                    width: width / 1.1,
                    child: TabBar(
                      unselectedLabelColor: notifier.getblackcolor,
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: notifier.getred,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              LanguageFr.delivery,
                              style: TextStyle(
                                fontSize: height / 50,
                                fontFamily: 'GilroyBold',
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              LanguageFr.history,
                              style: TextStyle(
                                  fontSize: height / 50,
                                  fontFamily: 'GilroyBold'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: <Widget>[Deliverytabs(), Historytabs()],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
