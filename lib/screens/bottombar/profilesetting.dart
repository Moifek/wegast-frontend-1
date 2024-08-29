import 'package:flutter/material.dart';
import 'package:wegast/custtomscreens/custtombutton.dart';
import 'package:wegast/custtomscreens/textfild.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/user_controller.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
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
    final UserController userController = Get.find();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getred,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: height / 13),
              Row(
                children: [
                  SizedBox(width: width / 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: height / 40,
                      color: notifier.getwhite,
                    ),
                  ),
                  Text(
                    LanguageFr.profilesetting,
                    style: TextStyle(
                      color: notifier.getwhite,
                      fontSize: height / 45,
                      fontFamily: 'GilroyBold',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Spacer(),
                  ),
                  SizedBox(width: width / 20),
                ],
              ),
              SizedBox(height: height / 6),
              // Image.asset("assets/p3.png"),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: notifier.getwhite,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Center(
                child: SizedBox(height: height / 3),
              ),
              SizedBox(height: height / 25),
              Customtextfild.textField(
                  userController.user.value.username,
                  notifier.getblackcolor,
                  width / 1.13,
                  Icons.person,
                  notifier.getbgfildcolor),
              SizedBox(height: height / 25),
              Customtextfild.textField(
                  userController.user.value.email,
                  notifier.getblackcolor,
                  width / 1.13,
                  Icons.email,
                  notifier.getbgfildcolor),
              SizedBox(height: height / 4.3),
              // GestureDetector(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: button(notifier.getred, notifier.getwhite,
              //         LanguageFr.save, width / 1.1))
            ],
          ),
        ],
      ),
    );
  }
}
