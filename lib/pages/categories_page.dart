// // THIS IS MY categories_page.dart page code

// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../theme/app_theme.dart';
// import '../controller/theme_controller.dart';
// import 'Category_Property_Page.dart';

// class CategoriesPage extends StatefulWidget {
//   const CategoriesPage({super.key});

//   @override
//   State<CategoriesPage> createState() => _CategoriesPageState();
// }

// class _CategoriesPageState extends State<CategoriesPage> {
//   final ThemeController themeController = Get.find<ThemeController>();
//   final ScrollController _scrollController = ScrollController();

//   bool isLoading = true;
//   List allProperties = [];
//   List categories = [];
//   double _scrollOffset = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchPropertyCategories();
//     _scrollController.addListener(_onScroll);
//   }

//   Future<void> fetchPropertyCategories() async {
//     try {
//       final url = "https://apimanager.viskorealestate.com/fetch-all-properties";
//       final res = await http.get(Uri.parse(url));

//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);

//         if (data["status"] == true && data["properties"] != null) {
//           allProperties = data["properties"];
//           final Map<String, int> subcategoryCounts = {};

//           for (var p in allProperties) {
//             final subcat = p["property_subcategory"] ?? "Unknown";
//             subcategoryCounts[subcat] = (subcategoryCounts[subcat] ?? 0) + 1;
//           }

//           if (!subcategoryCounts.containsKey("Plots")) {
//             subcategoryCounts["Plots"] = allProperties
//                 .where((p) => p["property_type"]?.toLowerCase() == "plot")
//                 .length;
//           }

//           categories = subcategoryCounts.entries.map((e) {
//             return {
//               "name": e.key,
//               "subtitle": "${e.value} listings",
//               "image": "https://via.placeholder.com/500x300?text=${e.key}",
//               "count": e.value,
//             };
//           }).toList();
//         }
//       }
//     } catch (e) {
//       debugPrint("Category API Error: $e");
//     }

//     if (mounted) setState(() => isLoading = false);
//   }

//   void _onScroll() => setState(() => _scrollOffset = _scrollController.offset);

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final primary = Theme.of(context).primaryColor;

//     if (isLoading) {
//       return Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(color: primary),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Categories',
//                           style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w800,
//                               color: glass.textPrimary),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Explore properties by type',
//                           style: TextStyle(
//                               fontSize: 15, color: glass.textSecondary),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Obx(() => _glassIcon(context,
//                       icon: themeController.isDark.value
//                           ? Icons.light_mode
//                           : Icons.dark_mode,
//                       glass: glass,
//                       primary: primary,
//                       onTap: () => themeController.toggleTheme())),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 controller: _scrollController,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final item = categories[index];
//                   const tileHeight = 160.0;
//                   const spacing = 16.0;
//                   final itemPosition = index * (tileHeight + spacing);
//                   final diff = _scrollOffset - itemPosition;
//                   final parallax = (diff * 0.05).clamp(-20.0, 20.0);

//                   return GestureDetector(
//                     onTap: () {
//                       final slug =
//                           item["name"].toLowerCase().replaceAll(" ", "-");
//                       Get.to(() => CategoryPropertyPage(
//                           categoryName: item["name"], categorySlug: slug));
//                     },
//                     child: _glassCategoryTile(context, item, parallax,
//                         tileHeight, spacing, glass, primary),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _glassCategoryTile(
//   BuildContext context,
//   Map item,
//   double parallax,
//   double tileHeight,
//   double spacing,
//   GlassColors glass,
//   Color primary,
// ) {
//   return _GlassTileWidget(
//     item: item,
//     parallax: parallax,
//     tileHeight: tileHeight,
//     glass: glass,
//     primary: primary,
//   );
// }

// class _GlassTileWidget extends StatefulWidget {
//   final Map item;
//   final double parallax;
//   final double tileHeight;
//   final GlassColors glass;
//   final Color primary;

//   const _GlassTileWidget({
//     required this.item,
//     required this.parallax,
//     required this.tileHeight,
//     required this.glass,
//     required this.primary,
//   });

//   @override
//   State<_GlassTileWidget> createState() => _GlassTileWidgetState();
// }

// class _GlassTileWidgetState extends State<_GlassTileWidget> {
//   double _scale = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _scale = 0.985),
//       onTapUp: (_) => setState(() => _scale = 1.0),
//       onTapCancel: () => setState(() => _scale = 1.0),
//       onTap: () {
//         final slug = widget.item["name"].toLowerCase().replaceAll(" ", "-");
//         Get.to(() => CategoryPropertyPage(
//             categoryName: widget.item["name"], categorySlug: slug));
//       },
//       child: AnimatedScale(
//         scale: _scale,
//         duration: const Duration(milliseconds: 120),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 20),
//               height: widget.tileHeight,
//               decoration: BoxDecoration(
//                 color: widget.glass.cardBackground,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: widget.glass.glassBorder, width: 1.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Theme.of(context).brightness == Brightness.dark
//                         ? Colors.black.withOpacity(0.45)
//                         : widget.primary.withOpacity(0.12),
//                     blurRadius: 18,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 4,
//                     child: Transform.translate(
//                       offset: Offset(0, widget.parallax),
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           bottomLeft: Radius.circular(20),
//                         ),
//                         child: Image.network(
//                           widget.item["image"] ?? "",
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => Container(
//                               color: widget.glass.chipUnselectedStart),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 6,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.item["name"] ?? "",
//                             style: TextStyle(
//                               color: widget.glass.textPrimary,
//                               fontWeight: FontWeight.w800,
//                               fontSize: 18,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             widget.item["subtitle"] ?? "",
//                             style: TextStyle(
//                               color: widget.glass.textSecondary,
//                               fontSize: 13,
//                             ),
//                           ),
//                           const Spacer(),
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 6),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       widget.glass.chipSelectedGradientStart,
//                                       widget.glass.chipSelectedGradientEnd,
//                                     ],
//                                   ),
//                                 ),
//                                 child: Text(
//                                   "View Listings (${widget.item['count'] ?? 0})",
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                               const Spacer(),
//                               Icon(Icons.arrow_forward_ios_rounded,
//                                   size: 16, color: widget.glass.textPrimary),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _glassIcon(BuildContext context,
//     {required IconData icon,
//     required VoidCallback onTap,
//     required GlassColors glass,
//     required Color primary}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           height: 40,
//           width: 40,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: glass.glassBackground,
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Icon(icon, size: 20, color: primary),
//         ),
//       ),
//     ),
//   );
// }

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/pages/Category_list.dart';

import '../theme/app_theme.dart';
import '../controller/theme_controller.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final ThemeController themeController = Get.find<ThemeController>();
  final ScrollController _scrollController = ScrollController();

  bool isLoading = true;
  List allProperties = [];
  List categories = [];
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    fetchPropertyCategories();
    _scrollController.addListener(_onScroll);
  }

  Future<void> fetchPropertyCategories() async {
    try {
      final res = await http.get(Uri.parse(
          "https://apimanager.viskorealestate.com/fetch-all-properties"));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["status"] == true && data["properties"] != null) {
          allProperties = data["properties"];

          final Map<String, int> counts = {};
          for (var p in allProperties) {
            final sub = p["property_subcategory"] ?? "Unknown";
            counts[sub] = (counts[sub] ?? 0) + 1;
          }

          categories = counts.entries.map((e) {
            return {
              "name": e.key,
              "subtitle": "${e.value} listings",
              "image":
                  "https://via.placeholder.com/500x300?text=${e.key.replaceAll(' ', '+')}",
              "count": e.value,
            };
          }).toList();
        }
      }
    } catch (e) {
      debugPrint("Category API Error: $e");
    }

    if (mounted) setState(() => isLoading = false);
  }

  void _onScroll() => setState(() => _scrollOffset = _scrollController.offset);

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;

    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: glass.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Explore properties by type',
                          style: TextStyle(
                            fontSize: 15,
                            color: glass.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => _glassIcon(
                      icon: themeController.isDark.value
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      glass: glass,
                      onTap: themeController.toggleTheme,
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- LIST ----------------
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  const tileHeight = 160.0;
                  const spacing = 16.0;

                  final itemPos = index * (tileHeight + spacing);
                  final diff = _scrollOffset - itemPos;
                  final parallax = (diff * 0.05).clamp(-20.0, 20.0);

                  return _GlassTileWidget(
                    item: item,
                    parallax: parallax,
                    tileHeight: tileHeight,
                    glass: glass,
                    primary: primary,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                               GLASS TILE                                   */
/* -------------------------------------------------------------------------- */

class _GlassTileWidget extends StatefulWidget {
  final Map item;
  final double parallax;
  final double tileHeight;
  final GlassColors glass;
  final Color primary;

  const _GlassTileWidget({
    required this.item,
    required this.parallax,
    required this.tileHeight,
    required this.glass,
    required this.primary,
  });

  @override
  State<_GlassTileWidget> createState() => _GlassTileWidgetState();
}

class _GlassTileWidgetState extends State<_GlassTileWidget> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.985),
      onTapUp: (_) => setState(() => _scale = 1),
      onTapCancel: () => setState(() => _scale = 1),
      onTap: () {
        final slug = widget.item["name"].toLowerCase().replaceAll(" ", "-");
        Get.to(() => CategoryPropertyPage(
              categoryName: widget.item["name"],
              categorySlug: slug,
            ));
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: widget.tileHeight,
              decoration: BoxDecoration(
                color: widget.glass.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: widget.glass.glassBorder),
              ),
              child: Row(
                children: [
                  // IMAGE
                  Expanded(
                    flex: 4,
                    child: Transform.translate(
                      offset: Offset(0, widget.parallax),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20)),
                        child: Image.network(
                          widget.item["image"],
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: widget.glass.chipUnselectedStart,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // CONTENT
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item["name"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: widget.glass.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.item["subtitle"],
                            style: TextStyle(
                              fontSize: 13,
                              color: widget.glass.textSecondary,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      widget.glass.chipSelectedGradientStart,
                                      widget.glass.chipSelectedGradientEnd,
                                    ],
                                  ),
                                ),
                                child: Text(
                                  "View Listings (${widget.item['count']})",
                                  style: TextStyle(
                                    // 🔧 UPDATED – NO Colors.white
                                    color: widget.glass.solidSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: widget.glass.textPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              GLASS ICON                                    */
/* -------------------------------------------------------------------------- */

Widget _glassIcon({
  required IconData icon,
  required VoidCallback onTap,
  required GlassColors glass,
}) {
  return GestureDetector(
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: glass.glassBackground,
            border: Border.all(color: glass.glassBorder),
          ),
          child: Icon(
            icon,
            size: 20,
            color: glass.textPrimary, // 🔧 UPDATED
          ),
        ),
      ),
    ),
  );
}
