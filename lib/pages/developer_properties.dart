// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart';

// const Color kPrimaryOrange = Color(0xffF26A33);

// class DeveloperProperties extends StatefulWidget {
//   final String slug;
//   const DeveloperProperties({required this.slug});

//   @override
//   State<DeveloperProperties> createState() => _DeveloperPropertiesState();
// }

// class _DeveloperPropertiesState extends State<DeveloperProperties> {
//   Map<String, dynamic>? developer;
//   List<dynamic> properties = [];
//   List<dynamic> filteredProperties = [];
//   bool isLoading = true;
//   final ThemeController themeController = Get.find<ThemeController>();
//   String selectedType = '';
//   String selectedCategory = '';

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
//         filteredProperties = properties;
//         isLoading = false;
//       });
//     } else {
//       setState(() => isLoading = false);
//     }
//   }

//   void filterProperties() {
//     setState(() {
//       filteredProperties = properties.where((p) {
//         final matchesType =
//             selectedType.isEmpty || p['property_type'] == selectedType;
//         final matchesCategory =
//             selectedCategory.isEmpty ||
//             p['property_category'] == selectedCategory;
//         return matchesType && matchesCategory;
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     // Extract unique types and categories
//     final types = properties
//         .map((p) => p['property_type'] ?? 'Unknown')
//         .toSet()
//         .toList();
//     final categories = properties
//         .map((p) => p['property_category'] ?? 'Unknown')
//         .toSet()
//         .toList();

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: isDark
//             ? Colors.black.withOpacity(0.6)
//             : kPrimaryOrange.withOpacity(0.8),
//         title: Text(
//           developer != null ? developer!['developer_name'] : 'Loading...',
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : developer == null
//           ? const Center(child: Text("Developer not found"))
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDeveloperHeader(isDark),
//                   const SizedBox(height: 24),

//                   // ---------------- FILTER CHIPS ----------------
//                   Text(
//                     "Filter by Type",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: isDark ? Colors.white : Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     height: 40,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: types.length,
//                       itemBuilder: (_, index) {
//                         final type = types[index];
//                         return glassChip(
//                           type,
//                           selected: selectedType == type,
//                           isDark: isDark,
//                           onTap: () {
//                             selectedType = selectedType == type ? '' : type;
//                             filterProperties();
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     "Filter by Category",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: isDark ? Colors.white : Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   SizedBox(
//                     height: 40,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: categories.length,
//                       itemBuilder: (_, index) {
//                         final category = categories[index];
//                         return glassChip(
//                           category,
//                           selected: selectedCategory == category,
//                           isDark: isDark,
//                           onTap: () {
//                             selectedCategory = selectedCategory == category
//                                 ? ''
//                                 : category;
//                             filterProperties();
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   Text(
//                     "Properties by ${developer!['developer_name']}",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: isDark ? Colors.white : Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   ...filteredProperties
//                       .map((p) => _buildPropertyCard(p, isDark))
//                       .toList(),
//                 ],
//               ),
//             ),
//     );
//   }

//   // ---------------- GLASS CHIPS ----------------
//   Widget glassChip(
//     String title, {
//     required bool selected,
//     required bool isDark,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 12),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: selected
//                 ? LinearGradient(
//                     colors: [
//                       kPrimaryOrange.withOpacity(0.45),
//                       kPrimaryOrange.withOpacity(0.25),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                 : LinearGradient(
//                     colors: isDark
//                         ? [
//                             Colors.white.withOpacity(0.1),
//                             Colors.white.withOpacity(0.05),
//                           ]
//                         : [
//                             Colors.white.withOpacity(0.7),
//                             Colors.white.withOpacity(0.5),
//                           ],
//                   ),
//             border: Border.all(
//               color: selected
//                   ? Colors.orange.shade800
//                   : isDark
//                   ? Colors.white24
//                   : Colors.orange.shade200,
//             ),
//             boxShadow: selected
//                 ? [
//                     BoxShadow(
//                       color: kPrimaryOrange.withOpacity(0.4),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ]
//                 : [],
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
//           child: Text(
//             title,
//             style: TextStyle(
//               color: selected
//                   ? Colors.white
//                   : isDark
//                   ? Colors.white
//                   : Colors.black87,
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDeveloperHeader(bool isDark) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             gradient: isDark
//                 ? LinearGradient(
//                     colors: [
//                       Colors.white.withOpacity(0.05),
//                       Colors.white.withOpacity(0.1),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                 : LinearGradient(
//                     colors: [
//                       Colors.white.withOpacity(0.7),
//                       Colors.white.withOpacity(0.5),
//                     ],
//                   ),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: isDark ? Colors.white24 : Colors.orange.shade200,
//             ),
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   developer!['developer_logo'] ?? '',
//                   height: 80,
//                   width: 120,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     height: 80,
//                     width: 80,
//                     color: Colors.grey[300],
//                     child: const Icon(Icons.error),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       developer!['developer_name'],
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: isDark ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       "${developer!['developer_city']}, ${developer!['developer_state']}",
//                       style: TextStyle(
//                         color: isDark ? Colors.white70 : Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       "📞 ${developer!['developer_mobile_number']}",
//                       style: TextStyle(
//                         color: isDark ? Colors.white70 : Colors.black87,
//                       ),
//                     ),
//                     Text(
//                       "✉️ ${developer!['developer_email_address']}",
//                       style: TextStyle(
//                         color: isDark ? Colors.white70 : Colors.black87,
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

//   Widget _buildPropertyCard(Map<String, dynamic> property, bool isDark) {
//     final imageUrl =
//         property['property_images'] != null &&
//             property['property_images'].isNotEmpty
//         ? property['property_images'][0]
//         : 'https://via.placeholder.com/400x200';

//     return GestureDetector(
//       onTap: () {
//         Get.to(() => PropertyDetailPage(slug: property['property_slug']));
//       },
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withOpacity(0.08)
//                   : Colors.white.withOpacity(0.6),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isDark ? Colors.white24 : Colors.orange.shade200,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: isDark
//                       ? Colors.black.withOpacity(0.4)
//                       : Colors.orange.withOpacity(0.25),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                   child: Image.network(
//                     imageUrl,
//                     height: 180,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) =>
//                         Container(color: Colors.grey, height: 180),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 12,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         property['property_name'] ?? 'No Title',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: isDark ? Colors.white : Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         property['property_address'] ?? '',
//                         style: TextStyle(
//                           color: isDark ? Colors.white70 : Colors.grey.shade600,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.villa,
//                             size: 18,
//                             color: isDark ? Colors.white70 : kPrimaryOrange,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             property['property_type'] ?? '',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: isDark ? Colors.white70 : Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Icon(
//                             Icons.category,
//                             size: 18,
//                             color: isDark ? Colors.white70 : kPrimaryOrange,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             property['property_category'] ?? '',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: isDark ? Colors.white70 : Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const Color kPrimaryOrange = Color(0xffF26A33);

class DeveloperProperties extends StatefulWidget {
  final String slug;
  const DeveloperProperties({required this.slug});

  @override
  State<DeveloperProperties> createState() => _DeveloperPropertiesState();
}

class _DeveloperPropertiesState extends State<DeveloperProperties> {
  Map<String, dynamic>? developer;
  List<dynamic> properties = [];
  bool isLoading = true;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          /// ------------------- GLASS HEADER -------------------
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        Colors.black.withOpacity(0.6),
                        Colors.grey.shade800.withOpacity(0.4),
                      ]
                    : [
                        kPrimaryOrange.withOpacity(0.65),
                        const Color.fromARGB(
                          255,
                          255,
                          215,
                          173,
                        ).withOpacity(0.35),
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
                            _glassBackButton(isDark, context),
                            Text(
                              developer!['developer_name'] ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// ------------------- DEVELOPER CARD -------------------
                        _buildDeveloperHeader(isDark),

                        const SizedBox(height: 26),

                        Text(
                          "Properties by ${developer!['developer_name']}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 14),

                        ...properties
                            .map((p) => _buildGlassPropertyCard(p, isDark))
                            .toList(),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// ------------------- BACK BUTTON GLASS -------------------
  Widget _glassBackButton(bool isDark, BuildContext context) {
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
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? Colors.white30 : Colors.orange.shade300,
              ),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: isDark ? Colors.white : kPrimaryOrange,
            ),
          ),
        ),
      ),
    );
  }

  /// ------------------- GLASS DEVELOPER HEADER -------------------
  Widget _buildDeveloperHeader(bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.orange.shade200,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  developer!['developer_logo'] ?? '',
                  height: 80,
                  width: 95,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      developer!['developer_name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: kPrimaryOrange,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            developer!['developer_city'] ?? '',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "📞 ${developer!['developer_mobile_number']}",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black87,
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

  /// ------------------- GLASS PROPERTY CARD -------------------
  Widget _buildGlassPropertyCard(Map<String, dynamic> property, bool isDark) {
    final imageUrl =
        property['property_images'] != null &&
            property['property_images'].isNotEmpty
        ? property['property_images'][0]
        : 'https://via.placeholder.com/400x200';

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.orange.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black54
                    : Colors.orange.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: Image.network(
                  imageUrl,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// DETAILS
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property['property_name'] ?? 'No Title',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: kPrimaryOrange,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            property['property_city'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.villa, size: 12, color: kPrimaryOrange),
                        const SizedBox(width: 4),
                        Text(
                          property['property_type'] ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Icon(Icons.category, size: 12, color: kPrimaryOrange),
                        const SizedBox(width: 4),
                        Text(
                          property['property_category'] ?? '',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
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
