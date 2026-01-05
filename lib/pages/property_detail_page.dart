// // property_detail_page.dart
// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:visko_rocky_flutter/component/inquiry_form.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';

// const Color kPrimaryOrange = Color(0xffF26A33);

// class PropertyDetailPage extends StatefulWidget {
//   final String slug;
//   const PropertyDetailPage({required this.slug, super.key});

//   @override
//   _PropertyDetailPageState createState() => _PropertyDetailPageState();
// }

// class _PropertyDetailPageState extends State<PropertyDetailPage>
//     with SingleTickerProviderStateMixin {
//   bool isLoading = true;
//   Map<String, dynamic>? property;
//   int activeIndex = 0;
//   late TabController _tabController;
//   final PageController _pageController = PageController();

//   final ThemeController themeController = Get.find<ThemeController>();

//   @override
//   void initState() {
//     super.initState();
//     fetchPropertyDetails();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   Future<void> fetchPropertyDetails() async {
//     final url =
//         'https://apimanager.viskorealestate.com/fetch-property-full-details?slug=${widget.slug}';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final result = json.decode(response.body);
//         if (result['status'] == true) {
//           setState(() {
//             property = Map<String, dynamic>.from(result['data'] ?? {});
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             isLoading = false;
//             property = null;
//           });
//         }
//       } else {
//         setState(() {
//           isLoading = false;
//           property = null;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         property = null;
//       });
//     }
//   }

//   void openFullScreenImage(String imageUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => FullScreenImageViewer(imageUrl: imageUrl),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = themeController.isDark.value;
//     final media = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : property == null
//               ? const Center(child: Text("Property not found"))
//               : Stack(
//                   children: [
//                     SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // ---------- IMAGE BANNER (Full image banner + glass overlay) ----------
//                           Stack(
//                             children: [
//                               SizedBox(
//                                 height: 340,
//                                 child: GestureDetector(
//                                   onTap: () => openFullScreenImage(
//                                     _getImageAtIndex(activeIndex),
//                                   ),
//                                   child: PageView.builder(
//                                     controller: _pageController,
//                                     itemCount: _imagesLength(),
//                                     onPageChanged: (index) {
//                                       setState(() {
//                                         activeIndex = index;
//                                       });
//                                     },
//                                     itemBuilder: (_, index) {
//                                       final img = _getImageAtIndex(index);
//                                       return Container(
//                                         color: isDark
//                                             ? Colors.black
//                                             : Colors.grey.shade200,
//                                         child: Image.network(
//                                           img,
//                                           width: double.infinity,
//                                           fit: BoxFit.cover,
//                                           loadingBuilder:
//                                               (context, child, progress) {
//                                             if (progress == null) return child;
//                                             return Container(
//                                               color: isDark
//                                                   ? Colors.black
//                                                   : Colors.grey.shade200,
//                                               child: const Center(
//                                                 child:
//                                                     CircularProgressIndicator(),
//                                               ),
//                                             );
//                                           },
//                                           errorBuilder:
//                                               (context, error, stackTrace) {
//                                             return Container(
//                                               color: isDark
//                                                   ? Colors.black
//                                                   : Colors.grey.shade200,
//                                               child: const Center(
//                                                 child: Icon(Icons.broken_image),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),

//                               // subtle dark gradient at bottom for readability
//                               // Positioned(
//                               //   bottom: 0,
//                               //   left: 0,
//                               //   right: 0,
//                               //   child: Container(
//                               //     height: 120,
//                               //     decoration: BoxDecoration(
//                               //       gradient: LinearGradient(
//                               //         begin: Alignment.topCenter,
//                               //         end: Alignment.bottomCenter,
//                               //         colors: [
//                               //           Colors.transparent,
//                               //           (isDark
//                               //                   ? Colors.black.withOpacity(0.55)
//                               //                   : Colors.black.withOpacity(0.28))
//                               //               .withOpacity(1),
//                               //         ],
//                               //       ),
//                               //     ),
//                               //   ),
//                               // ),

//                               // page indicator - centered bottom
//                               Positioned(
//                                 bottom: 18,
//                                 left: 0,
//                                 right: 0,
//                                 child: Center(
//                                   child: AnimatedSmoothIndicator(
//                                     activeIndex: activeIndex,
//                                     count: _imagesLength(),
//                                     effect: ExpandingDotsEffect(
//                                       activeDotColor: kPrimaryOrange,
//                                       dotColor: isDark
//                                           ? Colors.white24
//                                           : Colors.white70,
//                                       dotHeight: 8,
//                                       dotWidth: 8,
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               // Top left / right glass circle buttons
//                               Positioned(
//                                 top: 18,
//                                 left: 14,
//                                 child: glassCircle(
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.arrow_back_ios,
//                                       color:
//                                           isDark ? Colors.white : Colors.black,
//                                     ),
//                                     onPressed: () => Navigator.pop(context),
//                                   ),
//                                   isDark: isDark,
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 18,
//                                 right: 16,
//                                 child: Row(
//                                   children: [
//                                     glassCircle(
//                                       child: IconButton(
//                                         icon: Icon(
//                                           Icons.share,
//                                           color: isDark
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                         onPressed: () {
//                                           // TODO: share
//                                         },
//                                       ),
//                                       isDark: isDark,
//                                     ),
//                                     const SizedBox(width: 8),
//                                     glassCircle(
//                                       child: IconButton(
//                                         icon: Icon(
//                                           Icons.favorite_border,
//                                           color: isDark
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                         onPressed: () {
//                                           // TODO: favorite
//                                         },
//                                       ),
//                                       isDark: isDark,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 12),

//                           // Thumbnails row with subtle glass border
//                           SizedBox(
//                             height: 76,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               itemCount: _imagesLength(),
//                               itemBuilder: (context, index) {
//                                 final imageUrl = _getImageAtIndex(index);
//                                 final isActive = activeIndex == index;
//                                 return GestureDetector(
//                                   onTap: () {
//                                     _pageController.animateToPage(
//                                       index,
//                                       duration:
//                                           const Duration(milliseconds: 300),
//                                       curve: Curves.easeInOut,
//                                     );
//                                   },
//                                   child: AnimatedContainer(
//                                     duration: const Duration(milliseconds: 220),
//                                     margin: const EdgeInsets.symmetric(
//                                       horizontal: 6,
//                                       vertical: 8,
//                                     ),
//                                     padding: const EdgeInsets.all(3),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                         color: isActive
//                                             ? kPrimaryOrange
//                                             : (isDark
//                                                 ? Colors.white12
//                                                 : Colors.transparent),
//                                         width: isActive ? 2 : 1,
//                                       ),
//                                       boxShadow: [
//                                         if (!isDark)
//                                           BoxShadow(
//                                             color: Colors.black12,
//                                             blurRadius: 6,
//                                             offset: Offset(0, 3),
//                                           ),
//                                       ],
//                                       color: isDark
//                                           ? Colors.white24.withOpacity(
//                                               isActive ? 0.04 : 0.02,
//                                             )
//                                           : Colors.white,
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image.network(
//                                         imageUrl,
//                                         width: 64,
//                                         height: 64,
//                                         fit: BoxFit.cover,
//                                         errorBuilder: (_, __, ___) => Container(
//                                           width: 64,
//                                           height: 64,
//                                           color: isDark
//                                               ? Colors.grey[900]
//                                               : Colors.grey[200],
//                                           child: const Icon(Icons.broken_image),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),

//                           const SizedBox(height: 8),

//                           // Tag + basic info row
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Row(
//                               children: [
//                                 _smallTag(
//                                   property?['property_type']?.toString() ?? '',
//                                   isDark: isDark,
//                                 ),
//                                 const Spacer(),
//                                 const Icon(
//                                   Icons.square_foot,
//                                   size: 18,
//                                   color: kPrimaryOrange,
//                                 ),
//                                 const SizedBox(width: 6),
//                                 Text(
//                                   _sqftText(),
//                                   style: TextStyle(
//                                     color: isDark
//                                         ? Colors.white70
//                                         : Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 10),

//                           // Title & address
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   property?['property_name']?.toString() ??
//                                       'No title',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w700,
//                                     color:
//                                         isDark ? Colors.white : Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on,
//                                       size: 14,
//                                       color: isDark
//                                           ? Colors.white70
//                                           : kPrimaryOrange,
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Expanded(
//                                       child: Text(
//                                         property?['property_address']
//                                                 ?.toString() ??
//                                             '',
//                                         style: TextStyle(
//                                           color: isDark
//                                               ? Colors.white70
//                                               : Colors.grey[700],
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 12),

//                           // Tab bar styled to match glass look
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 12.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: isDark
//                                     ? Colors.white.withOpacity(0.02)
//                                     : Colors.white.withOpacity(0.75),
//                                 border: Border.all(
//                                   color: isDark
//                                       ? Colors.white12
//                                       : Colors.grey.shade200,
//                                 ),
//                               ),
//                               child: TabBar(
//                                 controller: _tabController,
//                                 labelColor: kPrimaryOrange,
//                                 unselectedLabelColor:
//                                     isDark ? Colors.white54 : Colors.grey,
//                                 indicatorColor: kPrimaryOrange,
//                                 indicatorWeight: 3,
//                                 tabs: const [
//                                   Tab(text: 'About'),
//                                   Tab(text: 'Gallery'),
//                                   Tab(text: 'Review'),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           SizedBox(
//                             height: 260,
//                             child: TabBarView(
//                               controller: _tabController,
//                               children: [
//                                 // ABOUT
//                                 Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Tag(property!['property_category'] ??
//                                               ''),
//                                           const SizedBox(width: 8),
//                                           Tag(
//                                             property!['property_subcategory'] ??
//                                                 '',
//                                           ),
//                                           const SizedBox(width: 8),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 12),
//                                       Text(
//                                         "Description",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                           color: isDark
//                                               ? Colors.white
//                                               : Colors.black87,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         property?['property_description']
//                                                 ?.toString() ??
//                                             'No description available.',
//                                         style: TextStyle(
//                                           color: isDark
//                                               ? Colors.white70
//                                               : Colors.black87,
//                                         ),
//                                         maxLines: 8,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ],
//                                   ),
//                                 ),

//                                 // GALLERY
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 8.0,
//                                   ),
//                                   child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: _imagesLength(),
//                                     itemBuilder: (context, index) {
//                                       final img = _getImageAtIndex(index);
//                                       return Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: GestureDetector(
//                                           onTap: () => openFullScreenImage(img),
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             child: Image.network(
//                                               img,
//                                               width: 180,
//                                               height: 140,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),

//                                 // REVIEW
//                                 Center(
//                                   child: Text(
//                                     "No reviews available.",
//                                     style: TextStyle(
//                                       color: isDark
//                                           ? Colors.white70
//                                           : Colors.black87,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 12),

//                           // Developer info (glass card)
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Container(
//                               width: double.infinity,
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: isDark
//                                     ? Colors.white.withOpacity(0.03)
//                                     : Colors.white.withOpacity(0.9),
//                                 border: Border.all(
//                                   color: isDark
//                                       ? Colors.white12
//                                       : Colors.grey.shade200,
//                                 ),
//                                 boxShadow: [
//                                   if (!isDark)
//                                     BoxShadow(
//                                       color: Colors.black12,
//                                       blurRadius: 8,
//                                       offset: Offset(0, 4),
//                                     ),
//                                 ],
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Developer",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color:
//                                           isDark ? Colors.white : Colors.black,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor: isDark
//                                             ? Colors.white12
//                                             : Colors.grey.shade200,
//                                         child: Icon(
//                                           Icons.person,
//                                           color: isDark
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           property?['developer_name']
//                                                   ?.toString() ??
//                                               'Unknown',
//                                           style: TextStyle(
//                                             color: isDark
//                                                 ? Colors.white70
//                                                 : Colors.black87,
//                                           ),
//                                         ),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           // view developer
//                                         },
//                                         child: Text(
//                                           "View",
//                                           style:
//                                               TextStyle(color: kPrimaryOrange),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 14),

//                           // Amenities title + chips
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(
//                               "Amenities",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: isDark ? Colors.white : Colors.black87,
//                               ),
//                             ),
//                           ),

//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 12,
//                             ),
//                             child: Wrap(
//                               spacing: 8,
//                               runSpacing: 8,
//                               children: _amenityChips(isDark),
//                             ),
//                           ),

//                           SizedBox(height: 140), // space for bottom booking bar
//                         ],
//                       ),
//                     ),

//                     // BOTTOM BOOKING BAR - glass style (fixed)
//                     Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: SafeArea(
//                         top: false,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12.0,
//                             vertical: 8,
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(14),
//                             child: BackdropFilter(
//                               filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 12,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: isDark
//                                       ? Colors.white.withOpacity(0.04)
//                                       : Colors.white,
//                                   border: Border.all(
//                                     color: isDark
//                                         ? Colors.white12
//                                         : Colors.grey.shade200,
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: isDark
//                                           ? Colors.black.withOpacity(0.6)
//                                           : Colors.black12,
//                                       offset: const Offset(0, -2),
//                                       blurRadius: 8,
//                                     ),
//                                   ],
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         // showDialog(
//                                         //   context: context,
//                                         //   builder: (_) =>
//                                         //       _buildInquiryDialog(isDark),
//                                         // );
//                                         showDialog(
//                                           context: context,
//                                           builder: (_) => InquiryForm(
//                                             isDark: isDark,
//                                             propertySlug: widget.slug,
//                                           ),
//                                         );
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: kPrimaryOrange,
//                                         shape: const StadiumBorder(),
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 20,
//                                           vertical: 12,
//                                         ),
//                                         elevation: 4,
//                                       ),
//                                       child: const Text(
//                                         "INQUIRY",
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }

//   // ----------------------------
//   // Helpers & small widgets
//   // ----------------------------

//   int _imagesLength() {
//     try {
//       final list = property?['property_images'] as List?;
//       return list?.length ?? 0;
//     } catch (_) {
//       return 0;
//     }
//   }

//   String _getImageAtIndex(int idx) {
//     try {
//       final list = property?['property_images'] as List?;
//       if (list == null || list.isEmpty) {
//         return 'https://via.placeholder.com/600x400';
//       }
//       return list[idx % list.length].toString();
//     } catch (_) {
//       return 'https://via.placeholder.com/600x400';
//     }
//   }

//   String _sqftText() {
//     try {
//       final sq = property?['property_sq_ft'];
//       if (sq is List) return '${sq.join(", ")} sqft';
//       if (sq != null) return '$sq sqft';
//       return '- sqft';
//     } catch (_) {
//       return '- sqft';
//     }
//   }

//   String _priceText() {
//     try {
//       final price = property?['property_price'] ?? property?['price'] ?? '';
//       if (price == null || price.toString().isEmpty) return 'Price on request';
//       return price.toString();
//     } catch (_) {
//       return 'Price on request';
//     }
//   }

//   Widget glassCircle({required Widget child, required bool isDark}) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(40),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//         child: Container(
//           padding: const EdgeInsets.all(2),
//           decoration: BoxDecoration(
//             color: isDark
//                 ? Colors.white.withOpacity(0.06)
//                 : Colors.white.withOpacity(0.9),
//             borderRadius: BorderRadius.circular(40),
//             border: Border.all(
//               color: isDark ? Colors.white12 : Colors.grey.shade300,
//             ),
//           ),
//           child: CircleAvatar(
//             radius: 18,
//             backgroundColor: Colors.transparent,
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _smallTag(String title, {required bool isDark}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: isDark
//             ? Colors.white.withOpacity(0.06)
//             : Colors.white.withOpacity(0.9),
//         border: Border.all(
//           color: isDark ? Colors.white12 : Colors.grey.shade200,
//         ),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.villa, size: 14, color: kPrimaryOrange),
//           const SizedBox(width: 6),
//           Text(
//             title,
//             style: TextStyle(
//               color: isDark ? Colors.white70 : Colors.black87,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   IconData getAmenityIcon(String name) {
//     final lower = name.toLowerCase();
//     if (lower.contains("bed")) return Icons.bed;
//     if (lower.contains("bath")) return Icons.bathtub_outlined;
//     if (lower.contains("pool")) return Icons.pool;
//     if (lower.contains("wifi")) return Icons.wifi;
//     if (lower.contains("park") || lower.contains("parking"))
//       return Icons.local_parking;
//     if (lower.contains("gym")) return Icons.fitness_center;
//     if (lower.contains("garden")) return Icons.park;
//     if (lower.contains("pet")) return Icons.pets;
//     if (lower.contains("security")) return Icons.security;
//     if (lower.contains("lift") || lower.contains("elevator"))
//       return Icons.elevator;
//     if (lower.contains("area") ||
//         lower.contains("sqft") ||
//         lower.contains("m²")) return Icons.square_foot;
//     return Icons.check_circle_outline;
//   }

//   List<Widget> _amenityChips(bool isDark) {
//     final List amenities = (property?['property_amenities'] as List?) ?? [];
//     return amenities.map<Widget>((a) {
//       final label = a?.toString() ?? '';
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           color: isDark ? Colors.white12 : Colors.grey.shade100,
//           border: Border.all(
//             color: isDark ? Colors.white12 : Colors.grey.shade200,
//           ),
//           boxShadow: [
//             if (!isDark)
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(0, 3),
//               ),
//           ],
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               getAmenityIcon(label),
//               size: 14,
//               color: isDark ? Colors.white70 : Colors.black87,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isDark ? Colors.white70 : Colors.black87,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       );
//     }).toList();
//   }
// }

// // Tag widget (small chip used in details)
// class Tag extends StatelessWidget {
//   final String label;
//   const Tag(this.label, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Get.find<ThemeController>().isDark.value;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey[200],
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: isDark ? Colors.white12 : Colors.transparent),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.check_circle_outline,
//             size: 15.0,
//             color: isDark ? Colors.white70 : Colors.black54,
//           ),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12.0,
//               color: isDark ? Colors.white70 : Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Full screen image viewer
// class FullScreenImageViewer extends StatelessWidget {
//   final String imageUrl;
//   const FullScreenImageViewer({required this.imageUrl, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Get.find<ThemeController>().isDark.value;
//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       appBar: AppBar(
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
//         elevation: 0,
//       ),
//       body: Center(
//         child: InteractiveViewer(
//           child: Image.network(imageUrl, fit: BoxFit.contain),
//         ),
//       ),
//     );
//   }
// }

// this is my  property_detail_page.dart
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';
import 'package:visko_rocky_flutter/controller/theme_controller.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_filex/open_filex.dart';

class PropertyDetailPage extends StatefulWidget {
  final String slug;
  const PropertyDetailPage({required this.slug, super.key, required property});

  @override
  _PropertyDetailPageState createState() => _PropertyDetailPageState();
}

Future<void> downloadAndOpenPDF(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/property_brochure.pdf');

      await file.writeAsBytes(bytes, flush: true);

      // Open the PDF
      await OpenFilex.open(file.path);
    } else {
      Get.snackbar(
        "Download Failed",
        "Could not download brochure",
        // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
        colorText: Colors.white,
      );
    }
  } catch (e) {
    Get.snackbar(
      "Error",
      "Something went wrong: $e",
      // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
      colorText: Colors.white,
    );
  }
}

class _PropertyDetailPageState extends State<PropertyDetailPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  Map<String, dynamic>? property;
  int activeIndex = 0;
  late TabController _tabController;
  final PageController _pageController = PageController();
  final ThemeController themeController = Get.find<ThemeController>();

  GlassColors get glassColors => Theme.of(context).extension<GlassColors>()!;

  @override
  void initState() {
    super.initState();
    fetchPropertyDetails();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> fetchPropertyDetails() async {
    final url =
        'https://apimanager.viskorealestate.com/fetch-property-full-details?slug=${widget.slug}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == true) {
          setState(() {
            property = Map<String, dynamic>.from(result['data'] ?? {});
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            property = null;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          property = null;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        property = null;
      });
    }
  }

  void openFullScreenImage(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImageViewer(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDark.value;
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : property == null
              ? const Center(child: Text("Property not found"))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IMAGE BANNER
                          Stack(
                            children: [
                              SizedBox(
                                height: 480,
                                child: GestureDetector(
                                  onTap: () => openFullScreenImage(
                                      _getImageAtIndex(activeIndex)),
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: _imagesLength(),
                                    onPageChanged: (index) {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                    },
                                    itemBuilder: (_, index) {
                                      final img = _getImageAtIndex(index);
                                      return Container(
                                        color: glassColors.cardBackground,
                                        child: Image.network(
                                          img,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (context, child, progress) {
                                            if (progress == null) return child;
                                            return Container(
                                              color: glassColors.cardBackground,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: glassColors.cardBackground,
                                              child: const Center(
                                                child: Icon(Icons.broken_image),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              // Page indicator
                              Positioned(
                                bottom: 18,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: AnimatedSmoothIndicator(
                                    activeIndex: activeIndex,
                                    count: _imagesLength(),
                                    effect: ExpandingDotsEffect(
                                      activeDotColor:
                                          Theme.of(context).primaryColor,
                                      dotColor: glassColors.textSecondary,
                                      dotHeight: 8,
                                      dotWidth: 8,
                                    ),
                                  ),
                                ),
                              ),

                              // Back & action buttons

                              Positioned(
                                top: 40,
                                left: 14,
                                child: _glassCircleIcon(
                                  icon: Icons.arrow_back_ios_new,
                                  tooltip: 'Back',
                                  onTap: () => Navigator.pop(context),
                                ),
                              ),

                              Positioned(
                                top: 40,
                                right: 16,
                                child: Row(
                                  children: [
                                    _glassCircleIcon(
                                      icon: Icons.share,
                                      tooltip: 'Share',
                                      onTap: () {
                                        final title =
                                            property?['title'] ?? 'Property';
                                        final link = property?['url'] ??
                                            'https://visko-realestate.com';

                                        Share.share(
                                          'Check this property: $title\n\n$link',
                                          subject: 'VISKO Property Share',
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    _glassCircleIcon(
                                      icon: Icons.favorite_border,
                                      tooltip: 'Wishlist',
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Thumbnails
                          SizedBox(
                            height: 76,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              itemCount: _imagesLength(),
                              itemBuilder: (context, index) {
                                final imageUrl = _getImageAtIndex(index);
                                final isActive = activeIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                    _pageController.animateToPage(
                                      index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 220),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 8),
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isActive
                                            ? Theme.of(context).primaryColor
                                            : glassColors.glassBorder,
                                        width: isActive ? 2 : 1,
                                      ),
                                      color: glassColors.cardBackground,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        imageUrl,
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          width: 64,
                                          height: 64,
                                          color: glassColors.cardBackground,
                                          child: const Icon(Icons.broken_image),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Tag + sqft
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                _smallTag(
                                    property?['property_type']?.toString() ??
                                        ''),
                                const Spacer(),
                                const Icon(Icons.square_foot,
                                    size: 18, color: kPrimaryOrange),
                                const SizedBox(width: 6),
                                Text(_sqftText(),
                                    style: TextStyle(
                                        color: glassColors.textSecondary)),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Title & address
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property?['property_name']?.toString() ??
                                      'No title',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: glassColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        size: 14,
                                        color: Theme.of(context).primaryColor),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        property?['property_address']
                                                ?.toString() ??
                                            '',
                                        style: TextStyle(
                                            color: glassColors.textSecondary,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Tab bar
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: glassColors.cardBackground,
                                border:
                                    Border.all(color: glassColors.glassBorder),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: glassColors.textSecondary,
                                indicatorColor: Theme.of(context).primaryColor,
                                indicatorWeight: 3,
                                tabs: const [
                                  Tab(text: 'About'),
                                  Tab(text: 'Gallery'),
                                  Tab(text: 'View Map'),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 260,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                // ABOUT
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Tag(property!['property_category'] ??
                                              ''),
                                          const SizedBox(width: 8),
                                          Tag(property![
                                                  'property_subcategory'] ??
                                              ''),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Description",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: glassColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        property?['property_description']
                                                ?.toString() ??
                                            'No description available.',
                                        style: TextStyle(
                                            color: glassColors.textSecondary),
                                        maxLines: 8,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),

                                // GALLERY
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _imagesLength(),
                                    itemBuilder: (context, index) {
                                      final img = _getImageAtIndex(index);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () => openFullScreenImage(img),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              img,
                                              width: 180,
                                              height: 140,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // REVIEW
                                Center(
                                  child: Text(
                                    "No Map available.",
                                    style: TextStyle(
                                        color: glassColors.textSecondary),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Developer info
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: glassColors.cardBackground,
                                border:
                                    Border.all(color: glassColors.glassBorder),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Developer",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: glassColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            glassColors.cardBackground,
                                        child: Icon(Icons.person,
                                            color: glassColors.textPrimary),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          property?['developer_name']
                                                  ?.toString() ??
                                              'Unknown',
                                          style: TextStyle(
                                              color: glassColors.textSecondary),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text("View",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Amenities
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Amenities",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: glassColors.textPrimary),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _amenityChips(),
                            ),
                          ),

                          // FLOOR PLAN SECTION
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading
                                Text(
                                  "Floor Plans",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: glassColors
                                        .textPrimary, // uses your theme
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // List of floor plans
                                Column(
                                  children: (property?['property_floor_plan']
                                              as List<dynamic>? ??
                                          [])
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    final index = entry.key;
                                    final url = entry.value.toString();
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      color: glassColors
                                          .chipUnselectedStart, // theme color

                                      margin: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      elevation: 2,
                                      child: ExpansionTile(
                                        iconColor: Theme.of(context)
                                            .primaryColor, // arrow color
                                        collapsedIconColor:
                                            Theme.of(context).primaryColor,
                                        title: Text(
                                          "Map ${index + 1}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: glassColors
                                                .textPrimary, // theme color
                                          ),
                                        ),
                                        childrenPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 2),
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        FullScreenImageViewer(
                                                            imageUrl: url)),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                url,
                                                width: double.infinity,
                                                height: 180,
                                                fit: BoxFit.cover,
                                                loadingBuilder:
                                                    (context, child, progress) {
                                                  if (progress == null)
                                                    return child;
                                                  return Container(
                                                    height: 180,
                                                    color: glassColors
                                                        .chipUnselectedStart,
                                                    child: const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                  );
                                                },
                                                errorBuilder: (_, __, ___) =>
                                                    Container(
                                                  height: 180,
                                                  color: glassColors
                                                      .cardBackground,
                                                  child: const Center(
                                                      child: Icon(
                                                          Icons.broken_image)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),

                          // BROCHURE SECTION
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 16.0, vertical: 12),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         "Brochure",
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 16,
                          //           color: glassColors.textPrimary,
                          //         ),
                          //       ),
                          //       const SizedBox(height: 8),

                          //       // Brochure Card / Button
                          //       GestureDetector(
                          //         onTap: () async {
                          //           final url = property?['property_brochure']
                          //               ?.toString();
                          //           if (url == null || url.isEmpty) {
                          //             Get.snackbar(
                          //               "No Brochure",
                          //               "Brochure not available for this property",
                          //               backgroundColor: Theme.of(context)
                          //                   .primaryColor
                          //                   .withOpacity(0.9),
                          //               colorText: Colors.white,
                          //             );
                          //             return;
                          //           }

                          //           // Download the PDF
                          //           await downloadAndOpenPDF(url);
                          //         },
                          //         child: Card(
                          //           color: glassColors.cardBackground,
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(12)),
                          //           elevation: 2,
                          //           child: Padding(
                          //             padding: const EdgeInsets.symmetric(
                          //                 horizontal: 16, vertical: 12),
                          //             child: Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.picture_as_pdf,
                          //                   size: 28,
                          //                   color:
                          //                       Theme.of(context).primaryColor,
                          //                 ),
                          //                 const SizedBox(width: 12),
                          //                 Expanded(
                          //                   child: Text(
                          //                     "Download Brochure",
                          //                     style: TextStyle(
                          //                         fontSize: 14,
                          //                         fontWeight: FontWeight.w600,
                          //                         color:
                          //                             glassColors.textPrimary),
                          //                   ),
                          //                 ),
                          //                 Icon(
                          //                   Icons.download,
                          //                   color:
                          //                       Theme.of(context).primaryColor,
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // PREMIUM BROCHURE SECTION
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Brochure",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: glassColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Premium Card
                                GestureDetector(
                                  onTap: () async {
                                    final url = property?['property_brochure']
                                        ?.toString();
                                    if (url == null || url.isEmpty) {
                                      Get.snackbar(
                                        "No Brochure",
                                        "Brochure not available for this property",
                                        backgroundColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.9),
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }
                                    await downloadAndOpenPDF(url);
                                  },
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      bool isPressed = false;
                                      return Listener(
                                        onPointerDown: (_) =>
                                            setState(() => isPressed = true),
                                        onPointerUp: (_) =>
                                            setState(() => isPressed = false),
                                        child: AnimatedScale(
                                          duration:
                                              const Duration(milliseconds: 150),
                                          scale: isPressed ? 0.97 : 1.0,
                                          curve: Curves.easeOutBack,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 15, sigmaY: 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: glassColors
                                                      .glassBackground
                                                      .withOpacity(0.85),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: glassColors
                                                          .glassBorder,
                                                      width: 1.2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.15),
                                                      blurRadius: 20,
                                                      offset:
                                                          const Offset(0, 6),
                                                    )
                                                  ],
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 16),
                                                child: Row(
                                                  children: [
                                                    // PDF Icon
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.15),
                                                      ),
                                                      child: Icon(
                                                        Icons.picture_as_pdf,
                                                        size: 28,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),

                                                    const SizedBox(width: 16),

                                                    // Title
                                                    Expanded(
                                                      child: Text(
                                                        "Download Brochure",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: glassColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                    ),

                                                    // Download arrow
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.15),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.download,
                                                        color: Theme.of(context)
                                                            .primaryColor,
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

                          const SizedBox(height: 140), // bottom bar space
                        ],
                      ),
                    ),

                    // BOTTOM BOOKING BAR
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: glassColors.glassBackground,
                                  border: Border.all(
                                      color: glassColors.glassBorder),
                                ),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => InquiryForm(
                                            isDark: isDark,
                                            propertySlug: widget.slug,
                                            propertyName: null,
                                            propertyData: null,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        shape: const StadiumBorder(),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 12),
                                      ),
                                      child: const Text("INQUIRY",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  // ----------------- HELPERS -----------------
  int _imagesLength() {
    try {
      final list = property?['property_images'] as List?;
      return list?.length ?? 0;
    } catch (_) {
      return 0;
    }
  }

  String _getImageAtIndex(int idx) {
    try {
      final list = property?['property_images'] as List?;
      if (list == null || list.isEmpty)
        return 'https://via.placeholder.com/600x400';
      return list[idx % list.length].toString();
    } catch (_) {
      return 'https://via.placeholder.com/600x400';
    }
  }

  String _sqftText() {
    try {
      final sq = property?['property_sq_ft'];
      if (sq is List) return '${sq.join(", ")} sqft';
      if (sq != null) return '$sq sqft';
      return '- sqft';
    } catch (_) {
      return '- sqft';
    }
  }

  Widget _glassCircleIcon({
    required IconData icon,
    String? tooltip,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip ?? '',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: 36,
              width: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: glassColors.glassBackground,
                shape: BoxShape.circle,
                border: Border.all(
                  color: glassColors.glassBorder,
                ),
              ),
              child: Icon(
                icon,
                size: 18,
                color: glassColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget glassButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final glass = Theme.of(Get.context!).extension<GlassColors>()!;

    return StatefulBuilder(
      builder: (context, setState) {
        bool isPressed = false;

        return Listener(
          onPointerDown: (_) => setState(() => isPressed = true),
          onPointerUp: (_) => setState(() => isPressed = false),
          child: AnimatedScale(
            scale: isPressed ? 0.88 : 1.0,
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutBack,
            child: GestureDetector(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: glass.glassBackground.withOpacity(0.55),
                      border: Border.all(
                        color: glass.glassBorder
                            .withOpacity(isPressed ? 0.9 : 0.6),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(Get.context!)
                              .primaryColor
                              .withOpacity(isPressed ? 0.25 : 0.15),
                          blurRadius: isPressed ? 16 : 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Theme.of(Get.context!).primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _smallTag(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: glassColors.cardBackground,
        border: Border.all(color: glassColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.villa, size: 14, color: Theme.of(context).primaryColor),
          const SizedBox(width: 6),
          Text(title,
              style: TextStyle(color: glassColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  IconData getAmenityIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains("bed")) return Icons.bed;
    if (lower.contains("bath")) return Icons.bathtub_outlined;
    if (lower.contains("pool")) return Icons.pool;
    if (lower.contains("wifi")) return Icons.wifi;
    if (lower.contains("park") || lower.contains("parking"))
      return Icons.local_parking;
    if (lower.contains("gym")) return Icons.fitness_center;
    if (lower.contains("garden")) return Icons.park;
    if (lower.contains("pet")) return Icons.pets;
    if (lower.contains("security")) return Icons.security;
    if (lower.contains("lift") || lower.contains("elevator"))
      return Icons.elevator;
    if (lower.contains("area") ||
        lower.contains("sqft") ||
        lower.contains("m²")) return Icons.square_foot;
    return Icons.check_circle_outline;
  }

  List<Widget> _amenityChips() {
    final List amenities = (property?['property_amenities'] as List?) ?? [];
    return amenities.map<Widget>((a) {
      final label = a?.toString() ?? '';
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: glassColors.cardBackground,
          border: Border.all(color: glassColors.glassBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(getAmenityIcon(label),
                size: 14, color: glassColors.textSecondary),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    color: glassColors.textSecondary,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      );
    }).toList();
  }
}

// Tag widget (small chip used in details)
class Tag extends StatelessWidget {
  final String label;
  const Tag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final glassColors = Theme.of(context).extension<GlassColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: glassColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: glassColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 15.0,
            color: glassColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: glassColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// Full screen image viewer
class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;
  const FullScreenImageViewer({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final glassColors = Theme.of(context).extension<GlassColors>()!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: glassColors.textPrimary),
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class FloorPlanPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const FloorPlanPage({required this.property, super.key});

  @override
  _FloorPlanPageState createState() => _FloorPlanPageState();
}

class _FloorPlanPageState extends State<FloorPlanPage> {
  int activeIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final glassColors = Theme.of(context).extension<GlassColors>()!;
    final List<dynamic> floorPlans =
        widget.property['property_floor_plan'] ?? [];

    if (floorPlans.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Floor Plan")),
        body: const Center(child: Text("No floor plans available.")),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: glassColors.textPrimary),
        elevation: 0,
        title: const Text("Floor Plan"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: floorPlans.length,
              onPageChanged: (index) => setState(() => activeIndex = index),
              itemBuilder: (context, index) {
                final img = floorPlans[index].toString();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenImageViewer(imageUrl: img),
                      ),
                    );
                  },
                  child: Container(
                    color: glassColors.cardBackground,
                    child: Image.network(
                      img,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (_, __, ___) =>
                          const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                );
              },
            ),
          ),

          // Page indicator
          if (floorPlans.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: floorPlans.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: glassColors.textSecondary,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


// and i want to added init 1. (view flow plan) 2. (view on map)  