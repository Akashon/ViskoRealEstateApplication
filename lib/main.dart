// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:visko_rocky_flutter/pages/dashboard_page.dart';
// // import 'package:visko_rocky_flutter/pages/home.dart';
// // import 'controller/theme_controller.dart';

// // void main() {
// //   Get.put(ThemeController());
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     final themeController = Get.find<ThemeController>();

// //     return Obx(
// //       () => GetMaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         title: "Visko Real Estate",
// //         theme: ThemeData.light(),
// //         darkTheme: ThemeData.dark(),
// //         themeMode: themeController.theme,

// //         home: DashboardPage(),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/pages/home.dart';
// import 'package:visko_rocky_flutter/pages/bottom_nav_bar_page.dart';
// import 'controller/theme_controller.dart';

// void main() {
//   Get.put(ThemeController());
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final themeController = Get.find<ThemeController>();

//     return Obx(
//       () => GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: "Visko Real Estate",
//         theme: ThemeData.light(),
//         darkTheme: ThemeData.dark(),
//         themeMode: themeController.theme,

//         // START FROM HOME PAGE (BOTTOM NAVIGATION INCLUDED)
//         home: BottomNavBarPage(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/pages/bottom_nav_bar_page.dart';
import 'controller/theme_controller.dart';
import 'theme/app_theme.dart';

void main() {
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Visko Real Estate",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.theme,
        home: BottomNavBarPage(),
      ),
    );
  }
}
