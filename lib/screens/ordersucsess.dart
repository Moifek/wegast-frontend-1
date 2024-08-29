import 'package:flutter/material.dart';
import 'package:wegast/custtomscreens/custtombutton.dart';
import 'package:wegast/screens/bottombar/bottombar.dart';
import 'package:wegast/screens/myorder.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSucsess extends StatefulWidget {
  const OrderSucsess({Key? key}) : super(key: key);

  @override
  State<OrderSucsess> createState() => _OrderSucsessState();
}

class _OrderSucsessState extends State<OrderSucsess> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 8),
            Center(
              child: Text(
                LanguageFr.checking,
                style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 38,
                  fontFamily: 'GilroyBold',
                ),
              ),
            ),
            SizedBox(height: height / 13),
            Image.asset("assets/Deliveryscooter.png", height: height / 3),
            SizedBox(height: height / 20),
            Text(
              LanguageFr.ordersuccess,
              style: TextStyle(
                color: notifier.getblackcolor,
                fontSize: height / 36,
                fontFamily: 'GilroyBold',
              ),
            ),
            SizedBox(height: height / 90),
            Text(
              LanguageFr.pleasewaitafewminute,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: notifier.getgrey,
                fontSize: height / 55,
                fontFamily: 'GilroyMedium',
              ),
            ),
            SizedBox(height: height / 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyOrder(),
                  ),
                );
              },
              child: Container(
                height: height / 14,
                width: width / 1.1,
                decoration: BoxDecoration(
                  border: Border.all(color: notifier.getred),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(13),
                  ),
                ),
                child: Center(
                  child: Text(
                    LanguageFr.myorder,
                    style: TextStyle(
                      color: notifier.getred,
                      fontFamily: 'GilroyBold',
                      fontSize: height / 50,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height / 50),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomHome(),
                    ),
                  );
                },
                child: button(notifier.getred, notifier.getwhite,
                    LanguageFr.home, width / 1.1))
          ],
        ),
      ),
    );
  }
}
