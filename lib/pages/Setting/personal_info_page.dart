// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class PersonalInfoPage extends StatefulWidget {
//   const PersonalInfoPage({super.key});

//   @override
//   State<PersonalInfoPage> createState() => _PersonalInfoPageState();
// }

// class _PersonalInfoPageState extends State<PersonalInfoPage> {
//   final nameCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final dobCtrl = TextEditingController();

//   final RxString gender = "Male".obs;

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
//         title: const Text("Personal Information"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           _glassInput(glass, "Full Name", nameCtrl),
//           const SizedBox(height: 15),
//           _dateInput(glass),
//           const SizedBox(height: 20),
//           _genderSelector(glass),
//           const SizedBox(height: 20),
//           _glassInput(glass, "Address", addressCtrl, maxLines: 3),
//           const SizedBox(height: 40),
//           _saveButton(glass),
//         ],
//       ),
//     );
//   }

//   // ===============================================================
//   // WIDGETS
//   // ===============================================================

//   Widget _glassInput(
//     GlassColors glass,
//     String hint,
//     TextEditingController controller, {
//     int maxLines = 1,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: TextField(
//             controller: controller,
//             maxLines: maxLines,
//             style: TextStyle(color: glass.textPrimary),
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(color: glass.textSecondary),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _dateInput(GlassColors glass) {
//     return GestureDetector(
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           firstDate: DateTime(1950),
//           lastDate: DateTime.now(),
//         );
//         if (picked != null) {
//           dobCtrl.text = "${picked.day}/${picked.month}/${picked.year}";
//         }
//       },
//       child: AbsorbPointer(
//         child: _glassInput(glass, "Date of Birth", dobCtrl),
//       ),
//     );
//   }

//   Widget _genderSelector(GlassColors glass) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Gender",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Obx(
//                 () => Row(
//                   children: ["Male", "Female", "Other"].map((g) {
//                     final selected = gender.value == g;
//                     return Expanded(
//                       child: GestureDetector(
//                         onTap: () => gender.value = g,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: selected
//                                 ? LinearGradient(
//                                     colors: [
//                                       glass.chipSelectedGradientStart,
//                                       glass.chipSelectedGradientEnd,
//                                     ],
//                                   )
//                                 : null,
//                             border: Border.all(
//                               color: glass.glassBorder,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               g,
//                               style: TextStyle(
//                                 color:
//                                     selected ? Colors.white : glass.textPrimary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
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
//       onTap: () {
//         Get.back();
//       },
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
//             "Save Changes",
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

// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class PersonalInfoPage extends StatefulWidget {
//   const PersonalInfoPage({super.key});

//   @override
//   State<PersonalInfoPage> createState() => _PersonalInfoPageState();
// }

// class _PersonalInfoPageState extends State<PersonalInfoPage> {
//   final nameCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final dobCtrl = TextEditingController();

//   final RxString gender = "Male".obs;

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         leading: CupertinoNavigationBarBackButton(
//           color: glass.textPrimary,
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           "Personal Information",
//           style: TextStyle(color: glass.textPrimary),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           _glassInput(glass, "Full Name", nameCtrl),
//           const SizedBox(height: 15),
//           _dateInput(glass),
//           const SizedBox(height: 20),
//           _genderSelector(glass),
//           const SizedBox(height: 20),
//           _glassInput(glass, "Address", addressCtrl, maxLines: 3),
//           const SizedBox(height: 40),
//           _saveButton(glass),
//         ],
//       ),
//     );
//   }

//   // ===============================================================
//   // GLASS INPUT
//   // ===============================================================

//   Widget _glassInput(
//     GlassColors glass,
//     String hint,
//     TextEditingController controller, {
//     int maxLines = 1,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: TextField(
//             controller: controller,
//             maxLines: maxLines,
//             style: TextStyle(color: glass.textPrimary),
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(color: glass.textSecondary),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ===============================================================
//   // DATE INPUT (THEME SAFE)
//   // ===============================================================

//   Widget _dateInput(GlassColors glass) {
//     return GestureDetector(
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           firstDate: DateTime(1950),
//           lastDate: DateTime.now(),
//           builder: (context, child) {
//             return Theme(
//               data: Theme.of(context),
//               child: child!,
//             );
//           },
//         );

//         if (picked != null) {
//           dobCtrl.text = "${picked.day}/${picked.month}/${picked.year}";
//         }
//       },
//       child: AbsorbPointer(
//         child: _glassInput(glass, "Date of Birth", dobCtrl),
//       ),
//     );
//   }

//   // ===============================================================
//   // GENDER SELECTOR (NO COLORS.WHITE)
//   // ===============================================================

//   Widget _genderSelector(GlassColors glass) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Gender",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Obx(
//                 () => Row(
//                   children: ["Male", "Female", "Other"].map((g) {
//                     final selected = gender.value == g;

//                     return Expanded(
//                       child: GestureDetector(
//                         onTap: () => gender.value = g,
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: selected
//                                 ? LinearGradient(
//                                     colors: [
//                                       glass.chipSelectedGradientStart,
//                                       glass.chipSelectedGradientEnd,
//                                     ],
//                                   )
//                                 : null,
//                             border: Border.all(color: glass.glassBorder),
//                           ),
//                           child: Center(
//                             child: Text(
//                               g,
//                               style: TextStyle(
//                                 color: selected
//                                     ? glass.solidSurface // 🔥 UPDATED
//                                     : glass.textPrimary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ===============================================================
//   // SAVE BUTTON (THEME ONLY)
//   // ===============================================================

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
//         child: Center(
//           child: Text(
//             "Save Changes",
//             style: TextStyle(
//               color: glass.solidSurface, // 🔥 UPDATED
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
import '../../controller/personal_info_controller.dart';
import '../../theme/app_theme.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final ctrl = Get.put(PersonalInfoController());

  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final RxString gender = 'Male'.obs;

  @override
  void initState() {
    super.initState();
    nameCtrl.text = ctrl.name.value;
    addressCtrl.text = ctrl.address.value;
    dobCtrl.text = ctrl.dob.value;
    gender.value = ctrl.gender.value;
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
        title: Text("Personal Information",
            style: TextStyle(color: glass.textPrimary)),
        backgroundColor: glass.solidSurface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _input(glass, "Full Name", nameCtrl),
          const SizedBox(height: 15),
          _dateInput(glass),
          const SizedBox(height: 20),
          _gender(glass),
          const SizedBox(height: 20),
          _input(glass, "Address", addressCtrl, maxLines: 3),
          const SizedBox(height: 40),
          _save(glass),
        ],
      ),
    );
  }

  Widget _input(GlassColors glass, String hint, TextEditingController c,
      {int maxLines = 1}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: glass.glassBorder),
          ),
          child: TextField(
            controller: c,
            maxLines: maxLines,
            style: TextStyle(color: glass.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: glass.textSecondary),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateInput(GlassColors glass) {
    return GestureDetector(
      onTap: () async {
        final d = await showDatePicker(
          context: context,
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
        );
        if (d != null) {
          dobCtrl.text = "${d.day}/${d.month}/${d.year}";
        }
      },
      child: AbsorbPointer(child: _input(glass, "Date of Birth", dobCtrl)),
    );
  }

  Widget _gender(GlassColors glass) {
    return Obx(() => Row(
          children: ["Male", "Female", "Other"].map((g) {
            final s = gender.value == g;
            return Expanded(
              child: GestureDetector(
                onTap: () => gender.value = g,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: s
                        ? LinearGradient(colors: [
                            glass.chipSelectedGradientStart,
                            glass.chipSelectedGradientEnd
                          ])
                        : null,
                    border: Border.all(color: glass.glassBorder),
                  ),
                  child: Center(
                    child: Text(
                      g,
                      style: TextStyle(
                        color: s ? glass.solidSurface : glass.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }

  Widget _save(GlassColors glass) {
    return GestureDetector(
      onTap: () {
        ctrl.save(
          name: nameCtrl.text,
          address: addressCtrl.text,
          dob: dobCtrl.text,
          gender: gender.value,
        );
        Get.back();
      },
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [
            glass.chipSelectedGradientStart,
            glass.chipSelectedGradientEnd,
          ]),
        ),
        child: Center(
          child: Text("Save Changes",
              style: TextStyle(
                  color: glass.solidSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
