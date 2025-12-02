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
// import '../config/colors.dart' hide kPrimaryOrange;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final HomeController controller = Get.put(HomeController());
//   final ThemeController themeController = Get.find<ThemeController>();
//   final RxString selectedLocation = ''.obs;
//   final PageController pageController = PageController(viewportFraction: 0.75);

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
//               height: MediaQuery.of(context).size.height * 0.32,
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
//                   horizontal: MediaQuery.of(context).size.width * 0.04,
//                 ),
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
//                       style: TextStyle(
//                         fontSize: 28,
//                         height: 1.05,
//                         fontWeight: FontWeight.w700,
//                         color: glass.textPrimary,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// Search Bar + Buttons
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(50),
//                             child: BackdropFilter(
//                               filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//                               child: Container(
//                                 height: 40,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 decoration: BoxDecoration(
//                                   color: glass.glassBackground,
//                                   borderRadius: BorderRadius.circular(50),
//                                   border: Border.all(color: glass.glassBorder),
//                                 ),
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                     hintText: "Search properties...",
//                                     hintStyle: TextStyle(
//                                         fontSize: 13,
//                                         color: glass.textSecondary),
//                                     border: InputBorder.none,
//                                   ),
//                                   style: TextStyle(color: glass.textPrimary),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         glassButton(icon: Icons.search),
//                         const SizedBox(width: 10),
//                         glassButton(icon: Icons.filter_alt_outlined),
//                       ],
//                     ),

//                     const SizedBox(height: 20),

//                     /// Location Chips
//                     Obx(() {
//                       final allLocations = controller.properties
//                           .map((e) => e['property_location_slug'] ?? 'Unknown')
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

//                     const SizedBox(height: 25),

//                     /// Developers PageView
//                     SizedBox(
//                       height: 150,
//                       child: Obx(
//                         () => controller.developers.isEmpty
//                             ? const Center(child: CircularProgressIndicator())
//                             : PageView.builder(
//                                 controller: pageController,
//                                 itemCount: controller.developers.length,
//                                 onPageChanged: controller.setActiveIndex,
//                                 itemBuilder: (context, index) {
//                                   final dev = controller.developers[index];
//                                   return GestureDetector(
//                                     onTap: () {
//                                       Get.to(() => DeveloperProperties(
//                                             slug: dev['developer_slug'],
//                                           ));
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           horizontal: 8),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: isDark
//                                                 ? Colors.black.withOpacity(0.4)
//                                                 : const Color.fromARGB(
//                                                         255, 245, 243, 242)
//                                                     .withOpacity(0.25),
//                                             blurRadius: 12,
//                                             offset: const Offset(0, 5),
//                                           ),
//                                         ],
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(20),
//                                         child: Stack(
//                                           children: [
//                                             // CachedNetworkImage(
//                                             //   imageUrl:
//                                             //       dev['developer_logo'] ?? "",
//                                             //   width: double.infinity,
//                                             //   height: double.infinity,
//                                             //   fit: BoxFit.cover,
//                                             // ),
//                                             CachedNetworkImage(
//                                               imageUrl:
//                                                   dev['developer_logo'] ?? "",
//                                               width: double.infinity,
//                                               height: 150,
//                                               fit: BoxFit.contain,
//                                               placeholder: (context, url) => Center(
//                                                   child:
//                                                       CircularProgressIndicator()),
//                                               errorWidget: (context, url,
//                                                       error) =>
//                                                   const Icon(Icons.broken_image,
//                                                       size: 40,
//                                                       color: Colors.white),
//                                             ),

//                                             Container(
//                                                 color: Colors.black
//                                                     .withOpacity(0.35)),
//                                             Positioned(
//                                               bottom: 12,
//                                               left: 12,
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     dev['developer_name'] ?? "",
//                                                     style: const TextStyle(
//                                                       fontSize: 18,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       const Icon(
//                                                           Icons.location_on,
//                                                           size: 14,
//                                                           color: Colors.white),
//                                                       const SizedBox(width: 4),
//                                                       Text(
//                                                         dev['developer_city'] ??
//                                                             "",
//                                                         style: const TextStyle(
//                                                             color:
//                                                                 Colors.white70),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                     ),

//                     const SizedBox(height: 10),

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

//                     const SizedBox(height: 20),

//                     /// Popular Properties
//                     Text(
//                       "Popular Properties",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: glass.textPrimary,
//                       ),
//                     ),
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

// /// --- GLASS WIDGETS ---
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
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// home_page.dart
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/controller/home_controller.dart';
import 'package:visko_rocky_flutter/controller/theme_controller.dart';
import 'package:visko_rocky_flutter/pages/developer_properties.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart'
    hide kPrimaryOrange;
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import '../config/colors.dart' hide kPrimaryOrange;

/// Full HomePage with redesigned Developer Cards (Style A)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final ThemeController themeController = Get.find<ThemeController>();
  final RxString selectedLocation = ''.obs;

  // PageControllers: one for developers (new design) and one you might already use
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
            // Top gradient background
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

                    /// Top Row: Profile, Location, Theme Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        glassCircleAvatar(),
                        Column(
                          children: [
                            Text(
                              "Indore Location",
                              style: TextStyle(
                                  fontSize: 12, color: glass.textSecondary),
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

                    // --- Search Row (search field + filter button)
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

                    const SizedBox(height: 20),

                    /// Location Chips
                    Obx(() {
                      final allLocations = controller.properties
                          .map((e) => e['property_location_slug'] ?? 'Unknown')
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

                    const SizedBox(height: 25),

                    /// --- NEW: Developers PageView (Style A - full-image developer cards) ---
                    Text(
                      "Nearby Developers",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context)
                            .extension<GlassColors>()!
                            .textPrimary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 250,
                      child: Obx(() {
                        if (controller.developers.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return PageView.builder(
                          controller: devPageController,
                          itemCount: controller.developers.length,
                          onPageChanged: controller.setActiveIndex,
                          itemBuilder: (context, index) {
                            final dev = controller.developers[index];
                            final glass =
                                Theme.of(context).extension<GlassColors>()!;
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => DeveloperProperties(
                                    slug: dev['developer_slug'] ?? ''));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                width: MediaQuery.of(context).size.width * 0.72,
                                child: Stack(
                                  children: [
                                    // Background Image with rounded corners & shadow
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.black
                                                      .withOpacity(0.45)
                                                  : Colors.orange.shade100
                                                      .withOpacity(0.25),
                                              blurRadius: 15,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: dev['developer_banner'] ??
                                                dev['developer_logo'] ??
                                                '',
                                            width: double.infinity,
                                            height: 150,
                                            fit: BoxFit.contain,
                                            alignment: Alignment.center,
                                            placeholder: (context, url) =>
                                                Container(
                                                    color:
                                                        glass.glassBackground),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: glass.glassBackground,
                                              child: const Icon(
                                                  Icons.broken_image,
                                                  size: 40,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Gradient overlay for depth and attractiveness
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.2),
                                              Colors.black.withOpacity(0.35),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Top-right rating badge
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: kPrimaryOrange,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: glass.glassBorder),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star,
                                                size: 14, color: Colors.white),
                                            const SizedBox(width: 6),
                                            Text(
                                              (dev['rating'] ?? "4.8")
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Bottom glass panel with developer info
                                    Positioned(
                                      left: 12,
                                      right: 12,
                                      bottom: 12,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 12, sigmaY: 12),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 12),
                                            decoration: BoxDecoration(
                                              color: glass.cardBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: glass.glassBorder),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Left: Developer name & city
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        dev['developer_name'] ??
                                                            'Developer Name',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              glass.textPrimary,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.location_on,
                                                              size: 14,
                                                              color: Colors
                                                                  .white70),
                                                          const SizedBox(
                                                              width: 4),
                                                          Text(
                                                            dev['developer_city'] ??
                                                                'City',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: glass
                                                                  .textSecondary,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(width: 10),

                                                // Right: developer type / badge
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        glass.glassBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color:
                                                            glass.glassBorder),
                                                  ),
                                                  child: Text(
                                                    dev['developer_type'] ??
                                                        'Builder',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: kPrimaryOrange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 10),

                    /// Page indicator for developers (uses controller.activeIndex)
                    Obx(() => Center(
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
                        )),

                    const SizedBox(height: 20),

                    /// Popular Properties (kept as-is)
                    Text(
                      "Popular Properties",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: glass.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: controller.properties.map((property) {
                                return HomePropertyCard(
                                  property: property,
                                  isDark: isDark,
                                  onTap: () {
                                    Get.to(() => PropertyDetailPage(
                                          slug: property['property_slug'],
                                          property: null,
                                        ));
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
                  colors: [glass.chipUnselectedStart, glass.chipUnselectedEnd]),
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
