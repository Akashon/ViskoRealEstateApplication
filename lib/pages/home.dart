// // PROPERTY SEARCH SECTION
// import 'dart:convert' show jsonDecode;
// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/component/developer_card.dart';
// import 'package:visko_rocky_flutter/controller/home_controller.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/All_property_page.dart';
// import 'package:visko_rocky_flutter/pages/my_filter_property_page.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart'
//     hide kPrimaryOrange;
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import '../config/colors.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final HomeController controller = Get.put(HomeController());
//   final ThemeController themeController = Get.find<ThemeController>();
//   final RxString selectedLocation = ''.obs;

//   // Page controllers
//   final PageController devPageController =
//       PageController(viewportFraction: 0.75);
//   final PageController pageController = PageController(viewportFraction: 0.75);

//   // Search property states
//   final RxString subcategory = "Residential".obs;
//   final RxList<String> locations = <String>[].obs;
//   final RxList<String> types = <String>[].obs;
//   final RxList<String> sqFts = <String>[].obs;
//   final RxString selectedType = "".obs;
//   final RxString selectedSqFt = "".obs;

//   final RxBool isLoadingSearch = false.obs;

//   // Search results shown in same page (B)
//   final RxList<Map<String, dynamic>> searchResults =
//       <Map<String, dynamic>>[].obs;
//   final RxBool isSearching = false.obs;

//   @override
//   void initState() {
//     super.initState();
//     fetchFilters(subc: subcategory.value);
//   }

//   // Future<void> fetchFilters({
//   //   String subc = "Residential",
//   //   String location = "",
//   //   String type = "",
//   //   String sqFt = "",
//   // }) async {
//   //   try {
//   //     final url =
//   //         'https://apimanager.viskorealestate.com/fetch-homepage-filters?subcategory=$subc&location=$location&type=$type&sq_ft=$sqFt';
//   //     final response = await http.get(Uri.parse(url));
//   //     final data = jsonDecode(response.body);

//   //     if (data['status'] == true) {
//   //       // If no location passed, populate locations list
//   //       if (location.isEmpty) {
//   //         locations.value = List<String>.from(data['locations'] ?? []);
//   //       }

//   //       // If location passed but type not passed, populate types
//   //       if (location.isNotEmpty && type.isEmpty) {
//   //         types.value = List<String>.from(data['types'] ?? []);
//   //       }

//   //       // If location + type (or plot) -> populate sqFts
//   //       if (location.isNotEmpty && (type.isNotEmpty || subc == "Plot")) {
//   //         // API returns sqFts as map sometimes; take values or list
//   //         final sqData = data['sqFts'];
//   //         if (sqData is Map) {
//   //           sqFts.value =
//   //               List<String>.from(sqData.values.map((e) => e.toString()));
//   //         } else if (sqData is List) {
//   //           sqFts.value = List<String>.from(sqData.map((e) => e.toString()));
//   //         } else {
//   //           sqFts.value = [];
//   //         }
//   //       }

//   //       // If user switched subcategory, ensure dependent lists cleared if needed
//   //       if (location.isEmpty &&
//   //           type.isEmpty &&
//   //           sqFt.isEmpty &&
//   //           subc.isNotEmpty) {
//   //         // when just loading for subcategory change
//   //         types.clear();
//   //         sqFts.clear();
//   //       }
//   //     } else {
//   //       // status false -> clear dependent lists
//   //       if (location.isEmpty) {
//   //         locations.clear();
//   //       } else if (location.isNotEmpty && type.isEmpty) {
//   //         types.clear();
//   //       } else {
//   //         sqFts.clear();
//   //       }
//   //     }
//   //   } catch (e) {
//   //     // On error, clear dependent lists to avoid stale options
//   //     if (location.isEmpty) {
//   //       locations.clear();
//   //     } else if (location.isNotEmpty && type.isEmpty) {
//   //       types.clear();
//   //     } else {
//   //       sqFts.clear();
//   //     }
//   //   }
//   // }

//   Future<void> fetchFilters({
//     String subc = "Residential",
//     String location = "",
//     String type = "",
//     String sqFt = "",
//   }) async {
//     try {
//       // ⭐ CHANGED → API expects Residential + type=plot for Plot tab
//       final apiSubc = subc == "Plot" ? "Residential" : subc;
//       final apiType = subc == "Plot" ? "plot" : type;

//       final url =
//           'https://apimanager.viskorealestate.com/fetch-homepage-filters'
//           '?subcategory=$apiSubc'
//           '&location=$location'
//           '&type=$apiType'
//           '&sq_ft=$sqFt';

//       final response = await http.get(Uri.parse(url));
//       if (!mounted) return;

//       final data = jsonDecode(response.body);

//       if (data['status'] == true) {
//         /// ⭐ CHANGED → Always load locations when empty
//         if (location.isEmpty) {
//           locations.value = List<String>.from(data['locations'] ?? []);
//         }

//         /// Residential → types
//         if (subc == "Residential" && location.isNotEmpty && type.isEmpty) {
//           types.value = List<String>.from(data['types'] ?? []);
//         }

//         /// Plot OR Residential → sqFt
//         if (location.isNotEmpty && (subc == "Plot" || type.isNotEmpty)) {
//           final sqData = data['sqFts'];
//           if (sqData is Map) {
//             sqFts.value =
//                 List<String>.from(sqData.values.map((e) => e.toString()));
//           } else if (sqData is List) {
//             sqFts.value = List<String>.from(sqData.map((e) => e.toString()));
//           } else {
//             sqFts.clear();
//           }
//         }
//       } else {
//         locations.clear();
//         types.clear();
//         sqFts.clear();
//       }
//     } catch (e) {
//       locations.clear();
//       types.clear();
//       sqFts.clear();
//     }
//   }

//   /// Call API to fetch properties based on selected filters and show results in same page
//   Future<void> fetchFilteredProperties({
//     required String subc,
//     required String location,
//     String type = "",
//     String sqFt = "",
//   }) async {
//     try {
//       isSearching.value = true;
//       searchResults.clear();

//       // Build API URL - adapt if your real endpoint differs
//       final uri = Uri.parse(
//           'https://apimanager.viskorealestate.com/fetch-properties?subcategory=${Uri.encodeComponent(subc)}&location=${Uri.encodeComponent(location)}&type=${Uri.encodeComponent(type)}&sq_ft=${Uri.encodeComponent(sqFt)}');

//       final res = await http.get(uri);
//       final body = jsonDecode(res.body);

//       if (body != null && body['status'] == true && body['data'] != null) {
//         final List<dynamic> items = body['data'] is List
//             ? body['data']
//             : (body['data']['properties'] ?? []);
//         searchResults.value = items.map<Map<String, dynamic>>((e) {
//           if (e is Map) return Map<String, dynamic>.from(e);
//           return <String, dynamic>{};
//         }).toList();
//       } else {
//         searchResults.clear();
//       }
//     } catch (e) {
//       searchResults.clear();
//     } finally {
//       isSearching.value = false;
//     }
//   }

//   /// Validate and perform in-page search
//   void handleSearch() async {
//     if (subcategory.value == "Residential" &&
//         (selectedLocation.value.isEmpty ||
//             selectedType.value.isEmpty ||
//             selectedSqFt.value.isEmpty)) {
//       return;
//     }

//     if (subcategory.value == "Plot" &&
//         (selectedLocation.value.isEmpty || selectedSqFt.value.isEmpty)) {
//       return;
//     }

//     isLoadingSearch.value = true;

//     await Get.to(
//       MyFilterPropertyPage(
//         initialLocation: selectedLocation.value,
//         initialType: selectedType.value,
//         initialSqFt: selectedSqFt.value,
//       ),
//     );

//     // 🔥 IMPORTANT — RESET LOADER AFTER COMING BACK
//     isLoadingSearch.value = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final isDark = themeController.isDark.value;
//       final glass = Theme.of(context).extension<GlassColors>()!;

//       return Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         body: Stack(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.35,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//                 gradient: LinearGradient(
//                   colors: isDark
//                       ? [
//                           Colors.black.withOpacity(0.6),
//                           Colors.grey.shade800.withOpacity(0.4),
//                         ]
//                       : [
//                           kPrimaryOrange.withOpacity(0.65),
//                           const Color.fromARGB(255, 255, 215, 173)
//                               .withOpacity(0.35),
//                         ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//             SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: MediaQuery.of(context).size.width * 0.04),
//                 child: ListView(
//                   children: [
//                     const SizedBox(height: 20),

//                     /// Top Row
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         glassCircleAvatar(),
//                         Column(
//                           children: [
//                             Text(
//                               "Indore Location",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: glass.textSecondary,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 const Icon(Icons.location_on,
//                                     size: 16, color: kPrimaryOrange),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   "Vijay Nagar Indore",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: glass.textPrimary,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         GestureDetector(
//                           onTap: () => themeController.toggleTheme(),
//                           child: glassButton(
//                             icon: isDark
//                                 ? Icons.light_mode_rounded
//                                 : Icons.dark_mode_rounded,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 25),

//                     Text(
//                       "From Houses to Holiday\nDreams",
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         fontSize: 28,
//                         height: 1.4,
//                         fontWeight: FontWeight.w700,
//                         color: glass.textPrimary,
//                         letterSpacing: 0.5,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(1, 1),
//                             blurRadius: 3,
//                             color: Colors.black26,
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // --- THE SEARCH BAR SECTION --- //

//                     Obx(() {
//                       final glass = Theme.of(context).extension<GlassColors>()!;
//                       final bool isDisabled = isLoadingSearch.value ||
//                           (subcategory.value == "Residential" &&
//                               (selectedLocation.value.isEmpty ||
//                                   selectedType.value.isEmpty ||
//                                   selectedSqFt.value.isEmpty)) ||
//                           (subcategory.value == "Plot" &&
//                               (selectedLocation.value.isEmpty ||
//                                   selectedSqFt.value.isEmpty));

//                       return Column(
//                         children: [
//                           /// -------------------------------
//                           /// PREMIUM GLASS TAB SWITCHER
//                           /// -------------------------------

//                           Row(
//                             children: ["Residential", "Plot"].map((tab) {
//                               final active = subcategory.value == tab;

//                               return GestureDetector(
//                                 onTap: () {
//                                   subcategory.value = tab;
//                                   selectedLocation.value = "";
//                                   selectedType.value = "";
//                                   selectedSqFt.value = "";
//                                   locations.clear();
//                                   types.clear();
//                                   sqFts.clear();

//                                   // ⭐ CHANGED
//                                   fetchFilters(subc: tab);
//                                 },
//                                 child: AnimatedContainer(
//                                   duration: const Duration(milliseconds: 220),
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 12, horizontal: 30),
//                                   margin: const EdgeInsets.only(right: 8),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         topRight: Radius.circular(20)),
//                                     gradient: active
//                                         ? LinearGradient(
//                                             colors: [
//                                               glass.chipSelectedGradientStart,
//                                               glass.chipSelectedGradientEnd,
//                                             ],
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomRight,
//                                           )
//                                         : LinearGradient(
//                                             colors: [
//                                               glass.chipUnselectedStart,
//                                               glass.chipUnselectedEnd
//                                             ],
//                                           ),
//                                     border: Border.all(
//                                       color: glass.glassBorder
//                                           .withOpacity(active ? 0.9 : 0.3),
//                                       width: 1.3,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.18),
//                                         blurRadius: 6,
//                                         offset: const Offset(0, 6),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Text(
//                                     tab,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: active
//                                           ? Colors.white
//                                           : glass.textSecondary,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                           ),

//                           /// GLASS CARD – PREMIUM LOOK
//                           Container(
//                             padding: const EdgeInsets.all(14),
//                             decoration: BoxDecoration(
//                               color: glass.cardBackground,
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(20),
//                                   bottomLeft: Radius.circular(20),
//                                   bottomRight: Radius.circular(20)),
//                               border: Border.all(
//                                 color: glass.glassBorder,
//                                 width: 1.2,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: glass.textPrimary.withOpacity(0.15),
//                                   blurRadius: 6,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 //  make location size width big and type is size is small
//                                 /// ---------------- 1ST ROW ----------------
//                                 Row(
//                                   children: [
//                                     /// PLOT → RESIDENTIAL (STATIC)
//                                     if (subcategory.value == "Plot")
//                                       Expanded(
//                                         flex: 2,
//                                         child: buildRoundedDropdown(
//                                           label: "Residential",
//                                           items: const ["Residential"],
//                                           value: "Residential",
//                                           onChanged: (_) {},
//                                         ),
//                                       ),

//                                     if (subcategory.value == "Plot")
//                                       const SizedBox(width: 6),

//                                     /// LOCATION (Both tabs)
//                                     Expanded(
//                                       flex: 3,
//                                       child: buildRoundedDropdown(
//                                         label: "Location",
//                                         items: locations,
//                                         value: selectedLocation.value.isEmpty
//                                             ? null
//                                             : selectedLocation.value,
//                                         onChanged: (val) async {
//                                           if (val != null) {
//                                             selectedLocation.value = val;
//                                             selectedType.value = "";
//                                             selectedSqFt.value = "";
//                                             await fetchFilters(
//                                               subc: subcategory.value,
//                                               location: selectedLocation.value,
//                                             );
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 const SizedBox(height: 14),

//                                 /// ---------------- 2ND ROW ----------------
//                                 Row(
//                                   children: [
//                                     /// TYPE (Residential only)
//                                     if (subcategory.value == "Residential")
//                                       Expanded(
//                                         flex: 2,
//                                         child: buildRoundedDropdown(
//                                           label: "Type",
//                                           items: types,
//                                           value: selectedType.value.isEmpty
//                                               ? null
//                                               : selectedType.value,
//                                           onChanged: (val) async {
//                                             if (val != null) {
//                                               selectedType.value = val;
//                                               selectedSqFt.value = "";
//                                               await fetchFilters(
//                                                 subc: subcategory.value,
//                                                 location:
//                                                     selectedLocation.value,
//                                                 type: selectedType.value,
//                                               );
//                                             }
//                                           },
//                                         ),
//                                       ),

//                                     if (subcategory.value == "Residential")
//                                       const SizedBox(width: 6),

//                                     /// AREA SIZE (Both tabs)
//                                     SizedBox(
//                                       width: 140,
//                                       child: buildRoundedDropdown(
//                                         label: "Area Size (sq. ft.)",
//                                         items: sqFts,
//                                         value: selectedSqFt.value.isEmpty
//                                             ? null
//                                             : selectedSqFt.value,
//                                         onChanged: (val) {
//                                           if (val != null)
//                                             selectedSqFt.value = val;
//                                         },
//                                       ),
//                                     ),

//                                     const SizedBox(width: 6),

//                                     /// SEARCH BUTTON
//                                     SizedBox(
//                                       height: 50,
//                                       child: ElevatedButton(
//                                         onPressed:
//                                             isDisabled ? null : handleSearch,
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               Theme.of(context).primaryColor,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(16),
//                                           ),
//                                           elevation: 6,
//                                         ),
//                                         child: Obx(() {
//                                           if (isLoadingSearch.value) {
//                                             return const SizedBox(
//                                               width: 20,
//                                               height: 20,
//                                               child: CircularProgressIndicator(
//                                                   color: Colors.white),
//                                             );
//                                           }
//                                           return const Icon(Icons.search,
//                                               color: Colors.white);
//                                         }),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     }),

//                     const SizedBox(height: 25),

//                     // ---------------------------------------------------------
//                     // ⭐ NEW: Developer Card Section Using Component
//                     // ---------------------------------------------------------
//                     SizedBox(
//                       height: 250,
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 64,
//                             height: 250,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   glass.cardBackground.withOpacity(0.80),
//                                   glass.cardBackground.withOpacity(0.65),
//                                   glass.cardBackground.withOpacity(0.80),
//                                 ],
//                               ),
//                               border: Border.all(
//                                 color: glass.glassBorder,
//                                 width: 1.3,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Theme.of(context).brightness ==
//                                           Brightness.dark
//                                       ? Colors.black.withOpacity(0.4)
//                                       : kPrimaryOrange.withOpacity(0.25),
//                                   blurRadius: 20,
//                                   offset: const Offset(0, 6),
//                                 ),
//                               ],
//                             ),
//                             child: RotatedBox(
//                               quarterTurns: 3,
//                               child: Text(
//                                 "DEVELOPERS",
//                                 style: TextStyle(
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.w900,
//                                   foreground: Paint()
//                                     ..shader = LinearGradient(
//                                       colors: [
//                                         kPrimaryOrange,
//                                         kPrimaryOrange.withOpacity(0.7)
//                                       ],
//                                     ).createShader(
//                                         const Rect.fromLTWH(0, 0, 200, 60)),
//                                   letterSpacing: 2,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(width: 4),

//                           // ⭐ USE COMPONENT HERE
//                           Expanded(
//                             child: Obx(() {
//                               if (controller.developers.isEmpty) {
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               }

//                               return PageView.builder(
//                                 controller: devPageController,
//                                 padEnds: false,
//                                 itemCount: controller.developers.length,
//                                 onPageChanged: controller.setActiveIndex,
//                                 itemBuilder: (context, index) {
//                                   final dev = controller.developers[index];

//                                   return DeveloperCard(
//                                     dev: dev,
//                                     onTap: () {
//                                       // navigate to developer properties page (existing)
//                                       Get.toNamed('/developer-properties',
//                                           arguments: {
//                                             'slug': dev['developer_slug'] ?? "",
//                                           });
//                                     },
//                                   );
//                                 },
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     // -------- Developer Page Indicator --------
//                     Obx(
//                       () => Center(
//                         child: AnimatedSmoothIndicator(
//                           activeIndex: controller.activeIndex.value,
//                           count: controller.developers.length,
//                           effect: ExpandingDotsEffect(
//                             activeDotColor: kPrimaryOrange,
//                             dotColor: isDark
//                                 ? Colors.white30
//                                 : Colors.orange.shade200,
//                             dotHeight: 8,
//                             dotWidth: 8,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // -------------------------------------------------
//                     // In-page SEARCH RESULTS: If searchResults has items, show them.
//                     // Otherwise show Location Chips + Popular list as before.
//                     // -------------------------------------------------
//                     Obx(() {
//                       if (isSearching.value) {
//                         return const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 30),
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       }

//                       final limitedProperties =
//                           controller.properties.take(4).toList();

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           /// Title + View All
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Popular Properties",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                   color: glass.textPrimary,
//                                 ),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Get.to(
//                                     () => AllPropertyPage(),
//                                   );
//                                 },
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: glass.textSecondary,
//                                 ),
//                                 child: const Text(
//                                   "View All",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 16),

//                           /// Only 4 Property Cards
//                           limitedProperties.isEmpty
//                               ? Center(
//                                   child: Text(
//                                     "No properties found",
//                                     style: TextStyle(
//                                       color: glass.textSecondary,
//                                     ),
//                                   ),
//                                 )
//                               : Column(
//                                   children: limitedProperties.map((property) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(bottom: 2),
//                                       child: HomePropertyCard(
//                                         property: property,
//                                         isDark: isDark,
//                                         onTap: () {
//                                           Get.to(
//                                             () => PropertyDetailPage(
//                                               slug: property['property_slug'] ??
//                                                   "",
//                                               property: property,
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),

//                           /// View All Button
//                           Center(
//                             child: GestureDetector(
//                               onTap: () {
//                                 Get.to(() => AllPropertyPage());
//                               },
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(28),
//                                 child: BackdropFilter(
//                                   filter:
//                                       ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 28, vertical: 12),
//                                     decoration: BoxDecoration(
//                                       color: glass.glassBackground,
//                                       borderRadius: BorderRadius.circular(28),
//                                       border: Border.all(
//                                         color: glass.glassBorder,
//                                       ),
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           "View All",
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                             color: glass.textPrimary,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }),

//                     const SizedBox(height: 40),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// /// --- GLASS WIDGETS (unchanged) ---
// Widget glassButton({required IconData icon}) {
//   final glass = Theme.of(Get.context!).extension<GlassColors>()!;
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(50),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//       child: Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//           color: glass.glassBackground,
//           shape: BoxShape.circle,
//           border: Border.all(color: glass.glassBorder),
//         ),
//         child: Icon(icon, color: Theme.of(Get.context!).primaryColor, size: 20),
//       ),
//     ),
//   );
// }

// Widget glassCircleAvatar() {
//   final glass = Theme.of(Get.context!).extension<GlassColors>()!;
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(40),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//       child: Container(
//         width: 48,
//         height: 48,
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           color: glass.glassBackground,
//           borderRadius: BorderRadius.circular(40),
//           border: Border.all(color: glass.glassBorder),
//         ),
//         child: ClipOval(
//           child: Image.network(
//             'https://viskohr.com/static/media/viskologo.c8d5be31d9819c924a6d.webp',
//             fit: BoxFit.contain, // 👈 keeps logo fully visible
//             errorBuilder: (_, __, ___) => const Icon(
//               Icons.business,
//               size: 20,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget glassChip(
//   String title, {
//   required bool selected,
//   required VoidCallback onTap,
// }) {
//   final glass = Theme.of(Get.context!).extension<GlassColors>()!;
//   return GestureDetector(
//     onTap: onTap,
//     child: Padding(
//       padding: const EdgeInsets.only(right: 12),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: selected
//               ? LinearGradient(
//                   colors: [
//                     glass.chipSelectedGradientStart,
//                     glass.chipSelectedGradientEnd
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )
//               : LinearGradient(
//                   colors: [glass.chipUnselectedStart, glass.chipUnselectedEnd],
//                 ),
//           border: Border.all(
//             color: selected ? Colors.orange.shade800 : glass.glassBorder,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: selected ? Colors.white : glass.textPrimary,
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget buildRoundedDropdown({
//   required String label,
//   required List<String> items,
//   required String? value,
//   required Function(String?) onChanged,
// }) {
//   final glass = Get.context!.theme.extension<GlassColors>()!;

//   // FIX 1 → Remove duplicates
//   final safeItems = items.toSet().toList();

//   // FIX 2 → Only set value if it exists in the list
//   final safeValue = (value != null && safeItems.contains(value)) ? value : null;

//   return DropdownButtonFormField<String>(
//     value: safeValue,
//     decoration: InputDecoration(
//       labelText: label,
//       labelStyle: TextStyle(
//         fontSize: 13,
//         color: glass.textSecondary,
//         fontWeight: FontWeight.w500,
//       ),
//       filled: true,
//       fillColor: glass.glassBackground,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(18),
//         borderSide: BorderSide(color: glass.glassBorder, width: 1),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(18),
//         borderSide: BorderSide(color: glass.glassBorder, width: 1),
//       ),
//     ),
//     style: TextStyle(
//       fontSize: 14,
//       color: glass.textPrimary,
//       fontWeight: FontWeight.w500,
//     ),
//     dropdownColor: glass.cardBackground,
//     items: safeItems
//         .map((v) => DropdownMenuItem(
//               value: v,
//               child: Text(
//                 v,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: glass.textPrimary,
//                 ),
//               ),
//             ))
//         .toList(),
//     onChanged: onChanged,
//   );
// }

// PROPERTY SEARCH SECTION

// this is my full complete code see this and remove extra code and give me clean code only then you according give  design and flow added init and give me full code
import 'dart:convert' show jsonDecode;
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/component/developer_card.dart';
import 'package:visko_rocky_flutter/controller/home_controller.dart';
import 'package:visko_rocky_flutter/controller/theme_controller.dart';
import 'package:visko_rocky_flutter/pages/All_property_page.dart';
import 'package:visko_rocky_flutter/pages/my_filter_property_page.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart'
    hide kPrimaryOrange;
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../config/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class SearchUIController extends GetxController {
  var showCompactSearch = false.obs;
  var showFullSearch = false.obs;

  void openFullSearch() {
    showFullSearch.value = true;
  }

  void closeFullSearch() {
    showFullSearch.value = false;
  }
}

class _PinnedSearchHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  final bool isDark;

  _PinnedSearchHeader({
    required this.height,
    required this.child,
    this.isDark = false,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height; // ⭐ UPDATED: extra buffer removed

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool scrolled = shrinkOffset > 5;

    final glass = Theme.of(context).extension<GlassColors>()!;

    final double progress = (shrinkOffset / height).clamp(0.0, 1.0);

    return SizedBox.expand(
      child: ClipRRect(
        // ⭐ UPDATED
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: BackdropFilter(
          // ⭐ UPDATED (premium glass)
          filter: ImageFilter.blur(
            sigmaX: scrolled ? 18 : 10,
            sigmaY: scrolled ? 18 : 10,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: scrolled
                  ? glass.solidSurface // ⭐ SCROLL KE BAAD SOLID
                  : glass.glassBackground, // ⭐ SCROLL SE PEHLE GLASS
              //   // ⭐ UPDATED (theme-only gradient)
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   // colors: [
              //   //   glass.glassBackground.withOpacity(scrolled ? 0.92 : 0.75),
              //   //   glass.cardBackground.withOpacity(scrolled ? 0.88 : 0.65),
              //   // ],
              // ),
              border: Border(
                bottom: BorderSide(
                  color: glass.glassBorder
                      .withOpacity(scrolled ? 0.6 : 0.3), // ⭐ UPDATED
                  width: 1,
                ),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedSearchHeader oldDelegate) => true;
}

class GradientHeroHeader extends SliverPersistentHeaderDelegate {
  final bool isDark;
  final Widget child;

  GradientHeroHeader({
    required this.isDark,
    required this.child,
  });

  @override
  double get maxExtent => 320;
  @override
  double get minExtent => 140;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        gradient: LinearGradient(
          colors: isDark
              ? [
                  Colors.black.withOpacity(0.6),
                  Colors.grey.shade800.withOpacity(0.4),
                ]
              : [
                  kPrimaryOrange.withOpacity(0.65),
                  const Color.fromARGB(255, 255, 215, 173).withOpacity(0.35),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final ThemeController themeController = Get.find<ThemeController>();
  final RxString selectedLocation = ''.obs;

  // Page controllers
  final PageController devPageController =
      PageController(viewportFraction: 0.75);
  final PageController pageController = PageController(viewportFraction: 0.75);

  // Search property states
  final RxString subcategory = "Residential".obs;
  final RxList<String> locations = <String>[].obs;
  final RxList<String> types = <String>[].obs;
  final RxList<String> sqFts = <String>[].obs;
  final RxString selectedType = "".obs;
  final RxString selectedSqFt = "".obs;

  final RxBool isLoadingSearch = false.obs;

  // Search results shown in same page (B)
  final RxList<Map<String, dynamic>> searchResults =
      <Map<String, dynamic>>[].obs;
  final RxBool isSearching = false.obs;

  @override
  void initState() {
    super.initState();
    fetchFilters(subc: subcategory.value);
  }

  Future<void> fetchFilters({
    String subc = "Residential",
    String location = "",
    String type = "",
    String sqFt = "",
  }) async {
    try {
      // ⭐ CHANGED → API expects Residential + type=plot for Plot tab
      final apiSubc = subc == "Plot" ? "Residential" : subc;
      final apiType = subc == "Plot" ? "plot" : type;

      final url =
          'https://apimanager.viskorealestate.com/fetch-homepage-filters'
          '?subcategory=$apiSubc'
          '&location=$location'
          '&type=$apiType'
          '&sq_ft=$sqFt';

      final response = await http.get(Uri.parse(url));
      if (!mounted) return;

      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        /// ⭐ CHANGED → Always load locations when empty
        if (location.isEmpty) {
          locations.value = List<String>.from(data['locations'] ?? []);
        }

        /// Residential → types
        if (subc == "Residential" && location.isNotEmpty && type.isEmpty) {
          types.value = List<String>.from(data['types'] ?? []);
        }

        /// Plot OR Residential → sqFt
        if (location.isNotEmpty && (subc == "Plot" || type.isNotEmpty)) {
          final sqData = data['sqFts'];
          if (sqData is Map) {
            sqFts.value =
                List<String>.from(sqData.values.map((e) => e.toString()));
          } else if (sqData is List) {
            sqFts.value = List<String>.from(sqData.map((e) => e.toString()));
          } else {
            sqFts.clear();
          }
        }
      } else {
        locations.clear();
        types.clear();
        sqFts.clear();
      }
    } catch (e) {
      locations.clear();
      types.clear();
      sqFts.clear();
    }
  }

  Future<void> fetchFilteredProperties({
    required String subc,
    required String location,
    String type = "",
    String sqFt = "",
  }) async {
    try {
      isSearching.value = true;
      searchResults.clear();

      // Build API URL - adapt if your real endpoint differs
      final uri = Uri.parse(
          'https://apimanager.viskorealestate.com/fetch-properties?subcategory=${Uri.encodeComponent(subc)}&location=${Uri.encodeComponent(location)}&type=${Uri.encodeComponent(type)}&sq_ft=${Uri.encodeComponent(sqFt)}');

      final res = await http.get(uri);
      final body = jsonDecode(res.body);

      if (body != null && body['status'] == true && body['data'] != null) {
        final List<dynamic> items = body['data'] is List
            ? body['data']
            : (body['data']['properties'] ?? []);
        searchResults.value = items.map<Map<String, dynamic>>((e) {
          if (e is Map) return Map<String, dynamic>.from(e);
          return <String, dynamic>{};
        }).toList();
      } else {
        searchResults.clear();
      }
    } catch (e) {
      searchResults.clear();
    } finally {
      isSearching.value = false;
    }
  }

  void handleSearch() async {
    if (subcategory.value == "Residential" &&
        (selectedLocation.value.isEmpty ||
            selectedType.value.isEmpty ||
            selectedSqFt.value.isEmpty)) {
      return;
    }

    if (subcategory.value == "Plot" &&
        (selectedLocation.value.isEmpty || selectedSqFt.value.isEmpty)) {
      return;
    }

    isLoadingSearch.value = true;

    await Get.to(
      MyFilterPropertyPage(
        initialLocation: selectedLocation.value,
        initialType: selectedType.value,
        initialSqFt: selectedSqFt.value,
      ),
    );

    // 🔥 IMPORTANT — RESET LOADER AFTER COMING BACK
    isLoadingSearch.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDark.value;
      final glass = Theme.of(context).extension<GlassColors>()!;

      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(children: [
            /// 🌈 ONE SINGLE GRADIENT BACKGROUND (FIX)
            Container(
              height: MediaQuery.of(context).size.height * 0.36,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    glass.chipSelectedGradientStart.withOpacity(0.0),
                    glass.chipSelectedGradientEnd.withOpacity(0.45),
                  ],
                ),
              ),
            ),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _PinnedSearchHeader(
                    height: 275 + MediaQuery.of(context).padding.top,
                    isDark: themeController.isDark.value,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: 12,
                        right: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// ================= TOP BAR =================
                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                glassCircleAvatar(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Indore Location",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: glass.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: const [
                                        Icon(Icons.location_on,
                                            size: 15, color: kPrimaryOrange),
                                        SizedBox(width: 4),
                                        Text(
                                          "Vijay Nagar",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: themeController.toggleTheme,
                                  child: glassButton(
                                    icon: isDark
                                        ? Icons.light_mode_rounded
                                        : Icons.dark_mode_rounded,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// ================= SEARCH SECTION =================
                          /// ================= SEARCH SECTION =================
                          Obx(() {
                            final isDisabled = isLoadingSearch.value ||
                                (selectedLocation.value.isEmpty ||
                                    selectedType.value.isEmpty ||
                                    selectedSqFt.value.isEmpty);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// -------- TAB SWITCHER (Residential only) --------
                                Row(
                                  children: [
                                    Expanded(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 220),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 30),
                                        // margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              glass.chipSelectedGradientStart,
                                              glass.chipSelectedGradientEnd,
                                            ],
                                          ),
                                          border: Border.all(
                                            color: glass.glassBorder
                                                .withOpacity(0.9),
                                            width: 1.3,
                                          ),
                                        ),
                                        child: Text(
                                          "Residential",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                /// -------- GLASS SEARCH CARD --------
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: glass.cardBackground,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    border: Border.all(
                                      color: glass.glassBorder,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      /// ROW 1 - Location Dropdown
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: buildRoundedDropdown(
                                              label: "Location",
                                              items: locations,
                                              value:
                                                  selectedLocation.value.isEmpty
                                                      ? null
                                                      : selectedLocation.value,
                                              onChanged: (val) async {
                                                if (val != null) {
                                                  selectedLocation.value = val;
                                                  selectedType.value = "";
                                                  selectedSqFt.value = "";
                                                  await fetchFilters(
                                                    subc: "Residential",
                                                    location: val,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      /// ROW 2 - Type & Area Size
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: buildRoundedDropdown(
                                              label: "Type",
                                              items: types,
                                              value: selectedType.value.isEmpty
                                                  ? null
                                                  : selectedType.value,
                                              onChanged: (val) async {
                                                if (val != null) {
                                                  selectedType.value = val;
                                                  selectedSqFt.value = "";
                                                  await fetchFilters(
                                                    subc: "Residential",
                                                    location:
                                                        selectedLocation.value,
                                                    type: val,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          SizedBox(
                                            width: 140,
                                            child: buildRoundedDropdown(
                                              label: "Area Size",
                                              items: sqFts,
                                              value: selectedSqFt.value.isEmpty
                                                  ? null
                                                  : selectedSqFt.value,
                                              onChanged: (val) {
                                                if (val != null)
                                                  selectedSqFt.value = val;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: isDisabled
                                                  ? null
                                                  : handleSearch,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                elevation: 6,
                                              ),
                                              child: Obx(() {
                                                if (isLoadingSearch.value) {
                                                  return const SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                            color:
                                                                Colors.white),
                                                  );
                                                }
                                                return const Icon(Icons.search,
                                                    color: Colors.white);
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),

                          // Obx(() {
                          //   final isDisabled = isLoadingSearch.value ||
                          //       (subcategory.value == "Residential" &&
                          //           (selectedLocation.value.isEmpty ||
                          //               selectedType.value.isEmpty ||
                          //               selectedSqFt.value.isEmpty)) ||
                          //       (subcategory.value == "Plot" &&
                          //           (selectedLocation.value.isEmpty ||
                          //               selectedSqFt.value.isEmpty));

                          //   return Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       /// -------- TAB SWITCHER --------
                          //       Row(
                          //         children: ["Residential", "Plot"].map((tab) {
                          //           final active = subcategory.value == tab;

                          //           return GestureDetector(
                          //             onTap: () {
                          //               subcategory.value = tab;
                          //               selectedLocation.value = "";
                          //               selectedType.value = "";
                          //               selectedSqFt.value = "";
                          //               locations.clear();
                          //               types.clear();
                          //               sqFts.clear();
                          //               fetchFilters(subc: tab);
                          //             },
                          //             child: AnimatedContainer(
                          //               duration:
                          //                   const Duration(milliseconds: 220),
                          //               padding: const EdgeInsets.symmetric(
                          //                   vertical: 12, horizontal: 30),
                          //               margin: const EdgeInsets.only(right: 8),
                          //               decoration: BoxDecoration(
                          //                 borderRadius: const BorderRadius.only(
                          //                   topLeft: Radius.circular(20),
                          //                   topRight: Radius.circular(20),
                          //                 ),
                          //                 gradient: active
                          //                     ? LinearGradient(
                          //                         colors: [
                          //                           glass
                          //                               .chipSelectedGradientStart,
                          //                           glass
                          //                               .chipSelectedGradientEnd,
                          //                         ],
                          //                       )
                          //                     : LinearGradient(
                          //                         colors: [
                          //                           glass.chipUnselectedStart,
                          //                           glass.chipUnselectedEnd,
                          //                         ],
                          //                       ),
                          //                 border: Border.all(
                          //                   color: glass.glassBorder
                          //                       .withOpacity(
                          //                           active ? 0.9 : 0.9),
                          //                   width: 1.3,
                          //                 ),
                          //               ),
                          //               child: Text(
                          //                 tab,
                          //                 style: TextStyle(
                          //                   fontSize: 14,
                          //                   fontWeight: FontWeight.w600,
                          //                   color: active
                          //                       ? Theme.of(context)
                          //                           .colorScheme
                          //                           .onPrimary
                          //                       : glass.textSecondary,
                          //                 ),
                          //               ),
                          //             ),
                          //           );
                          //         }).toList(),
                          //       ),

                          //       /// -------- GLASS SEARCH CARD --------
                          //       Container(
                          //         padding: const EdgeInsets.all(14),
                          //         decoration: BoxDecoration(
                          //           color: glass.cardBackground,
                          //           borderRadius: const BorderRadius.only(
                          //             topRight: Radius.circular(20),
                          //             bottomLeft: Radius.circular(20),
                          //             bottomRight: Radius.circular(20),
                          //           ),
                          //           border: Border.all(
                          //             color: glass.glassBorder,
                          //             // width: 1.2,
                          //           ),
                          //         ),
                          //         child: Column(
                          //           children: [
                          //             /// ROW 1
                          //             Row(
                          //               children: [
                          //                 if (subcategory.value == "Plot")
                          //                   Expanded(
                          //                     flex: 2,
                          //                     child: buildRoundedDropdown(
                          //                       label: "Residential",
                          //                       items: const ["Residential"],
                          //                       value: "Residential",
                          //                       onChanged: (_) {},
                          //                     ),
                          //                   ),
                          //                 if (subcategory.value == "Plot")
                          //                   const SizedBox(width: 6),
                          //                 Expanded(
                          //                   flex: 3,
                          //                   child: buildRoundedDropdown(
                          //                     label: "Location",
                          //                     items: locations,
                          //                     value:
                          //                         selectedLocation.value.isEmpty
                          //                             ? null
                          //                             : selectedLocation.value,
                          //                     onChanged: (val) async {
                          //                       if (val != null) {
                          //                         selectedLocation.value = val;
                          //                         selectedType.value = "";
                          //                         selectedSqFt.value = "";
                          //                         await fetchFilters(
                          //                           subc: subcategory.value,
                          //                           location: val,
                          //                         );
                          //                       }
                          //                     },
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),

                          //             const SizedBox(height: 6),

                          //             /// ROW 2
                          //             Row(
                          //               children: [
                          //                 if (subcategory.value ==
                          //                     "Residential")
                          //                   Expanded(
                          //                     flex: 2,
                          //                     child: buildRoundedDropdown(
                          //                       label: "Type",
                          //                       items: types,
                          //                       value:
                          //                           selectedType.value.isEmpty
                          //                               ? null
                          //                               : selectedType.value,
                          //                       onChanged: (val) async {
                          //                         if (val != null) {
                          //                           selectedType.value = val;
                          //                           selectedSqFt.value = "";
                          //                           await fetchFilters(
                          //                             subc: subcategory.value,
                          //                             location: selectedLocation
                          //                                 .value,
                          //                             type: val,
                          //                           );
                          //                         }
                          //                       },
                          //                     ),
                          //                   ),
                          //                 if (subcategory.value ==
                          //                     "Residential")
                          //                   const SizedBox(width: 6),
                          //                 SizedBox(
                          //                   width: 140,
                          //                   child: buildRoundedDropdown(
                          //                     label: "Area Size",
                          //                     items: sqFts,
                          //                     value: selectedSqFt.value.isEmpty
                          //                         ? null
                          //                         : selectedSqFt.value,
                          //                     onChanged: (val) {
                          //                       if (val != null) {
                          //                         selectedSqFt.value = val;
                          //                       }
                          //                     },
                          //                   ),
                          //                 ),
                          //                 const SizedBox(width: 6),
                          //                 SizedBox(
                          //                   height: 50,
                          //                   child: ElevatedButton(
                          //                     onPressed: isDisabled
                          //                         ? null
                          //                         : handleSearch,
                          //                     style: ElevatedButton.styleFrom(
                          //                       backgroundColor:
                          //                           Theme.of(context)
                          //                               .primaryColor,
                          //                       shape: RoundedRectangleBorder(
                          //                         borderRadius:
                          //                             BorderRadius.circular(16),
                          //                       ),
                          //                       elevation: 6,
                          //                     ),
                          //                     child: Obx(() {
                          //                       if (isLoadingSearch.value) {
                          //                         return const SizedBox(
                          //                           width: 20,
                          //                           height: 20,
                          //                           child:
                          //                               CircularProgressIndicator(
                          //                                   color:
                          //                                       Colors.white),
                          //                         );
                          //                       }
                          //                       return const Icon(Icons.search,
                          //                           color: Colors.white);
                          //                     }),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   );

                          // }),
                        ],
                      ),
                    ),
                  ),
                ),

                /// =====================================
                /// 4. PAGE CONTENT
                /// =====================================
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          height: 250,
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 250,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      glass.cardBackground.withOpacity(0.80),
                                      glass.cardBackground.withOpacity(0.65),
                                      glass.cardBackground.withOpacity(0.80),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: glass.glassBorder,
                                    width: 1.3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black.withOpacity(0.4)
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.25),
                                      blurRadius: 20,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    "DEVELOPERS",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w900,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            Theme.of(context).primaryColor,
                                            Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.7)
                                          ],
                                        ).createShader(
                                            const Rect.fromLTWH(0, 0, 200, 60)),
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 4),

                              // ⭐ USE COMPONENT HERE
                              Expanded(
                                child: Obx(() {
                                  if (controller.developers.isEmpty) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return PageView.builder(
                                    controller: devPageController,
                                    padEnds: false,
                                    itemCount: controller.developers.length,
                                    onPageChanged: controller.setActiveIndex,
                                    itemBuilder: (context, index) {
                                      final dev = controller.developers[index];

                                      return DeveloperCard(
                                        dev: dev,
                                        onTap: () {
                                          // navigate to developer properties page (existing)
                                          Get.toNamed('/developer-properties',
                                              arguments: {
                                                'slug':
                                                    dev['developer_slug'] ?? "",
                                              });
                                        },
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // -------- Developer Page Indicator --------
                        Obx(
                          () => Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: controller.activeIndex.value,
                              count: controller.developers.length,
                              effect: ExpandingDotsEffect(
                                // activeDotColor: kPrimaryOrange,
                                activeDotColor: Theme.of(context).primaryColor,
                                dotColor: glass.textSecondary.withOpacity(0.35),

                                dotHeight: 8,
                                dotWidth: 8,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // -------------------------------------------------
                        // In-page SEARCH RESULTS: If searchResults has items, show them.
                        // Otherwise show Location Chips + Popular list as before.
                        // -------------------------------------------------
                        Obx(() {
                          if (isSearching.value) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final limitedProperties =
                              controller.properties.take(4).toList();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Title + View All
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Popular Properties",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: glass.textPrimary,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(
                                        () => AllPropertyPage(),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: glass.textSecondary,
                                    ),
                                    child: const Text(
                                      "View All",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              /// Only 4 Property Cards
                              limitedProperties.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No properties found",
                                        style: TextStyle(
                                          color: glass.textSecondary,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children:
                                          limitedProperties.map((property) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: HomePropertyCard(
                                            property: property,
                                            isDark: isDark,
                                            onTap: () {
                                              Get.to(
                                                () => PropertyDetailPage(
                                                  slug: property[
                                                          'property_slug'] ??
                                                      "",
                                                ),
                                              );
                                            },
                                            image: null,
                                          ),
                                        );
                                      }).toList(),
                                    ),

                              /// View All Button
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => AllPropertyPage());
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(28),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 8, sigmaY: 8),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: glass.glassBackground,
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          border: Border.all(
                                            color: glass.glassBorder,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "View All",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: glass.textPrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]));
    });
  }
}

/// --- GLASS WIDGETS (unchanged) ---
Widget glassButton({required IconData icon}) {
  final glass = Theme.of(Get.context!).extension<GlassColors>()!;
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: glass.glassBackground,
          shape: BoxShape.circle,
          border: Border.all(color: glass.glassBorder),
        ),
        child: Icon(icon, color: Theme.of(Get.context!).primaryColor, size: 20),
      ),
    ),
  );
}

Widget glassCircleAvatar() {
  final glass = Theme.of(Get.context!).extension<GlassColors>()!;
  return ClipRRect(
    borderRadius: BorderRadius.circular(40),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
      child: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: glass.glassBackground,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: glass.glassBorder),
        ),
        child: ClipOval(
          child: Image.network(
            'https://viskohr.com/static/media/Visko_logo.096d8e010f7b30432a17.png',
            // 'https://viskohr.com/static/media/viskologo.c8d5be31d9819c924a6d.webp',
            fit: BoxFit.contain, // 👈 keeps logo fully visible
            // errorBuilder: (_, __, ___) => const Icon(
            //   Icons.business,
            //   size: 20,
            // ),
          ),
        ),
      ),
    ),
  );
}

Widget glassChip(
  String title, {
  required bool selected,
  required VoidCallback onTap,
}) {
  final glass = Theme.of(Get.context!).extension<GlassColors>()!;
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: selected
              ? LinearGradient(
                  colors: [
                    glass.chipSelectedGradientStart,
                    glass.chipSelectedGradientEnd
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [glass.chipUnselectedStart, glass.chipUnselectedEnd],
                ),
          border: Border.all(
            color: selected
                ? Theme.of(Get.context!).primaryColor
                : glass.glassBorder,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? Theme.of(Get.context!).colorScheme.onPrimary
                : glass.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

Widget buildRoundedDropdown({
  required String label,
  required List<String> items,
  required String? value,
  required Function(String?) onChanged,
}) {
  final context = Get.context!;
  final glass = context.theme.extension<GlassColors>()!;

  final safeItems = items.toSet().toList();
  final safeValue = (value != null && safeItems.contains(value)) ? value : null;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: safeValue,

          hint: Text(
            " $label",
            style: TextStyle(
              fontSize: 14,
              color: glass.textSecondary,
            ),
          ),

          items: safeItems.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: glass.textPrimary,
                ),
              ),
            );
          }).toList(),

          onChanged: onChanged,

          /// 🔘 BUTTON (INPUT FIELD)
          buttonStyleData: ButtonStyleData(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: glass.glassBackground,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: glass.glassBorder,
                width: 1.2,
              ),
            ),
          ),

          /// ⬇️ DROPDOWN MENU
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            maxHeight: 48 * 4, // ⭐ ONLY 4 ITEMS
            decoration: BoxDecoration(
              // color: glass.cardBackground.withOpacity(0.95),
              color: glass.solidSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: glass.glassBorder,
                width: 1.2,
              ),
            ),
            scrollbarTheme: ScrollbarThemeData(
              thumbColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              thickness: MaterialStateProperty.all(5),
              radius: const Radius.circular(10),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),

          /// 📏 ITEM SIZE
          menuItemStyleData: const MenuItemStyleData(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),

          /// ⬇️ ICON
          iconStyleData: IconStyleData(
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            iconSize: 22,
            iconEnabledColor: glass.textSecondary,
          ),
        ),
      ),
    ],
  );
}
