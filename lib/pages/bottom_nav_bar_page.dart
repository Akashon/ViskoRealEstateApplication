import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart'
    hide kPrimaryOrange;
import 'package:visko_rocky_flutter/pages/home.dart';
import 'package:visko_rocky_flutter/pages/dashboard_page.dart';
import 'package:visko_rocky_flutter/pages/favorite_page.dart';
import '../controller/theme_controller.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'account_setting_page.dart';

class BottomNavBarPage extends StatefulWidget {
  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _pageIndex = 0;

  final themeController = Get.find<ThemeController>();

  // 🔥 Use your real pages
  final List<Widget> _pages = [
    HomePage(), // index 0
    DashboardPage(), // index 1
    FavoritePage(), // index 2
    SettingsPage(), // index 3
  ];

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Obx(() {
      final isDark = themeController.isDark.value;

      return Scaffold(
        extendBody: true,
        body: IndexedStack(index: _pageIndex, children: _pages),

        // Bottom Navigation
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    colors: [
                      Colors.black87.withOpacity(0.6),
                      Colors.black87.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : LinearGradient(
                    colors: [Color(0xffffefe3), Color(0xffffe3d2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
          ),
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            height: 65,
            index: _pageIndex,
            animationDuration: Duration(milliseconds: 300),
            items: [
              _pageIndex == 0
                  ? Icon(Icons.home_rounded, size: 30, color: kPrimaryOrange)
                  : Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: glass.textSecondary,
                    ),
              _pageIndex == 1
                  ? Icon(
                      Icons.dashboard_rounded,
                      size: 30,
                      color: kPrimaryOrange,
                    )
                  : Icon(
                      Icons.dashboard_outlined,
                      size: 30,
                      color: glass.textSecondary,
                    ),
              _pageIndex == 2
                  ? Icon(
                      Icons.favorite_rounded,
                      size: 30,
                      color: kPrimaryOrange,
                    )
                  : Icon(
                      Icons.favorite_border,
                      size: 30,
                      color: glass.textSecondary,
                    ),
              _pageIndex == 3
                  ? Icon(
                      Icons.settings_rounded,
                      size: 30,
                      color: kPrimaryOrange,
                    )
                  : Icon(
                      Icons.settings_outlined,
                      size: 30,
                      color: glass.textSecondary,
                    ),
            ],
            color: glass.glassBackground,
            buttonBackgroundColor: glass.glassBackground,
            onTap: (index) {
              setState(() => _pageIndex = index);
            },
          ),
        ),
      );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/component/home_property_card.dart';

// import '../controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// import 'home.dart';
// import 'dashboard_page.dart';
// import 'favorite_page.dart';
// import 'account_setting_page.dart';

// class BottomNavBarPage extends StatefulWidget {
//   const BottomNavBarPage({Key? key}) : super(key: key);

//   @override
//   _BottomNavBarPageState createState() => _BottomNavBarPageState();
// }

// class _BottomNavBarPageState extends State<BottomNavBarPage> {
//   int _pageIndex = 0;
//   final ThemeController themeController = Get.find<ThemeController>();

//   late final List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();

//     // initialize pages here so they exist before first build
//     _pages = [
//       HomePage(), // 0
//       DashboardPage(), // 1
//       FavoritePage(), // 2
//       SettingsPage(), // 3
//     ];

//     // ensure pageIndex is valid (just in case)
//     _pageIndex = _pageIndex.clamp(0, _pages.length - 1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // get glass colors safely — if extension missing, use reasonable defaults
//     final glass = Theme.of(context).extension<GlassColors>() ??
//         GlassColors(
//           glassBackground: Colors.white.withOpacity(0.6),
//           glassBorder: Colors.white24,
//           cardBackground: Colors.white.withOpacity(0.9),
//           chipSelectedGradientStart: Colors.orange,
//           chipSelectedGradientEnd: Colors.orangeAccent,
//           chipUnselectedStart: Colors.white70,
//           chipUnselectedEnd: Colors.white54,
//           textPrimary: Colors.black87,
//           textSecondary: Colors.black54,
//         );

//     return Obx(() {
//       final isDark = themeController.isDark.value;

//       return Scaffold(
//         extendBody: true,

//         // clamp index here too to be 100% safe
//         body: IndexedStack(
//           index: _pageIndex.clamp(0, _pages.length - 1),
//           children: _pages,
//         ),

//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             gradient: isDark
//                 ? LinearGradient(
//                     colors: [
//                       Colors.black87.withOpacity(0.6),
//                       Colors.black87.withOpacity(0.4),
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   )
//                 : LinearGradient(
//                     colors: const [Color(0xffffefe3), Color(0xffffe3d2)],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//           ),
//           // NOTE: items list must be static length (do not remove/insert items at runtime)
//           child: CurvedNavigationBar(
//             backgroundColor: Colors.transparent,
//             height: 65,
//             // provide a safe index to the nav bar
//             index: _pageIndex.clamp(0, _pages.length - 1),
//             animationDuration: const Duration(milliseconds: 300),
//             // static items (length must equal _pages.length)
//             items: [
//               Icon(
//                 _pageIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
//                 size: 30,
//                 color: _pageIndex == 0 ? kPrimaryOrange : glass.textSecondary,
//               ),
//               Icon(
//                 _pageIndex == 1
//                     ? Icons.dashboard_rounded
//                     : Icons.dashboard_outlined,
//                 size: 30,
//                 color: _pageIndex == 1 ? kPrimaryOrange : glass.textSecondary,
//               ),
//               Icon(
//                 _pageIndex == 2
//                     ? Icons.favorite_rounded
//                     : Icons.favorite_border,
//                 size: 30,
//                 color: _pageIndex == 2 ? kPrimaryOrange : glass.textSecondary,
//               ),
//               Icon(
//                 _pageIndex == 3
//                     ? Icons.settings_rounded
//                     : Icons.settings_outlined,
//                 size: 30,
//                 color: _pageIndex == 3 ? kPrimaryOrange : glass.textSecondary,
//               ),
//             ],
//             color: glass.glassBackground,
//             buttonBackgroundColor: glass.glassBackground,
//             onTap: (index) {
//               // clamp incoming index just in case (shouldn't be necessary but defensive)
//               final safeIndex = index.clamp(0, _pages.length - 1);
//               setState(() => _pageIndex = safeIndex);
//             },
//           ),
//         ),
//       );
//     });
//   }
// }
