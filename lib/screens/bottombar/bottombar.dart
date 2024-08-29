// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wegast/screens/bottombar/profile.dart';
import 'package:wegast/screens/home.dart';
import 'package:wegast/screens/orderconfirmation.dart';
import 'package:wegast/screens/yourorder/yourorder.dart';
import 'package:wegast/utils/mediaqury.dart';
import 'package:wegast/utils/notifirecolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomHome extends StatefulWidget {
  const BottomHome({Key? key}) : super(key: key);

  @override
  _BottomHomeState createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  int _selectedIndex = 0;
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

  late ColorNotifier notifire;
  List widgetoption = [
    const HomePage(),
    const YourOrder(),
    const OrderConformation(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: notifire.getwhite,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 1,
            backgroundColor: notifire.getbottomcolor,
            unselectedItemColor: notifire.getgrey.withOpacity(.80),
            selectedLabelStyle: const TextStyle(fontFamily: 'Gilroy_Medium'),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: notifire.getred,
            unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy_Medium'),
            currentIndex: _selectedIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: notifire.getwhite,
                  icon: Image.asset("assets/Home.png",
                      color: _selectedIndex == 0
                          ? notifire.getred
                          : notifire.getgrey,
                      height: height / 42),
                  label: ''),
              BottomNavigationBarItem(
                  backgroundColor: notifire.getwhite,
                  icon: Image.asset("assets/Paper.png",
                      color: _selectedIndex == 1
                          ? notifire.getred
                          : notifire.getgrey,
                      height: height / 35),
                  label: ''),
              BottomNavigationBarItem(
                  backgroundColor: notifire.getwhite,
                  icon: Image.asset("assets/Buy.png",
                      color: _selectedIndex == 2
                          ? notifire.getred
                          : notifire.getgrey,
                      height: height / 42),
                  label: ''),
              BottomNavigationBarItem(
                backgroundColor: notifire.getwhite,
                icon: Image.asset("assets/profile.png",
                    color: _selectedIndex == 3
                        ? notifire.getred
                        : notifire.getgrey,
                    height: height / 42),
                label: '',
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          body: Center(
            child: widgetoption.elementAt(_selectedIndex),
          )),
    );
  }

  // Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
  //   return {
  //     '/': (context) {
  //       return [
  //         const HomePage(),
  //         const YourOrder(),
  //         const OrderConformation(),
  //         const Profile(),
  //       ].elementAt(index);
  //     },
  //   };
}
  //
  // Widget _buildOffstageNavigator(int index) {
  //   var routeBuilders = _routeBuilders(context, index);
  //
  //   return Offstage(
  //     offstage: _selectedIndex != index,
  //     child: Navigator(
  //       onGenerateRoute: (routeSettings) {
  //         return MaterialPageRoute(
  //           builder: (context) => routeBuilders[routeSettings.name]!(context),
  //         );
  //       },
  //     ),
  //   );
  // }
// }
