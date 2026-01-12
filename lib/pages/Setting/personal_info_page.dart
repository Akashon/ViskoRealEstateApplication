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

  final RxBool isFormValid = false.obs;

  @override
  void initState() {
    super.initState();

    nameCtrl.text = ctrl.name.value;
    addressCtrl.text = ctrl.address.value;
    dobCtrl.text = ctrl.dob.value;
    gender.value = ctrl.gender.value;

    /// 🔥 Listen for changes
    nameCtrl.addListener(_validate);
    addressCtrl.addListener(_validate);
    dobCtrl.addListener(_validate);
    gender.listen((_) => _validate());

    _validate();
  }

  void _validate() {
    isFormValid.value = nameCtrl.text.trim().isNotEmpty &&
        addressCtrl.text.trim().isNotEmpty &&
        dobCtrl.text.trim().isNotEmpty;
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
          "Personal Information",
          style: TextStyle(color: glass.textPrimary),
        ),
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

  Widget _input(
    GlassColors glass,
    String hint,
    TextEditingController c, {
    int maxLines = 1,
  }) {
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
          _validate();
        }
      },
      child: AbsorbPointer(
        child: _input(glass, "Date of Birth", dobCtrl),
      ),
    );
  }

  Widget _gender(GlassColors glass) {
    return Obx(() => Row(
          children: ["Male", "Female", "Other"].map((g) {
            final selected = gender.value == g;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  gender.value = g;
                  _validate();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: selected
                        ? LinearGradient(colors: [
                            glass.chipSelectedGradientStart,
                            glass.chipSelectedGradientEnd,
                          ])
                        : null,
                    border: Border.all(color: glass.glassBorder),
                  ),
                  child: Center(
                    child: Text(
                      g,
                      style: TextStyle(
                        color:
                            selected ? glass.solidSurface : glass.textPrimary,
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
    return Obx(() {
      final enabled = isFormValid.value;

      return GestureDetector(
        onTap: enabled
            ? () {
                ctrl.save(
                  name: nameCtrl.text,
                  address: addressCtrl.text,
                  dob: dobCtrl.text,
                  gender: gender.value,
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
                "Save Changes",
                style: TextStyle(
                  color: glass.solidSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/personal_info_controller.dart';
// import '../../theme/app_theme.dart';

// class PersonalInfoPage extends StatefulWidget {
//   const PersonalInfoPage({super.key});

//   @override
//   State<PersonalInfoPage> createState() => _PersonalInfoPageState();
// }

// class _PersonalInfoPageState extends State<PersonalInfoPage> {
//   final ctrl = Get.put(PersonalInfoController());

//   final nameCtrl = TextEditingController();
//   final addressCtrl = TextEditingController();
//   final dobCtrl = TextEditingController();
//   final RxString gender = 'Male'.obs;

//   @override
//   void initState() {
//     super.initState();
//     nameCtrl.text = ctrl.name.value;
//     addressCtrl.text = ctrl.address.value;
//     dobCtrl.text = ctrl.dob.value;
//     gender.value = ctrl.gender.value;
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
//         title: Text("Personal Information",
//             style: TextStyle(color: glass.textPrimary)),
//         backgroundColor: glass.solidSurface,
//         elevation: 0,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           _input(glass, "Full Name", nameCtrl),
//           const SizedBox(height: 15),
//           _dateInput(glass),
//           const SizedBox(height: 20),
//           _gender(glass),
//           const SizedBox(height: 20),
//           _input(glass, "Address", addressCtrl, maxLines: 3),
//           const SizedBox(height: 40),
//           _save(glass),
//         ],
//       ),
//     );
//   }

//   Widget _input(GlassColors glass, String hint, TextEditingController c,
//       {int maxLines = 1}) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: TextField(
//             controller: c,
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
//         final d = await showDatePicker(
//           context: context,
//           firstDate: DateTime(1950),
//           lastDate: DateTime.now(),
//         );
//         if (d != null) {
//           dobCtrl.text = "${d.day}/${d.month}/${d.year}";
//         }
//       },
//       child: AbsorbPointer(child: _input(glass, "Date of Birth", dobCtrl)),
//     );
//   }

//   Widget _gender(GlassColors glass) {
//     return Obx(() => Row(
//           children: ["Male", "Female", "Other"].map((g) {
//             final s = gender.value == g;
//             return Expanded(
//               child: GestureDetector(
//                 onTap: () => gender.value = g,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 5),
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     gradient: s
//                         ? LinearGradient(colors: [
//                             glass.chipSelectedGradientStart,
//                             glass.chipSelectedGradientEnd
//                           ])
//                         : null,
//                     border: Border.all(color: glass.glassBorder),
//                   ),
//                   child: Center(
//                     child: Text(
//                       g,
//                       style: TextStyle(
//                         color: s ? glass.solidSurface : glass.textPrimary,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ));
//   }

//   Widget _save(GlassColors glass) {
//     return GestureDetector(
//       onTap: () {
//         ctrl.save(
//           name: nameCtrl.text,
//           address: addressCtrl.text,
//           dob: dobCtrl.text,
//           gender: gender.value,
//         );
//         Get.back();
//       },
//       child: Container(
//         height: 55,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           gradient: LinearGradient(colors: [
//             glass.chipSelectedGradientStart,
//             glass.chipSelectedGradientEnd,
//           ]),
//         ),
//         child: Center(
//           child: Text("Save Changes",
//               style: TextStyle(
//                   color: glass.solidSurface,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold)),
//         ),
//       ),
//     );
//   }
// }
