import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wegast/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:wegast/custtomscreens/custtomrestorent.dart';
import 'package:wegast/models/items_models.dart';
import 'package:wegast/models/restaurant_model.dart';
import 'package:wegast/screens/homeseeall/nearbyrestorent.dart';
import 'package:wegast/screens/restorentdeal.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wegast/web_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  late ColorNotifier notifier;
  RxList<Restaurant> restaurants = <Restaurant>[].obs;
  RxList<Restaurant> recommendedRestaurants = <Restaurant>[].obs;
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
    recommendedRestaurants.value =
        (tmp as List).map((e) => Restaurant.fromJsonRecommended(e)).toList();
  }

  handleItems() async {
    var tmp;
    tmp = await ApiCalls().fetchItems();
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
    final UserController userController = Get.find();

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getbgcolor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          'Hello ${userController.user.value.username},',
                          style: TextStyle(
                            fontFamily: 'GilroyBold',
                            color: Colors.black,
                            fontSize: height / 50,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: width / 25),
                        Icon(Icons.location_on_outlined,
                            color: notifier.getgrey, size: height / 40),
                        Text(
                          'Nabel, Tunisia',
                          style: TextStyle(
                            color: notifier.getgrey,
                            fontSize: height / 60,
                            fontFamily: 'GilroyMedium',
                          ),
                        )
                      ],
                    )
                  ],
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const ProfileSetting(),
                //       ),
                //     );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(right: 20),
                //     child: Image.asset("assets/Buy.png", height: 25),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: height / 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Customsearchtextfild.textField(
                    //     LanguageEn.searchfordish,
                    //     notifier.getblackcolor,
                    //     width / 1.13,
                    //     notifier.getbgfildcolor),
                    // SizedBox(height: height / 40),
                    // Container(
                    //   color: Colors.transparent,
                    //   height: height / 5,
                    //   child: ListView.builder(
                    //     itemCount: 1,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => const Pizza(),
                    //             ),
                    //           );
                    //         },
                    //         child: Row(
                    //           children: [
                    //             SizedBox(width: width / 18),
                    //             Image.asset("assets/d.png"),
                    //             SizedBox(width: width / 20),
                    //             Image.asset("assets/e.png"),
                    //             SizedBox(width: width / 20),
                    //             Image.asset("assets/d1.png"),
                    //             SizedBox(width: width / 20),
                    //             Image.asset("assets/s.png"),
                    //             SizedBox(width: width / 20),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                    // SizedBox(height: height / 40),
                    // Explore Categories
                    // Row(
                    //   children: [
                    //     SizedBox(width: width / 20),
                    //     Text(
                    //       LanguageEn.explorecategories,
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: height / 45,
                    //           fontFamily: 'GilroyBold'),
                    //     ),
                    //     const Spacer(),
                    //     GestureDetector(
                    //       onTap: () => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const Categories(),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         LanguageEn.showall,
                    //         style: TextStyle(
                    //             color: notifier.getred,
                    //             fontSize: height / 55,
                    //             fontFamily: 'GilroyMedium'),
                    //       ),
                    //     ),
                    //     SizedBox(width: width / 18),
                    //   ],
                    // ),
                    // SizedBox(height: height / 100),
                    // Container(
                    //   color: Colors.transparent,
                    //   height: height / 5,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 1,
                    //     itemBuilder: (context, index) {
                    //       return Row(
                    //         children: [
                    //           SizedBox(width: width / 20),
                    //           ExploreCategories("assets/f1.png",
                    //               LanguageEn.milkshake, height / 9),
                    //           SizedBox(width: width / 60),
                    //           ExploreCategories("assets/f2.png",
                    //               LanguageEn.omelette, height / 9),
                    //           SizedBox(width: width / 60),
                    //           ExploreCategories("assets/f3.png",
                    //               LanguageEn.tomatosup, height / 9),
                    //           SizedBox(width: width / 60),
                    //           ExploreCategories("assets/pizza.png",
                    //               LanguageEn.shake, height / 9),
                    //           SizedBox(width: width / 60),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                    // Popular Near you
                    // Row(
                    //   children: [
                    //     SizedBox(width: width / 20),
                    //     Text(
                    //       LanguageEn.popularnearyou,
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: height / 45,
                    //           fontFamily: 'GilroyBold'),
                    //     ),
                    //     const Spacer(),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => const PopularViewMore(),
                    //           ),
                    //         );
                    //       },
                    //       child: Text(
                    //         LanguageEn.viewmore,
                    //         style: TextStyle(
                    //             color: notifier.getred,
                    //             fontSize: height / 55,
                    //             fontFamily: 'GilroyMedium'),
                    //       ),
                    //     ),
                    //     SizedBox(width: width / 18),
                    //   ],
                    // ),
                    // SizedBox(height: height / 80),
                    // Container(
                    //   color: Colors.transparent,
                    //   height: height / 3,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 1,
                    //     itemBuilder: (context, index) {
                    //       return Row(
                    //         children: [
                    //           SizedBox(width: width / 20),
                    //           CusttomPopularfoodlist(
                    //               "assets/bfood.jpg",
                    //               height / 3,
                    //               width / 1.3,
                    //               height / 5,
                    //               width / 1.3,
                    //               width / 5.7,
                    //               LanguageEn.mayo),
                    //           SizedBox(width: width / 31),
                    //           CusttomPopularfoodlist(
                    //               "assets/cake.jpg",
                    //               height / 3,
                    //               width / 1.3,
                    //               height / 5,
                    //               width / 1.3,
                    //               width / 5.7,
                    //               LanguageEn.atul),
                    //           SizedBox(width: width / 31),
                    //           CusttomPopularfoodlist(
                    //               "assets/bfood.jpg",
                    //               height / 3,
                    //               width / 1.3,
                    //               height / 5,
                    //               width / 1.3,
                    //               width / 5.7,
                    //               LanguageEn.burgerking),
                    //           SizedBox(width: width / 31),
                    //           CusttomPopularfoodlist(
                    //               "assets/cake.jpg",
                    //               height / 3,
                    //               width / 1.3,
                    //               height / 5,
                    //               width / 1.3,
                    //               width / 5.7,
                    //               LanguageEn.monginis),
                    //           SizedBox(width: width / 31),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: height / 80),
                    // Recommended
                    // Row(
                    //   children: [
                    //     SizedBox(width: width / 20),
                    //     Text(
                    //       LanguageEn.recommended,
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: height / 45,
                    //         fontFamily: 'GilroyBold',
                    //       ),
                    //     ),
                    //     const Spacer(),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => const RecommendedSeeall(),
                    //           ),
                    //         );
                    //       },
                    //       child: Text(
                    //         LanguageEn.showall,
                    //         style: TextStyle(
                    //             color: notifier.getred,
                    //             fontSize: height / 55,
                    //             fontFamily: 'GilroyMedium'),
                    //       ),
                    //     ),
                    //     SizedBox(width: width / 18),
                    //   ],
                    // ),
                    // SizedBox(height: height / 80),
                    // Container(
                    //   color: Colors.transparent,
                    //   height: height / 2.3,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 1,
                    //     itemBuilder: (context, index) {
                    //       return Row(
                    //         children: [
                    //           SizedBox(width: width / 20),
                    //           CusttomRecommended(
                    //               "assets/bfood.jpg",
                    //               LanguageEn.burgerkings,
                    //               LanguageEn.westernburgerfast),
                    //           SizedBox(width: width / 31),
                    //           CusttomRecommended(
                    //               "assets/cake.jpg",
                    //               LanguageEn.monginis,
                    //               LanguageEn.westernburgerfast),
                    //           SizedBox(width: width / 31),
                    //           CusttomRecommended(
                    //               "assets/bfood.jpg",
                    //               LanguageEn.mayo,
                    //               LanguageEn.westernburgerfast),
                    //           SizedBox(width: width / 31),
                    //           CusttomRecommended(
                    //               "assets/cake.jpg",
                    //               LanguageEn.atul,
                    //               LanguageEn.westernburgerfast),
                    //           SizedBox(width: width / 31),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: height / 55),
                    Obx(() {
                      return ListView.builder(
                        itemCount: items.length,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final name = item.attributes.name;
                          final imageUrl = item.attributes.image.data.isNotEmpty
                              ? item.attributes.image.data.first.attributes.url
                                  .substring(1)
                              : null;

                          // Extract description text from the Description model
                          final descriptionText =
                              item.attributes.description.isNotEmpty
                                  ? item.attributes.description.first.children
                                      .map((child) => child.text)
                                      .join(' ')
                                  : '';
                          return ListTile(
                            title: Text(
                              name,
                              style: TextStyle(color: Colors.orange),
                            ),
                            subtitle: Text(
                              descriptionText,
                            ),
                            leading: imageUrl != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                      margin: EdgeInsets.all(
                                          4.0), // Add margin around the image
                                      width: 100, // Set the width of the image
                                      height:
                                          100, // Set the height of the image
                                      child: Image.network(
                                        '$baseUrl$imageUrl',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : null,
                          );
                        },
                      );
                    }),

                    SizedBox(height: height / 55),
                    // Near by Restorent
                    Row(
                      children: [
                        SizedBox(width: width / 20),
                        Text(
                          'Restaurants Recommendée',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: height / 45,
                              fontFamily: 'GilroyBold'),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NearByRestaurant(),
                            ),
                          ),
                          child: Text(
                            LanguageEn.showall,
                            style: TextStyle(
                                color: notifier.getred,
                                fontSize: height / 55,
                                fontFamily: 'GilroyMedium'),
                          ),
                        ),
                        SizedBox(width: width / 18),
                      ],
                    ),

                    SizedBox(height: height / 55),
                    Obx(() {
                      return ListView.builder(
                        itemCount: restaurants.length,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Attributes restaurantData =
                              restaurants[index].attributes ?? Attributes();
                          String imageUrl = restaurantData
                                  .restaurantImage?.data?.attributes?.url ??
                              '';
                          if (imageUrl.isNotEmpty) {
                            imageUrl = imageUrl.substring(1);
                          }

                          return CusttomRestaurant(
                            baseUrl + imageUrl,
                            restaurantData.name ?? '',
                            restaurantData.email ?? '',
                          );
                        },
                      );
                    }),
                    SizedBox(height: height / 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget kmtime(w, icon, txt) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RestorentDeal(),
          ),
        );
      },
      child: Container(
        height: height / 30,
        width: w,
        decoration: const BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: height / 70,
              color: notifier.getred,
            ),
            Text(
              txt,
              style: TextStyle(
                fontSize: height / 70,
                color: notifier.getred,
              ),
            )
          ],
        ),
      ),
    );
  }
}
