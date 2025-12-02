// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../theme/app_theme.dart';
// import '../controller/theme_controller.dart';
// import '../config/colors.dart';
// import 'Category_Property_Page.dart';

// class CategoriesPage extends StatefulWidget {
//   const CategoriesPage({super.key});

//   @override
//   State<CategoriesPage> createState() => _CategoriesPageState();
// }

// class _CategoriesPageState extends State<CategoriesPage> {
//   final ThemeController themeController = Get.find<ThemeController>();

//   final List<Map<String, dynamic>> categories = [
//     {
//       'name': "Residential",
//       'image':
//           "https://images.unsplash.com/photo-1754325899655-5e9b7bf05cdc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
//     },
//     {
//       'name': "Commercial",
//       'image':
//           "https://images.unsplash.com/photo-1656646424501-06d57009b725?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
//     },
//     {
//       'name': "Luxury",
//       'image':
//           "https://plus.unsplash.com/premium_photo-1686090449194-04ac2af9f758?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
//     },
//     {
//       'name': "Plots",
//       'image':
//           "https://cdn.prod.website-files.com/67cbec06b8c5d262aa607982/68021674f65f21e56be38843_banner.jpg"
//     },
//     {
//       'name': "Affordable",
//       'image': "https://images.prop24.com/361464103/Crop600x400"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final isDark = themeController.isDark.value;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Stack(
//         children: [
//           // Background gradient
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: isDark
//                     ? [Colors.black87, Colors.grey.shade900]
//                     : [
//                         kPrimaryOrange.withOpacity(0.8),
//                         const Color(0xFFFFE0B2)
//                       ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     backButton(),
//                     Text(
//                       "Categories",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: glass.textPrimary,
//                       ),
//                     ),
//                     Obx(
//                       () => GestureDetector(
//                         onTap: () => themeController.toggleTheme(),
//                         child: glassButton(
//                           icon: themeController.isDark.value
//                               ? Icons.light_mode_rounded
//                               : Icons.dark_mode_rounded,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),

//                 // Grid Cards
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: categories.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.9,
//                   ),
//                   itemBuilder: (context, index) {
//                     final cat = categories[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(
//                             () => CategoryPropertyPage(category: cat['name']));
//                       },
//                       child: AnimatedContainer(
//                         duration: Duration(milliseconds: 500 + index * 100),
//                         curve: Curves.easeOut,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black26,
//                               blurRadius: 8,
//                               offset: Offset(2, 2),
//                             ),
//                           ],
//                         ),
//                         child: Stack(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: Image.network(
//                                 cat['image'],
//                                 fit: BoxFit.cover,
//                                 width: double.infinity,
//                                 height: double.infinity,
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.black.withOpacity(0.35),
//                                     Colors.transparent,
//                                   ],
//                                   begin: Alignment.bottomCenter,
//                                   end: Alignment.topCenter,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 12,
//                               left: 12,
//                               right: 12,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: BackdropFilter(
//                                   filter:
//                                       ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 8),
//                                     decoration: BoxDecoration(
//                                       color: glass.cardBackground,
//                                       borderRadius: BorderRadius.circular(16),
//                                       border:
//                                           Border.all(color: glass.glassBorder),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         cat['name'],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// GLASS BUTTONS
// Widget backButton() => GestureDetector(
//       onTap: () => Get.back(),
//       child: glassButton(icon: Icons.arrow_back_ios_new_rounded),
//     );

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

// categories_premium_ios.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../controller/theme_controller.dart';
import 'Category_Property_Page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final ThemeController themeController = Get.find<ThemeController>();
  final ScrollController _scrollController = ScrollController();

  // sample categories - replace URLs/names with your real data if needed
  final List<Map<String, String>> _categories = [
    {
      'name': 'Residential',
      'subtitle': 'Homes, apartments & flats',
      'image':
          'https://images.unsplash.com/photo-1754325899655-5e9b7bf05cdc?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'name': 'Commercial',
      'subtitle': 'Offices, retail & warehouses',
      'image':
          'https://images.unsplash.com/photo-1656646424501-06d57009b725?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'name': 'Luxury',
      'subtitle': 'Premium villas & penthouses',
      'image':
          'https://plus.unsplash.com/premium_photo-1686090449194-04ac2af9f758?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'name': 'Plots',
      'subtitle': 'Land & development plots',
      'image':
          'https://cdn.prod.website-files.com/67cbec06b8c5d262aa607982/68021674f65f21e56be38843_banner.jpg'
    },
    {
      'name': 'Affordable',
      'subtitle': 'Budget friendly homes',
      'image': 'https://images.prop24.com/361464103/Crop600x400'
    },
  ];

  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() => _scrollOffset = _scrollController.offset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlassColors glass = Theme.of(context).extension<GlassColors>()!;
    final bool isDark = themeController.isDark.value;
    final accent = Theme.of(context).primaryColor; // accent from existing theme

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            color: glass.textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Explore properties by category',
                          style: TextStyle(
                            color: glass.textSecondary,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => _glassIcon(context,
                      icon: themeController.isDark.value
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      glass: glass,
                      onTap: () => themeController.toggleTheme())),
                ],
              ),
            ),

            // Text(
            //   "Explore Locations",
            //   style: TextStyle(
            //     fontSize: 28,
            //     fontWeight: FontWeight.bold,
            //     color:
            //         themeController.isDark.value ? Colors.white : Colors.black,
            //   ),
            // ),
            // const SizedBox(height: 6),
            // Text(
            //   "Choose your ideal property spot",
            //   style: TextStyle(fontSize: 15, color: Colors.grey),
            // ),
            // const SizedBox(height: 16),

            const SizedBox(height: 8),

            // Chips (to match HomePage look)
            SizedBox(
              height: 40,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                children: [
                  _glassChip('All', glass, selected: true),
                  const SizedBox(width: 10),
                  _glassChip('Residential', glass),
                  const SizedBox(width: 10),
                  _glassChip('Luxury', glass),
                  const SizedBox(width: 10),
                  _glassChip('Commercial', glass),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Tiles list
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final item = _categories[index];
                  final tileHeight = 170.0;
                  final spacing = 14.0;
                  final itemPosition = index * (tileHeight + spacing);
                  final diff = _scrollOffset - itemPosition;
                  final parallax = (diff * 0.06).clamp(-20.0, 20.0);

                  return GestureDetector(
                    onTap: () => Get.to(
                        () => CategoryPropertyPage(category: item['name']!)),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 420),
                      curve: Curves.easeOut,
                      margin: EdgeInsets.only(bottom: spacing),
                      height: tileHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(isDark ? 0.45 : 0.12),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // Row: Left image (40%) | Right content (60%)
                            Row(
                              children: [
                                // Left Image with parallax transform
                                Expanded(
                                  flex: 4,
                                  child: Transform.translate(
                                    offset: Offset(0, parallax),
                                    child: Container(
                                      color: glass.glassBackground,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.network(
                                            item['image']!,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              if (progress == null)
                                                return child;
                                              return Container(
                                                  color: glass.glassBackground);
                                            },
                                            errorBuilder: (_, __, ___) {
                                              return Container(
                                                color: glass.glassBackground,
                                                child: Icon(Icons.broken_image,
                                                    color: glass.textSecondary,
                                                    size: 36),
                                              );
                                            },
                                          ),
                                          // Gradient overlay for better contrast
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withOpacity(
                                                      isDark ? 0.18 : 0.14),
                                                  Colors.black.withOpacity(
                                                      isDark ? 0.28 : 0.12),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Right details area
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Title + small accent
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item['name'] ?? '',
                                                style: TextStyle(
                                                  color: glass.textPrimary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            // Accent circle (uses primaryColor from theme)
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),

                                        // Subtitle
                                        Text(
                                          item['subtitle'] ?? '',
                                          style: TextStyle(
                                            color: glass.textSecondary,
                                            fontSize: 13,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        const Spacer(),

                                        // bottom row: rating pill + listings + glass arrow
                                        Row(
                                          children: [
                                            // rating pill (glass)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color: glass.glassBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: glass.glassBorder),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      size: 14,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    "4.${(index + 6) % 10}",
                                                    style: TextStyle(
                                                      color: glass.textPrimary,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(width: 12),

                                            // listings info
                                            Text(
                                              "${(index + 1) * 14} listings",
                                              style: TextStyle(
                                                  color: glass.textSecondary),
                                            ),

                                            const Spacer(),

                                            // Glass circular arrow button (Style B)
                                            _glassCircleButton(
                                              glass: glass,
                                              onTap: () => Get.to(() =>
                                                  CategoryPropertyPage(
                                                      category: item['name']!)),
                                              icon: Icons
                                                  .arrow_forward_ios_rounded,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // small floating glass label on top-left
                            Positioned(
                              top: 12,
                              left: 12,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: glass.glassBackground,
                                      border:
                                          Border.all(color: glass.glassBorder),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      item['name'] ?? '',
                                      style: TextStyle(
                                        color: glass.textPrimary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}

/// Reusable glass circular icon used in header
Widget _glassIcon(BuildContext context,
    {required IconData icon,
    required VoidCallback onTap,
    required GlassColors glass}) {
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
          child: Icon(icon, size: 20, color: glass.textPrimary),
        ),
      ),
    ),
  );
}

/// Glass chip used for the top filter row
Widget _glassChip(String title, GlassColors glass, {bool selected = false}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
    child: Text(
      title,
      style: TextStyle(
        color: selected ? Colors.white : glass.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Glass circular arrow button (Style B)
Widget _glassCircleButton({
  required GlassColors glass,
  required VoidCallback onTap,
  required IconData icon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: glass.glassBackground,
            border: Border.all(color: glass.glassBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 16, color: glass.textPrimary),
        ),
      ),
    ),
  );
}
