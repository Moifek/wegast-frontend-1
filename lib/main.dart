import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:wegast/screens/authscreen/createaccount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wegast/controllers/user_controller.dart';
import 'package:wegast/screens/bottombar/bottombar.dart';
import 'package:wegast/screens/onbonding/onbonding.dart';
import 'package:wegast/controllers/orders_controller.dart';
import 'package:wegast/screens/dasher_screen.dart';
import 'utils/notifirecolor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Initialize GetX controllers
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => OrdersController());

  // Determine the initial route based on SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  runApp(MyApp(initialRoute: hasSeenOnboarding ? '/createAccount' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

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
        initialRoute: initialRoute,
        getPages: [
          GetPage(name: '/', page: () => Onbonding()),
          GetPage(name: '/home', page: () => BottomHome()),
          GetPage(name: '/createAccount', page: () => CreateAccount()),
          GetPage(name: '/dasher', page: () => DasherScreen()),
        ],
      ),
    );
  }
}
