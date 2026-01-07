// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class ContactInformationPage extends StatefulWidget {
//   const ContactInformationPage({super.key});

//   @override
//   State<ContactInformationPage> createState() => _ContactInformationPageState();
// }

// class _ContactInformationPageState extends State<ContactInformationPage> {
//   final mobileCtrl = TextEditingController();
//   final emailCtrl = TextEditingController();

//   final RxBool mobileVerified = true.obs;
//   final RxBool emailVerified = false.obs;

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         leading: CupertinoNavigationBarBackButton(
//           color: glass.textPrimary,
//           onPressed: () => Get.back(),
//         ),
//         title: const Text("Contact Information"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           _infoCard(
//             glass,
//             title: "Mobile Number",
//             controller: mobileCtrl,
//             hint: "Enter mobile number",
//             verified: mobileVerified,
//             keyboard: TextInputType.phone,
//           ),
//           const SizedBox(height: 20),
//           _infoCard(
//             glass,
//             title: "Email ID",
//             controller: emailCtrl,
//             hint: "Enter email address",
//             verified: emailVerified,
//             keyboard: TextInputType.emailAddress,
//           ),
//           const SizedBox(height: 40),
//           _saveButton(glass),
//         ],
//       ),
//     );
//   }

//   // ===============================================================
//   // WIDGETS
//   // ===============================================================

//   Widget _infoCard(
//     GlassColors glass, {
//     required String title,
//     required TextEditingController controller,
//     required String hint,
//     required RxBool verified,
//     required TextInputType keyboard,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: glass.textPrimary,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                   Obx(
//                     () => Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: LinearGradient(
//                           colors: verified.value
//                               ? [
//                                   glass.chipSelectedGradientStart,
//                                   glass.chipSelectedGradientEnd,
//                                 ]
//                               : [
//                                   glass.chipUnselectedStart,
//                                   glass.chipUnselectedEnd,
//                                 ],
//                         ),
//                       ),
//                       child: Text(
//                         verified.value ? "Verified" : "Not Verified",
//                         style: TextStyle(
//                           color:
//                               verified.value ? Colors.white : glass.textPrimary,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: controller,
//                 keyboardType: keyboard,
//                 style: TextStyle(color: glass.textPrimary),
//                 decoration: InputDecoration(
//                   hintText: hint,
//                   hintStyle: TextStyle(color: glass.textSecondary),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _saveButton(GlassColors glass) {
//     return GestureDetector(
//       onTap: () => Get.back(),
//       child: Container(
//         height: 55,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           gradient: LinearGradient(
//             colors: [
//               glass.chipSelectedGradientStart,
//               glass.chipSelectedGradientEnd,
//             ],
//           ),
//         ),
//         child: const Center(
//           child: Text(
//             "Save Contact Details",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class ContactInformationPage extends StatefulWidget {
  const ContactInformationPage({super.key});

  @override
  State<ContactInformationPage> createState() => _ContactInformationPageState();
}

class _ContactInformationPageState extends State<ContactInformationPage> {
  final mobileCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  final RxBool mobileVerified = true.obs;
  final RxBool emailVerified = false.obs;

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: glass.textPrimary, // 🔧 UPDATED
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Contact Information",
          style: TextStyle(color: glass.textPrimary), // 🔧 UPDATED
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _infoCard(
            glass,
            title: "Mobile Number",
            controller: mobileCtrl,
            hint: "Enter mobile number",
            verified: mobileVerified,
            keyboard: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          _infoCard(
            glass,
            title: "Email ID",
            controller: emailCtrl,
            hint: "Enter email address",
            verified: emailVerified,
            keyboard: TextInputType.emailAddress,
          ),
          const SizedBox(height: 40),
          _saveButton(glass),
        ],
      ),
    );
  }

  // ===============================================================
  // INFO CARD
  // ===============================================================

  Widget _infoCard(
    GlassColors glass, {
    required String title,
    required TextEditingController controller,
    required String hint,
    required RxBool verified,
    required TextInputType keyboard,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: glass.cardBackground, // 🔧 UPDATED
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: glass.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: glass.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: verified.value
                              ? [
                                  glass.chipSelectedGradientStart,
                                  glass.chipSelectedGradientEnd,
                                ]
                              : [
                                  glass.chipUnselectedStart,
                                  glass.chipUnselectedEnd,
                                ],
                        ),
                      ),
                      child: Text(
                        verified.value ? "Verified" : "Not Verified",
                        style: TextStyle(
                          // 🔧 UPDATED (NO Colors.white)
                          color: verified.value
                              ? glass.solidSurface
                              : glass.textPrimary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: keyboard,
                style: TextStyle(
                  color: glass.textPrimary, // 🔧 UPDATED
                ),
                cursorColor: glass.chipSelectedGradientStart, // 🔧 UPDATED
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: glass.textSecondary,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // SAVE BUTTON
  // ===============================================================

  Widget _saveButton(GlassColors glass) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              glass.chipSelectedGradientStart,
              glass.chipSelectedGradientEnd,
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Save Contact Details",
            style: TextStyle(
              color: glass.solidSurface, // 🔧 UPDATED
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
