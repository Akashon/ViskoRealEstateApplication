// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:visko_rocky_flutter/component/inquiry_form.dart';

// // const Color kPrimaryOrange = Color(0xffF26A33);

// // class HomePropertyCard extends StatefulWidget {
// //   final Map property;
// //   final bool isDark;
// //   final VoidCallback onTap;

// //   const HomePropertyCard({
// //     super.key,
// //     required this.property,
// //     required this.isDark,
// //     required this.onTap,
// //   });

// //   @override
// //   State<HomePropertyCard> createState() => _HomePropertyCardState();
// // }

// // class _HomePropertyCardState extends State<HomePropertyCard> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: widget.onTap,
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(20),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //           child: Container(
// //             margin: const EdgeInsets.only(bottom: 20),
// //             decoration: BoxDecoration(
// //               color: widget.isDark
// //                   ? Colors.white.withOpacity(0.1)
// //                   : Colors.white.withOpacity(0.6),
// //               borderRadius: BorderRadius.circular(20),
// //               border: Border.all(
// //                 color: widget.isDark ? Colors.white24 : Colors.orange.shade100,
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: widget.isDark
// //                       ? Colors.black54
// //                       : kPrimaryOrange.withOpacity(0.35),
// //                   blurRadius: 12,
// //                   offset: const Offset(0, 4),
// //                 ),
// //               ],
// //             ),
// //             padding: const EdgeInsets.all(12),
// //             child: Column(
// //               children: [
// //                 Row(
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(10),
// //                       child: Image.network(
// //                         widget.property['property_images'] != null &&
// //                                 widget.property['property_images'].isNotEmpty
// //                             ? widget.property['property_images'][0]
// //                             : "https://via.placeholder.com/150",
// //                         width: 110,
// //                         height: 95,
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),

// //                     const SizedBox(width: 12),

// //                     /// INFO SECTION
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Row(
// //                             children: [
// //                               Expanded(
// //                                 child: Text(
// //                                   widget.property['property_name'] ??
// //                                       'No Title',
// //                                   maxLines: 1,
// //                                   overflow: TextOverflow.ellipsis,
// //                                   style: TextStyle(
// //                                     fontSize: 18,
// //                                     fontWeight: FontWeight.bold,
// //                                     color: widget.isDark
// //                                         ? Colors.white
// //                                         : Colors.black87,
// //                                   ),
// //                                 ),
// //                               ),
// //                               _glassIconSmall(
// //                                 widget.isDark,
// //                                 Icons.arrow_outward_rounded,
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 6),
// //                           Row(
// //                             children: [
// //                               const Icon(
// //                                 Icons.location_on,
// //                                 size: 14,
// //                                 color: kPrimaryOrange,
// //                               ),
// //                               const SizedBox(width: 4),
// //                               Expanded(
// //                                 child: Text(
// //                                   widget.property['property_city'] ?? 'Unknown',
// //                                   maxLines: 1,
// //                                   overflow: TextOverflow.ellipsis,
// //                                   style: TextStyle(
// //                                     fontSize: 14,
// //                                     color: widget.isDark
// //                                         ? Colors.white70
// //                                         : Colors.black54,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 6),
// //                           Row(
// //                             children: [
// //                               const Icon(
// //                                 Icons.square_foot,
// //                                 size: 16,
// //                                 color: kPrimaryOrange,
// //                               ),
// //                               const SizedBox(width: 4),
// //                               Text(
// //                                 "${(widget.property['property_sq_ft'] as List).join(', ')} sqft",
// //                                 style: TextStyle(
// //                                   fontSize: 14,
// //                                   color: widget.isDark
// //                                       ? Colors.white70
// //                                       : Colors.black54,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 6),
// //                           Row(
// //                             children: [
// //                               const Icon(
// //                                 Icons.villa,
// //                                 size: 14,
// //                                 color: kPrimaryOrange,
// //                               ),
// //                               const SizedBox(width: 4),
// //                               Text(
// //                                 widget.property['property_type'] ?? '',
// //                                 style: TextStyle(
// //                                   fontSize: 12,
// //                                   color: widget.isDark
// //                                       ? Colors.white70
// //                                       : Colors.black54,
// //                                 ),
// //                               ),
// //                               const SizedBox(width: 12),
// //                               const Icon(
// //                                 Icons.category,
// //                                 size: 14,
// //                                 color: kPrimaryOrange,
// //                               ),
// //                               const SizedBox(width: 4),
// //                               Text(
// //                                 widget.property['property_category'] ?? '',
// //                                 style: TextStyle(
// //                                   fontSize: 12,
// //                                   color: widget.isDark
// //                                       ? Colors.white70
// //                                       : Colors.black54,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //                 const SizedBox(height: 14),

// //                 /// ⭐ ACTION BUTTONS ROW ⭐
// //                 Row(
// //                   children: [
// //                     /// INQUIRY BUTTON
// //                     Expanded(
// //                       child: Container(
// //                         height: 42,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(12),
// //                           gradient: LinearGradient(
// //                             colors: [
// //                               kPrimaryOrange.withOpacity(0.9),
// //                               kPrimaryOrange.withOpacity(0.7),
// //                             ],
// //                           ),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: kPrimaryOrange.withOpacity(0.4),
// //                               blurRadius: 10,
// //                               offset: const Offset(0, 4),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             ElevatedButton(
// //                               onPressed: () {
// //                                 // showDialog(
// //                                 //   context: context,
// //                                 //   builder: (_) =>
// //                                 //       _buildInquiryDialog(isDark),
// //                                 // );
// //                                 showDialog(
// //                                   context: context,
// //                                   builder: (_) => InquiryForm(
// //                                     isDark: widget.isDark,
// //                                     propertySlug: '',
// //                                   ),
// //                                 );
// //                               },
// //                               child: Text(
// //                                 "Inquiry Now",
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontWeight: FontWeight.w600,
// //                                   fontSize: 15,
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(width: 12),

// //                     /// FAVORITE ICON (Glass)
// //                     _glassIconSmall(widget.isDark, Icons.favorite_border),

// //                     const SizedBox(width: 8),

// //                     /// SHARE ICON (Glass)
// //                     _glassIconSmall(widget.isDark, Icons.share),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// small round glass icons (arrow, share, favorite)
// //   Widget _glassIconSmall(bool isDark, IconData icon) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(40),
// //       child: BackdropFilter(
// //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //         child: Container(
// //           height: 34,
// //           width: 34,
// //           decoration: BoxDecoration(
// //             color: isDark
// //                 ? Colors.white.withOpacity(0.08)
// //                 : Colors.white.withOpacity(0.5),
// //             shape: BoxShape.circle,
// //             border: Border.all(
// //               color: isDark ? Colors.white24 : Colors.orange.shade200,
// //             ),
// //           ),
// //           child: Icon(
// //             icon,
// //             size: 18,
// //             color: isDark ? Colors.white : kPrimaryOrange,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:visko_rocky_flutter/component/inquiry_form.dart';

// const Color kPrimaryOrange = Color(0xffF26A33);

// class HomePropertyCard extends StatefulWidget {
//   final Map property;
//   final bool isDark;
//   final VoidCallback onTap;

//   const HomePropertyCard({
//     super.key,
//     required this.property,
//     required this.isDark,
//     required this.onTap,
//   });

//   @override
//   State<HomePropertyCard> createState() => _HomePropertyCardState();
// }

// class _HomePropertyCardState extends State<HomePropertyCard> {
//   @override
//   Widget build(BuildContext context) {
//     final propertySqFt = widget.property['property_sq_ft'];
//     final sqFtText = propertySqFt is List && propertySqFt.isNotEmpty
//         ? "${propertySqFt.join(', ')} sqft"
//         : "N/A";

//     return GestureDetector(
//       onTap: widget.onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: widget.isDark
//                   ? Colors.white.withOpacity(0.12)
//                   : Colors.white.withOpacity(0.65),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: widget.isDark ? Colors.white24 : Colors.orange.shade100,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: widget.isDark
//                       ? Colors.black54
//                       : kPrimaryOrange.withOpacity(0.30),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(
//                         widget.property['property_images'] != null &&
//                                 widget.property['property_images'].isNotEmpty
//                             ? widget.property['property_images'][0]
//                             : "https://via.placeholder.com/150",
//                         width: 115,
//                         height: 95,
//                         fit: BoxFit.cover,
//                       ),
//                     ),

//                     const SizedBox(width: 12),

//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   widget.property['property_name'] ??
//                                       'No Title',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.bold,
//                                     color: widget.isDark
//                                         ? Colors.white
//                                         : Colors.black87,
//                                   ),
//                                 ),
//                               ),
//                               _glassIconSmall(
//                                 widget.isDark,
//                                 Icons.arrow_outward_rounded,
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 6),

//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.location_on,
//                                 size: 15,
//                                 color: kPrimaryOrange,
//                               ),
//                               const SizedBox(width: 4),
//                               Expanded(
//                                 child: Text(
//                                   widget.property['property_city'] ?? 'Unknown',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: widget.isDark
//                                         ? Colors.white70
//                                         : Colors.black54,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 6),

//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.square_foot,
//                                 size: 16,
//                                 color: kPrimaryOrange,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 sqFtText,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: widget.isDark
//                                       ? Colors.white70
//                                       : Colors.black54,
//                                 ),
//                               ),
//                             ],
//                           ),

//                           const SizedBox(height: 6),

//                           Row(
//                             children: [
//                               const Icon(
//                                 Icons.villa,
//                                 size: 14,
//                                 color: kPrimaryOrange,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 widget.property['property_type'] ?? '',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: widget.isDark
//                                       ? Colors.white70
//                                       : Colors.black54,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               const Icon(
//                                 Icons.category,
//                                 size: 14,
//                                 color: kPrimaryOrange,
//                               ),
//                               const SizedBox(width: 4),
//                               Text(
//                                 widget.property['property_category'] ?? '',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: widget.isDark
//                                       ? Colors.white70
//                                       : Colors.black54,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 16),

//                 Row(
//                   children: [
//                     // ---------------- INQUIRY BUTTON ---------------- //
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (_) => InquiryForm(
//                               isDark: widget.isDark,
//                               propertySlug:
//                                   widget.property['property_slug'] ?? "",
//                             ),
//                           );
//                         },
//                         child: Container(
//                           height: 45,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             gradient: LinearGradient(
//                               colors: [
//                                 kPrimaryOrange.withOpacity(0.9),
//                                 kPrimaryOrange.withOpacity(0.7),
//                               ],
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: kPrimaryOrange.withOpacity(0.4),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           alignment: Alignment.center,
//                           child: const Text(
//                             "Inquiry Now",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 12),

//                     _glassIconSmall(widget.isDark, Icons.favorite_border),
//                     const SizedBox(width: 8),
//                     _glassIconSmall(widget.isDark, Icons.share),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// GLASS EFFECT ICON
//   Widget _glassIconSmall(bool isDark, IconData icon) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           height: 36,
//           width: 36,
//           decoration: BoxDecoration(
//             color: isDark ? Colors.white.withOpacity(0.08) : Colors.white70,
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: isDark ? Colors.white24 : Colors.orange.shade200,
//             ),
//           ),
//           child: Icon(
//             icon,
//             size: 18,
//             color: isDark ? Colors.white : kPrimaryOrange,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';

const Color kPrimaryOrange = Color(0xffF26A33);

class HomePropertyCard extends StatefulWidget {
  final Map property;
  final bool isDark;
  final VoidCallback onTap;

  const HomePropertyCard({
    super.key,
    required this.property,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<HomePropertyCard> createState() => _HomePropertyCardState();
}

class _HomePropertyCardState extends State<HomePropertyCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? Colors.white.withOpacity(0.07)
                  : Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.isDark ? Colors.white24 : Colors.orange.shade100,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.isDark
                      ? Colors.black.withOpacity(0.4)
                      : kPrimaryOrange.withOpacity(0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    /// PROPERTY IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.property['property_images'] != null &&
                                widget.property['property_images'].isNotEmpty
                            ? widget.property['property_images'][0]
                            : "https://via.placeholder.com/150",
                        width: 110,
                        height: 95,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// TEXT INFO SECTION
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE + ARROW
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.property['property_name'] ??
                                      'No Title',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              _glassIconSmall(
                                widget.isDark,
                                Icons.arrow_outward_rounded,
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// LOCATION
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: kPrimaryOrange,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.property['property_city'] ?? 'Unknown',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: widget.isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// SQFT
                          Row(
                            children: [
                              const Icon(
                                Icons.square_foot,
                                size: 16,
                                color: kPrimaryOrange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.property['property_sq_ft'] != null
                                    ? "${(widget.property['property_sq_ft'] as List).join(', ')} sqft"
                                    : "0 sqft",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// TYPE + CATEGORY
                          Row(
                            children: [
                              const Icon(
                                Icons.villa,
                                size: 14,
                                color: kPrimaryOrange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.property['property_type'] ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.category,
                                size: 14,
                                color: kPrimaryOrange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.property['property_category'] ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                /// ACTION BUTTONS
                Row(
                  children: [
                    /// INQUIRY BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            shadowColor: kPrimaryOrange.withOpacity(0.4),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => InquiryForm(
                                isDark: widget.isDark,
                                propertySlug: '',
                              ),
                            );
                          },
                          child: const Text(
                            "Inquiry Now",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// FAVORITE ICON
                    _glassIconSmall(widget.isDark, Icons.favorite_border),

                    const SizedBox(width: 8),

                    /// SHARE ICON — using share_plus
                    GestureDetector(
                      onTap: () {
                        String shareText =
                            "Check this property: ${widget.property['property_name']}\n"
                            "Location: ${widget.property['property_city']}\n"
                            "${widget.property['property_images']?[0] ?? ''}";

                        Share.share(shareText);
                      },
                      child: _glassIconSmall(widget.isDark, Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Glass Icon Widget
  Widget _glassIconSmall(bool isDark, IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.orange.shade200,
            ),
          ),
          child: Icon(
            icon,
            size: 18,
            color: isDark ? Colors.white : kPrimaryOrange,
          ),
        ),
      ),
    );
  }
}
