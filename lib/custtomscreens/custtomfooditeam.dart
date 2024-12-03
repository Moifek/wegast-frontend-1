import 'package:flutter/material.dart';
import 'package:wegast/screens/orderconfirmation.dart';
import 'package:wegast/utils/enstring.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CusttomFoodIteam extends StatefulWidget {
  final String? image;
  final String? name;
  final String? description;
  final int price;
  const CusttomFoodIteam(this.image, this.name, this.description, this.price,
      {Key? key})
      : super(key: key);

  @override
  State<CusttomFoodIteam> createState() => _CusttomFoodIteamState();
}

class _CusttomFoodIteamState extends State<CusttomFoodIteam> {
  late ColorNotifier notifier;
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
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
    return Container(
      color: Colors.transparent,
      height: height / 6.5,
      width: width / 1.1,
      child: Row(
        children: [
          SizedBox(width: width / 50),
          Container(
            width: width / 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(
                    widget.image!,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: width / 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height / 110),
              Text(
                widget.name!,
                style: TextStyle(
                  color: notifier.getblackcolor,
                  fontSize: height / 44,
                  fontFamily: 'GilroyBold',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: height / 200),
              Text(
                widget.description!,
                style: TextStyle(
                  color: notifier.getgrey,
                  fontSize: height / 60,
                  fontFamily: 'GilroyMedium',
                ),
                maxLines: 1, // Limit the text to one line
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if the text overflows
              ),
              SizedBox(height: height / 200),
              Row(
                children: [
                  Text(
                    widget.price!.toString() + 'TND',
                    style: TextStyle(
                      color: notifier.getred,
                      fontFamily: 'GilroyExtraBold',
                      fontSize: height / 60,
                    ),
                  ),
                  SizedBox(width: width / 2.4),
                  GestureDetector(
                    onTap: () {
                      showmodelbottomsheet();
                    },
                    child: Container(
                      height: height / 20,
                      width: width / 10,
                      decoration: BoxDecoration(
                        color: notifier.getred,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.add,
                            size: height / 30, color: notifier.getwhite),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future showmodelbottomsheet() {
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
                    SizedBox(height: height / 40),
                    Row(
                      children: [
                        SizedBox(width: width / 25),
                        Text(
                          LanguageFr.choiceofsize,
                          style: TextStyle(
                              color: notifier.getgrey,
                              fontSize: height / 60,
                              fontFamily: 'GilroyMedium'),
                        )
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Size L",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$4.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check1,
                          onChanged: (bool? value) {
                            setState(() {
                              check1 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Size M",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$3.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check2,
                          onChanged: (bool? value) {
                            setState(() {
                              check2 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Size S",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$1.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check3,
                          onChanged: (bool? value) {
                            setState(() {
                              check3 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        SizedBox(width: width / 25),
                        Text(
                          LanguageFr.choiceoftopping,
                          style: TextStyle(
                              color: notifier.getgrey,
                              fontSize: height / 60,
                              fontFamily: 'GilroyMedium'),
                        )
                      ],
                    ),
                    SizedBox(height: height / 50),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Topping Fish (4 pieces)",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$4.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check4,
                          onChanged: (bool? value) {
                            setState(() {
                              check4 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 80),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "Topping Meat(5 pieces)",
                                  style: TextStyle(
                                      color: notifier.getblackcolor,
                                      fontSize: height / 50,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                            SizedBox(height: height / 150),
                            Row(
                              children: [
                                SizedBox(width: width / 25),
                                Text(
                                  "\$3.5",
                                  style: TextStyle(
                                      color: notifier.getgrey,
                                      fontSize: height / 60,
                                      fontFamily: 'GilroyBold'),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Checkbox(
                          activeColor: notifier.getred,
                          checkColor: notifier.getblackcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: check5,
                          onChanged: (bool? value) {
                            setState(() {
                              check5 = value!;
                            });
                          },
                        ),
                        SizedBox(width: width / 30),
                      ],
                    ),
                    SizedBox(height: height / 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderConformation(),
                          ),
                        );
                      },
                      child: Container(
                        height: height / 17,
                        width: width / 1.1,
                        decoration: BoxDecoration(
                          color: notifier.getred,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: notifier.getwhite,
                              fontFamily: 'GilroyMedium',
                              fontSize: height / 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height / 50),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
