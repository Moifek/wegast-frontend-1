import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:wegast/controllers/user_controller.dart';
import 'package:wegast/screens/bottombar/bottombar.dart';
import 'package:wegast/screens/onbonding/onbonding.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/screens/dasher_screen.dart';
import 'utils/notifirecolor.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => OrdersController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifier(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Onbonding()),
          GetPage(name: '/home', page: () => BottomHome()),
          GetPage(name: '/dasher', page: () => DasherScreen()),
        ],
      ),
    );
  }
}
