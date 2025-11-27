// // import 'dart:ui';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;

// // import 'package:visko_rocky_flutter/component/home_property_card.dart';
// // import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// // import 'package:visko_rocky_flutter/theme/app_theme.dart';

// // class DeveloperProperties extends StatefulWidget {
// //   final String slug;
// //   const DeveloperProperties({required this.slug});

// //   @override
// //   State<DeveloperProperties> createState() => _DeveloperPropertiesState();
// // }

// // class _DeveloperPropertiesState extends State<DeveloperProperties> {
// //   Map<String, dynamic>? developer;
// //   List<dynamic> properties = [];
// //   bool isLoading = true;

// //   final themeController = Get.find<ThemeController>();

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchDeveloperDetails();
// //   }

// //   Future<void> fetchDeveloperDetails() async {
// //     final url =
// //         'https://apimanager.viskorealestate.com/fetch-single-developer?slug=${widget.slug}';
// //     final response = await http.get(Uri.parse(url));

// //     if (response.statusCode == 200) {
// //       final result = jsonDecode(response.body);
// //       if (result['developer'] != null) {
// //         setState(() {
// //           developer = result['developer'];
// //           properties = result['properties'] ?? [];
// //           isLoading = false;
// //         });
// //       } else {
// //         setState(() => isLoading = false);
// //       }
// //     } else {
// //       setState(() => isLoading = false);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final glass = Theme.of(context).extension<GlassColors>()!;

// //     return Scaffold(
// //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// //       body: Stack(
// //         children: [
// //           /// ------------------- HEADER -------------------
// //           Container(
// //             height: MediaQuery.of(context).size.height * 0.26,
// //             decoration: BoxDecoration(
// //               borderRadius: const BorderRadius.only(
// //                 bottomLeft: Radius.circular(18),
// //                 bottomRight: Radius.circular(18),
// //               ),
// //               gradient: LinearGradient(
// //                 colors: [
// //                   glass.cardBackground.withOpacity(0.9),
// //                   glass.cardBackground.withOpacity(0.7),
// //                 ],
// //                 begin: Alignment.topLeft,
// //                 end: Alignment.bottomRight,
// //               ),
// //             ),
// //           ),

// //           SafeArea(
// //             child: isLoading
// //                 ? const Center(child: CircularProgressIndicator())
// //                 : developer == null
// //                     ? const Center(child: Text("Developer not found"))
// //                     : Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 16),
// //                         child: ListView(
// //                           children: [
// //                             const SizedBox(height: 10),

// //                             /// ------------------- TOP BAR -------------------
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 _glassBackButton(glass),
// //                                 Text(
// //                                   developer!['developer_name'] ?? '',
// //                                   style: TextStyle(
// //                                     fontSize: 18,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: glass.textPrimary,
// //                                   ),
// //                                 ),
// //                                 const SizedBox(width: 40),
// //                               ],
// //                             ),

// //                             const SizedBox(height: 18),

// //                             /// ------------------- DEVELOPER HEADER -------------------
// //                             _buildDeveloperHeader(glass),

// //                             const SizedBox(height: 26),

// //                             Text(
// //                               "Properties by ${developer!['developer_name']}",
// //                               style: TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.w700,
// //                                 color: glass.textPrimary,
// //                               ),
// //                             ),

// //                             const SizedBox(height: 14),

// //                             ...properties
// //                                 .map((p) => _buildGlassPropertyCard(p, glass))
// //                                 .toList(),
// //                           ],
// //                         ),
// //                       ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   /// ------------------- BACK BUTTON -------------------
// //   Widget _glassBackButton(GlassColors glass) {
// //     return GestureDetector(
// //       onTap: () => Navigator.pop(context),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(50),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
// //           child: Container(
// //             height: 40,
// //             width: 40,
// //             decoration: BoxDecoration(
// //               color: glass.cardBackground,
// //               shape: BoxShape.circle,
// //               border: Border.all(color: glass.glassBorder),
// //             ),
// //             child: Icon(Icons.arrow_back_rounded, color: glass.textPrimary),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// ------------------- DEVELOPER HEADER -------------------
// //   Widget _buildDeveloperHeader(GlassColors glass) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(20),
// //       child: BackdropFilter(
// //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //         child: Container(
// //           padding: const EdgeInsets.all(16),
// //           decoration: BoxDecoration(
// //             color: glass.cardBackground,
// //             borderRadius: BorderRadius.circular(20),
// //             border: Border.all(color: glass.glassBorder),
// //           ),
// //           child: Row(
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(14),
// //                 child: Image.network(
// //                   developer!['developer_logo'] ?? '',
// //                   height: 95,
// //                   width: 140,
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //               const SizedBox(width: 16),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       developer!['developer_name'],
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                         color: glass.textPrimary,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 6),
// //                     Row(
// //                       children: [
// //                         Icon(
// //                           Icons.location_on,
// //                           size: 16,
// //                           color: kPrimaryOrange,
// //                         ),
// //                         const SizedBox(width: 6),
// //                         Expanded(
// //                           child: Text(
// //                             developer!['developer_city'] ?? '',
// //                             style: TextStyle(color: glass.textSecondary),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 6),
// //                     Text(
// //                       "📞 ${developer!['developer_mobile_number']}",
// //                       style: TextStyle(color: glass.textSecondary),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// ------------------- PROPERTY CARD -------------------
// //   Widget _buildGlassPropertyCard(
// //       Map<String, dynamic> property, GlassColors glass) {
// //     final imageUrl = property['property_images'] != null &&
// //             property['property_images'].isNotEmpty
// //         ? property['property_images'][0]
// //         : 'https://via.placeholder.com/400x200';

// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(18),
// //       child: BackdropFilter(
// //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //         child: Container(
// //           margin: const EdgeInsets.only(bottom: 18),
// //           decoration: BoxDecoration(
// //             color: glass.cardBackground,
// //             borderRadius: BorderRadius.circular(18),
// //             border: Border.all(color: glass.glassBorder),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               /// IMAGE
// //               ClipRRect(
// //                 borderRadius:
// //                     const BorderRadius.vertical(top: Radius.circular(18)),
// //                 child: Image.network(
// //                   imageUrl,
// //                   height: 170,
// //                   width: double.infinity,
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),

// //               /// DETAILS
// //               Padding(
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       property['property_name'] ?? 'No Title',
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         color: glass.textPrimary,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 6),
// //                     Row(
// //                       children: [
// //                         Icon(Icons.location_on,
// //                             size: 14, color: kPrimaryOrange),
// //                         const SizedBox(width: 4),
// //                         Expanded(
// //                           child: Text(
// //                             property['property_city'] ?? '',
// //                             style: TextStyle(
// //                               fontSize: 12,
// //                               color: glass.textSecondary,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 6),
// //                     Row(
// //                       children: [
// //                         Icon(Icons.villa, size: 12, color: kPrimaryOrange),
// //                         const SizedBox(width: 4),
// //                         Text(
// //                           property['property_type'] ?? '',
// //                           style: TextStyle(
// //                             fontSize: 11,
// //                             color: glass.textSecondary,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 14),
// //                         Icon(Icons.category, size: 12, color: kPrimaryOrange),
// //                         const SizedBox(width: 4),
// //                         Text(
// //                           property['property_category'] ?? '',
// //                           style: TextStyle(
// //                             fontSize: 11,
// //                             color: glass.textSecondary,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:ui';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import '../controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

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
//       if (result['developer'] != null) {
//         setState(() {
//           developer = result['developer'];
//           properties = result['properties'] ?? [];
//           isLoading = false;
//         });
//       } else {
//         setState(() => isLoading = false);
//       }
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
//       body: Stack(
//         children: [
//           /// ------------------- GLASS HEADER -------------------
//           Container(
//             height: MediaQuery.of(context).size.height * 0.26,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(18),
//                 bottomRight: Radius.circular(18),
//               ),
//               gradient: LinearGradient(
//                 colors: isDark
//                     ? [Colors.black87, Colors.black54]
//                     : [
//                         kPrimaryOrange.withOpacity(0.7),
//                         Colors.orange.shade200.withOpacity(0.4)
//                       ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),

//           SafeArea(
//             child: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : developer == null
//                     ? const Center(child: Text("Developer not found"))
//                     : Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: ListView(
//                           children: [
//                             const SizedBox(height: 10),

//                             /// ------------------- TOP BAR -------------------
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 _glassBackButton(glass),
//                                 Text(
//                                   developer!['developer_name'] ?? '',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: glass.textPrimary,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 40),
//                               ],
//                             ),

//                             const SizedBox(height: 18),

//                             /// ------------------- DEVELOPER HEADER -------------------
//                             _buildDeveloperHeader(glass),

//                             const SizedBox(height: 26),

//                             Text(
//                               "Properties by ${developer!['developer_name']}",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                                 color: glass.textPrimary,
//                               ),
//                             ),

//                             const SizedBox(height: 14),

//                             ...properties
//                                 .map((p) => _buildGlassPropertyCard(p, glass))
//                                 .toList(),
//                           ],
//                         ),
//                       ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ------------------- BACK BUTTON -------------------
//   Widget _glassBackButton(GlassColors glass) {
//     return GestureDetector(
//       onTap: () => Navigator.pop(context),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(50),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//           child: Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//               color: glass.cardBackground,
//               shape: BoxShape.circle,
//               border: Border.all(color: glass.glassBorder),
//             ),
//             child: Icon(Icons.arrow_back_rounded, color: glass.textPrimary),
//           ),
//         ),
//       ),
//     );
//   }

//   /// ------------------- DEVELOPER HEADER CARD -------------------
//   Widget _buildDeveloperHeader(GlassColors glass) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(14),
//                 child: Image.network(
//                   developer!['developer_logo'] ?? '',
//                   height: 95,
//                   width: 140,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       developer!['developer_name'] ?? '',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: glass.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on,
//                             size: 16, color: kPrimaryOrange),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             developer!['developer_city'] ?? '',
//                             style: TextStyle(color: glass.textSecondary),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       "📞 ${developer!['developer_mobile_number'] ?? ''}",
//                       style: TextStyle(color: glass.textSecondary),
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

//   /// ------------------- PROPERTY CARD -------------------
//   Widget _buildGlassPropertyCard(
//     Map<String, dynamic> property,
//     GlassColors glass,
//   ) {
//     final imageUrl = property['property_images'] != null &&
//             property['property_images'].isNotEmpty
//         ? property['property_images'][0]
//         : 'https://via.placeholder.com/400x200';

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 18),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// IMAGE
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(18),
//                 ),
//                 child: Image.network(
//                   imageUrl,
//                   height: 170,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),

//               /// DETAILS
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       property['property_name'] ?? 'No Title',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: glass.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on,
//                             size: 14, color: kPrimaryOrange),
//                         const SizedBox(width: 4),
//                         Expanded(
//                           child: Text(
//                             property['property_city'] ?? '',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: glass.textSecondary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         Icon(Icons.villa, size: 12, color: kPrimaryOrange),
//                         const SizedBox(width: 4),
//                         Text(
//                           property['property_type'] ?? '',
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: glass.textSecondary,
//                           ),
//                         ),
//                         const SizedBox(width: 14),
//                         Icon(Icons.category, size: 12, color: kPrimaryOrange),
//                         const SizedBox(width: 4),
//                         Text(
//                           property['property_category'] ?? '',
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: glass.textSecondary,
//                           ),
//                         ),
//                       ],
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

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart'
    hide kPrimaryOrange;
import '../controller/theme_controller.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

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

  Future<void> fetchDeveloperDetails() async {
    final url =
        'https://apimanager.viskorealestate.com/fetch-single-developer?slug=${widget.slug}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['developer'] != null) {
        setState(() {
          developer = result['developer'];
          properties = result['properties'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
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
      body: Stack(
        children: [
          /// ------------------- GLASS HEADER -------------------
          Container(
            height: MediaQuery.of(context).size.height * 0.26,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.black87, Colors.black54]
                    : [
                        kPrimaryOrange.withOpacity(0.7),
                        Colors.orange.shade200.withOpacity(0.4)
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : developer == null
                    ? const Center(child: Text("Developer not found"))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView(
                          children: [
                            const SizedBox(height: 10),

                            /// ------------------- TOP BAR -------------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _glassBackButton(glass),
                                Text(
                                  developer!['developer_name'] ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: glass.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 40),
                              ],
                            ),

                            const SizedBox(height: 18),

                            /// ------------------- DEVELOPER HEADER -------------------
                            _buildDeveloperHeader(glass),

                            const SizedBox(height: 26),

                            Text(
                              "Properties by ${developer!['developer_name']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: glass.textPrimary,
                              ),
                            ),

                            const SizedBox(height: 14),

                            /// ------------------- PROPERTY LIST -------------------
                            ...properties.map(
                              (p) => HomePropertyCard(
                                property: p,
                                isDark: isDark,
                                onTap: () {
                                  // Optional: navigate to property detail page
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  /// ------------------- BACK BUTTON -------------------
  Widget _glassBackButton(GlassColors glass) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: glass.cardBackground,
              shape: BoxShape.circle,
              border: Border.all(color: glass.glassBorder),
            ),
            child: Icon(Icons.arrow_back_rounded, color: glass.textPrimary),
          ),
        ),
      ),
    );
  }

  /// ------------------- DEVELOPER HEADER CARD -------------------
  Widget _buildDeveloperHeader(GlassColors glass) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: glass.glassBorder),
                  color: glass.cardBackground,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Image.network(
                      developer!['developer_logo'] ?? '',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              /// DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Developer Name — larger, cleaner
                    Text(
                      developer!['developer_name'] ?? '',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: glass.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// City Row — neat + spacing
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

                    /// Phone — subtle container (same color palette)
                    Container(
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
                            developer!['developer_mobile_number'] ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: glass.textPrimary,
                            ),
                          ),
                        ],
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
