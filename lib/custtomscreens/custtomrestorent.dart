import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wegast/screens/restaurantMenu.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CusttomRestaurant extends StatefulWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final int? id;
  const CusttomRestaurant(this.image, this.title, this.subtitle, this.id,
      {Key? key})
      : super(key: key);

  @override
  State<CusttomRestaurant> createState() => _CusttomRestaurantState();
}

class _CusttomRestaurantState extends State<CusttomRestaurant> {
  late ColorNotifier notifier;
  late double height;
  late double width;

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => restaurantMenu(),
          ),
        );
      },
      child: Container(
        height: height / 8.6,
        width: width / 1.1,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: notifier.getwhite,
          borderRadius: const BorderRadius.all(
            Radius.circular(11),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: widget.image != null
                  ? CachedNetworkImage(
                      imageUrl: widget.image!,
                      height: height / 8.6,
                      width: width / 4,
                      fit: BoxFit.cover,
                      // errorBuilder: (context, error, stackTrace) {
                      //   return Icon(Icons.error, color: Colors.red);
                      // },
                    )
                  : Icon(Icons.image, size: height / 8.6),
            ),
            SizedBox(width: width / 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 70),
                Text(
                  widget.title!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: notifier.getblackcolor,
                      fontSize: height / 50,
                      fontFamily: 'GilroyBold'),
                ),
                Text(
                  widget.subtitle!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: notifier.getgrey,
                      fontSize: height / 60,
                      fontFamily: 'GilroyMedium'),
                ),
                SizedBox(height: height / 70),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget kmtime(w, icon, txt) {
    return Container(
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
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: height / 70,
              color: notifier.getred,
            ),
          )
        ],
      ),
    );
  }
}
