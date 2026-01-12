// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/controller/contact_info_controller.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class ContactInformationPage extends StatefulWidget {
//   const ContactInformationPage({super.key});

//   @override
//   State<ContactInformationPage> createState() => _ContactInformationPageState();
// }

// class _ContactInformationPageState extends State<ContactInformationPage> {
//   final contact = Get.find<ContactInfoController>();

//   late TextEditingController mobileCtrl;
//   late TextEditingController emailCtrl;

//   // Reactive variable to track form validity
//   final isFormValid = false.obs;

//   @override
//   void initState() {
//     super.initState();
//     mobileCtrl = TextEditingController(text: contact.mobile.value);
//     emailCtrl = TextEditingController(text: contact.email.value);

//     // Listen for input changes to update validation
//     mobileCtrl.addListener(_validateForm);
//     emailCtrl.addListener(_validateForm);
//   }

//   void _validateForm() {
//     final mobileValid = mobileCtrl.text.trim().isNotEmpty &&
//         mobileCtrl.text.trim().length == 10;
//     final emailValid = emailCtrl.text.trim().isNotEmpty &&
//         RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//             .hasMatch(emailCtrl.text.trim());

//     isFormValid.value = mobileValid && emailValid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;

//     return Scaffold(
//       appBar: AppBar(
//         leading: CupertinoNavigationBarBackButton(
//           color: glass.textPrimary,
//           onPressed: Get.back,
//         ),
//         title: Text("Contact Information",
//             style: TextStyle(color: glass.textPrimary)),
//         backgroundColor: glass.solidSurface,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           _infoCard(
//             glass,
//             title: "Mobile Number",
//             controller: mobileCtrl,
//             hint: "Enter 10 digit mobile number",
//             verified: contact.mobileVerified,
//             keyboard: TextInputType.phone,
//           ),
//           const SizedBox(height: 20),
//           _infoCard(
//             glass,
//             title: "Email ID",
//             controller: emailCtrl,
//             hint: "Enter email address",
//             verified: contact.emailVerified,
//             keyboard: TextInputType.emailAddress,
//           ),
//           const SizedBox(height: 40),
//           _saveButton(glass),
//         ],
//       ),
//     );
//   }

//   // ================= INFO CARD =================
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
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: glass.textPrimary,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const Spacer(),
//                   Obx(() {
//                     if (!verified.value) return const SizedBox();
//                     return _verifiedChip(glass, verified.value);
//                   }),
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

//   Widget _verifiedChip(GlassColors glass, bool verified) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         gradient: LinearGradient(
//           colors: verified
//               ? [glass.chipSelectedGradientStart, glass.chipSelectedGradientEnd]
//               : [glass.chipUnselectedStart, glass.chipUnselectedEnd],
//         ),
//       ),
//       child: Text(
//         verified ? "Verified" : "Not Verified",
//         style: TextStyle(
//           color: verified ? glass.solidSurface : glass.textPrimary,
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   // ================= SAVE =================
//   Widget _saveButton(GlassColors glass) {
//     return Obx(() {
//       final enabled = isFormValid.value;

//       return GestureDetector(
//         onTap: enabled
//             ? () {
//                 contact.save(
//                   mobile: mobileCtrl.text.trim(),
//                   email: emailCtrl.text.trim(),
//                 );
//                 Get.back();
//               }
//             : null,
//         child: AnimatedOpacity(
//           duration: const Duration(milliseconds: 200),
//           opacity: enabled ? 1 : 0.45,
//           child: Container(
//             height: 55,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               gradient: LinearGradient(
//                   colors: enabled
//                       ? [
//                           glass.chipSelectedGradientStart,
//                           glass.chipSelectedGradientEnd,
//                         ]
//                       : [
//                           glass.glassBorder,
//                           glass.glassBorder,
//                         ]),
//             ),
//             child: Center(
//               child: Text(
//                 "Save Contact Details",
//                 style: TextStyle(
//                     color: glass.solidSurface,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/controller/contact_info_controller.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class ContactInformationPage extends StatefulWidget {
  const ContactInformationPage({super.key});

  @override
  State<ContactInformationPage> createState() => _ContactInformationPageState();
}

class _ContactInformationPageState extends State<ContactInformationPage> {
  final contact = Get.find<ContactInfoController>();

  late TextEditingController mobileCtrl;
  late TextEditingController emailCtrl;

  // Reactive variable to track form validity
  final isFormValid = false.obs;

  @override
  void initState() {
    super.initState();
    mobileCtrl = TextEditingController(text: contact.mobile.value);
    emailCtrl = TextEditingController(text: contact.email.value);

    // Listen for input changes to update validation
    mobileCtrl.addListener(_validateForm);
    emailCtrl.addListener(_validateForm);
  }

  void _validateForm() {
    final mobileValid = mobileCtrl.text.trim().length == 10;
    final emailValid = emailCtrl.text.trim().isNotEmpty &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            .hasMatch(emailCtrl.text.trim());

    isFormValid.value = mobileValid && emailValid;
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: glass.textPrimary,
          onPressed: Get.back,
        ),
        title: Text(
          "Contact Information",
          style: TextStyle(color: glass.textPrimary),
        ),
        backgroundColor: glass.solidSurface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _infoCard(
            glass,
            title: "Mobile Number",
            controller: mobileCtrl,
            hint: "Enter 10 digit mobile number",
            verified: contact.mobileVerified,
            keyboard: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Only digits
              LengthLimitingTextInputFormatter(10), // Max 10 digits
            ],
          ),
          const SizedBox(height: 20),
          _infoCard(
            glass,
            title: "Email ID",
            controller: emailCtrl,
            hint: "Enter email address",
            verified: contact.emailVerified,
            keyboard: TextInputType.emailAddress,
          ),
          const SizedBox(height: 40),
          _saveButton(glass),
        ],
      ),
    );
  }

  // ================= INFO CARD =================
  Widget _infoCard(
    GlassColors glass, {
    required String title,
    required TextEditingController controller,
    required String hint,
    required RxBool verified,
    required TextInputType keyboard,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: glass.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: glass.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    if (!verified.value) return const SizedBox();
                    return _verifiedChip(glass, verified.value);
                  }),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: keyboard,
                style: TextStyle(color: glass.textPrimary),
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: glass.textSecondary),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _verifiedChip(GlassColors glass, bool verified) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: verified
              ? [glass.chipSelectedGradientStart, glass.chipSelectedGradientEnd]
              : [glass.chipUnselectedStart, glass.chipUnselectedEnd],
        ),
      ),
      child: Text(
        verified ? "Verified" : "Not Verified",
        style: TextStyle(
          color: verified ? glass.solidSurface : glass.textPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ================= SAVE =================
  Widget _saveButton(GlassColors glass) {
    return Obx(() {
      final enabled = isFormValid.value;

      return GestureDetector(
        onTap: enabled
            ? () {
                contact.save(
                  mobile: mobileCtrl.text.trim(),
                  email: emailCtrl.text.trim(),
                );
                Get.back();
              }
            : null,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: enabled ? 1 : 0.45,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  colors: enabled
                      ? [
                          glass.chipSelectedGradientStart,
                          glass.chipSelectedGradientEnd,
                        ]
                      : [
                          glass.glassBorder,
                          glass.glassBorder,
                        ]),
            ),
            child: Center(
              child: Text(
                "Save Contact Details",
                style: TextStyle(
                    color: glass.solidSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ),
      );
    });
  }
}
