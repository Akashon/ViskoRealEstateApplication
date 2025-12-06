// this is my main code for favorite_page.dart
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../component/home_property_card.dart';

// const String baseURL = "https://apimanager.viskorealestate.com";

// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage> {
//   List favorites = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchFavorites();
//   }

//   Future<void> fetchFavorites() async {
//     try {
//       final response = await http.get(Uri.parse("$baseURL/favorites/user"));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         List list = [];

//         if (data['favorite_properties'] != null) {
//           list = data['favorite_properties'];
//         } else if (data['favorites'] != null) {
//           list = data['favorites'];
//         } else if (data['data'] != null) {
//           list = data['data'];
//         }

//         setState(() {
//           favorites = list;
//           loading = false;
//         });
//       } else {
//         setState(() => loading = false);
//       }
//     } catch (e) {
//       print("Error: $e");
//       setState(() => loading = false);
//     }
//   }

//   void removeFromFavorites(int propertyId) async {
//     try {
//       final response = await http.post(
//         Uri.parse("$baseURL/api/favorites/remove"),
//         body: {"property_id": propertyId.toString()},
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           favorites.removeWhere((item) =>
//               item["property_id"].toString() == propertyId.toString());
//         });
//       }
//     } catch (e) {
//       print("Error removing favorite: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Favorite Properties"),
//         backgroundColor: Colors.orange,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : favorites.isEmpty
//               ? const Center(child: Text("No favorites found"))
//               : ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: favorites.length,
//                   itemBuilder: (context, index) {
//                     final item = favorites[index];

//                     return HomePropertyCard(
//                       property: item,
//                       isDark: false,
//                       onTap: () {},
//                       onFavoriteRemoved: () {
//                         removeFromFavorites(item["property_id"]);
//                       },
//                     );
//                   },
//                 ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../component/home_property_card.dart';
// import '../theme/app_theme.dart';

// const String baseURL = "https://apimanager.viskorealestate.com";

// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage>
//     with SingleTickerProviderStateMixin {
//   List favorites = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchFavorites();
//   }

//   Future<void> fetchFavorites() async {
//     try {
//       final response = await http.get(Uri.parse("$baseURL/favorites/user"));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         List list = [];

//         if (data["favorite_properties"] != null) {
//           list = data["favorite_properties"];
//         } else if (data["favorites"] != null) {
//           list = data["favorites"];
//         } else if (data["data"] != null) {
//           list = data["data"];
//         }

//         setState(() {
//           favorites = list;
//           loading = false;
//         });
//       } else {
//         setState(() => loading = false);
//       }
//     } catch (e) {
//       setState(() => loading = false);
//     }
//   }

//   void removeFromFavorites(int id) async {
//     try {
//       final response = await http.post(
//         Uri.parse("$baseURL/api/favorites/remove"),
//         body: {"property_id": id.toString()},
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           favorites.removeWhere(
//               (item) => item["property_id"].toString() == id.toString());
//         });
//       }
//     } catch (e) {
//       print("Error $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,

//       // ----------------------- CUSTOM GLASSMORPHISM APPBAR -----------------------
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 glass.chipSelectedGradientStart,
//                 glass.chipSelectedGradientEnd.withOpacity(0.9),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius:
//                 const BorderRadius.vertical(bottom: Radius.circular(26)),
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               child: Row(
//                 children: [
//                   const Icon(Icons.favorite_rounded,
//                       size: 32, color: Colors.white),
//                   const SizedBox(width: 10),
//                   Text(
//                     "My Favorites",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: glass.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),

//       // ------------------------- BODY -------------------------
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : favorites.isEmpty
//               ? _buildEmptyUI(glass)
//               : ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.all(16),
//                   itemCount: favorites.length,
//                   itemBuilder: (context, index) {
//                     final item = favorites[index];

//                     return AnimatedOpacity(
//                       duration: const Duration(milliseconds: 300),
//                       opacity: 1,
//                       child: GlassFavoriteCard(
//                         glass: glass,
//                         child: HomePropertyCard(
//                           property: item,
//                           isDark:
//                               Theme.of(context).brightness == Brightness.dark,
//                           onTap: () {},
//                           onFavoriteRemoved: () {
//                             removeFromFavorites(item["property_id"]);
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }

//   // ---------------------- EMPTY STATE PREMIUM UI ----------------------
//   Widget _buildEmptyUI(GlassColors glass) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.favorite_outline_rounded,
//               size: 80, color: glass.textSecondary),
//           const SizedBox(height: 14),
//           Text(
//             "No Favorites Yet",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: glass.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             "Add properties to your wishlist",
//             style: TextStyle(fontSize: 15, color: glass.textSecondary),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // -------------------------- GLASS CARD WRAPPER --------------------------
// class GlassFavoriteCard extends StatelessWidget {
//   final Widget child;
//   final GlassColors glass;

//   const GlassFavoriteCard({
//     super.key,
//     required this.child,
//     required this.glass,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 18),
//       decoration: BoxDecoration(
//         color: glass.cardBackground,
//         borderRadius: BorderRadius.circular(22),
//         border: Border.all(color: glass.glassBorder, width: 0.9),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           )
//         ],
//       ),
//       child: child,
//     );
//   }
// }

// ✅ FIXED VERSION — NO LateInitializationError
// The issue came because AnimationController was mixed in but never created.
// This version removes TickerProvider + controller completely and uses implicit animations instead.
// ---------------------------------------------------------------

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
import '../component/home_property_card.dart';
import '../theme/app_theme.dart';

const String baseURL = "https://apimanager.viskorealestate.com";

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List favorites = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      final response = await http.get(Uri.parse("$baseURL/favorites/user"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List list = [];

        if (data["favorite_properties"] != null) {
          list = data["favorite_properties"];
        } else if (data["favorites"] != null) {
          list = data["favorites"];
        } else if (data["data"] != null) {
          list = data["data"];
        }

        setState(() {
          favorites = list;
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => loading = false);
    }
  }

  void removeFromFavorites(int id) async {
    try {
      final response = await http.post(
        Uri.parse("$baseURL/api/favorites/remove"),
        body: {"property_id": id.toString()},
      );

      if (response.statusCode == 200) {
        setState(() {
          favorites.removeWhere(
            (item) => item["property_id"].toString() == id.toString(),
          );
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildPremiumGlassAppBar(glass),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : favorites.isEmpty
              ? _buildEmptyUI(glass)
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final item = favorites[index];

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                      // margin: const EdgeInsets.only(bottom: 20),
                      child: GlassFavoriteCard(
                        glass: glass,
                        child: HomePropertyCard(
                          property: item,
                          isDark:
                              Theme.of(context).brightness == Brightness.dark,
                          onTap: () {
                            Get.to(() => PropertyDetailPage(
                                  slug: item['property_slug'],
                                  property: null,
                                ));
                          },
                          onFavoriteRemoved: () {
                            removeFromFavorites(item["property_id"]);
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  PreferredSizeWidget _buildPremiumGlassAppBar(GlassColors glass) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(85),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              glass.chipSelectedGradientStart,
              glass.chipSelectedGradientEnd.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(26)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.favorite_rounded,
                    size: 32, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  "My Favorites",
                  style: TextStyle(
                    fontSize: 26,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w800,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.white, Colors.white.withOpacity(0.7)],
                      ).createShader(const Rect.fromLTWH(0, 0, 150, 50)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyUI(GlassColors glass) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite_border_rounded,
            size: 90, color: glass.textSecondary),
        const SizedBox(height: 12),
        Text(
          "No Favorites Yet",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: glass.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Start saving properties you love",
          style: TextStyle(fontSize: 15, color: glass.textSecondary),
        ),
      ],
    );
  }
}

class GlassFavoriteCard extends StatelessWidget {
  final Widget child;
  final GlassColors glass;

  const GlassFavoriteCard(
      {super.key, required this.child, required this.glass});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: glass.cardBackground,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }
}
