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
