import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/custtomscreens/custtomrecommended.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecommendedSeeall extends StatefulWidget {
  const RecommendedSeeall({Key? key}) : super(key: key);

  @override
  State<RecommendedSeeall> createState() => _RecommendedSeeallState();
}

class _RecommendedSeeallState extends State<RecommendedSeeall> {
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
        backgroundColor: notifier.getwhite,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.offNamedUntil('/home', (Route<dynamic> route) => route.isFirst);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: height / 30,
          ),
        ),
        title: Text(
          LanguageFr.recommended,
          style: TextStyle(
              color: Colors.black,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CusttomRecommended("assets/bfood.jpg", LanguageFr.donzs,
                    LanguageFr.westernburgerfast),
                SizedBox(width: width / 40),
                CusttomRecommended("assets/cake.jpg", LanguageFr.burgerkings,
                    LanguageFr.westernburgerfast),
              ],
            ),
            SizedBox(height: height / 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CusttomRecommended("assets/cake.jpg", LanguageFr.atul,
                    LanguageFr.westernburgerfast),
                SizedBox(width: width / 40),
                CusttomRecommended("assets/bfood.jpg", LanguageFr.mayo,
                    LanguageFr.westernburgerfast),
              ],
            ),
            SizedBox(height: height / 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CusttomRecommended("assets/bfood.jpg", LanguageFr.donzs,
                    LanguageFr.westernburgerfast),
                SizedBox(width: width / 40),
                CusttomRecommended("assets/cake.jpg", LanguageFr.derryfresh,
                    LanguageFr.westernburgerfast),
              ],
            ),
            SizedBox(height: height / 40),
          ],
        ),
      ),
    );
  }
}
