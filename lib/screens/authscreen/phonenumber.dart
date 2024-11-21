import 'package:flutter/material.dart';
import 'package:wegast/custtomscreens/custtombutton.dart';
import 'package:wegast/screens/authscreen/createaccount.dart';
import 'package:wegast/screens/authscreen/otp.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wegast/controllers/login.controller.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  late ColorNotifier notifier;
  String? _selectedindex;
  bool isChecked = false;
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<Map> _myjson = [
    {
      'id': '1',
      'image': 'assets/flagfour.png.png',
      'Text': "+216",
    },
  ];
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
      backgroundColor: notifier.getbgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/signin.jpg"),
                Column(
                  children: [
                    SizedBox(height: height / 12),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          LanguageFr.signin,
                          style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 25,
                            fontFamily: 'GilroyBold',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          LanguageFr.welcometowegast,
                          style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 42,
                            fontFamily: 'GilroyMedium',
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  "Email",
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 60),
            Container(
              width: width / 1.1,
              child: TextField(
                controller: identifierController,
                decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  prefixIcon: Icon(Icons.email, color: notifier.getblackcolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: notifier.getbgfildcolor,
                ),
              ),
            ),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  LanguageFr.password,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontSize: height / 50,
                    fontFamily: 'GilroyMedium',
                  ),
                ),
              ],
            ),
            SizedBox(height: height / 50),
            Container(
              width: width / 1.1,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: LanguageFr.enteryourpassword,
                  prefixIcon: Icon(Icons.lock, color: notifier.getblackcolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: notifier.getbgfildcolor,
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: height / 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.scale(
                  scale: 1,
                  child: Row(
                    children: [
                      Checkbox(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        activeColor: notifier.getred,
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text("Remember Me"),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 16.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const ForgotPassword(),
                //         ),
                //       );
                //     },
                //     child: Text(
                //       LanguageFr.forgotpassword,
                //       style: TextStyle(
                //         fontSize: height / 55,
                //         color: const Color(0xff3a71d5),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: height / 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     authbutton(
            //       const Color(0xff3a71d5),
            //       Colors.white,
            //       LanguageFr.facebook,
            //       width / 2.3,
            //       "assets/facebook.png",
            //     ),
            //     SizedBox(width: width / 25),
            //     GestureDetector(
            //       onTap: () {
            //         Get.offNamed('/home');
            //       },
            //       child: authbutton(
            //         const Color(0xff323337),
            //         Colors.white,
            //         LanguageFr.apple,
            //         width / 2.3,
            //         "assets/apple.png",
            //       ),
            //     ),
            //   ],
            // ),
            Obx(() {
              if (loginController.isLoading.value) {
                return CircularProgressIndicator(
                  color: notifier.getred,
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    loginController.login(
                      identifierController.text,
                      passwordController.text,
                    );
                  },
                  child: button(
                    notifier.getred,
                    notifier.getwhite,
                    LanguageFr.signin,
                    width / 1.1,
                  ),
                );
              }
            }),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LanguageFr.donothaveaccount,
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontFamily: 'GilroyMedium',
                    fontSize: height / 55,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      ),
                    );
                  },
                  child: Text(
                    LanguageFr.signup,
                    style: TextStyle(
                      color: const Color(0xff3a71d5),
                      fontFamily: 'GilroyMedium',
                      fontSize: height / 55,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _faceshowMyDialog() async {
    return showDialog(
      context: context, useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifier.getwhite,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 3.4,
                child: Column(
                  children: [
                    SizedBox(height: height / 100),
                    Center(
                      child:
                          Image.asset("assets/FaceID.png", height: height / 13),
                    ),
                    SizedBox(height: height / 35),
                    Text(
                      LanguageFr.continuewithfaceid,
                      style: TextStyle(
                          color: notifier.getblackcolor,
                          fontFamily: 'GilroyBold',
                          fontSize: height / 35),
                    ),
                    SizedBox(height: height / 150),
                    Text(
                      LanguageFr.usefaceidtounlockcarr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: notifier.getgrey,
                          fontFamily: 'GilroyMedium',
                          fontSize: height / 60),
                    ),
                    SizedBox(height: height / 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: button(
                        notifier.getred,
                        notifier.getwhite,
                        LanguageFr.cancel,
                        width / 2,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        );
      },
    );
  }

  Widget authbutton(buttoncolor, buttontextcolor, txt, w, image) {
    return Container(
      height: height / 14,
      width: w,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: height / 35),
            SizedBox(width: width / 30),
            Text(
              txt,
              style: TextStyle(
                  color: buttontextcolor,
                  fontSize: height / 50,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  _showMyDialog() async {
    return showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: notifier.getwhite,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                color: Colors.transparent,
                height: height / 3.2,
                child: Column(
                  children: [
                    SizedBox(height: height / 130),
                    Text(
                      LanguageFr.loginwithphonenumber,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 60,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 60),
                    Text(
                      "(+84) 39 787 5256",
                      style: TextStyle(
                        color: notifier.getblackcolor,
                        fontSize: height / 30,
                        fontFamily: 'GilroyBold',
                      ),
                    ),
                    SizedBox(height: height / 50),
                    Text(
                      LanguageFr.wewillsend,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: notifier.getgrey,
                        fontSize: height / 60,
                        fontFamily: 'GilroyMedium',
                      ),
                    ),
                    SizedBox(height: height / 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: dailogbutton(Colors.transparent,
                              LanguageFr.cancel, notifier.getred),
                        ),
                        SizedBox(width: width / 30),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Otp(),
                              ),
                            );
                          },
                          child: dailogbutton(notifier.getred, LanguageFr.next,
                              notifier.getwhite),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        );
      },
    );
  }

  Widget dailogbutton(buttoncolor, txt, textcolor) {
    return Container(
      height: height / 16,
      width: width / 3.8,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        // border: Border.all(color: bordercolor),
      ),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(
            color: textcolor,
            fontSize: height / 50,
            fontFamily: 'GilroyMedium',
          ),
        ),
      ),
    );
  }

  Widget mobailnotextfild() {
    return Container(
      height: height / 16,
      width: width / 1.1,
      decoration: BoxDecoration(
        color: notifier.getbgfildcolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: width / 100),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Row(
                children: [
                  Image.asset("assets/flagfour.png.png", height: height / 25),
                  Text(
                    "+91",
                    style: TextStyle(color: notifier.getblackcolor),
                  )
                ],
              ),
              value: _selectedindex,
              onChanged: (newValue) {
                setState(() {
                  _selectedindex = newValue;
                });
              },
              items: _myjson.map((Map map) {
                return DropdownMenuItem<String>(
                  value: map["id"].toString(),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        map["image"].toString(),
                        width: 35,
                      ),
                      Text(
                        map["Text"].toString(),
                        style: TextStyle(color: notifier.getblackcolor),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Container(width: 1, height: height / 25, color: notifier.getgrey),
          SizedBox(width: width / 100),
          Container(
            color: Colors.transparent,
            height: 80,
            width: 190,
            child: TextField(
              style: TextStyle(color: notifier.getblackcolor),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 50,
                      fontFamily: 'GilroyMedium'),
                  border: InputBorder.none,
                  hintText: LanguageFr.enteryournumber),
            ),
          ),
        ],
      ),
    );
  }
}
