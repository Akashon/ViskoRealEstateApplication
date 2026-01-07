// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class SupportBottomSheet {
//   static void show(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     Get.bottomSheet(
//       ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: glass.glassBackground,
//               border: Border.all(color: glass.glassBorder),
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(30)),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   height: 5,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: glass.textSecondary,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Contact Support",
//                   style: TextStyle(
//                     color: glass.textPrimary,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 _supportTile(
//                   glass,
//                   icon: Icons.email_outlined,
//                   title: "Email Support",
//                   subtitle: "support@visko.com",
//                 ),
//                 const SizedBox(height: 12),
//                 _supportTile(
//                   glass,
//                   icon: Icons.phone_in_talk_outlined,
//                   title: "Phone Support",
//                   subtitle: "+91 98765 43210",
//                 ),
//                 const SizedBox(height: 12),
//                 _supportTile(
//                   glass,
//                   icon: Icons.whatshot_outlined,
//                   title: "WhatsApp Support",
//                   subtitle: "Chat instantly",
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }

//   static Widget _supportTile(
//     GlassColors glass, {
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: glass.textPrimary),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         color: glass.textPrimary,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                         color: glass.textSecondary,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 14,
//                 color: glass.textSecondary,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class SupportBottomSheet {
  static void show(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;

    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: glass.glassBackground, // ✅ theme glass
              border: Border.all(color: glass.glassBorder),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔹 Drag Handle
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: glass.textSecondary.withOpacity(0.5), // ✅ UPDATED
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Title
                Text(
                  "Contact Support",
                  style: TextStyle(
                    color: glass.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                _supportTile(
                  glass,
                  primary: primary,
                  icon: Icons.email_outlined,
                  title: "Email Support",
                  subtitle: "support@visko.com",
                ),

                const SizedBox(height: 12),

                _supportTile(
                  glass,
                  primary: primary,
                  icon: Icons.phone_in_talk_outlined,
                  title: "Phone Support",
                  subtitle: "+91 98765 43210",
                ),

                const SizedBox(height: 12),

                _supportTile(
                  glass,
                  primary: primary,
                  icon: Icons.whatshot_outlined,
                  title: "WhatsApp Support",
                  subtitle: "Chat instantly",
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  // ================= SUPPORT TILE =================

  static Widget _supportTile(
    GlassColors glass, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color primary,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: glass.cardBackground, // ✅ theme card bg
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: glass.glassBorder),
          ),
          child: Row(
            children: [
              // 🔹 Icon
              Icon(
                icon,
                color: primary, // ✅ primary accent
                size: 22,
              ),

              const SizedBox(width: 15),

              // 🔹 Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: glass.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: glass.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Arrow
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: glass.textSecondary.withOpacity(0.6), // ✅ UPDATED
              ),
            ],
          ),
        ),
      ),
    );
  }
}
