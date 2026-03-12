import 'package:aadaiz_seller/src/config/firebase/firebase.dart';
import 'package:aadaiz_seller/src/features/seller/ui/home/controller/home_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/location_controller.dart';
import 'package:aadaiz_seller/src/features/seller/ui/profile/controller/profile_controller.dart';
import 'package:aadaiz_seller/src/utils/routes/routes.dart';
import 'package:aadaiz_seller/src/utils/routes/routes_name.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 Firebase Init
  await FirebaseService.init();

  /// GetX Controllers
  Get.put(ProfileController(), permanent: true);
  Get.put(LocationController(), permanent: true);
  Get.put(HomeController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.transparent,
        ),
        textTheme:
        GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Routes.generateRouteSettings,
      initialRoute: RoutesName.splashActivity,
    );
  }
}
