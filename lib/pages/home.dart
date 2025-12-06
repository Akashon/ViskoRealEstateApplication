// (OLD) THIS IS HOME PAGE (OLD) CODE USER DEVELOPER AND PROPERTY LISTING PAGE WITHOUT COMPONENT BASED
// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/controller/home_controller.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/developer_properties.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart'
//     hide kPrimaryOrange;
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import '../config/colors.dart';

// /// Full HomePage with redesigned Developer Cards (Style A)
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final HomeController controller = Get.put(HomeController());
//   final ThemeController themeController = Get.find<ThemeController>();
//   final RxString selectedLocation = ''.obs;

//   // PageControllers: one for developers (new design) and one you might already use
//   final PageController devPageController =
//       PageController(viewportFraction: 0.75);
//   final PageController pageController = PageController(viewportFraction: 0.75);

//   @override
//   void dispose() {
//     devPageController.dispose();
//     pageController.dispose();
//     super.dispose();
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
//             // Top gradient background
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

//                     /// Top Row: Profile, Location, Theme Toggle
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         glassCircleAvatar(),
//                         Column(
//                           children: [
//                             Text(
//                               "Indore Location",
//                               style: TextStyle(
//                                   fontSize: 12, color: glass.textSecondary),
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
//                       "From Houses to\nHoliday Dreams",
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

//                     // --- Search Row (search field + filter button)
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(28),
//                             child: BackdropFilter(
//                               filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                               child: Container(
//                                 height: 50,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 18),
//                                 decoration: BoxDecoration(
//                                   color: glass.glassBackground,
//                                   borderRadius: BorderRadius.circular(28),
//                                   border: Border.all(color: glass.glassBorder),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.search,
//                                         color: glass.textSecondary, size: 20),
//                                     const SizedBox(width: 12),
//                                     Expanded(
//                                       child: TextField(
//                                         style:
//                                             TextStyle(color: glass.textPrimary),
//                                         decoration: InputDecoration(
//                                           hintText: "Find a house...",
//                                           hintStyle: TextStyle(
//                                               color: glass.textSecondary,
//                                               fontSize: 14),
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Container(
//                                       height: 34,
//                                       width: 34,
//                                       decoration: BoxDecoration(
//                                         color: glass.cardBackground,
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(
//                                             color: glass.glassBorder),
//                                       ),
//                                       child: Icon(Icons.tune_rounded,
//                                           size: 18, color: kPrimaryOrange),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 25),
//                     // DEVELOPER CARD SECTION
//                     SizedBox(
//                       height: 250,
//                       child: Row(
//                         children: [
//                           // ------------------------- FIXED LEFT BANNER -------------------------
//                           Container(
//                             width: 64,
//                             height: 250,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),

//                               // Premium soft gradient using ONLY theme colors
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   glass.cardBackground.withOpacity(0.80),
//                                   glass.cardBackground.withOpacity(0.65),
//                                   glass.cardBackground.withOpacity(0.80),
//                                 ],
//                               ),

//                               // Theme-based glowing border
//                               border: Border.all(
//                                 color: glass.glassBorder,
//                                 width: 1.3,
//                               ),

//                               // Premium shadow based on theme brightness
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
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: BackdropFilter(
//                                 filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//                                 child: RotatedBox(
//                                   quarterTurns: 3,
//                                   child: Text(
//                                     "DEVELOPERS",
//                                     style: TextStyle(
//                                       fontSize: 19,
//                                       fontWeight: FontWeight.w900,

//                                       // Gradient text using theme colors only
//                                       foreground: Paint()
//                                         ..shader = LinearGradient(
//                                           colors: [
//                                             kPrimaryOrange,
//                                             kPrimaryOrange.withOpacity(0.7),
//                                           ],
//                                         ).createShader(
//                                             const Rect.fromLTWH(0, 0, 200, 60)),
//                                       letterSpacing: 2,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(width: 4),

//                           // ------------------------- SLIDING DEVELOPER CARDS -------------------------
//                           Expanded(
//                             child: Obx(() {
//                               if (controller.developers.isEmpty) {
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               }

//                               return PageView.builder(
//                                 controller: devPageController,

//                                 // ★ removes unwanted gap on left & right
//                                 padEnds: false,

//                                 itemCount: controller.developers.length,
//                                 onPageChanged: controller.setActiveIndex,
//                                 itemBuilder: (context, index) {
//                                   final dev = controller.developers[index];
//                                   final glass = Theme.of(context)
//                                       .extension<GlassColors>()!;

//                                   return GestureDetector(
//                                     onTap: () {
//                                       Get.to(() => DeveloperProperties(
//                                             slug: dev['developer_slug'] ?? '',
//                                           ));
//                                     },
//                                     child: Container(
//                                       // ★ EXACT spacing like your screenshot:
//                                       margin: const EdgeInsets.only(
//                                           left: 6, right: 3),

//                                       // ★ perfect card width (same as screenshot)
//                                       width: MediaQuery.of(context).size.width *
//                                           0.72,

//                                       child: Stack(
//                                         children: [
//                                           // Background Image with rounded corners & shadow
//                                           Positioned.fill(
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: glass.cardBackground,
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 border: Border.all(
//                                                   color: glass.glassBorder,
//                                                   width: 1.0,
//                                                 ),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Theme.of(context)
//                                                                 .brightness ==
//                                                             Brightness.dark
//                                                         ? Colors.black
//                                                             .withOpacity(0.45)
//                                                         : Colors.orange.shade100
//                                                             .withOpacity(0.25),
//                                                     blurRadius: 15,
//                                                     offset: const Offset(0, 6),
//                                                   ),
//                                                 ],
//                                               ),
//                                               child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 child: CachedNetworkImage(
//                                                   imageUrl: dev[
//                                                           'developer_banner'] ??
//                                                       dev['developer_logo'] ??
//                                                       '',
//                                                   width: double.infinity,
//                                                   height: 150,
//                                                   fit: BoxFit.contain,
//                                                   alignment: Alignment.center,
//                                                   placeholder: (context, url) =>
//                                                       Container(
//                                                           color: glass
//                                                               .glassBackground),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                           Container(
//                                                     color:
//                                                         glass.glassBackground,
//                                                     child: const Icon(
//                                                         Icons.broken_image,
//                                                         size: 40,
//                                                         color: Colors.grey),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),

//                                           // Gradient overlay for depth and attractiveness
//                                           Positioned.fill(
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                                 gradient: LinearGradient(
//                                                   begin: Alignment.topCenter,
//                                                   end: Alignment.bottomCenter,
//                                                   colors: [
//                                                     Colors.black
//                                                         .withOpacity(0.2),
//                                                     Colors.black
//                                                         .withOpacity(0.35),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),

//                                           // Top-right rating badge
//                                           Positioned(
//                                             top: 12,
//                                             right: 12,
//                                             child: Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 8,
//                                                       vertical: 6),
//                                               decoration: BoxDecoration(
//                                                 color: kPrimaryOrange,
//                                                 borderRadius:
//                                                     BorderRadius.circular(12),
//                                                 border: Border.all(
//                                                     color: glass.glassBorder),
//                                               ),
//                                               child: Row(
//                                                 children: [
//                                                   const Icon(Icons.star,
//                                                       size: 14,
//                                                       color: Colors.white),
//                                                   const SizedBox(width: 6),
//                                                   Text(
//                                                     (dev['rating'] ?? "4.8")
//                                                         .toString(),
//                                                     style: const TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),

//                                           // Bottom glass panel with developer info
//                                           Positioned(
//                                             left: 12,
//                                             right: 12,
//                                             bottom: 12,
//                                             child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                               child: BackdropFilter(
//                                                 filter: ImageFilter.blur(
//                                                     sigmaX: 12, sigmaY: 12),
//                                                 child: Container(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 14,
//                                                       vertical: 12),
//                                                   decoration: BoxDecoration(
//                                                     color: glass.cardBackground,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             16),
//                                                     border: Border.all(
//                                                         color:
//                                                             glass.glassBorder),
//                                                   ),
//                                                   child: Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       // Left: Developer name & city
//                                                       Expanded(
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               dev['developer_name'] ??
//                                                                   'Developer Name',
//                                                               maxLines: 1,
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               style: TextStyle(
//                                                                 fontSize: 16,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w800,
//                                                                 color: glass
//                                                                     .textPrimary,
//                                                               ),
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 4),
//                                                             Row(
//                                                               children: [
//                                                                 const Icon(
//                                                                     Icons
//                                                                         .location_on,
//                                                                     size: 14,
//                                                                     color: Colors
//                                                                         .white70),
//                                                                 const SizedBox(
//                                                                     width: 4),
//                                                                 Text(
//                                                                   dev['developer_city'] ??
//                                                                       'City',
//                                                                   maxLines: 1,
//                                                                   overflow:
//                                                                       TextOverflow
//                                                                           .ellipsis,
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     color: glass
//                                                                         .textSecondary,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),

//                                                       const SizedBox(width: 10),

//                                                       // Right: developer type / badge
//                                                       Container(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal: 12,
//                                                                 vertical: 6),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: glass
//                                                               .glassBackground,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(12),
//                                                           border: Border.all(
//                                                               color: glass
//                                                                   .glassBorder),
//                                                         ),
//                                                         child: Text(
//                                                           dev['developer_type'] ??
//                                                               'Builder',
//                                                           style: TextStyle(
//                                                             fontSize: 12,
//                                                             color:
//                                                                 kPrimaryOrange,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     /// Page indicator for developers (uses controller.activeIndex)
//                     Obx(() => Center(
//                           child: AnimatedSmoothIndicator(
//                             activeIndex: controller.activeIndex.value,
//                             count: controller.developers.length,
//                             effect: ExpandingDotsEffect(
//                               activeDotColor: kPrimaryOrange,
//                               dotColor: isDark
//                                   ? Colors.white30
//                                   : Colors.orange.shade200,
//                               dotHeight: 8,
//                               dotWidth: 8,
//                             ),
//                           ),
//                         )),

//                     const SizedBox(height: 20),

//                     /// Popular Properties (kept as-is)
//                     Text(
//                       "Popular Properties",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: glass.textPrimary,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// Location Chips
//                     Obx(() {
//                       final allLocations = controller.properties
//                           .map((e) => e['property_location_name'] ?? 'Unknown')
//                           .toSet()
//                           .toList();
//                       return SizedBox(
//                         height: 40,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: allLocations.length,
//                           itemBuilder: (_, index) {
//                             final loc = allLocations[index];
//                             return Obx(
//                               () => glassChip(
//                                 loc,
//                                 selected: selectedLocation.value == loc,
//                                 onTap: () => selectedLocation.value = loc,
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }),
//                     const SizedBox(height: 10),

//                     Obx(
//                       () => controller.isLoading.value
//                           ? const Center(child: CircularProgressIndicator())
//                           : Column(
//                               children: controller.properties.map((property) {
//                                 return HomePropertyCard(
//                                   property: property,
//                                   isDark: isDark,
//                                   onTap: () {
//                                     Get.to(() => PropertyDetailPage(
//                                           slug: property['property_slug'],
//                                           property: null,
//                                         ));
//                                   },
//                                 );
//                               }).toList(),
//                             ),
//                     ),

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
//         padding: const EdgeInsets.all(2),
//         decoration: BoxDecoration(
//           color: glass.glassBackground,
//           borderRadius: BorderRadius.circular(40),
//           border: Border.all(color: glass.glassBorder),
//         ),
//         child: const CircleAvatar(
//           radius: 22,
//           backgroundImage: NetworkImage(
//             'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500',
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
//                   colors: [glass.chipUnselectedStart, glass.chipUnselectedEnd]),
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

// THIS IS HOME PAGE CODE USER DEVELOPER AND PROPERTY LISTING PAGE WITH COMPONENT BASED
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/component/developer_card.dart'; // ⭐ NEW IMPORT
import 'package:visko_rocky_flutter/controller/home_controller.dart';
import 'package:visko_rocky_flutter/controller/theme_controller.dart';
import 'package:visko_rocky_flutter/pages/developer_properties.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart'
    hide kPrimaryOrange;
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import '../config/colors.dart';

/// Full HomePage with redesigned Developer Cards (Component-based)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final ThemeController themeController = Get.find<ThemeController>();
  final RxString selectedLocation = ''.obs;

  // Page controllers
  final PageController devPageController =
      PageController(viewportFraction: 0.75);

  final PageController pageController = PageController(viewportFraction: 0.75);

  @override
  void dispose() {
    devPageController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDark.value;
      final glass = Theme.of(context).extension<GlassColors>()!;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
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
                          const Color.fromARGB(255, 255, 215, 173)
                              .withOpacity(0.35),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),

                    /// Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        glassCircleAvatar(),
                        Column(
                          children: [
                            Text(
                              "Indore Location",
                              style: TextStyle(
                                fontSize: 12,
                                color: glass.textSecondary,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 16, color: kPrimaryOrange),
                                const SizedBox(width: 4),
                                Text(
                                  "Vijay Nagar Indore",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: glass.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => themeController.toggleTheme(),
                          child: glassButton(
                            icon: isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "From Houses to\nHoliday Dreams",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 28,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        color: glass.textPrimary,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 3,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // --- THE SERACH BAR SECTION --- //
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
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
                                        color: glass.textSecondary, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        style:
                                            TextStyle(color: glass.textPrimary),
                                        decoration: InputDecoration(
                                          hintText: "Find a house...",
                                          hintStyle: TextStyle(
                                              color: glass.textSecondary,
                                              fontSize: 14),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      height: 34,
                                      width: 34,
                                      decoration: BoxDecoration(
                                        color: glass.cardBackground,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: glass.glassBorder),
                                      ),
                                      child: Icon(Icons.tune_rounded,
                                          size: 18, color: kPrimaryOrange),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // ---------------------------------------------------------
                    // ⭐ NEW: Developer Card Section Using Component
                    // ---------------------------------------------------------
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
                                      : kPrimaryOrange.withOpacity(0.25),
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
                                        kPrimaryOrange,
                                        kPrimaryOrange.withOpacity(0.7),
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
                                      Get.to(() => DeveloperProperties(
                                            slug: dev['developer_slug'] ?? "",
                                          ));
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
                            activeDotColor: kPrimaryOrange,
                            dotColor: isDark
                                ? Colors.white30
                                : Colors.orange.shade200,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Popular Properties
                    Text(
                      "Popular Properties",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: glass.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Location Chips
                    Obx(() {
                      final allLocations = controller.properties
                          .map((e) => e['property_location_name'] ?? 'Unknown')
                          .toSet()
                          .toList();

                      return SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: allLocations.length,
                          itemBuilder: (_, index) {
                            final loc = allLocations[index];
                            return Obx(
                              () => glassChip(
                                loc,
                                selected: selectedLocation.value == loc,
                                onTap: () => selectedLocation.value = loc,
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    const SizedBox(height: 10),

                    /// Popular Property List
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: controller.properties.map((property) {
                                return HomePropertyCard(
                                  property: property,
                                  isDark: isDark,
                                  onTap: () {
                                    Get.to(
                                      () => PropertyDetailPage(
                                        slug: property['property_slug'],
                                        property: null,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
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
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: glass.glassBackground,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: glass.glassBorder),
        ),
        child: const CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500',
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
            color: selected ? Colors.orange.shade800 : glass.glassBorder,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : glass.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

// PROPERTY SEARCH SECTION
// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/component/developer_card.dart';
// import 'package:visko_rocky_flutter/controller/home_controller.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/developer_properties.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart'
//     hide kPrimaryOrange;
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import '../config/colors.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final HomeController controller = Get.put(HomeController());
//   final ThemeController themeController = Get.find<ThemeController>();

//   final PageController devPageController =
//       PageController(viewportFraction: 0.75);

//   // Search property states
//   final RxString subcategory = "Residential".obs;
//   final RxList<String> locations = <String>[].obs;
//   final RxList<String> types = <String>[].obs;
//   final RxList<String> sqFts = <String>[].obs;

//   final RxString selectedLocation = "".obs;
//   final RxString selectedType = "".obs;
//   final RxString selectedSqFt = "".obs;

//   final RxBool isLoadingSearch = false.obs;

//   @override
//   void initState() {
//     super.initState();
//     fetchFilters();
//   }

//   Future<void> fetchFilters(
//       {String subc = "Residential",
//       String location = "",
//       String type = "",
//       String sqFt = ""}) async {
//     try {
//       final url =
//           'https://apimanager.viskorealestate.com/fetch-homepage-filters?subcategory=$subc&location=$location&type=$type&sq_ft=$sqFt';
//       final response = await http.get(Uri.parse(url));
//       final data = jsonDecode(response.body);
//       if (data['status'] == true) {
//         locations.value = List<String>.from(data['locations'] ?? []);
//         types.value = List<String>.from(data['types'] ?? []);
//         sqFts.value = data['sqFts'] != null
//             ? List<String>.from(data['sqFts'].values)
//             : [];
//       } else {
//         sqFts.clear();
//       }
//     } catch (e) {
//       sqFts.clear();
//     }
//   }

//   void handleSearch() {
//     if (subcategory.value == "Residential" &&
//         (selectedLocation.value.isEmpty ||
//             selectedType.value.isEmpty ||
//             selectedSqFt.value.isEmpty)) return;
//     if (subcategory.value == "Plot" &&
//         (selectedLocation.value.isEmpty || selectedSqFt.value.isEmpty)) return;

//     isLoadingSearch.value = true;

//     Future.delayed(const Duration(milliseconds: 1500), () {
//       final formattedSubc = subcategory.value.toLowerCase();
//       final formattedLocation =
//           selectedLocation.value.replaceAll(" ", "-").toLowerCase();
//       final formattedType = selectedType.value.isNotEmpty
//           ? selectedType.value.replaceAll(" ", "-").toLowerCase()
//           : "";
//       final formattedSqFt =
//           selectedSqFt.value.isNotEmpty ? selectedSqFt.value : "0";

//       String seoPath;
//       if (formattedSubc == "plot") {
//         seoPath =
//             '/properties/$formattedSubc-property-in-indore-$formattedLocation-$formattedSqFt-sqFt';
//       } else {
//         seoPath =
//             '/properties/$formattedSubc-property-in-indore-$formattedLocation-$formattedType-$formattedSqFt-sqFt';
//       }

//       // Navigate to your route (replace with your actual route logic)
//       print("Navigate to: $seoPath");

//       isLoadingSearch.value = false;
//     });
//   }

//   @override
//   void dispose() {
//     devPageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = themeController.isDark.value;
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             height: MediaQuery.of(context).size.height * 0.35,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: isDark
//                     ? [
//                         Colors.black.withOpacity(0.6),
//                         Colors.grey.shade800.withOpacity(0.4)
//                       ]
//                     : [
//                         kPrimaryOrange.withOpacity(0.65),
//                         const Color.fromARGB(255, 255, 215, 173)
//                             .withOpacity(0.35)
//                       ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width * 0.04),
//               child: ListView(
//                 children: [
//                   const SizedBox(height: 20),
//                   // Hero Text
//                   Text(
//                     "From Houses to\nHoliday Dreams",
//                     style: TextStyle(
//                       fontSize: 28,
//                       height: 1.4,
//                       fontWeight: FontWeight.w700,
//                       color: glass.textPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // ===================== SEARCH PROPERTY SECTION =====================
//                   Obx(() {
//                     final bool isDisabled = isLoadingSearch.value ||
//                         (subcategory.value == "Residential" &&
//                             (selectedLocation.value.isEmpty ||
//                                 selectedType.value.isEmpty ||
//                                 selectedSqFt.value.isEmpty)) ||
//                         (subcategory.value == "Plot" &&
//                             (selectedLocation.value.isEmpty ||
//                                 selectedSqFt.value.isEmpty));

//                     return Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: ["Residential", "Plot"].map((tab) {
//                             final bool active = subcategory.value == tab;
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 6),
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   subcategory.value = tab;
//                                   selectedLocation.value = "";
//                                   selectedType.value = "";
//                                   selectedSqFt.value = "";
//                                   fetchFilters(subc: tab);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: active
//                                       ? kPrimaryOrange
//                                       : Colors.black.withOpacity(0.4),
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 child: Text(tab),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                         const SizedBox(height: 10),
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: glass.cardBackground,
//                             borderRadius: BorderRadius.circular(24),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 4)),
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               // Location Dropdown
//                               Obx(() => DropdownButtonFormField<String>(
//                                     value: selectedLocation.value.isEmpty
//                                         ? null
//                                         : selectedLocation.value,
//                                     decoration: const InputDecoration(
//                                       labelText: "Location",
//                                       border: OutlineInputBorder(),
//                                     ),
//                                     items: locations
//                                         .map((loc) => DropdownMenuItem(
//                                               value: loc,
//                                               child: Text(loc),
//                                             ))
//                                         .toList(),
//                                     onChanged: (val) {
//                                       if (val != null) {
//                                         selectedLocation.value = val;
//                                       }
//                                     },
//                                   )),
//                               const SizedBox(height: 8),
//                               // Type Dropdown (only Residential)
//                               if (subcategory.value == "Residential")
//                                 Obx(() => DropdownButtonFormField<String>(
//                                       value: selectedType.value.isEmpty
//                                           ? null
//                                           : selectedType.value,
//                                       decoration: const InputDecoration(
//                                         labelText: "Property Type",
//                                         border: OutlineInputBorder(),
//                                       ),
//                                       items: types
//                                           .map((type) => DropdownMenuItem(
//                                                 value: type,
//                                                 child: Text(type),
//                                               ))
//                                           .toList(),
//                                       onChanged: (val) {
//                                         if (val != null)
//                                           selectedType.value = val;
//                                       },
//                                     )),
//                               if (subcategory.value == "Residential")
//                                 const SizedBox(height: 8),
//                               // Sq Ft Dropdown
//                               Obx(() => DropdownButtonFormField<String>(
//                                     value: selectedSqFt.value.isEmpty
//                                         ? null
//                                         : selectedSqFt.value,
//                                     decoration: const InputDecoration(
//                                       labelText: "Area Size (sq ft)",
//                                       border: OutlineInputBorder(),
//                                     ),
//                                     items: sqFts
//                                         .map((sq) => DropdownMenuItem(
//                                               value: sq,
//                                               child: Text(sq),
//                                             ))
//                                         .toList(),
//                                     onChanged: (val) {
//                                       if (val != null) selectedSqFt.value = val;
//                                     },
//                                   )),
//                               const SizedBox(height: 12),
//                               // Search Button
//                               ElevatedButton(
//                                 onPressed: isDisabled ? null : handleSearch,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: kPrimaryOrange,
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 14, horizontal: 24),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(28),
//                                   ),
//                                 ),
//                                 child: Obx(() => isLoadingSearch.value
//                                     ? const SizedBox(
//                                         height: 20,
//                                         width: 20,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                           strokeWidth: 2,
//                                         ))
//                                     : const Text(
//                                         "Search",
//                                         style: TextStyle(fontSize: 16),
//                                       )),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
