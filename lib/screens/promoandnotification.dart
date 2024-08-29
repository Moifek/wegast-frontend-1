import 'package:flutter/material.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  final String name;

  const Notifications(this.name, {Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late ColorNotifier notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 14,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: notifire.getblackcolor,
                      size: height / 35,
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 20,
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                      color: notifire.getblackcolor,
                      fontFamily: 'Gilroy Bold',
                      fontSize: height / 43),
                ),
              ],
            ),
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 20),
              child: Column(
                children: [
                  not(const Color(0xff4BD37B), "assets/cheack.png",
                      LanguageFr.successfully, LanguageFr.yesterday),
                  SizedBox(
                    height: height / 80,
                  ),
                  not(const Color(0xff10AFFF), "assets/lockdown.png",
                      LanguageFr.lockdown, LanguageFr.mar),
                  SizedBox(
                    height: height / 80,
                  ),
                  not(const Color(0xffFFA03C), "assets/car.png",
                      LanguageFr.wayorder, LanguageFr.mar1),
                  SizedBox(
                    height: height / 80,
                  ),
                  not(const Color(0xff8349FF), "assets/dele.png",
                      LanguageFr.prepared, LanguageFr.mar2),
                  SizedBox(
                    height: height / 80,
                  ),
                  not(const Color(0xff10AFFF), "assets/lockdown.png",
                      LanguageFr.discount, LanguageFr.mar3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget not(clr, img, txt, txt2) {
    return Container(
      height: height / 11,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: notifire.getbgfildcolor,
      ),
      child: Row(
        children: [
          SizedBox(
            width: width / 35,
          ),
          Container(
            height: height / 15,
            width: width / 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: clr,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(height / 70),
                child: Image.asset(img),
              ),
            ),
          ),
          SizedBox(
            width: width / 50,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 60,
                ),
                Text(
                  txt,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                      color: notifire.getblackcolor,
                      fontFamily: 'GilroyBold',
                      fontSize: height / 54),
                ),
                SizedBox(
                  height: height / 200,
                ),
                Text(
                  txt2,
                  style: TextStyle(
                      color: notifire.getgrey,
                      fontFamily: 'GilroyMedium',
                      fontSize: height / 55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
