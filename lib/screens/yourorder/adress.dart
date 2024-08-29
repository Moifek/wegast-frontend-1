import 'package:flutter/material.dart';
import 'package:wegast/custtomscreens/custtombutton.dart';
import 'package:wegast/custtomscreens/textfild.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late ColorNotifier notifire;
  bool isChecked = false;
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: notifire.getwhite,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: height / 33,
            color: notifire.getblackcolor,
          ),
        ),
        title: Text(
          LanguageFr.deliveryadds,
          style: TextStyle(
              color: notifire.getblackcolor,
              fontFamily: 'GilroyBold',
              fontSize: height / 43),
        ),
      ),
      backgroundColor: notifire.getwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 50),
            Container(
              color: Colors.transparent,
              height: height / 1.6,
              width: width / 1.1,
              child: Column(
                children: [
                  Customtextfild.textField(
                      LanguageFr.enteryourfullname,
                      notifire.getblackcolor,
                      width / 1.13,
                      Icons.person,
                      notifire.getbgfildcolor),
                  SizedBox(height: height / 40),
                  Customtextfild.textField(
                      LanguageFr.enteryourphonenumber,
                      notifire.getblackcolor,
                      width / 1.13,
                      Icons.call,
                      notifire.getbgfildcolor),
                  SizedBox(height: height / 40),
                  Customtextfild.textField(
                      LanguageFr.adresslineone,
                      notifire.getblackcolor,
                      width / 1.13,
                      Icons.location_on_outlined,
                      notifire.getbgfildcolor),
                  SizedBox(height: height / 40),
                  Customtextfild.textField(
                      LanguageFr.adresslinetwo,
                      notifire.getblackcolor,
                      width / 1.13,
                      Icons.location_on_outlined,
                      notifire.getbgfildcolor),
                  SizedBox(height: height / 60),
                  Row(
                    children: [
                      SizedBox(width: width / 50),
                      Transform.scale(
                        scale: 1,
                        child: Checkbox(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          activeColor: notifire.getred,
                          side: BorderSide(color: notifire.getred),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                LanguageFr.selects,
                                style: TextStyle(
                                    fontSize: height / 55, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height / 9.5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 15),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: button(notifire.getred, notifire.getwhite,
                      LanguageFr.confirm, width / 1.1)),
            ),
          ],
        ),
      ),
    );
  }
}
