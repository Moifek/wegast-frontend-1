import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegast/custtomscreens/custtomexplorecaterories.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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

  List img = [
    "assets/f1.png",
    "assets/f2.png",
    "assets/f3.png",
    "assets/pizza.png",
    "assets/foods.png",
    "assets/dalfry.png",
    "assets/chiken.png",
    "assets/eggiteam.png",
  ];
  List name = [
    LanguageFr.milkshake,
    LanguageFr.omelette,
    LanguageFr.tomatosup,
    LanguageFr.shake,
    LanguageFr.fruitdish,
    LanguageFr.dalfry,
    LanguageFr.chicken,
    LanguageFr.eggitem,
  ];

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: notifire.getwhite,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.offNamedUntil('/home', (Route<dynamic> route) => route.isFirst);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: notifire.getblackcolor,
            size: height / 30,
          ),
        ),
        title: Text(
          LanguageFr.explorecategories,
          style: TextStyle(
              color: notifire.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      backgroundColor: notifire.getwhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: height / 1,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: width / 20),
                itemCount: img.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: height / 40),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: notifire.getwhite),
                    ),
                    child: ExploreCategories(
                      img[index],
                      name[index],
                      height / 10,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
