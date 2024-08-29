import 'package:flutter/material.dart';
import 'package:wegast/custtomscreens/custtombutton.dart';
import 'package:wegast/custtomscreens/custtomfooditeam.dart';
import 'package:wegast/custtomscreens/custtomgriadeiteam.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'orderconfirmation.dart';

class Pizza extends StatefulWidget {
  const Pizza({Key? key}) : super(key: key);

  @override
  State<Pizza> createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> with TickerProviderStateMixin {
  late ColorNotifier notifier;
  late TabController _tabController;
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
    _tabController = TabController(length: 3, vsync: this);
    getdarkmodepreviousstate();
  }

  int selectedindex = -1;
  String dropdownvalue = 'Best match';
  String filterbydropdownvalue = 'Open';
  double _currentSliderValue = 20;
  bool hide = false;
  var items = [
    'Best match',
    'Low match',
    'High match',
  ];
  var filterbyitems = [
    'Open',
    'Close',
  ];
  List locationlist = [
    "Bronx",
    "Brooklyn",
    "Samara river city",
    "Manhattan",
    "Staten island",
    "near me",
  ];
  List img = [
    'assets/location-pin.png',
    'assets/stopwatch.png',
  ];
  List text = [
    '254m',
    '27',
  ];
  List food = [
    'assets/idli.png',
    'assets/supcup.png',
    'assets/juice.png',
  ];
  List foodname = [
    'Pizza',
    'Drink',
    'Dessert',
  ];
  bool like = false;
  bool count = false;
  bool counttwo = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        floatingActionButton: Container(
          width: width / 1.2,
          child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: notifier.getred,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConformation(),
                  ));
            },
            label: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'My Order',
                    style: TextStyle(
                        fontFamily: 'GilroyBold',
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: width / 2,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.greenAccent,
                  ),
                  child: Center(
                      child: Text(
                    '10',
                    style: TextStyle(fontFamily: 'GilroyBold', fontSize: 15),
                  )),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Image.asset('assets/bfood.jpg'),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: notifier.getbgcolor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabBar(
                              dividerColor: Colors.black,
                              indicatorColor: notifier.getred,
                              labelColor: notifier.getred,
                              unselectedLabelColor: Colors.black,
                              controller: _tabController,
                              tabs: const <Widget>[
                                Tab(
                                  text: 'Delivery',
                                ),
                                Tab(
                                  text: 'Menu',
                                ),
                                Tab(
                                  text: 'Review',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 250,
                              child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            'Burger King',
                                            style: TextStyle(
                                                fontFamily: 'GilroyBold',
                                                fontSize: 15,
                                                color: notifier.getblackcolor),
                                          ),
                                          subtitle: Text(
                                            'Western cuisine, Fast Food Burger',
                                            style: TextStyle(
                                                fontFamily: 'GilroyMedium',
                                                fontSize: 10,
                                                color: notifier.getgrey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              star(),
                                              SizedBox(
                                                height: 25,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: 2,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 25,
                                                      width:
                                                          index == 0 ? 60 : 50,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.grey
                                                            .withOpacity(0.4),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Image.asset(
                                                              img[index],
                                                              height: 15,
                                                              width: 15,
                                                              color: notifier
                                                                  .getred,
                                                            ),
                                                            Text(
                                                              text[index],
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'GilroyBold',
                                                                  fontSize: 10,
                                                                  color: notifier
                                                                      .getred),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: delivery(
                                                text:
                                                    'Freeship within 5km: Enter code Freeship')),
                                        Expanded(
                                            child: delivery(
                                                text:
                                                    '30% off on all menu items')),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 250,
                                          child: ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            itemCount: food.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading:
                                                    Image.asset(food[index]),
                                                title: Text(foodname[index]),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                indent: 15,
                                                endIndent: 15,
                                                height: 10,
                                                thickness: 1,
                                                color: Colors.grey,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        review("assets/p3.png",
                                            LanguageFr.harrydaniels),
                                        review("assets/p4.png",
                                            LanguageFr.harrydaniels),
                                      ],
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height / 70),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white,
                        child: Column(
                          children: [
                            TabBar(
                              dividerColor: Colors.black,
                              indicatorColor: notifier.getred,
                              labelColor: notifier.getred,
                              unselectedLabelColor: Colors.black,
                              tabs: <Widget>[
                                Tab(
                                  text: 'Pizza',
                                ),
                                Tab(
                                  text: 'Pasta&Rice',
                                ),
                                Tab(
                                  text: 'Drink',
                                ),
                                Tab(
                                  text: 'Special',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 1.1,
                              child: TabBarView(children: [
                                tabbarview(),
                                tabbarview(),
                                tabbarview(),
                                tabbarview(),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sortBy() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: height / 15,
              mainAxisExtent: height / 7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 7),
          itemCount: locationlist.length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedindex == index
                      ? notifier.getred
                      : Colors.transparent,
                  border: Border.all(color: notifier.getgrey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    locationlist[index],
                    style: TextStyle(
                        fontFamily: 'GilroyMedium',
                        color: selectedindex == index
                            ? notifier.getwhite
                            : notifier.getblackcolor,
                        fontWeight: FontWeight.normal,
                        fontSize: height / 60),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future filtershowmodelbottomsheet() {
    return showModalBottomSheet(
      backgroundColor: notifier.getwhite,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Column(
                  children: [
                    SizedBox(height: height / 30),
                    Row(
                      children: [
                        SizedBox(width: width / 12),
                        Text(
                          LanguageFr.location,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontFamily: 'GilroyBold',
                              fontSize: height / 35),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        SizedBox(width: width / 17),
                        SizedBox(
                          height: height / 8,
                          width: width / 1.1,
                          child: sortBy(),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 35),
                    Row(
                      children: [
                        SizedBox(width: width / 12),
                        Text(
                          LanguageFr.filterby,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontFamily: 'GilroyBold',
                              fontSize: height / 35),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 70,
                    ),
                    Container(
                      height: height / 15,
                      width: width / 1.22,
                      decoration: BoxDecoration(
                        color: notifier.getbgfildcolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: DropdownButton(
                        dropdownColor: notifier.getbgfildcolor,
                        underline: const SizedBox(),
                        value: filterbydropdownvalue,
                        icon: Row(
                          children: [
                            SizedBox(width: width / 1.7),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        items: filterbyitems.map((String filterbyitems) {
                          return DropdownMenuItem(
                            value: filterbyitems,
                            child: Padding(
                              padding: EdgeInsets.only(left: width / 40),
                              child: Text(
                                filterbyitems,
                                style: TextStyle(
                                    color: notifier.getblackcolor,
                                    fontSize: height / 50),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            filterbydropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: height / 35),
                    Row(
                      children: [
                        SizedBox(width: width / 12),
                        Text(
                          LanguageFr.price,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontFamily: 'GilroyBold',
                              fontSize: height / 35),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Slider(
                        activeColor: notifier.getred,
                        inactiveColor: const Color(0xff9ceabd),
                        value: _currentSliderValue,
                        max: 100,
                        divisions: 5,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: button(notifier.getred, notifier.getwhite,
                          LanguageFr.apply, width / 1.2),
                    ),
                    SizedBox(height: height / 30)
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget tabbarview() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: width / 20),
              Container(
                height: height / 20,
                width: width / 3.4,
                decoration: BoxDecoration(
                  color: notifier.getbgfildcolor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: DropdownButton(
                  dropdownColor: notifier.getbgfildcolor,
                  underline: const SizedBox(),
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Padding(
                        padding: EdgeInsets.only(left: width / 50),
                        child: Text(
                          items,
                          style: TextStyle(
                              color: notifier.getblackcolor,
                              fontSize: height / 60),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    hide = !hide;
                  });
                },
                child: Container(
                  height: height / 20,
                  width: width / 10,
                  decoration: BoxDecoration(
                    color: notifier.getbgfildcolor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(11),
                    ),
                  ),
                  child: hide == true
                      ? Icon(
                          Icons.widgets_outlined,
                          color: notifier.getblackcolor,
                          size: height / 35,
                        )
                      : Icon(
                          Icons.list,
                          color: notifier.getblackcolor,
                          size: height / 35,
                        ),
                ),
              ),
              SizedBox(width: width / 40),
              GestureDetector(
                onTap: () {
                  filtershowmodelbottomsheet();
                },
                child: Container(
                  height: height / 20,
                  width: width / 10,
                  decoration: BoxDecoration(
                    color: notifier.getbgfildcolor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(11),
                    ),
                  ),
                  child: Icon(
                    Icons.filter_list_sharp,
                    color: notifier.getblackcolor,
                    size: height / 35,
                  ),
                ),
              ),
              SizedBox(width: width / 20),
            ],
          ),
          SizedBox(height: height / 50),
          if (hide == true)
            Container(
                color: Colors.transparent,
                child: Container(
                  color: Colors.transparent,
                  height: height,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: width / 20),
                          CusttomGriadeFoodIteam(
                              "assets/pizzachicago.jpg", LanguageFr.cheesy),
                          SizedBox(width: width / 20),
                          CusttomGriadeFoodIteam(
                              "assets/pizzachicago.jpg", LanguageFr.sevenchess),
                          SizedBox(width: width / 20),
                        ],
                      ),
                      SizedBox(height: height / 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: width / 20),
                          CusttomGriadeFoodIteam(
                              "assets/pizzachicago.jpg", LanguageFr.calzne),
                          SizedBox(width: width / 20),
                          CusttomGriadeFoodIteam(
                              "assets/pizzachicago.jpg", LanguageFr.margarita),
                          SizedBox(width: width / 20),
                        ],
                      ),
                      SizedBox(height: height / 50),
                      SizedBox(height: height / 2.8),
                    ],
                  ),
                ))
          else
            Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  SizedBox(height: height / 50),
                  CusttomFoodIteam(
                      "assets/pizzachicago.jpg", LanguageFr.cheesy),
                  SizedBox(height: height / 100),
                  CusttomFoodIteam("assets/Salad.png", LanguageFr.margarita),
                  SizedBox(height: height / 100),
                  CusttomFoodIteam(
                      "assets/pizzachicago.jpg", LanguageFr.sevenchess),
                  SizedBox(height: height / 100),
                  CusttomFoodIteam("assets/Salad.png", LanguageFr.calzne),
                  SizedBox(height: height / 5),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget star() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),
      ],
    );
  }

  Widget delivery({required String text}) {
    return Column(
      children: [
        Container(
          // height: 100,
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: notifier.getred,
              ),
              child: Center(
                child: Icon(
                  Icons.discount,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              text,
              style: TextStyle(
                  fontFamily: 'GilroyBold',
                  fontSize: 15,
                  color: notifier.getblackcolor),
            ),
          ),
        ),
      ],
    );
  }

  Widget review(image, name) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: height / 9,
        width: width / 1.2,
        decoration: BoxDecoration(
          color: notifier.getbgfildcolor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: width / 30),
            Image.asset(image, height: height / 15),
            SizedBox(width: width / 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 60),
                Text(
                  name,
                  style: TextStyle(
                      color: notifier.getblackcolor,
                      fontSize: height / 55,
                      fontFamily: 'GilroyBold'),
                ),
                Row(
                  children: [
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                    Icon(Icons.star,
                        size: height / 40, color: notifier.getstarcolor),
                  ],
                ),
                SizedBox(height: height / 100),
                Text(
                  "29x.53618 - Lamborgini",
                  style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 60,
                      fontFamily: 'GilroyMedium'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
