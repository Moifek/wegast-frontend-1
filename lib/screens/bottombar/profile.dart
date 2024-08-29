import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:wegast/screens/bottombar/profilesetting.dart';
import 'package:wegast/screens/loremscreen.dart';
import 'package:wegast/screens/yourorder/yourorder.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:wegast/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ColorNotifier notifier;
  bool light = true;

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
    final UserController userController = Get.find();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 11),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageEn.myprofile,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height / 22,
                    fontFamily: 'GilroyBold',
                  ),
                )
              ],
            ),
            SizedBox(height: height / 20),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YourOrder(),
                  )),
              child: profiletype("assets/Bag.png", LanguageEn.myporder),
            ),
            SizedBox(height: height / 30),
            GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSetting(),
                  )),
              child:
                  profiletype("assets/Setting.png", LanguageEn.profilesetting),
            ),
            // SizedBox(height: height / 30),
            // GestureDetector(
            //   onTap: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Notifications('Promocodes'),
            //       )),
            //   child: profiletype(
            //       "assets/Ticket.png", LanguageEn.discountsandpromocodes),
            // ),
            // SizedBox(height: height / 30),
            // GestureDetector(
            //   onTap: () => Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Notifications('Notifications'),
            //       )),
            //   child: profiletype(
            //       "assets/Notification.png", LanguageEn.notifications),
            // ),
            SizedBox(height: height / 30),
            GestureDetector(
                onTap: () {
                  FlutterShare.share(title: 'Example share text...');
                },
                child:
                    profiletype("assets/invite.png", LanguageEn.invitefriend)),
            SizedBox(height: height / 30),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Loream('About us',
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                    )),
                child: profiletype("assets/about.png", LanguageEn.aboutus)),
            SizedBox(height: height / 30),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Loream('FAQs',
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                    )),
                child: profiletype("assets/Paper.png", LanguageEn.faq)),
            // SizedBox(height: height / 30),
            // GestureDetector(
            //     onTap: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => Loream('Teams & Condition',
            //               "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            //         )),
            //     child: profiletype(
            //         "assets/teams.png", LanguageEn.teamsandcontiotion)),
            SizedBox(height: height / 30),
            GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Loream('Help Center',
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                    )),
                child: profiletype("assets/Call.png", LanguageEn.helpcenter)),
            // SizedBox(height: height / 30),
            // darkmode(),
            SizedBox(height: height / 30),
            GestureDetector(
              onTap: () {
                userController.logout();
              },
              child: profiletype("assets/Logout.png", LanguageEn.logout),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Widget profiletype(icon, txt) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 13),
          Image.asset(
            icon,
            height: height / 33,
            color: notifier.getred,
          ),
          SizedBox(width: width / 20),
          Text(
            txt,
            style: TextStyle(
              fontSize: height / 50,
              fontFamily: 'GilroyMedium',
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,
              size: height / 40, color: notifier.getgrey),
          SizedBox(width: width / 13),
        ],
      ),
    );
  }

  Widget darkmode() {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          SizedBox(width: width / 13),
          Image.asset(
            "assets/darkmode.png",
            height: height / 33,
            color: notifier.getred,
          ),
          SizedBox(width: width / 20),
          Text(
            LanguageEn.darkmode,
            style: TextStyle(
              fontSize: height / 50,
              fontFamily: 'GilroyMedium',
              color: notifier.getblackcolor,
            ),
          ),
          const Spacer(),
          Switch(
            value: light,
            onChanged: (value) async {
              setState(() {
                notifier.setIsDark = value;
                light = value;
              });
              final prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setBool("setIsDark", value);
              });
            },
          ),
          SizedBox(width: width / 13),
        ],
      ),
    );
  }
}
