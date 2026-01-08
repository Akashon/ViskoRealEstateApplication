// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/controller/favorite_controller.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage> {
//   late final FavoriteController favCtrl;

//   @override
//   void initState() {
//     super.initState();
//     favCtrl = Get.find<FavoriteController>();
//     favCtrl.fetchFavorites(); // 🔥 load favorites on open
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// HEADER
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       "Favorites",
//                       style:
//                           TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 6),
//                     Text(
//                       "Your saved properties",
//                       style: TextStyle(fontSize: 15, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),

//               /// FAVORITE LIST
//               Expanded(
//                 child: Obx(() {
//                   // ⏳ Loading
//                   if (favCtrl.isLoading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   // ❤️ EMPTY UI
//                   if (favCtrl.favoriteList.isEmpty) {
//                     return _buildEmptyUI(glass);
//                   }

//                   // ✅ FAVORITE LIST
//                   return ListView.builder(
//                     itemCount: favCtrl.favoriteList.length,
//                     itemBuilder: (context, index) {
//                       final property = favCtrl.favoriteList[index];

//                       return HomePropertyCard(
//                         property: property,
//                         isDark: false,
//                         onTap: () {
//                           // TODO: navigate to property detail
//                         },
//                         image: null,
//                       );
//                     },
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // 🧡 EMPTY FAVORITE UI
// Widget _buildEmptyUI(GlassColors glass) {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.favorite_border,
//           size: 90,
//           color: glass.textSecondary,
//         ),
//         const SizedBox(height: 12),
//         Text(
//           "No Favorites Yet",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: glass.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           "Start saving properties you love",
//           style: TextStyle(
//             fontSize: 15,
//             color: glass.textSecondary,
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/controller/favorite_controller.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late final FavoriteController favCtrl;

  @override
  void initState() {
    super.initState();
    favCtrl = Get.find<FavoriteController>();
    favCtrl.fetchFavorites(); // 🔥 load favorites on open
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Favorites",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: glass.textPrimary, // theme color
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Your saved properties",
                      style: TextStyle(
                        fontSize: 15,
                        color: glass.textSecondary, // theme color
                      ),
                    ),
                  ],
                ),
              ),

              /// FAVORITE LIST
              Expanded(
                child: Obx(() {
                  // ⏳ Loading
                  if (favCtrl.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }

                  // ❤️ EMPTY UI
                  if (favCtrl.favoriteList.isEmpty) {
                    return _buildEmptyUI(glass);
                  }

                  // ✅ FAVORITE LIST
                  return ListView.builder(
                    itemCount: favCtrl.favoriteList.length,
                    itemBuilder: (context, index) {
                      final property = favCtrl.favoriteList[index];

                      return HomePropertyCard(
                        property: property,
                        isDark: brightness == Brightness.dark,
                        onTap: () {
                          Get.to(
                            () => PropertyDetailPage(
                              slug: property['property_slug'] ?? "",
                            ),
                          );
                        },
                        image: null,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🧡 EMPTY FAVORITE UI
Widget _buildEmptyUI(GlassColors glass) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite_border,
          size: 90,
          color: glass.textSecondary, // theme color
        ),
        const SizedBox(height: 12),
        Text(
          "No Favorites Yet",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: glass.textPrimary, // theme color
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Start saving properties you love",
          style: TextStyle(
            fontSize: 15,
            color: glass.textSecondary, // theme color
          ),
        ),
      ],
    ),
  );
}
