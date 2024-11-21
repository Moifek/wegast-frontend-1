import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/custtomscreens/custtombutton.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wegast/controllers/register.controller.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late ColorNotifier notifier;
  final registrationController = Get.put(RegistrationController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isChecked = false;
  String validationMessage = "";
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
                Image.asset("assets/signup.png"),
                Column(
                  children: [
                    SizedBox(height: height / 12),
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          "Create Account",
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
                          "Welcome to Wegast",
                          style: TextStyle(
                            color: notifier.getblackcolor,
                            fontSize: height / 42,
                            fontFamily: 'GilroyMedium',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height / 40),
            Row(
              children: [
                SizedBox(width: width / 20),
                Text(
                  "Full Name",
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
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "First Name",
                  prefixIcon: Icon(Icons.person, color: notifier.getblackcolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                  "Email",
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
                controller: emailController,
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
                  "Username",
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
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Enter Your Username",
                  prefixIcon: Icon(Icons.person, color: notifier.getblackcolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                  "Password",
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
                  hintText: "Enter Your Password",
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
              children: [
                SizedBox(width: width / 20),
                Text(
                  "Télephone",
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
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Saisser votre numéro de téléphone",
                  prefixIcon: Icon(Icons.phone_android_outlined,
                      color: notifier.getblackcolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: notifier.getbgfildcolor,
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    if (value.length != 8 ||
                        !RegExp(r'^\d+$').hasMatch(value)) {
                      validationMessage =
                          "Le numéro doit contenir exactement 8 chiffres.";
                    } else {
                      validationMessage = "";
                    }
                  });
                },
              ),
            ),
            SizedBox(height: height / 20),
            Obx(() {
              if (registrationController.isLoading.value) {
                return CircularProgressIndicator(
                  color: notifier.getred,
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    registrationController.register(
                      nameController.text,
                      emailController.text,
                      usernameController.text,
                      passwordController.text,
                      phoneController.text,
                    );
                  },
                  child: button(
                    notifier.getred,
                    notifier.getwhite,
                    "Create Account",
                    width / 1.1,
                  ),
                );
              }
            }),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: notifier.getgrey,
                    fontFamily: 'GilroyMedium',
                    fontSize: height / 55,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    " Sign In",
                    style: TextStyle(
                      color: const Color(0xff3a71d5),
                      fontFamily: 'GilroyMedium',
                      fontSize: height / 55,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
