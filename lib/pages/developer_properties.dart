// import 'dart:ui';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart' show CupertinoNavigationBarBackButton;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
// import '../controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import 'package:visko_rocky_flutter/config/colors.dart';

// class DeveloperProperties extends StatefulWidget {
//   final String slug;
//   const DeveloperProperties({required this.slug, super.key});

//   @override
//   State<DeveloperProperties> createState() => _DeveloperPropertiesState();
// }

// class _DeveloperPropertiesState extends State<DeveloperProperties> {
//   Map<String, dynamic>? developer;
//   List<dynamic> properties = [];
//   bool isLoading = true;

//   final themeController = Get.find<ThemeController>();

//   @override
//   void initState() {
//     super.initState();
//     fetchDeveloperDetails();
//   }

//   Future<void> fetchDeveloperDetails() async {
//     final url =
//         'https://apimanager.viskorealestate.com/fetch-single-developer?slug=${widget.slug}';
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final result = jsonDecode(response.body);
//       setState(() {
//         developer = result['developer'];
//         properties = result['properties'] ?? [];
//         isLoading = false;
//       });
//     } else {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final isDark = themeController.isDark.value;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : developer == null
//               ? Center(
//                   child: Text(
//                     "Developer not found",
//                     style: TextStyle(color: glass.textSecondary),
//                   ),
//                 )
//               : CustomScrollView(
//                   slivers: [
//                     /// ---------------- APP BAR ----------------
//                     SliverAppBar(
//                       pinned: true,
//                       elevation: 0,
//                       backgroundColor: glass.solidSurface,
//                       surfaceTintColor: glass.solidSurface,
//                       leading: CupertinoNavigationBarBackButton(
//                         color: glass.textPrimary,
//                       ),
//                       centerTitle: true,
//                       title: Text(
//                         developer!['developer_name'],
//                         style: TextStyle(
//                           color: glass.textPrimary,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),

//                     /// ---------------- DEVELOPER CARD (STACKED) ----------------
//                     SliverPersistentHeader(
//                       pinned: true,
//                       delegate: _StickyTitleDelegate(
//                         height: 180,
//                         child: Container(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
//                           child: _buildDeveloperHeader(glass),
//                         ),
//                       ),
//                     ),

//                     /// ---------------- TITLE STICKY ----------------
//                     SliverPersistentHeader(
//                       pinned: true,
//                       delegate: _StickyTitleDelegate(
//                         height: 56,
//                         child: Container(
//                           color: Theme.of(context).scaffoldBackgroundColor,
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Properties by ${developer!['developer_name']}",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700,
//                               color: glass.textPrimary,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     /// ---------------- PROPERTY LIST ----------------
//                     SliverPadding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       sliver: SliverList(
//                         delegate: SliverChildBuilderDelegate(
//                           (context, index) {
//                             final p = properties[index];
//                             return HomePropertyCard(
//                               property: p,
//                               isDark: isDark,
//                               image: null,
//                               onTap: () {
//                                 Get.to(
//                                   () => PropertyDetailPage(
//                                     slug: p['property_slug'],
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           childCount: properties.length,
//                         ),
//                       ),
//                     ),

//                     const SliverToBoxAdapter(
//                       child: SizedBox(height: 24),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   /// ---------------- DEVELOPER HEADER ----------------
//   Widget _buildDeveloperHeader(GlassColors glass) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(22),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(22),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: 120,
//                 width: 160,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: glass.glassBorder),
//                   color: glass.glassBackground,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.network(
//                     developer!['developer_logo'] ?? '',
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 14),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       developer!['developer_name'],
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w700,
//                         color: glass.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on,
//                             size: 16, color: kPrimaryOrange),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             developer!['developer_city'] ?? '',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: glass.textSecondary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 6),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: glass.glassBorder),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.phone, size: 14, color: kPrimaryOrange),
//                           const SizedBox(width: 6),
//                           Text(
//                             "+91 9238154587",
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: glass.textPrimary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ---------------- STICKY TITLE DELEGATE ----------------
// class _StickyTitleDelegate extends SliverPersistentHeaderDelegate {
//   final double height;
//   final Widget child;

//   _StickyTitleDelegate({required this.height, required this.child});

//   @override
//   double get minExtent => height;

//   @override
//   double get maxExtent => height;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   bool shouldRebuild(covariant _StickyTitleDelegate oldDelegate) => false;
// }

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/cupertino.dart' show CupertinoNavigationBarBackButton;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart'; // ✅ ADDED

import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
import '../controller/theme_controller.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'package:visko_rocky_flutter/config/colors.dart';

class DeveloperProperties extends StatefulWidget {
  final String slug;
  const DeveloperProperties({required this.slug, super.key});

  @override
  State<DeveloperProperties> createState() => _DeveloperPropertiesState();
}

class _DeveloperPropertiesState extends State<DeveloperProperties> {
  Map<String, dynamic>? developer;
  List<dynamic> properties = [];
  bool isLoading = true;

  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    fetchDeveloperDetails();
  }

  /// 📞 OPEN DIAL PAD
  Future<void> _callDeveloper(String phone) async {
    final cleanPhone = phone.replaceAll(' ', '');
    final Uri uri = Uri.parse('tel:$cleanPhone');

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open dialer")),
      );
    }
  }

  Future<void> fetchDeveloperDetails() async {
    final url =
        'https://apimanager.viskorealestate.com/fetch-single-developer?slug=${widget.slug}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      setState(() {
        developer = result['developer'];
        properties = result['properties'] ?? [];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final isDark = themeController.isDark.value;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : developer == null
              ? Center(
                  child: Text(
                    "Developer not found",
                    style: TextStyle(color: glass.textSecondary),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    /// ---------------- APP BAR ----------------
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      backgroundColor: glass.solidSurface,
                      surfaceTintColor: glass.solidSurface,
                      leading: CupertinoNavigationBarBackButton(
                        color: glass.textPrimary,
                      ),
                      centerTitle: true,
                      title: Text(
                        developer!['developer_name'],
                        style: TextStyle(
                          color: glass.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ),

                    /// ---------------- DEVELOPER HEADER ----------------
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _StickyTitleDelegate(
                        height: 180,
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
                          child: _buildDeveloperHeader(glass),
                        ),
                      ),
                    ),

                    /// ---------------- TITLE ----------------
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _StickyTitleDelegate(
                        height: 56,
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Properties by ${developer!['developer_name']}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: glass.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// ---------------- PROPERTY LIST ----------------
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final p = properties[index];
                            return HomePropertyCard(
                              property: p,
                              isDark: isDark,
                              image: null,
                              onTap: () {
                                Get.to(
                                  () => PropertyDetailPage(
                                    slug: p['property_slug'],
                                  ),
                                );
                              },
                            );
                          },
                          childCount: properties.length,
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 24),
                    ),
                  ],
                ),
    );
  }

  /// ---------------- DEVELOPER HEADER ----------------
  Widget _buildDeveloperHeader(GlassColors glass) {
    final phone = developer!['919238154587'] ?? "+919238154587";

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: glass.glassBorder),
          ),
          child: Row(
            children: [
              Container(
                height: 120,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: glass.glassBorder),
                  color: glass.glassBackground,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    developer!['developer_logo'] ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      developer!['developer_name'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: glass.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: kPrimaryOrange),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            developer!['developer_city'] ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: glass.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// 📞 TAP TO CALL
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _callDeveloper(phone),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: glass.glassBorder),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone, size: 14, color: kPrimaryOrange),
                            const SizedBox(width: 6),
                            Text(
                              phone,
                              style: TextStyle(
                                fontSize: 13,
                                color: glass.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- STICKY TITLE DELEGATE ----------------
class _StickyTitleDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _StickyTitleDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _StickyTitleDelegate oldDelegate) => false;
}
