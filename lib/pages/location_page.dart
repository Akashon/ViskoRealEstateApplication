// THE NICE ATTRACTIVE ROW LIST UI LOCATION
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
  List locations = [];
  List filteredLocations = [];
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
        final jsonData = jsonDecode(response.body);
        final list = jsonData["location_list"] ??
            jsonData["data"] ??
            jsonData["locations"] ??
            [];

        // Remove duplicates
        final unique = <String, dynamic>{};
        for (var item in list) {
          final name = item["property_location_name"] ?? "";
          if (name.isNotEmpty) unique[name] = item;
        }

        setState(() {
          locations = unique.values.toList();
          filteredLocations = locations;
          loading = false;
        });

        fadeController.forward();
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => loading = false);
      print("ERROR: $e");
    }
  }

  void filterLocations(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredLocations = locations
          .where((loc) =>
              (loc["property_location_name"] ?? "").toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Subtitle + Search
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                "Explore Locations",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )),
                          const SizedBox(height: 6),
                          Text(
                            "Choose your ideal property spot",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: searchController,
                            onChanged: filterLocations,
                            decoration: InputDecoration(
                              hintText: "Search city",
                              prefixIcon: Icon(Icons.search,
                                  color: Theme.of(context).primaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              filled: true,
                              fillColor: glass.glassBackground,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Grid of Locations
                    Flexible(
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: filteredLocations.length,
                        itemBuilder: (context, index) {
                          // final loc = filteredLocations[index]
                          //         ["property_location_name"] ??
                          //     "";
                          final loc = filteredLocations[index]
                                  ["property_location_name"] ??
                              "";
                          final slug = filteredLocations[index]
                                  ["property_location_slug"] ??
                              "";

                          return ScaleTransition(
                            scale: CurvedAnimation(
                              parent: fadeController,
                              curve: Interval(index * 0.08, 1,
                                  curve: Curves.easeOutBack),
                            ),
                            child: GestureDetector(
                              // onTap: () {
                              //   Get.snackbar(
                              //     "Location Selected",
                              //     loc,
                              //     backgroundColor: glass.glassBackground,
                              //     colorText: glass.textPrimary,
                              //   );
                              // },
                              onTap: () {
                                // Navigate to new page with slug
                                Get.to(() => PropertyLocationPage(
                                    locationName: loc, locationSlug: slug));
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: glass.glassBorder),
                                  gradient: LinearGradient(
                                    colors: [
                                      glass.glassBackground,
                                      glass.glassBackground.withOpacity(0.5),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 12, sigmaY: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TweenAnimationBuilder(
                                          tween: Tween<double>(
                                              begin: 0.9, end: 1.1),
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeInOut,
                                          builder: (context, value, child) {
                                            return Transform.scale(
                                              scale: value,
                                              child: child,
                                            );
                                          },
                                          child: Icon(
                                            Icons.location_on_rounded,
                                            size: 42,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          loc,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: glass.textPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
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

// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/pages/Property_Location_Page.dart';
// import '../controller/theme_controller.dart';
// import '../theme/app_theme.dart';
// import 'Property_Location_Page.dart';

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

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: loading
//             ? Center(
//                 child: CircularProgressIndicator(
//                   color: Theme.of(context).primaryColor,
//                 ),
//               )
//             : CustomScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 slivers: [
//                   SliverPadding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 12),
//                     sliver: SliverToBoxAdapter(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Obx(() => Text(
//                                 "Explore Locations",
//                                 style: TextStyle(
//                                   fontSize: 30,
//                                   fontWeight: FontWeight.bold,
//                                   color: themeController.isDark.value
//                                       ? Colors.white
//                                       : Colors.black,
//                                 ),
//                               )),
//                           const SizedBox(height: 6),
//                           Text(
//                             "Find the perfect place for your dream property",
//                             style: TextStyle(
//                                 fontSize: 16, color: glass.textSecondary),
//                           ),
//                           const SizedBox(height: 16),
//                           TextField(
//                             controller: searchController,
//                             onChanged: filterLocations,
//                             decoration: InputDecoration(
//                               hintText: "Search city",
//                               prefixIcon: Icon(Icons.search,
//                                   color: Theme.of(context).primaryColor),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               filled: true,
//                               fillColor: glass.glassBackground,
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverPadding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     sliver: SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                         (context, index) {
//                           final loc = filteredLocations[index]
//                                   ["property_location_name"] ??
//                               "";
//                           final slug = filteredLocations[index]
//                                   ["property_location_slug"] ??
//                               "";

//                           return FadeTransition(
//                             opacity: fadeController.drive(
//                                 Tween<double>(begin: 0, end: 1).chain(
//                                     CurveTween(
//                                         curve: Interval(index * 0.05, 1.0,
//                                             curve: Curves.easeOut)))),
//                             child: Padding(
//                               padding: const EdgeInsets.only(bottom: 16),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   // Navigate to new page with slug
//                                   Get.to(() => PropertyLocationPage(
//                                       locationName: loc, locationSlug: slug));
//                                 },
//                                 child: AnimatedContainer(
//                                   duration: const Duration(milliseconds: 400),
//                                   padding: const EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(24),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         glass.glassBackground,
//                                         glass.glassBackground.withOpacity(0.7)
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Theme.of(context)
//                                             .primaryColor
//                                             .withOpacity(0.2),
//                                         blurRadius: 12,
//                                         offset: const Offset(0, 8),
//                                       ),
//                                     ],
//                                     border:
//                                         Border.all(color: glass.glassBorder),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       ScaleTransition(
//                                         scale: CurvedAnimation(
//                                           parent: fadeController,
//                                           curve: Interval(index * 0.05, 1.0,
//                                               curve: Curves.easeOutBack),
//                                         ),
//                                         child: Icon(
//                                           Icons.location_on,
//                                           size: 42,
//                                           color: Theme.of(context).primaryColor,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       Expanded(
//                                         child: Text(
//                                           loc,
//                                           style: TextStyle(
//                                             color: glass.textPrimary,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       Icon(
//                                         Icons.arrow_forward_ios,
//                                         size: 20,
//                                         color: glass.textSecondary,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         childCount: filteredLocations.length,
//                       ),
//                     ),
//                   ),
//                   const SliverToBoxAdapter(
//                     child: SizedBox(height: 20),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
