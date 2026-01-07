// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/pages/Property_Location_Page.dart';
// import '../controller/theme_controller.dart';
// import '../theme/app_theme.dart';

// class LocationPage extends StatefulWidget {
//   const LocationPage({super.key});

//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage>
//     with TickerProviderStateMixin {
//   final ThemeController themeController = Get.find<ThemeController>();
//   bool loading = true;
//   List locations = [];
//   List filteredLocations = [];
//   late AnimationController fadeController;
//   final TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     fadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     fetchLocations();
//   }

//   @override
//   void dispose() {
//     fadeController.dispose();
//     searchController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchLocations() async {
//     final url = Uri.parse(
//         "https://apimanager.viskorealestate.com/fetch-single-location");

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         final list = jsonData["location_list"] ??
//             jsonData["data"] ??
//             jsonData["locations"] ??
//             [];

//         // Remove duplicates
//         final unique = <String, dynamic>{};
//         for (var item in list) {
//           final name = item["property_location_name"] ?? "";
//           if (name.isNotEmpty) unique[name] = item;
//         }

//         setState(() {
//           locations = unique.values.toList();
//           filteredLocations = locations;
//           loading = false;
//         });

//         fadeController.forward();
//       } else {
//         setState(() => loading = false);
//       }
//     } catch (e) {
//       setState(() => loading = false);
//       print("ERROR: $e");
//     }
//   }

//   void filterLocations(String query) {
//     final q = query.toLowerCase();
//     setState(() {
//       filteredLocations = locations
//           .where((loc) =>
//               (loc["property_location_name"] ?? "").toLowerCase().contains(q))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final primary = Theme.of(context).primaryColor;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: loading
//             ? Center(
//                 child: CircularProgressIndicator(color: primary),
//               )
//             : Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Title + Subtitle + Search
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Explore Locations",
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: glass.textPrimary,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             "Choose your ideal property spot",
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: glass.textSecondary,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(28),
//                                   child: BackdropFilter(
//                                     filter:
//                                         ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                                     child: Container(
//                                       height: 50,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 18),
//                                       decoration: BoxDecoration(
//                                         color: glass.glassBackground,
//                                         borderRadius: BorderRadius.circular(28),
//                                         border: Border.all(
//                                             color: glass.glassBorder),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Icon(Icons.search,
//                                               color: glass.textSecondary,
//                                               size: 20),
//                                           const SizedBox(width: 12),
//                                           Expanded(
//                                             child: TextField(
//                                               controller: searchController,
//                                               onChanged: filterLocations,
//                                               style: TextStyle(
//                                                   color: glass.textPrimary),
//                                               decoration: InputDecoration(
//                                                 hintText: "Find a house...",
//                                                 hintStyle: TextStyle(
//                                                     color: glass.textSecondary,
//                                                     fontSize: 14),
//                                                 border: InputBorder.none,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     // Grid of Locations
//                     Flexible(
//                       child: GridView.builder(
//                         padding: const EdgeInsets.only(bottom: 16),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 16,
//                           mainAxisSpacing: 16,
//                           childAspectRatio: 1.1,
//                         ),
//                         itemCount: filteredLocations.length,
//                         itemBuilder: (context, index) {
//                           final loc = filteredLocations[index]
//                                   ["property_location_name"] ??
//                               "";
//                           final slug = filteredLocations[index]
//                                   ["property_location_slug"] ??
//                               "";
//                           final count =
//                               filteredLocations[index]["property_count"] ?? 0;

//                           return ScaleTransition(
//                             scale: CurvedAnimation(
//                               parent: fadeController,
//                               curve: Interval(index * 0.08, 1,
//                                   curve: Curves.easeOutBack),
//                             ),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Get.to(() => PropertyLocationPage(
//                                     locationName: loc, locationSlug: slug));
//                               },
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 300),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(18),
//                                   border: Border.all(color: glass.glassBorder),
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       glass.glassBackground,
//                                       glass.glassBackground.withOpacity(0.5),
//                                     ],
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Theme.of(context).brightness ==
//                                               Brightness.dark
//                                           ? Colors.black.withOpacity(0.45)
//                                           : primary.withOpacity(0.12),
//                                       blurRadius: 12,
//                                       offset: const Offset(0, 6),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(18),
//                                   child: BackdropFilter(
//                                     filter: ImageFilter.blur(
//                                         sigmaX: 12, sigmaY: 12),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         TweenAnimationBuilder(
//                                           tween: Tween<double>(
//                                               begin: 0.9, end: 1.1),
//                                           duration: const Duration(seconds: 1),
//                                           curve: Curves.easeInOut,
//                                           builder: (context, value, child) {
//                                             return Transform.scale(
//                                               scale: value,
//                                               child: child,
//                                             );
//                                           },
//                                           child: Icon(
//                                             Icons.location_on_rounded,
//                                             size: 42,
//                                             color: primary,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Text(
//                                           loc,
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: glass.textPrimary,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                         Text(
//                                           "$count Properties",
//                                           style: TextStyle(
//                                             color: glass.textSecondary,
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/pages/Property_Location_Page.dart';
import '../controller/theme_controller.dart';
import '../theme/app_theme.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with TickerProviderStateMixin {
  final ThemeController themeController = Get.find<ThemeController>();

  bool loading = true;

  /// 👇 VERY IMPORTANT
  /// Only this type is used everywhere
  List<Map<String, dynamic>> locations = [];
  List<Map<String, dynamic>> filteredLocations = [];

  late AnimationController fadeController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fetchLocations();
  }

  @override
  void dispose() {
    fadeController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchLocations() async {
    final url = Uri.parse(
        "https://apimanager.viskorealestate.com/fetch-single-location");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        /// RAW LIST FROM API (dynamic)
        final List rawList = decoded["location_list"] ??
            decoded["data"] ??
            decoded["locations"] ??
            [];

        /// COUNT BY LOCATION NAME
        final Map<String, Map<String, dynamic>> tempMap = {};

        for (var item in rawList) {
          if (item is! Map) continue;

          final String name = item["property_location_name"]?.toString() ?? "";
          final String slug = item["property_location_slug"]?.toString() ?? "";

          if (name.isEmpty) continue;

          if (tempMap.containsKey(name)) {
            tempMap[name]!["count"] = (tempMap[name]!["count"] as int) + 1;
          } else {
            tempMap[name] = {
              "name": name,
              "slug": slug,
              "count": 1,
            };
          }
        }

        /// 🔥 THIS IS THE KEY FIX
        /// convert map → List<Map<String, dynamic>>
        final List<Map<String, dynamic>> finalList =
            tempMap.values.map((e) => Map<String, dynamic>.from(e)).toList();

        setState(() {
          locations = finalList;
          filteredLocations = List<Map<String, dynamic>>.from(finalList);
          loading = false;
        });

        fadeController.forward();
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => loading = false);
    }
  }

  void filterLocations(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredLocations = locations
          .where((item) => item["name"].toString().toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(color: primary),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE + SEARCH
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore Locations",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: glass.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Choose your ideal property spot",
                            style: TextStyle(
                              fontSize: 15,
                              color: glass.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                decoration: BoxDecoration(
                                  color: glass.glassBackground,
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(color: glass.glassBorder),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.search,
                                        color: glass.textSecondary),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: filterLocations,
                                        style:
                                            TextStyle(color: glass.textPrimary),
                                        decoration: InputDecoration(
                                          hintText: "Find a location...",
                                          hintStyle: TextStyle(
                                              color: glass.textSecondary),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// GRID
                    Expanded(
                      child: GridView.builder(
                        itemCount: filteredLocations.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) {
                          final item = filteredLocations[index];

                          final String name = item["name"];
                          final String slug = item["slug"];
                          final int count = item["count"];

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => PropertyLocationPage(
                                    locationName: name,
                                    locationSlug: slug,
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: glass.glassBorder),
                                color: glass.glassBackground,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 42,
                                        color: primary,
                                      ),
                                      const SizedBox(height: 12),
                                      // Text(
                                      //   "$name · $count Properties",
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //     color: glass.textPrimary,
                                      //     fontSize: 15,
                                      //     fontWeight: FontWeight.w600,
                                      //   ),
                                      // ),
                                      Text(
                                        "$name",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: glass.textPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "$count Properties",
                                        style: TextStyle(
                                          color: glass.textSecondary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
