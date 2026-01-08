// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
// import '../controller/theme_controller.dart';
// import '../theme/app_theme.dart';

// class CategoryPropertyPage extends StatefulWidget {
//   final String categoryName;
//   final String categorySlug;

//   const CategoryPropertyPage({
//     super.key,
//     required this.categoryName,
//     required this.categorySlug,
//   });

//   @override
//   State<CategoryPropertyPage> createState() => _CategoryPropertyPageState();
// }

// class _CategoryPropertyPageState extends State<CategoryPropertyPage> {
//   bool loading = true;
//   List properties = [];
//   final ThemeController themeController = Get.find<ThemeController>();

//   @override
//   void initState() {
//     super.initState();
//     fetchCategoryProperties();
//   }

//   Future<void> fetchCategoryProperties() async {
//     final url = Uri.parse(
//         "https://apimanager.viskorealestate.com/fetch-property-category?category_slug=${widget.categorySlug}");

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);

//         setState(() {
//           properties = jsonData["data"] ?? [];
//           loading = false;
//         });
//       } else {
//         setState(() => loading = false);
//       }
//     } catch (e) {
//       print("Category API Error: $e");
//       setState(() => loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = themeController.isDark.value;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
//         title: Text(
//           widget.categoryName,
//           style: TextStyle(
//             color: Theme.of(context).extension<GlassColors>()!.textPrimary,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : properties.isEmpty
//               ? Center(
//                   child: Text(
//                   "No properties found",
//                   style: TextStyle(
//                     color: Theme.of(context)
//                         .extension<GlassColors>()!
//                         .textSecondary,
//                   ),
//                 ))
//               : ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: properties.length,
//                   itemBuilder: (context, index) {
//                     final property = properties[index];

//                     return HomePropertyCard(
//                       isDark: isDark,
//                       property: property,
//                       onTap: () {
//                         Get.to(() => PropertyDetailPage(
//                               slug: property['property_slug'],
//                               property: null,
//                             ));
//                       },
//                       image: null,
//                     );
//                   },
//                 ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/pages/Property_detail_page.dart';
// import '../controller/theme_controller.dart';
// import '../theme/app_theme.dart';

// class CategoryPropertyPage extends StatefulWidget {
//   final String categoryName;
//   final String categorySlug;

//   const CategoryPropertyPage({
//     super.key,
//     required this.categoryName,
//     required this.categorySlug,
//   });

//   @override
//   State<CategoryPropertyPage> createState() => _CategoryPropertyPageState();
// }

// class _CategoryPropertyPageState extends State<CategoryPropertyPage> {
//   bool loading = true;
//   List properties = [];
//   final ThemeController themeController = Get.find<ThemeController>();

//   @override
//   void initState() {
//     super.initState();
//     fetchCategoryProperties();
//   }

//   Future<void> fetchCategoryProperties() async {
//     final url = Uri.parse(
//       "https://apimanager.viskorealestate.com/fetch-property-category?category_slug=${widget.categorySlug}",
//     );

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         setState(() {
//           properties = jsonData["data"] ?? [];
//           loading = false;
//         });
//       } else {
//         loading = false;
//         setState(() {});
//       }
//     } catch (e) {
//       debugPrint("Category API Error: $e");
//       loading = false;
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!; // 🔥 UPDATED
//     final isDark = themeController.isDark.value;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,

//       // ---------------- APP BAR ----------------
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: glass.solidSurface, // 🔥 UPDATED
//         centerTitle: false,
//         title: Text(
//           widget.categoryName,
//           style: TextStyle(
//             color: glass.textPrimary, // 🔥 UPDATED
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         iconTheme: IconThemeData(
//           color: glass.textPrimary, // 🔥 UPDATED
//         ),
//       ),

//       // ---------------- BODY ----------------
//       body: loading
//           ? Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(
//                   glass.chipSelectedGradientStart, // 🔥 UPDATED
//                 ),
//               ),
//             )
//           : properties.isEmpty
//               ? Center(
//                   child: Text(
//                     "No properties found",
//                     style: TextStyle(
//                       color: glass.textSecondary, // 🔥 UPDATED
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               : ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: properties.length,
//                   itemBuilder: (context, index) {
//                     final property = properties[index];

//                     return HomePropertyCard(
//                       isDark: isDark,
//                       property: property,
//                       image: null,
//                       onTap: () {
//                         Get.to(
//                           () => PropertyDetailPage(
//                             slug: property['property_slug'],
//                             property: null,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';

import '../theme/app_theme.dart';

class CategoryPropertyPage extends StatefulWidget {
  final String categoryName;
  final String categorySlug;

  const CategoryPropertyPage({
    super.key,
    required this.categoryName,
    required this.categorySlug,
  });

  @override
  State<CategoryPropertyPage> createState() => _CategoryPropertyPageState();
}

class _CategoryPropertyPageState extends State<CategoryPropertyPage> {
  bool isLoading = true;
  List properties = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryProperties();
  }

  Future<void> fetchCategoryProperties() async {
    try {
      final res = await http.get(Uri.parse(
          "https://apimanager.viskorealestate.com/fetch-all-properties"));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        if (data["status"] == true && data["properties"] != null) {
          properties = data["properties"].where((p) {
            final sub =
                (p["property_subcategory"] ?? "").toString().toLowerCase();
            return sub == widget.categoryName.toLowerCase();
          }).toList();
        }
      }
    } catch (e) {
      debugPrint("Category property error: $e");
    }

    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: glass.solidSurface, // 🔥 UPDATED
        surfaceTintColor: glass.solidSurface, // 🔥 IMPORTANT (Material 3 fix)
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: glass.textPrimary),
        ),
        title: Column(
          children: [
            Text(
              widget.categoryName,
              style: TextStyle(
                color: glass.textPrimary, // 🔥 UPDATED
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.categoryName} ${properties.length} Properties",
                        style: TextStyle(
                          fontSize: 13,
                          color: glass.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ---------------- LIST ----------------
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: primary),
                    )
                  : properties.isEmpty
                      ? Center(
                          child: Text(
                            "No properties found",
                            style: TextStyle(
                              color: glass.textSecondary,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: properties.length,
                          itemBuilder: (context, index) {
                            final property = properties[index];
                            return HomePropertyCard(
                              property: property,
                              isDark: isDark,
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
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              GLASS BACK                                    */
/* -------------------------------------------------------------------------- */

Widget _glassBack(GlassColors glass) {
  return GestureDetector(
    onTap: () => Get.back(),
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
            Icons.arrow_back_ios_new,
            size: 18,
            color: glass.textPrimary,
          ),
        ),
      ),
    ),
  );
}
