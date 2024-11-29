import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:wegast/custtomscreens/custtomrestorent.dart';
import 'package:wegast/models/items_models.dart';
import 'package:wegast/models/restaurant_model.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wegast/web_services.dart';

class NearByRestaurant extends StatefulWidget {
  const NearByRestaurant({Key? key}) : super(key: key);

  @override
  State<NearByRestaurant> createState() => _NearByRestaurantState();
}

class _NearByRestaurantState extends State<NearByRestaurant> {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  late ColorNotifier notifier;
  RxList<Restaurant> restaurants = <Restaurant>[].obs;
  RxList<ItemData> items = <ItemData>[].obs;
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifier.setIsDark = false;
    } else {
      notifier.setIsDark = previusstate;
    }
  }

  handleRestaurants() async {
    var tmp;
    tmp = await ApiCalls().fetchRestaurants();
    restaurants.value =
        (tmp as List).map((e) => Restaurant.fromJson(e)).toList();
  }

  handleItems() async {
    var tmp;
    //TODO:
    //tmp = await ApiCalls().fetchItems();
    items.value = (tmp as List).map((e) => ItemData.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
    handleRestaurants();
    handleItems();
  }

  @override
  Widget build(BuildContext context) {
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
            color: notifier.getblackcolor,
            size: height / 30,
          ),
        ),
        title: Text(
          LanguageFr.nearbyRestaurant,
          style: TextStyle(
              color: notifier.getblackcolor,
              fontSize: height / 45,
              fontFamily: 'GilroyBold'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return ListView.builder(
              itemCount: restaurants.length,
              padding: EdgeInsets.symmetric(horizontal: 15),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Attributes restaurantData =
                    restaurants[index].attributes ?? Attributes();
                String imageUrl =
                    restaurantData.restaurantImage?.data?.attributes?.url ?? '';
                if (imageUrl.isNotEmpty) {
                  imageUrl = imageUrl.substring(1);
                }

                return CusttomRestaurant(
                  baseUrl + imageUrl,
                  restaurantData.name ?? '',
                  restaurantData.email ?? '',
                  restaurants[index].id ?? 0,
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
