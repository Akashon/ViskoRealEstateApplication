// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/component/inquiry_form.dart'
//     hide kPrimaryOrange;
// import 'package:visko_rocky_flutter/pages/categories_page.dart';
// import 'package:visko_rocky_flutter/pages/home.dart';
// // import 'package:visko_rocky_flutter/pages/dashboard_page.dart';
// import 'package:visko_rocky_flutter/pages/favorite_page.dart';
// import 'package:visko_rocky_flutter/pages/location_page.dart';
// import '../controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import 'account_setting_page.dart';

// class BottomNavBarPage extends StatefulWidget {
//   @override
//   _BottomNavBarPageState createState() => _BottomNavBarPageState();
// }

// class _BottomNavBarPageState extends State<BottomNavBarPage> {
//   int _pageIndex = 0;

//   final themeController = Get.find<ThemeController>();

//   // 🔥 Use your real pages
//   final List<Widget> _pages = [
//     HomePage(), // index 0
//     // DashboardPage(), // index 1
//     CategoriesPage(), // index 2
//     // LocationPage(
//     //   slug: '',
//     //   locationName: '',
//     // ), // index

//     LocationPage(),
//     FavoritePage(), // index 4

//     SettingsPage(), // index 3
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     return Obx(() {
//       final isDark = themeController.isDark.value;

//       return Scaffold(
//         extendBody: true,
//         body: IndexedStack(index: _pageIndex, children: _pages),

//         // Bottom Navigation
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
//                     colors: [Color(0xffffefe3), Color(0xffffe3d2)],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//           ),
//           child: CurvedNavigationBar(
//             backgroundColor: Colors.transparent,
//             height: 65,
//             index: _pageIndex,
//             animationDuration: Duration(milliseconds: 300),
//             items: [
//               _pageIndex == 0
//                   ? Icon(Icons.home_rounded, size: 30, color: kPrimaryOrange)
//                   : Icon(
//                       Icons.home_outlined,
//                       size: 30,
//                       color: glass.textSecondary,
//                     ),
//               _pageIndex == 1
//                   // ? Icon(
//                   //     Icons.dashboard_rounded,
//                   //     size: 30,
//                   //     color: kPrimaryOrange,
//                   //   )
//                   // : Icon(
//                   //     Icons.dashboard_outlined,
//                   //     size: 30,
//                   //     color: glass.textSecondary,
//                   //   ),
//                   ? Icon(
//                       Icons.category_rounded,
//                       size: 30,
//                       color: kPrimaryOrange,
//                     )
//                   : Icon(
//                       Icons.category_outlined,
//                       size: 30,
//                       color: glass.textSecondary,
//                     ),
//               _pageIndex == 2
//                   ? Icon(
//                       Icons.location_on_rounded,
//                       size: 30,
//                       color: kPrimaryOrange,
//                     )
//                   : Icon(
//                       Icons.location_on_outlined,
//                       size: 30,
//                       color: glass.textSecondary,
//                     ),
//               _pageIndex == 3
//                   ? Icon(
//                       Icons.favorite_rounded,
//                       size: 30,
//                       color: kPrimaryOrange,
//                     )
//                   : Icon(
//                       Icons.favorite_border,
//                       size: 30,
//                       color: glass.textSecondary,
//                     ),
//               _pageIndex == 4
//                   ? Icon(
//                       Icons.settings_rounded,
//                       size: 30,
//                       color: kPrimaryOrange,
//                     )
//                   : Icon(
//                       Icons.settings_outlined,
//                       size: 30,
//                       color: glass.textSecondary,
//                     ),
//             ],
//             color: glass.glassBackground,
//             buttonBackgroundColor: glass.glassBackground,
//             onTap: (index) {
//               setState(() => _pageIndex = index);
//             },
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';
import 'package:visko_rocky_flutter/pages/categories_page.dart';
import 'package:visko_rocky_flutter/pages/home.dart';
import 'package:visko_rocky_flutter/pages/favorite_page.dart';
import 'package:visko_rocky_flutter/pages/location_page.dart';
import 'package:visko_rocky_flutter/pages/testing.dart';
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

  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    LocationPage(),
    FavoritePage(),
    SettingsPage(),
    // Testing(),
  ];

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Obx(() {
      final isDark = themeController.isDark.value;

      return Scaffold(
        extendBody: true,
        body: IndexedStack(index: _pageIndex, children: _pages),
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
                    colors: [
                      Color(0xffffefe3),
                      Color(0xffffe3d2),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
          ),
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            height: 65,
            index: _pageIndex,
            animationDuration: Duration(milliseconds: 300),

            // BUTTON COLOR (selected)
            buttonBackgroundColor: kPrimaryOrange,

            // NAV BAR BACKGROUND (from your theme)
            color: glass.glassBackground,

            // ITEMS
            items: [
              _buildIcon(
                selected: _pageIndex == 0,
                active: Icons.home_rounded,
                inactive: Icons.home_outlined,
              ),
              _buildIcon(
                selected: _pageIndex == 1,
                active: Icons.category_rounded,
                inactive: Icons.category_outlined,
              ),
              _buildIcon(
                selected: _pageIndex == 2,
                active: Icons.location_on_rounded,
                inactive: Icons.location_on_outlined,
              ),
              _buildIcon(
                selected: _pageIndex == 3,
                active: Icons.favorite_rounded,
                inactive: Icons.favorite_border,
              ),
              _buildIcon(
                selected: _pageIndex == 4,
                active: Icons.settings_rounded,
                inactive: Icons.settings_outlined,
              ),
              // _buildIcon(
              //   selected: _pageIndex == 5,
              //   active: Icons.developer_mode,
              //   inactive: Icons.developer_mode_outlined,
              // ),
            ],

            onTap: (index) {
              setState(() => _pageIndex = index);
            },
          ),
        ),
      );
    });
  }

  /// ---------- ICON BUILDER ----------
  Widget _buildIcon({
    required bool selected,
    required IconData active,
    required IconData inactive,
  }) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Icon(
      selected ? active : inactive,
      size: 30,
      color: selected ? Colors.white : glass.textSecondary,
    );
  }
}
